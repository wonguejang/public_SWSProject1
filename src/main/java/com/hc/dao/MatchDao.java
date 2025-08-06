package com.hc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hc.dto.MatchDetailDto;
import com.hc.dto.MatchItemsDto;
import com.hc.dto.MatchRunesDto;
import com.hc.dto.MatchShardsDto;
import com.hc.dto.MatchSkillsDto;
import com.hc.dto.MatchSpellDto;
import com.hc.dto.MatchsDto;
import com.hc.dto.SummonerInfoDto;

@Mapper
public interface MatchDao {
	//검색된 소환사 최근 매치기록 조회 인터페이스
	public Integer getMatchId(String matchId);
	
	//검색된 소환사 최근 매치기록 중 insert안된 매치데이터 새로 insert하는 메서드 (내용이 가장 많음)
	public void insertMatchs(MatchsDto dto);
	
	//위에 탐지된 insert안된 매치 디테일 내용들 insert하는 인터페이스들 (아래)
//----------------------------------------------------------------------------여기부터------------------------------------------------------------
	public void insertMatchDetail(MatchDetailDto dto);
	
	public void insertMatchItem(MatchItemsDto dto);
	
	public void insertMatchRunes(MatchRunesDto dto);
	
	public void insertMatchSkills(MatchSkillsDto dto);
	
	public void insertMatchSpell(MatchSpellDto dto);
	
	public void insertMatchShard(MatchShardsDto dto);
//----------------------------------------------------------------------------여기까지------------------------------------------------------------
	//소환사 주챔 찾기 (디테일 기반)
	public void selectSummonerMainChamp(String puuid);
	
	//서머너 info내용을 최근 조회된 내용 기준으로 변경
	public void MergeSummonerInfo(SummonerInfoDto dto);
	
	//소환사 주챔기준 소환사 주챔 빌드에서 룬빌드를 가져오는 인터페이스 
	public int getRuneBackGround(int rune);
	
	public String getOnlyPuuid(String id);
	
	public List<String> getOnlyMatchId(String id);

}


