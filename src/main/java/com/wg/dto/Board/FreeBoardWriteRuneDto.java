package com.wg.dto.Board;

public class FreeBoardWriteRuneDto {
	private String runeId;
	private String runeName;
	private String runeType;
	private String runeUrl;
	private String runeContent;

	public FreeBoardWriteRuneDto() { }
	public FreeBoardWriteRuneDto(String runeId, String runeName, String runeType, String runeUrl, String runeContent) {
		this.runeId = runeId;
		this.runeName = runeName;
		this.runeType = runeType;
		this.runeUrl = runeUrl;
		this.runeContent = runeContent;
	}
	public String getRuneId() {
		return runeId;
	}
	public void setRuneId(String runeId) {
		this.runeId = runeId;
	}
	public String getRuneName() {
		return runeName;
	}
	public void setRuneName(String runeName) {
		this.runeName = runeName;
	}
	public String getRuneType() {
		return runeType;
	}
	public void setRuneType(String runeType) {
		this.runeType = runeType;
	}
	public String getRuneUrl() {
		return runeUrl;
	}
	public void setRuneUrl(String runeUrl) {
		this.runeUrl = runeUrl;
	}
	public String getRuneContent() {
		return runeContent;
	}
	public void setRuneContent(String runeContent) {
		this.runeContent = runeContent;
	}
	
}
