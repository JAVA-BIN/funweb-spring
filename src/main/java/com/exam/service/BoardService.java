package com.exam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exam.domain.AttachVO;
import com.exam.domain.BoardVO;
import com.exam.mapper.AttachMapper;
import com.exam.mapper.BoardMapper; 
import com.exam.repository.DBManager;

import lombok.extern.log4j.Log4j;

@Service
@Transactional
@Log4j
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private AttachMapper attachMapper;
	
		// insert할 레코드의 번호 생성 메소드
		public int nextBoardNum() {
			int bnum = boardMapper.nextBoardNum();
			return bnum;
		} // nextBoardNum method
		
		
		// 게시글 한개 등록하는 메소드
		public void insertBoard(BoardVO boardVO) {
			boardMapper.insertBoard(boardVO);
		} // insertBoard method
		
		
		// 파일게시판 게시글 한개와 첨부파일정보 등록하는 메소드
		public void insertBoardAndAttaches(BoardVO boardVO, List<AttachVO> attachList) {
			// 파일게시판 주글 등록
			boardMapper.insertBoard(boardVO);
			if (attachList.size() >0) { // 첨부파일 정보 있으면
				for (AttachVO attachVO : attachList) {
					attachMapper.insertAttach(attachVO); // 첨부파일 등록
				}
			}
		} // insertBoardAndAttaches method
		
		
		public List<BoardVO> getBoards(int startRow, int pageSize, String search) {
			List<BoardVO> list = boardMapper.getBoards(startRow, pageSize, search);
			return list;
		} // getBoards method

		
		public int getBoardCount(String search) {
			return boardMapper.getBoardCount(search);
		} // getBoardCount method
		
		
		// 특정 레코드의 조회수를 1 증가시키는 메소드
		public void updateReadcount(int num) {
			boardMapper.updateReadcount(num);
		} // updateReadcount method

		
		// 글 한개를 가져오는 메소드
		public BoardVO getBoard(int num) {
			return boardMapper.getBoard(num);
		} // getBoard method
		
		

		// 게시글 패스워드비교(로그인 안한 사용자가 수행함)
		public boolean isPasswdEqual(int num, String passwd) {
			log.info("num : " + num + ", passwd : " + passwd);
			boolean result = false;
			int count = boardMapper.countByNumPasswd(num, passwd);
			if (count == 1) {
				result = true; // 게시글 패스워드 같음
			} else { // count == 0
				result = false; // 게시글 패스워드 다름
			}
			return result;
		} // isPasswdEqual method

		
		// 게시글 수정하기 메소드
		public void updateBoard(BoardVO boardVO) {
			boardMapper.updateBoard(boardVO);
		} // updateBoard method

		
		// 글번호에 해당하는 글 한개 삭제하기 메소드
		public void deleteBoard(int num) {
			boardMapper.deleteBoard(num);
		} // deleteBoard method

		
		
		// 답글쓰기 메소드 (update 이후 insert)
		// 트랜잭션 처리가 요구됨(안전하게 처리하려는 목적)
		public boolean reInsertBoard(BoardVO boardVO) {
			boolean isInserted = false; // 답글쓰기 성공여부
			// 같은 글그룹에서의 답글순서(re_seq) 재배치 update수행
			// 조건 re_ref같은그룹 re_seq 큰값은 re_seq+1
			boardMapper.updateReplyGroupSequence(boardVO.getReRef(), boardVO.getReSeq());
			// 답글 insert re_ref그대로 re_lev+1 re_seq+1
			// re_lev 는 [답글을 다는 대상글]의 들여쓰기값 + 1
			boardVO.setReLev(boardVO.getReLev() + 1);
			// re_seq 는 [답글을 다는 대상글]의 글그룹 내 순번값 + 1
			boardVO.setReSeq(boardVO.getReSeq() + 1);
			log.info("답글: " + boardVO);
			// 답글 insert 수행
			boardMapper.insertBoard(boardVO);
			return isInserted;
		} // reInsertBoard method
}
