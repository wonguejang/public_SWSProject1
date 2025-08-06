package com.hc.BuildBoardDtoFolder;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class getBuildPostDto {
	private int bBno;
	private String bChamp;
	private String bTitle;
	private String bContent;
	private String bWriter;
	private String bDate;
	private int bCheck;
	private int bRating;
}
