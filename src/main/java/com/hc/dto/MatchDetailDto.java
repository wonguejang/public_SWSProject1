package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MatchDetailDto {
	private String match_id;
	private String md_summoner_id;
	private String player_champ;
	private int champ_id;
	private int player_kills;
	private int player_deaths;
	private int player_assists;
	private int player_damage;
	private int team_id;
	private int ban_pick;
	private String md_puuid;
}
