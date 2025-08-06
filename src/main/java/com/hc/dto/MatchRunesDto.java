package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MatchRunesDto {
	private String match_id;
	private String mr_summoner_id;
	private int match_main_rune_1;
	private int match_main_rune_2;
	private int match_main_rune_3;
	private int match_main_rune_4;
	private int match_sub_rune_1;
	private int match_sub_rune_2;
}