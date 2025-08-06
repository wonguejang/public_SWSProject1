package com.wg.dto.RiotDto;

public class RankDto {
	private int rnum;
	private String userIcon;
	private String summonerId;
	private int rating;
	private double winRate;
	private int win;
	private int lose;

	public RankDto() { }
	public RankDto(int rnum, String userIcon, String summonerId, int rating, double winRate, int win, int lose) {
		this.rnum = rnum;
		this.userIcon = userIcon;
		this.summonerId = summonerId;
		this.rating = rating;
		this.winRate = winRate;
		this.win = win;
		this.lose = lose;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getUserIcon() {
		return userIcon;
	}

	public void setUserIcon(String userIcon) {
		this.userIcon = userIcon;
	}

	public String getSummonerId() {
		return summonerId;
	}

	public void setSummonerId(String summonerId) {
		this.summonerId = summonerId;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public double getWinRate() {
		return winRate;
	}

	public void setWinRate(double winRate) {
		this.winRate = winRate;
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

}
