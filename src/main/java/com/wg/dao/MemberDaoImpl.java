package com.wg.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wg.dto.Member.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession sqlSession;

	private static final String NAMESPACE = "com.wg.dao.MemberDao";

	@Override
	public void insert(MemberDto dto) {
		sqlSession.insert(NAMESPACE + ".insert", dto);
	}

	@Override
	public MemberDto findById(String id) {
		return sqlSession.selectOne(NAMESPACE + ".findById", id);
	}

	@Override
	public MemberDto login(String id, String pw) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.selectOne(NAMESPACE + ".login", map);
	}

	@Override
	public void updatePassword(String userId, String userPw) {
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("userPw", userPw);
		sqlSession.update(NAMESPACE + ".updatePassword", map);
	}

	@Override
	public void updateUserName(MemberDto dto) {
		sqlSession.update(NAMESPACE + ".updateUserName", dto);
	}

	@Override
	public int getGradeById(String userId) {
		return sqlSession.selectOne(NAMESPACE + ".getGradeById", userId);
	}

}
