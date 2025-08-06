package com.wg.dto.Board;

public class FreeBoardWriteItemDto {
	private String itemId;
	private String itemName;
	private String itemUrl;
	private String itemContent;

	public FreeBoardWriteItemDto() { } 
	public FreeBoardWriteItemDto(String itemId, String itemName, String itemUrl, String itemContent) {
		this.itemId = itemId;
		this.itemName = itemName;
		this.itemUrl = itemUrl;
		this.itemContent = itemContent;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemUrl() {
		return itemUrl;
	}
	public void setItemUrl(String itemUrl) {
		this.itemUrl = itemUrl;
	}
	public String getItemContent() {
		return itemContent;
	}
	public void setItemContent(String itemContent) {
		this.itemContent = itemContent;
	}
	
}
