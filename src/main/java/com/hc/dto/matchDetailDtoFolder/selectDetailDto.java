package com.hc.dto.matchDetailDtoFolder;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class selectDetailDto {
	String MatchId;
	String mdSummonerId;
	String playerChamp;
	int champId;
	int playerKills;
	int playerDeaths;
	int playerAssists;
	int playerDamage;
	int teamId;
	int banPick;
	String puuid;
}
