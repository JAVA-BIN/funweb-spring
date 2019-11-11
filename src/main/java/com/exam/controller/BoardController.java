package com.exam.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exam.domain.BoardVO;
import com.exam.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j    
public class BoardController {
	@Autowired
	private BoardService boardService;
	@GetMapping("/write")
	public String write() {
		log.info("write() 호출됨...");
		log.warn("주의 메시지");
		return "center/write";
	} 
	
	@PostMapping("/write")
	public String write(BoardVO boardVO, HttpServletRequest request) {
		// IP주소 값 저장
		boardVO.setIp(request.getRemoteAddr());
		// 게시글 번호 생성하는 메소드 호출
		int num = boardService.nextBoardNum();
		// 생성된 번호를 자바빈 글번호 필드에 설정
		boardVO.setNum(num);
		boardVO.setReadcount(0); // 조회수 0
		// 주글일 경우
		boardVO.setReRef(num); // [글그룹번호]는 글번호와 동일함
		boardVO.setReLev(0); // [들여쓰기 레벨] 0 
		boardVO.setReSeq(0); // [글그룹 안에서의 순서] 0
		// 게시글 한개 등록하는 메소드 호출 insertBoard(boardVO)
		boardService.insertBoard(boardVO);
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public String list(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "", required = false) String search,
			Model model) {
		// 한 페이지에 해당하는 글목록 구하기 작업
		// 한페이지(화면)에 보여줄 글 개수
		int pageSize = 10;
		// 시작행번호 구하기
//		int startRow = (pageNum - 1) * pageSize + 1; // Oracle 기준
		int startRow = (pageNum - 1) * pageSize;     // MySQL 기준
		// 글목록 가져오기 메소드 호출
		List<BoardVO> boardList = boardService.getBoards(startRow, pageSize, search);
		// 페이지 블록 관련정보 구하기 작업
		// board테이블 전체글개수 가져오기 메소드 호출
		int count = boardService.getBoardCount(search);
		// 총 페이지 개수 구하기
		//  전체 글개수 / 한페이지당 글개수 (+ 1 : 나머지 있을때)
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		// 페이지블록 수 설정
		int pageBlock = 5;
		// 시작페이지번호 startPage 구하기
		// pageNum값이 1~5 사이면 -> 시작페이지는 항상 1이 나와야 함
		int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
		// 끝페이지번호 endPage 구하기
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		// 페이지블록 관련정보를 Map 또는 VO 객체로 준비
		Map<String, Integer> pageInfoMap = new HashMap<String, Integer>();
		pageInfoMap.put("count", count);
		pageInfoMap.put("pageCount", pageCount);
		pageInfoMap.put("pageBlock", pageBlock);
		pageInfoMap.put("startPage", startPage);
		pageInfoMap.put("endPage", endPage);
		// 뷰(jsp)에 사용할 데이터를 request 영역객체에 저장
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageInfoMap", pageInfoMap);
		model.addAttribute("search", search);
		model.addAttribute("pageNum", pageNum);
		return "center/notice";
	} // list
	
	@GetMapping("/content")
	public String content(int num, @ModelAttribute("pageNum") int pageNum, Model model) {
		// 조회수 1증가시키는 메소드 호출
		boardService.updateReadcount(num);
		// 글번호에 해당하는 레코드 한개 가져오기
		BoardVO boardVO = boardService.getBoard(num);
		// request 영역객체에 저장
		model.addAttribute("board", boardVO);
		return "center/content";
	}
	
	@GetMapping("/modify")
	public String modify(int num, @ModelAttribute("pageNum") int pageNum, Model model) {
		// 수정할 글 가져오기
		BoardVO boardVO = boardService.getBoard(num);
		// request 영역객체에 저장
		model.addAttribute("board", boardVO);
		return "center/update";
	}
	
	@PostMapping("/modify")
	public ResponseEntity<String> modify(BoardVO boardVO, String pageNum) {
		boolean isPasswdEqual = boardService.isPasswdEqual(boardVO.getNum(), boardVO.getPasswd());
		if (!isPasswdEqual) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			StringBuilder sb =new StringBuilder();
			sb.append("<script>");
			sb.append("alert('글 패스워드가 다릅니다.');");
			sb.append("history.back();");
			sb.append("</script>");
			ResponseEntity<String> responseEntity
				= new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
			return responseEntity;
		}
		// 게시글 수정하기 메소드 호출
		boardService.updateBoard(boardVO);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("alert('글 수정 성공!');");
		sb.append("location.href = '/board/content?num=" + boardVO.getNum() + "&pageNum=" + pageNum + "';");
		sb.append("</script>");
		
		ResponseEntity<String> responseEntity
			= new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		
		return responseEntity;
	} // modify post
	
	@GetMapping("/delete")
	public String delete(@ModelAttribute("num") int num, @ModelAttribute("pageNum") String pageNum) {
		return "center/delete";
	}
	@PostMapping("/delete")
	public ResponseEntity<String> delete(int num, String passwd, String pageNum) {
		// 글패스워드가 다를때는 "글패스워드 다름" 뒤로가기
		if (!boardService.isPasswdEqual(num, passwd)) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('글 패스워드가 다릅니다.');");
			sb.append("history.back();");
			sb.append("</script>");
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
		// 게시글 삭제하기 메소드 호출
		boardService.deleteBoard(num); // 글 삭제처리
		// 삭제처리 후 글목록 /board/list 로 이동
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/board/list?pageNum=" + pageNum);
		return new ResponseEntity<String>(headers, HttpStatus.FOUND); // 리다이렉트
	}
	
	@GetMapping("/reply")
	public String reply(BoardVO boardVO, @ModelAttribute("pageNum") String pageNum) {
		return "center/reWrite";
	}
	@PostMapping ("/reply")
	public String reply(BoardVO boardVO, HttpServletRequest request, String pageNum, RedirectAttributes rttr) {
		// IP주소 값 vo에 저장
		boardVO.setIp(request.getRemoteAddr());
		// 게시글 번호 생성하는 메소드 호출
		int num = boardService.nextBoardNum();
		// 생성된 번호를 자바빈 글번호 필드에 설정
		boardVO.setNum(num);
		boardVO.setReadcount(0); // 조회수 0
		// 답글쓰기 메소드 호출
		boardService.reInsertBoard(boardVO);
		//return "redirect:/board/list?pageNum="+pageNum;
		rttr.addAttribute("pageNum", pageNum);
		return "redirect:/board/list";
	}
}
