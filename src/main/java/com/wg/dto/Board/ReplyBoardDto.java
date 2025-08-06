package com.wg.dto.Board;

public class ReplyBoardDto {
	private int rno;
	private String rWriter;
	private String rWritedate;
	private String rContent;
	private Integer rFBoardBno;
	private Integer rBBoardBno;
	private Integer rPBoardBno;

	public ReplyBoardDto() { }

	public ReplyBoardDto(int rno, String rWriter, String rWritedate, String rContent, Integer rFBoardBno,
			Integer rBBoardBno, Integer rPBoardBno) {
		this.rno = rno;
		this.rWriter = rWriter;
		this.rWritedate = rWritedate;
		this.rContent = rContent;
		this.rFBoardBno = rFBoardBno;
		this.rBBoardBno = rBBoardBno;
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

	public String getrWritedate() {
		return rWritedate;
	}

	public void setrWritedate(String rWritedate) {
		this.rWritedate = rWritedate;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public Integer getrFBoardBno() {
		return rFBoardBno;
	}

	public void setrFBoardBno(Integer rFBoardBno) {
		this.rFBoardBno = rFBoardBno;
	}

	public Integer getrBBoardBno() {
		return rBBoardBno;
	}

	public void setrBBoardBno(Integer rBBoardBno) {
		this.rBBoardBno = rBBoardBno;
	}

	public Integer getrPBoardBno() {
		return rPBoardBno;
	}

	public void setrPBoardBno(Integer rPBoardBno) {
		this.rPBoardBno = rPBoardBno;
	}

	
}
