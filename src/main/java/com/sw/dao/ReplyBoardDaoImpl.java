package com.sw.dao;

import com.sw.dto.ReplyBoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReplyBoardDaoImpl implements ReplyBoardDao {

    private static final String NAMESPACE = "com.sw.dao.ReplyBoardDao.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public void insertReply(ReplyBoardDto dto) {
        sqlSession.insert(NAMESPACE + "insertReply", dto);
    }

    @Override
    public List<ReplyBoardDto> getRepliesByBoardBno(int bno) {
        return sqlSession.selectList(NAMESPACE + "getRepliesByBoardBno", bno);
    }

    @Override
    public void deleteReply(int rno) {
        sqlSession.delete(NAMESPACE + "deleteReply", rno);
    }

    @Override
    public ReplyBoardDto getReplyByRno(int rno) {
        return sqlSession.selectOne(NAMESPACE + "getReplyByRno", rno);
    }

    @Override
    public void updateReply(ReplyBoardDto dto) {
        sqlSession.update(NAMESPACE + "updateReply", dto);
    }
}
