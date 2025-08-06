package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MatchShardsDto {
	private String match_id;
	private String summoner_id;
	private int offense;
	private int flex;
	private int defense;
}
