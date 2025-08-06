package com.wg.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Component
public class TokenService {

    @Autowired
    private SqlSession sqlSession;

    /**
     * 토큰 생성 후 DB에 저장
     */
    public String createToken(String email) {
        String token = UUID.randomUUID().toString();
        Map<String, Object> map = new HashMap<>();
        map.put("email", email);
        map.put("token", token);

        sqlSession.insert("com.wg.dao.MemberDao.insertResetToken", map);
        return token;
    }

    /**
     * 토큰으로 사용자 이메일(ID) 조회
     */
    public String getUserIdByToken(String token) {
        return sqlSession.selectOne("com.wg.dao.MemberDao.findEmailByToken", token); // ✅ 수정
    }

    /**
     * 토큰 무효화 (삭제)
     */
    public void invalidateToken(String token) {
        sqlSession.delete("com.wg.dao.MemberDao.deleteToken", token); // ✅ 수정
    }
}
