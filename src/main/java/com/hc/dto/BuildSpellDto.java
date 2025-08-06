package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BuildSpellDto {
    private int cbSpellChampId;
    private String cbSpellSummonerPuuid;
    private char spellCOrS;
    private String cbSpell1;
    private String cbSpell2;
}