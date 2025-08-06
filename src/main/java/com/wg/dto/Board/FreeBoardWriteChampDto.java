package com.wg.dto.Board;

public class FreeBoardWriteChampDto {
	private int champId;
	private String champName;
	private String champUrl;
	private String pUrl;
	private String pContent;
	private String pSkillName;
	
	public FreeBoardWriteChampDto() { }
	public FreeBoardWriteChampDto(int champId, String champName, String champUrl, String pUrl, String pContent,
			String pSkillName) {
		this.champId = champId;
		this.champName = champName;
		this.champUrl = champUrl;
		this.pUrl = pUrl;
		this.pContent = pContent;
		this.pSkillName = pSkillName;
	}
	public int getChampId() {
		return champId;
	}
	public void setChampId(int champId) {
		this.champId = champId;
	}
	public String getChampName() {
		return champName;
	}
	public void setChampName(String champName) {
		this.champName = champName;
	}
	public String getChampUrl() {
		return champUrl;
	}
	public void setChampUrl(String champUrl) {
		this.champUrl = champUrl;
	}
	public String getpUrl() {
		return pUrl;
	}
	public void setpUrl(String pUrl) {
		this.pUrl = pUrl;
	}
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	public String getpSkillName() {
		return pSkillName;
	}
	public void setpSkillName(String pSkillName) {
		this.pSkillName = pSkillName;
	}
	
	
}
