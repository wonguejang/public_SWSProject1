package com.hc.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class buildDaoImpl implements buildDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void margeChampionBuildItem() {
		sqlSession.insert("insertBuildMapper.mergeChampionBuildItem");
	}
	@Override
	public void mergeSummonerBuildItem(String puuid) {
		sqlSession.insert("insertBuildMapper.mergeSummonerBuildItem",puuid);
	}
	@Override
	public void mergeChampionBuildRunes() {
		sqlSession.insert("insertBuildMapper.mergeChampionBuildRune");
	}
	@Override
	public void mergeSummonerBuildRunes(String puuid) {
		sqlSession.insert("insertBuildMapper.mergeSummonerBuildRune",puuid);
	}
	@Override
	public void mergeChampionBuildSkills() {
		sqlSession.insert("insertBuildMapper.mergeChampionBuildSkill");
	}
	@Override
	public void mergeSummonerBuildSkills(String puuid) {
	    sqlSession.update("insertBuildMapper.mergeSummonerBuildSkill", puuid);
	    sqlSession.update("insertBuildMapper.gptqudtls",puuid);
	}
	@Override
	public void mergeChampionBuildSpell() {
		sqlSession.insert("insertBuildMapper.mergeChampionBuildSpell");
	}

	@Override
	public void mergeSummonerBuildSpell(String puuid) {
		sqlSession.insert("insertBuildMapper.mergeSummonerBuildSpell",puuid);
	}
}
