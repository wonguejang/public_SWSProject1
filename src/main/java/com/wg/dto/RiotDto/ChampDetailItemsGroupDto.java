package com.wg.dto.RiotDto;

import java.util.List;

public class ChampDetailItemsGroupDto {
	private List<MatchItemsDto> item1List;
	private List<MatchItemsDto> item2List;
	private List<MatchItemsDto> item3List;

	public ChampDetailItemsGroupDto() { } 
	public ChampDetailItemsGroupDto(List<MatchItemsDto> item1List, List<MatchItemsDto> item2List,
			List<MatchItemsDto> item3List) {
		this.item1List = item1List;
		this.item2List = item2List;
		this.item3List = item3List;
	}
	public List<MatchItemsDto> getItem1List() {
		return item1List;
	}
	public void setItem1List(List<MatchItemsDto> item1List) {
		this.item1List = item1List;
	}
	public List<MatchItemsDto> getItem2List() {
		return item2List;
	}
	public void setItem2List(List<MatchItemsDto> item2List) {
		this.item2List = item2List;
	}
	public List<MatchItemsDto> getItem3List() {
		return item3List;
	}
	public void setItem3List(List<MatchItemsDto> item3List) {
		this.item3List = item3List;
	}
	
	
}
