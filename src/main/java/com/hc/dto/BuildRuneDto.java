package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BuildRuneDto {
    private int cbrChampId;
    private String cbrSummonerPuuid;
    private char runeCOrS;
    private int cbrChampMain1;
    private int cbrChampMain2;
    private int cbrChampMain3;
    private int cbrChampMain4;
    private int cbrChampSub1;
    private int cbrChampSub2;
}