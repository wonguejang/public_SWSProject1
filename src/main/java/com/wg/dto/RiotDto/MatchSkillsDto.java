package com.wg.dto.RiotDto;

import java.util.Arrays;
import java.util.List;

public class MatchSkillsDto {
	private String matchId;
	private String msSummonerId;
	private String matchSkill1;
	private String matchSkill2;
	private String matchSkill3;
	private String matchSkill4;
	private String matchSkill5;
	private String matchSkill6;
	private String matchSkill7;
	private String matchSkill8;
	private String matchSkill9;
	private String matchSkill10;
	private String matchSkill11;
	private String matchSkill12;
	private String matchSkill13;
	private String matchSkill14;
	private String matchSkill15;
	private String matchSkill16;
	private String matchSkill17;
	private String matchSkill18;
	private String playerChamp;

	public MatchSkillsDto() { }
	public List<String> getSkillDtoList() {
		
		return Arrays.asList(
		        matchSkill1, matchSkill2, matchSkill3,
		        matchSkill4, matchSkill5, matchSkill6,
		        matchSkill7, matchSkill8, matchSkill9,
		        matchSkill10, matchSkill11, matchSkill12,
		        matchSkill13, matchSkill14, matchSkill15,
		        matchSkill16, matchSkill17, matchSkill18
		    );
	}
	public MatchSkillsDto(String matchId, String msSummonerId, String matchSkill1, String matchSkill2,
			String matchSkill3, String matchSkill4, String matchSkill5, String matchSkill6, String matchSkill7,
			String matchSkill8, String matchSkill9, String matchSkill10, String matchSkill11, String matchSkill12,
			String matchSkill13, String matchSkill14, String matchSkill15, String matchSkill16, String matchSkill17,
			String matchSkill18, String playerChamp) {
		this.matchId = matchId;
		this.msSummonerId = msSummonerId;
		this.matchSkill1 = matchSkill1;
		this.matchSkill2 = matchSkill2;
		this.matchSkill3 = matchSkill3;
		this.matchSkill4 = matchSkill4;
		this.matchSkill5 = matchSkill5;
		this.matchSkill6 = matchSkill6;
		this.matchSkill7 = matchSkill7;
		this.matchSkill8 = matchSkill8;
		this.matchSkill9 = matchSkill9;
		this.matchSkill10 = matchSkill10;
		this.matchSkill11 = matchSkill11;
		this.matchSkill12 = matchSkill12;
		this.matchSkill13 = matchSkill13;
		this.matchSkill14 = matchSkill14;
		this.matchSkill15 = matchSkill15;
		this.matchSkill16 = matchSkill16;
		this.matchSkill17 = matchSkill17;
		this.matchSkill18 = matchSkill18;
		this.playerChamp = playerChamp;
	}

	public String getMatchId() {
		return matchId;
	}

	public void setMatchId(String matchId) {
		this.matchId = matchId;
	}

	public String getMsSummonerId() {
		return msSummonerId;
	}

	public void setMsSummonerId(String msSummonerId) {
		this.msSummonerId = msSummonerId;
	}

	public String getMatchSkill1() {
		return matchSkill1;
	}

	public void setMatchSkill1(String matchSkill1) {
		this.matchSkill1 = matchSkill1;
	}

	public String getMatchSkill2() {
		return matchSkill2;
	}

	public void setMatchSkill2(String matchSkill2) {
		this.matchSkill2 = matchSkill2;
	}

	public String getMatchSkill3() {
		return matchSkill3;
	}

	public void setMatchSkill3(String matchSkill3) {
		this.matchSkill3 = matchSkill3;
	}

	public String getMatchSkill4() {
		return matchSkill4;
	}

	public void setMatchSkill4(String matchSkill4) {
		this.matchSkill4 = matchSkill4;
	}

	public String getMatchSkill5() {
		return matchSkill5;
	}

	public void setMatchSkill5(String matchSkill5) {
		this.matchSkill5 = matchSkill5;
	}

	public String getMatchSkill6() {
		return matchSkill6;
	}

	public void setMatchSkill6(String matchSkill6) {
		this.matchSkill6 = matchSkill6;
	}

	public String getMatchSkill7() {
		return matchSkill7;
	}

	public void setMatchSkill7(String matchSkill7) {
		this.matchSkill7 = matchSkill7;
	}

	public String getMatchSkill8() {
		return matchSkill8;
	}

	public void setMatchSkill8(String matchSkill8) {
		this.matchSkill8 = matchSkill8;
	}

	public String getMatchSkill9() {
		return matchSkill9;
	}

	public void setMatchSkill9(String matchSkill9) {
		this.matchSkill9 = matchSkill9;
	}

	public String getMatchSkill10() {
		return matchSkill10;
	}

	public void setMatchSkill10(String matchSkill10) {
		this.matchSkill10 = matchSkill10;
	}

	public String getMatchSkill11() {
		return matchSkill11;
	}

	public void setMatchSkill11(String matchSkill11) {
		this.matchSkill11 = matchSkill11;
	}

	public String getMatchSkill12() {
		return matchSkill12;
	}

	public void setMatchSkill12(String matchSkill12) {
		this.matchSkill12 = matchSkill12;
	}

	public String getMatchSkill13() {
		return matchSkill13;
	}

	public void setMatchSkill13(String matchSkill13) {
		this.matchSkill13 = matchSkill13;
	}

	public String getMatchSkill14() {
		return matchSkill14;
	}

	public void setMatchSkill14(String matchSkill14) {
		this.matchSkill14 = matchSkill14;
	}

	public String getMatchSkill15() {
		return matchSkill15;
	}

	public void setMatchSkill15(String matchSkill15) {
		this.matchSkill15 = matchSkill15;
	}

	public String getMatchSkill16() {
		return matchSkill16;
	}

	public void setMatchSkill16(String matchSkill16) {
		this.matchSkill16 = matchSkill16;
	}

	public String getMatchSkill17() {
		return matchSkill17;
	}

	public void setMatchSkill17(String matchSkill17) {
		this.matchSkill17 = matchSkill17;
	}

	public String getMatchSkill18() {
		return matchSkill18;
	}

	public void setMatchSkill18(String matchSkill18) {
		this.matchSkill18 = matchSkill18;
	}

	public String getPlayerChamp() {
		return playerChamp;
	}

	public void setPlayerChamp(String playerChamp) {
		this.playerChamp = playerChamp;
	}
	
}
