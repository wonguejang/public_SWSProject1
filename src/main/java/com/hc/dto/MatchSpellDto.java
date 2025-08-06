package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MatchSpellDto {
	private String m_spell_match_id;
	private String m_spell_summoner_id;
	private int match_spell_1;
	private int match_spell_2;
}
