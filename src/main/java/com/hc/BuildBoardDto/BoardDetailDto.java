package com.hc.BuildBoardDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class BoardDetailDto {
	private int bBno;
	private String bTitle;
	private String bContent;
	private String bWriter;
	private String bDate;
	
}
