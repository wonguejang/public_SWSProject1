package com.sw.dao;

import com.sw.dto.PatchBoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatchBoardDaoImpl implements PatchBoardDao {

    private static final String NAMESPACE = "com.sw.dao.PatchBoardDao.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<PatchBoardDto> getAllPosts() {
        return sqlSession.selectList(NAMESPACE + "getAllPosts");
    }

    @Override
    public PatchBoardDto getPostById(int bno) {
        return sqlSession.selectOne(NAMESPACE + "getPostById", bno);
    }

    @Override
    public void insertPost(PatchBoardDto dto) {
        sqlSession.insert(NAMESPACE + "insertPost", dto);
    }

    @Override
    public void updatePost(PatchBoardDto dto) {
        sqlSession.update(NAMESPACE + "updatePost", dto);
    }

    @Override
    public void deletePost(int bno) {
        sqlSession.delete(NAMESPACE + "deletePost", bno);
    }

    @Override
    public void increaseViewCount(int p_bno) {
        sqlSession.update(NAMESPACE + "increaseViewCount", p_bno);
    }

    @Override
    public PatchBoardDto getDetail(int bno) {
        return sqlSession.selectOne(NAMESPACE + "getDetail", bno);
    }

    @Override
    public void increaseLike(int p_bno) {
        sqlSession.update(NAMESPACE + "increaseLike", p_bno);
    }

    @Override
    public void increaseUnLike(int p_bno) {
        sqlSession.update(NAMESPACE + "increaseUnLike", p_bno);
    }

    @Override
    public List<PatchBoardDto> searchPosts(String category, String keyword) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("category", category);
        paramMap.put("keyword", keyword);
        return sqlSession.selectList(NAMESPACE + "searchPosts", paramMap);
    }
}
