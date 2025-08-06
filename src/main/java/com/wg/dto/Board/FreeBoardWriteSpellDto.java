package com.wg.dto.Board;

public class FreeBoardWriteSpellDto {
	private int spellId;
	private String spellUrl;
	private String spellContent;
	private String spellName;

	public FreeBoardWriteSpellDto() { }
	public FreeBoardWriteSpellDto(int spellId, String spellUrl, String spellContent, String spellName) {
		this.spellId = spellId;
		this.spellUrl = spellUrl;
		this.spellContent = spellContent;
		this.spellName = spellName;
	}
	public int getSpellId() {
		return spellId;
	}
	public void setSpellId(int spellId) {
		this.spellId = spellId;
	}
	public String getSpellUrl() {
		return spellUrl;
	}
	public void setSpellUrl(String spellUrl) {
		this.spellUrl = spellUrl;
	}
	public String getSpellContent() {
		return spellContent;
	}
	public void setSpellContent(String spellContent) {
		this.spellContent = spellContent;
	}
	public String getSpellName() {
		return spellName;
	}
	public void setSpellName(String spellName) {
		this.spellName = spellName;
	}
	
}
