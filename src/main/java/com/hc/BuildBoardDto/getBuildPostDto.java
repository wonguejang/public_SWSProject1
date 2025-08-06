package com.hc.BuildBoardDto;

import com.fasterxml.jackson.annotation.JsonProperty;

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
    @JsonProperty("bbno")
    private int bBno;
    @JsonProperty("bchamp")
    private String bChamp;
    @JsonProperty("btitle")
    private String bTitle;
    @JsonProperty("bcontent")
    private String bContent;
    @JsonProperty("bwriter")
    private String bWriter;
    @JsonProperty("bdate")
    private String bDate;
    @JsonProperty("bcheck")
    private int bCheck;
    @JsonProperty("brating")
    private int bRating;
}