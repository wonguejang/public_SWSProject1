package com.wg.dto.RiotDto;

public class MatchRunesDto {
	private String matchId;
	private String mrSummonerId;
	private String mainRune1Url;
	private String mainRune2Url;
	private String mainRune3Url;
	private String subRune1Url;
	private String subRune2Url;
	private String subRune3Url;
	private String playerChamp;

	public MatchRunesDto()  { }

	public MatchRunesDto(String matchId, String mrSummonerId, String mainRune1Url, String mainRune2Url,
			String mainRune3Url, String subRune1Url, String subRune2Url, String subRune3Url, String playerChamp) {
		this.matchId = matchId;
		this.mrSummonerId = mrSummonerId;
		this.mainRune1Url = mainRune1Url;
		this.mainRune2Url = mainRune2Url;
		this.mainRune3Url = mainRune3Url;
		this.subRune1Url = subRune1Url;
		this.subRune2Url = subRune2Url;
		this.subRune3Url = subRune3Url;
		this.playerChamp = playerChamp;
	}

	public String getMatchId() {
		return matchId;
	}

	public void setMatchId(String matchId) {
		this.matchId = matchId;
	}

	public String getMrSummonerId() {
		return mrSummonerId;
	}

	public void setMrSummonerId(String mrSummonerId) {
		this.mrSummonerId = mrSummonerId;
	}

	public String getMainRune1Url() {
		return mainRune1Url;
	}

	public void setMainRune1Url(String mainRune1Url) {
		this.mainRune1Url = mainRune1Url;
	}

	public String getMainRune2Url() {
		return mainRune2Url;
	}

	public void setMainRune2Url(String mainRune2Url) {
		this.mainRune2Url = mainRune2Url;
	}

	public String getMainRune3Url() {
		return mainRune3Url;
	}

	public void setMainRune3Url(String mainRune3Url) {
		this.mainRune3Url = mainRune3Url;
	}

	public String getSubRune1Url() {
		return subRune1Url;
	}

	public void setSubRune1Url(String subRune1Url) {
		this.subRune1Url = subRune1Url;
	}

	public String getSubRune2Url() {
		return subRune2Url;
	}

	public void setSubRune2Url(String subRune2Url) {
		this.subRune2Url = subRune2Url;
	}

	public String getSubRune3Url() {
		return subRune3Url;
	}

	public void setSubRune3Url(String subRune3Url) {
		this.subRune3Url = subRune3Url;
	}

	public String getPlayerChamp() {
		return playerChamp;
	}

	public void setPlayerChamp(String playerChamp) {
		this.playerChamp = playerChamp;
	}
	 
}
