package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class main3champDto {
	String playerChamp;
	int champId;
	int totalCnt;
	int winCnt;
	int loseCnt;
	double winRate;
	double kda;
}
