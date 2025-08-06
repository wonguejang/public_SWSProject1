package com.wg.dto.RiotDto;

public class MatchsDto {
	private String matchId;
	private String endTime;
	private String winnerTeam;

	public MatchsDto() { }
	public MatchsDto(String matchId, String endTime, String winnerTeam) {
		this.matchId = matchId;
		this.endTime = endTime;
		this.winnerTeam = winnerTeam;
	}
	public String getMatchId() {
		return matchId;
	}
	public void setMatchId(String matchId) {
		this.matchId = matchId;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getWinnerTeam() {
		return winnerTeam;
	}
	public void setWinnerTeam(String winnerTeam) {
		this.winnerTeam = winnerTeam;
	}
	
	
}

