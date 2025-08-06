package com.sw.dao;

import java.util.List;
import com.sw.dto.ReplyBoardDto;

public interface ReplyBoardDao {
    void insertReply(ReplyBoardDto dto);
    List<ReplyBoardDto> getRepliesByBoardBno(int bno);
    void deleteReply(int rno);
    ReplyBoardDto getReplyByRno(int rno);
    void updateReply(ReplyBoardDto dto); 
    
}
