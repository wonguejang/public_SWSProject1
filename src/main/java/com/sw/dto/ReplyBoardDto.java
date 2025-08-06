package com.sw.dto;

import java.util.Date;

public class ReplyBoardDto {
    private int rno;
    private String rWriter;
    private String rContent;
    private Date rWritedate;
    private int rPBoardBno;
    
    public ReplyBoardDto() { }
	public ReplyBoardDto(int rno, String rWriter, String rContent, Date rWritedate, int rPBoardBno) {
		this.rno = rno;
		this.rWriter = rWriter;
		this.rContent = rContent;
		this.rWritedate = rWritedate;
		this.rPBoardBno = rPBoardBno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getrWriter() {
		return rWriter;
	}
	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public Date getrWritedate() {
		return rWritedate;
	}
	public void setrWritedate(Date rWritedate) {
		this.rWritedate = rWritedate;
	}
	public int getrPBoardBno() {
		return rPBoardBno;
	}
	public void setrPBoardBno(int rPBoardBno) {
		this.rPBoardBno = rPBoardBno;
	}
	
}
