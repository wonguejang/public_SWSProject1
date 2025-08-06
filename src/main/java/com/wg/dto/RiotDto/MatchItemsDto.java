package com.wg.dto.RiotDto;

public class MatchItemsDto {
	private String macthId;
	private String miSummonerId;
	private String matchItem;
	private int matchItem1;
	private int matchItem2;
	private int matchItem3;
	private int matchItem4;
	private int matchItem5;
	private int matchItem6;
	private int matchItem7;
	private String playerChamp;

	public MatchItemsDto() { }

	public MatchItemsDto(String macthId, String miSummonerId, String matchItem, int matchItem1, int matchItem2,
			int matchItem3, int matchItem4, int matchItem5, int matchItem6, int matchItem7, String playerChamp) {
		super();
		this.macthId = macthId;
		this.miSummonerId = miSummonerId;
		this.matchItem = matchItem;
		this.matchItem1 = matchItem1;
		this.matchItem2 = matchItem2;
		this.matchItem3 = matchItem3;
		this.matchItem4 = matchItem4;
		this.matchItem5 = matchItem5;
		this.matchItem6 = matchItem6;
		this.matchItem7 = matchItem7;
		this.playerChamp = playerChamp;
	}

	public String getMacthId() {
		return macthId;
	}

	public void setMacthId(String macthId) {
		this.macthId = macthId;
	}

	public String getMiSummonerId() {
		return miSummonerId;
	}

	public void setMiSummonerId(String miSummonerId) {
		this.miSummonerId = miSummonerId;
	}

	public String getMatchItem() {
		return matchItem;
	}

	public void setMatchItem(String matchItem) {
		this.matchItem = matchItem;
	}

	public int getMatchItem1() {
		return matchItem1;
	}

	public void setMatchItem1(int matchItem1) {
		this.matchItem1 = matchItem1;
	}

	public int getMatchItem2() {
		return matchItem2;
	}

	public void setMatchItem2(int matchItem2) {
		this.matchItem2 = matchItem2;
	}

	public int getMatchItem3() {
		return matchItem3;
	}

	public void setMatchItem3(int matchItem3) {
		this.matchItem3 = matchItem3;
	}

	public int getMatchItem4() {
		return matchItem4;
	}

	public void setMatchItem4(int matchItem4) {
		this.matchItem4 = matchItem4;
	}

	public int getMatchItem5() {
		return matchItem5;
	}

	public void setMatchItem5(int matchItem5) {
		this.matchItem5 = matchItem5;
	}

	public int getMatchItem6() {
		return matchItem6;
	}

	public void setMatchItem6(int matchItem6) {
		this.matchItem6 = matchItem6;
	}

	public int getMatchItem7() {
		return matchItem7;
	}

	public void setMatchItem7(int matchItem7) {
		this.matchItem7 = matchItem7;
	}

	public String getPlayerChamp() {
		return playerChamp;
	}

	public void setPlayerChamp(String playerChamp) {
		this.playerChamp = playerChamp;
	}
		
}