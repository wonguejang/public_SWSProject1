package com.hc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hc.dto.MatchItemsDto;
import com.hc.dto.matchDetailDtoFolder.matchsDto;
import com.hc.dto.matchDetailDtoFolder.selectDetailDto;

@Repository
public class totalDetailDaoImpl implements totalDetailDao {
	@Autowired
	totalDetailDao dao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<selectDetailDto> selectDetail(String MatchId) {
		List<selectDetailDto> list1 = sqlSession.selectList("WindowMapper.selectDetail", MatchId);
		return list1;
	}
	@Override
	public matchsDto selectMatchs(String MatchId) {
		matchsDto dto = sqlSession.selectOne("WindowMapper.MatchData", MatchId);
		return dto;
	}
	@Override
	public MatchItemsDto selectMatchItem(String MatchId, String mdSummonerId) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("MatchId", MatchId);
	    params.put("mdSummonerId", mdSummonerId);
//	    System.out.println("이제 곧 터짐 터짐");
	    return sqlSession.selectOne("WindowMapper.MatchItem", params);
	}
}	
