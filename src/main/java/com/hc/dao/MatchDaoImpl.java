package com.hc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.hc.dto.MatchDetailDto;
import com.hc.dto.MatchItemsDto;
import com.hc.dto.MatchRunesDto;
import com.hc.dto.MatchShardsDto;
import com.hc.dto.MatchSkillsDto;
import com.hc.dto.MatchSpellDto;
import com.hc.dto.MatchsDto;
import com.hc.dto.SummonerInfoDto;
import com.hc.dto.SummonerInsertMainChampDto;

@Repository
public class MatchDaoImpl implements MatchDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Value("${riot.api.key}")
    private String API_KEY;
	
	//최근매치조회
	@Override
	public Integer getMatchId(String matchId) {
		int cnt = sqlSession.selectOne("matchMapper.getMatchId", matchId);
		return cnt;
	}
	//부족한매치추가
	@Override
	public void insertMatchs(MatchsDto dto) {
		sqlSession.insert("matchMapper.insertMatch", dto);
		System.out.println("insert Matchs complet");
	}
	//부족한매치들 디테일추가
//------------------------------------------------------------------------------------------------------------------------
	@Override
	public void insertMatchDetail(MatchDetailDto dto) {
		sqlSession.insert("matchMapper.insertMatchDetail", dto);
	}
	@Override
	public void insertMatchItem(MatchItemsDto dto) {
		sqlSession.insert("matchMapper.insertMatchItem", dto);
	}@Override
	
	public void insertMatchRunes(MatchRunesDto dto) {
		sqlSession.insert("matchMapper.insertMatchRunes", dto);
	}
	@Override
	public void insertMatchSkills(MatchSkillsDto dto) {
		sqlSession.insert("matchMapper.insertMatchSkills", dto);
	}
	@Override
	public void insertMatchSpell(MatchSpellDto dto) {
		sqlSession.insert("matchMapper.insertMatchSpell", dto);
	}
	@Override
	public void insertMatchShard(MatchShardsDto dto) {
		sqlSession.insert("matchMapper.insertMatchShard", dto);
	}
//------------------------------------------------------------------------------------------------------------------------	
	//서머너 주챔찾기
	@Override
	public void selectSummonerMainChamp(String puuid) {
		Map<String, Object> result = sqlSession.selectOne("matchMapper.selectSummonerMainChamp", puuid);
		String PlayerMainChamp = (String) result.get("PLAYER_CHAMP");
	    int PlayerMainChampId = ((Number) result.get("CHAMP_ID")).intValue();
	    SummonerInsertMainChampDto dto = new SummonerInsertMainChampDto(PlayerMainChamp, PlayerMainChampId, puuid);
	    sqlSession.update("matchMapper.updateSummonerMainChamp", dto);
	}
	
	//서머너info머지
	@Override
	public void MergeSummonerInfo(SummonerInfoDto dto) {
		sqlSession.insert("matchMapper.mergeSummonerInfomation", dto);
	}
	
	//서머너 주챔룬빌드 백그라운드 이미지 가져오기
	@Override
	public int getRuneBackGround(int rune) {
		return sqlSession.selectOne("WindowMapper.getRuneBackGround",rune);
	}

	@Override
	public String getOnlyPuuid(String id) {
		return sqlSession.selectOne("matchMapper.getOnlyPuuid", id);
	}
	
	@Override
	public List<String> getOnlyMatchId(String id){
		List<String> list1 = sqlSession.selectList("matchMapper.getOnlyMatchId", id);
		List<String> realList = sqlSession.selectList("matchMapper.realList", list1);
		return realList;
	}

}
