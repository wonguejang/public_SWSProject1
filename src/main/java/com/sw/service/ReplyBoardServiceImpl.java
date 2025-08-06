package com.sw.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sw.dao.ReplyBoardDao;
import com.sw.dto.ReplyBoardDto;

// 구현체
@Service
public class ReplyBoardServiceImpl implements ReplyBoardService {

    @Autowired
    private ReplyBoardDao dao;

    @Override
    public void insertReply(ReplyBoardDto dto) {
        dao.insertReply(dto);
    }

    @Override
    public void deleteReplyByRno(int rno) {
        dao.deleteReply(rno);
    }

    @Override
    public List<ReplyBoardDto> getRepliesByBoardBno(int bno) {
        return dao.getRepliesByBoardBno(bno);
    }
    @Override
    public ReplyBoardDto getReplyByRno(int rno) {
        return dao.getReplyByRno(rno);
    }
    @Override
    public void deleteReply(int rno) {
        dao.deleteReply(rno);
    }
    @Override
    public void updateReply(ReplyBoardDto dto) {
        dao.updateReply(dto); // dao는 ReplyBoardDao
    }

}
