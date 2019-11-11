package com.exam.domain;

import java.util.Date;

import lombok.Data;
@Data
public class BoardVO {
	private int num; 
	private String username; 
	private String passwd;
	private String subject;
	private String content;
	private int readcount;
	private String ip;
	private Date regDate;
	private int reRef;
	private int reLev;
	private int reSeq;
}
