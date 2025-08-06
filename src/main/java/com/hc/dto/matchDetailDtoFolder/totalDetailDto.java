package com.hc.dto.matchDetailDtoFolder;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class totalDetailDto {
	String MatchId;				//
	String mdSummonerId;		//
	String playerChamp;			//
	int champId;				//
	int playerKills;			//
	int playerDeaths;			//
	int playerAssists;			//
	int playerDamage;			//
	int teamId;					//
	int banPick;				//
	String mdPuuid;				//
	int matchItem1;				//
	int matchItem2;				//
	int matchItem3;				//
	int matchItem4;				//
	int matchItem5;				//
	int matchItem6;				//
	int matchItem7;				//
	String championUrl;			//
	String endTime;				//
	String playTime;			//
	int winnerTeam;				//
	String winOrLosses;			//
}
