package com.sw.service;

import com.sw.dto.ReplyBoardDto;
import java.util.List;

//인터페이스
public interface ReplyBoardService {
 void insertReply(ReplyBoardDto dto);
 void deleteReplyByRno(int rno);
 List<ReplyBoardDto> getRepliesByBoardBno(int bno);
 ReplyBoardDto getReplyByRno(int rno);
 void deleteReply(int rno);
 void updateReply(ReplyBoardDto dto);
}

