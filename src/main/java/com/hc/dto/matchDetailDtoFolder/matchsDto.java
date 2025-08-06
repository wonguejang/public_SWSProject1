package com.hc.dto.matchDetailDtoFolder;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class matchsDto {
	String matchId;
	String endTime;
	int playTime;
	int winnerTeam;
}
