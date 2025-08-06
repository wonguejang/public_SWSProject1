package com.wg.dto.RiotDto;

public class SummonerInfoDto {
	private String summonerId;
	private String summonerChampName;
	private int summonerChampId;
	private String ranks;
	private int leaguePoints;
	private double winRate;
	private int win;
	private int lose;
	private int summonerIcon;
	private String puuid;

	public SummonerInfoDto() { }
	public SummonerInfoDto(String summonerId, String summonerChampName, int summonerChampId, String ranks,
			int leaguePoints, double winRate, int win, int lose, int summonerIcon, String puuid) {
		this.summonerId = summonerId;
		this.summonerChampName = summonerChampName;
		this.summonerChampId = summonerChampId;
		this.ranks = ranks;
		this.leaguePoints = leaguePoints;
		this.winRate = winRate;
		this.win = win;
		this.lose = lose;
		this.summonerIcon = summonerIcon;
		this.puuid = puuid;
	}
	public String getSummonerId() {
		return summonerId;
	}
	public void setSummonerId(String summonerId) {
		this.summonerId = summonerId;
	}
	public String getSummonerChampName() {
		return summonerChampName;
	}
	public void setSummonerChampName(String summonerChampName) {
		this.summonerChampName = summonerChampName;
	}
	public int getSummonerChampId() {
		return summonerChampId;
	}
	public void setSummonerChampId(int summonerChampId) {
		this.summonerChampId = summonerChampId;
	}
	public String getRanks() {
		return ranks;
	}
	public void setRanks(String ranks) {
		this.ranks = ranks;
	}
	public int getLeaguePoints() {
		return leaguePoints;
	}
	public void setLeaguePoints(int leaguePoints) {
		this.leaguePoints = leaguePoints;
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
	public int getSummonerIcon() {
		return summonerIcon;
	}
	public void setSummonerIcon(int summonerIcon) {
		this.summonerIcon = summonerIcon;
	}
	public String getPuuid() {
		return puuid;
	}
	public void setPuuid(String puuid) {
		this.puuid = puuid;
	}
	
}
