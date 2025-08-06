package com.sw.dto;

import java.util.Date; 

public class PatchBoardDto {
    private int pBno;
    private String pTitle;
    private String pContent;
    private String pWriter;
    private Date pDate; 
    private int pCheck;
    private int pRating;
    private int pUnrating;
	
    public PatchBoardDto() { }
	public PatchBoardDto(int pBno, String pTitle, String pContent, String pWriter, Date pDate, int pCheck, int pRating,
			int pUnrating) {
		this.pBno = pBno;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pWriter = pWriter;
		this.pDate = pDate;
		this.pCheck = pCheck;
		this.pRating = pRating;
		this.pUnrating = pUnrating;
	}
	public int getpBno() {
		return pBno;
	}
	public void setpBno(int pBno) {
		this.pBno = pBno;
	}
	public String getpTitle() {
		return pTitle;
	}
	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	public String getpWriter() {
		return pWriter;
	}
	public void setpWriter(String pWriter) {
		this.pWriter = pWriter;
	}
	public Date getpDate() {
		return pDate;
	}
	public void setpDate(Date pDate) {
		this.pDate = pDate;
	}
	public int getpCheck() {
		return pCheck;
	}
	public void setpCheck(int pCheck) {
		this.pCheck = pCheck;
	}
	public int getpRating() {
		return pRating;
	}
	public void setpRating(int pRating) {
		this.pRating = pRating;
	}
	public int getpUnrating() {
		return pUnrating;
	}
	public void setpUnrating(int pUnrating) {
		this.pUnrating = pUnrating;
	}

}