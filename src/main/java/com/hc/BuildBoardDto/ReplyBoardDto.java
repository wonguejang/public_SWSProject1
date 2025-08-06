package com.hc.BuildBoardDto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReplyBoardDto {
    @JsonProperty("rWriter")
    private String rWriter;
    @JsonProperty("rWritedate")
    private String rWritedate;
    @JsonProperty("rContent")
    private String rContent;
    @JsonProperty("rno")
    private int rno;
    @JsonProperty("rFBoardBno")
    private int rFBoardBno;
    @JsonProperty("rBBoardBno")
    private int rBBoardBno;
    @JsonProperty("rPBoardBno")
    private int rPBoardBno;
}