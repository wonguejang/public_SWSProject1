package com.hc.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SummonerInsertMainChampDto {
	String playerChamp;
	int playerChampId;
	String puuid;
}
