package com.exam.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exam.domain.AttachVO;
import com.exam.mapper.AttachMapper;

@Service
@Transactional
public class AttachService {
	private AttachMapper attachMapper;
	public void insertAttach(AttachVO attachVO) {
		attachMapper.insertAttach(attachVO);
	}
	public void insertAttachges(List<AttachVO> attachList) { 
		for (AttachVO attachVO : attachList) {
			attachMapper.insertAttach(attachVO);
		}
	}
	public List<AttachVO> getAttaches(int bno) {
		return attachMapper.getAttaches(bno);
	}
	public void deleteAttachByBno(int bno) {
		attachMapper.deleteAttachByBno(bno);
	}
	public void deleteAttachByUuid(String uuid) {
		attachMapper.deleteAttachByUuid(uuid);
	}
	
	
}
