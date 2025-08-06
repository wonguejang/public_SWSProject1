package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SummonerInfoDto {
	private String puuid;
    private String summonerId;
    private String summonerChampName;
    private int summonerChampId;
    private String ranks;
    private int leaguePoints;
    private double winrate;
    private int win;
    private int lose;
    private int summonerIcon;
}
