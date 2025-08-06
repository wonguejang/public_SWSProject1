package com.wg.dto.Board;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class FreeBoardDto {
	private int fBno;
	private String fTitle;
	private String fContent;
	private String fWriter;
	private Date fDate;
	private String fFormattedDate;
	private int fRepltCount;
	private int fCheck;
	private int fLike;
	private int fDelike;

	public FreeBoardDto() { }
	public FreeBoardDto(int fBno, String fTitle, String fContent, String fWriter, Date fDate, String fFormattedDate,
			int fRepltCount, int fCheck, int fLike, int fDelike) {
		this.fBno = fBno;
		this.fTitle = fTitle;
		this.fContent = fContent;
		this.fWriter = fWriter;
		this.fDate = fDate;
		this.fFormattedDate = fFormattedDate;
		this.fRepltCount = fRepltCount;
		this.fCheck = fCheck;
		this.fLike = fLike;
		this.fDelike = fDelike;
	}

	public String getfDateString() {
	    if (fDate == null) return "";
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
	    return sdf.format(fDate);
	}

	public int getfBno() {
		return fBno;
	}

	public void setfBno(int fBno) {
		this.fBno = fBno;
	}

	public String getfTitle() {
		return fTitle;
	}

	public void setfTitle(String fTitle) {
		this.fTitle = fTitle;
	}

	public String getfContent() {
		return fContent;
	}

	public void setfContent(String fContent) {
		this.fContent = fContent;
	}

	public String getfWriter() {
		return fWriter;
	}

	public void setfWriter(String fWriter) {
		this.fWriter = fWriter;
	}

	public Date getfDate() {
		return fDate;
	}

	public void setfDate(Date fDate) {
		this.fDate = fDate;
	}

	public String getfFormattedDate() {
		return fFormattedDate;
	}

	public void setfFormattedDate(String fFormattedDate) {
		this.fFormattedDate = fFormattedDate;
	}

	public int getfRepltCount() {
		return fRepltCount;
	}

	public void setfRepltCount(int fRepltCount) {
		this.fRepltCount = fRepltCount;
	}

	public int getfCheck() {
		return fCheck;
	}

	public void setfCheck(int fCheck) {
		this.fCheck = fCheck;
	}

	public int getfLike() {
		return fLike;
	}

	public void setfLike(int fLike) {
		this.fLike = fLike;
	}

	public int getfDelike() {
		return fDelike;
	}

	public void setfDelike(int fDelike) {
		this.fDelike = fDelike;
	}


}
