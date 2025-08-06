package com.hc.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MatchItemsDto {
	private String matchId;
	private String miSummonerId;
	private int matchItem1;
	private int matchItem2;
	private int matchItem3;
	private int matchItem4;
	private int matchItem5;
	private int matchItem6;
	private int matchItem7;
}
