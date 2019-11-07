package com.exam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exam.domain.MemberVO;
import com.exam.mapper.MemberMapper;

// @Component 가 확장된 애노테이션
// @Controller, @service, @Repository
@Service
@Transactional
public class MemberService {
	@Autowired
	private  MemberMapper memberMapper; // mapper를 한번에 생성해줌
	
	public int insertMember(MemberVO memberVO) {
		return memberMapper.insertMember(memberVO); // mapper 사용
	} // insertMember method
	
	public int userCheck(String id, String passwd) {
		int check = -1;
		MemberVO memberVO = memberMapper.getMemberById(id);
		if (memberVO != null) {
			if (passwd.equals(memberVO.getPasswd())) {
				check = 1;
			} else {
				check = 0;
			}
		} else {
			check = -1;
		}
		return check;
	} // userCheck method
	
	// 아이디 중복여부 확인
	public boolean isIdDuplicated(String id) {
		// 중복이면 true, 중복아니면 false
		boolean isIdDuplicated = false;
		// 회원 가입(추가)
		int count = memberMapper.countMemberById(id);
		if (count > 0) {
			isIdDuplicated = true;
		}
		return isIdDuplicated;
	}
}
