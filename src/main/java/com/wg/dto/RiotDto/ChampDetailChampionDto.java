package com.wg.dto.RiotDto;

public class ChampDetailChampionDto {
	private String champName;
	private String ChampUrl;
	private int win;
	private int lose;
	private double winRate;

	public ChampDetailChampionDto() { }
	public ChampDetailChampionDto(String champName, String champUrl, int win, int lose, double winRate) {
		this.champName = champName;
		this.ChampUrl = champUrl;
		this.win = win;
		this.lose = lose;
		this.winRate = winRate;
	}
	public String getChampName() {
		return champName;
	}
	public void setChampName(String champName) {
		this.champName = champName;
	}
	public String getChampUrl() {
		return ChampUrl;
	}
	public void setChampUrl(String champUrl) {
		ChampUrl = champUrl;
	}
	public int getWin() {
		return win;
	}
	public void setWin(int win) {
		this.win = win;
	}
	public int getLose() {
		return lose;
	}
	public void setLose(int lose) {
		this.lose = lose;
	}
	public double getWinRate() {
		return winRate;
	}
	public void setWinRate(double winRate) {
		this.winRate = winRate;
	}
	
}
