package com.hc.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hc.dto.BuildItemDto;
import com.hc.dto.BuildRuneDto;
import com.hc.dto.BuildSkillDto;
import com.hc.dto.BuildSpellDto;
import com.hc.dto.MatchShardsDto;
import com.hc.dto.PickRateDto;
import com.hc.dto.SummonerInfoDto;
import com.hc.dto.WinRateAndPickRateDto;
import com.hc.dto.getShardBuildOnDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

@Mapper
@Repository
public class windowDaoImpl implements windowDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public String getChampionId(String puuid) {
		return sqlSession.selectOne("WindowMapper.ChampId",puuid);
	}
	
	@Override
	public String getChapionImage(int iconId) {
		return sqlSession.selectOne("WindowMapper.ChampImage", iconId);
	}
	
	@Override
	public SummonerInfoDto getSummonerInfo(String puuid) {
		return sqlSession.selectOne("WindowMapper.Info", puuid);
	}
	@Override
	public BuildItemDto getItemBuild(String puuid) {
		return sqlSession.selectOne("WindowMapper.ItemBuild", puuid);
	}
	@Override
	public BuildRuneDto getRuneBuild(String puuid) {
		return sqlSession.selectOne("WindowMapper.RuneBuild",puuid);
	}
	@Override
	public BuildSkillDto getSkillBuild(String puuid) {
		return sqlSession.selectOne("WindowMapper.SkillBuild",puuid);
	}
	@Override
	public BuildSpellDto getSpellBuild(String puuid) {
		return sqlSession.selectOne("WindowMapper.SpellBuild",puuid);
	}
	@Override
	public String getSummonerIcon(int icon) {
		return sqlSession.selectOne("WindowMapper.icon", icon);
	}
	@Override
	public String getSummonerChapionImage(int chapionId) {
	 	return sqlSession.selectOne("WindowMapper.championImage", chapionId);
	}
	@Override
	public String selectRuneUrl(int Rune) {
		return sqlSession.selectOne("WindowMapper.selectRuneUrl", Rune);
	}
	@Override
	public String selectChampKoreaName(int id) {
		return sqlSession.selectOne("WindowMapper.selectChampKoreaName", id);
	}
	@Override
	public String getshard(int id) {
		return sqlSession.selectOne("WindowMapper.shard", id); 
	}
	@Override
	public String SelectItemImage(int id) {
		return sqlSession.selectOne("WindowMapper.selectItemImage", id);
	}
	@Override
	public WinRateAndPickRateDto getSummonerItemWinrate(PickRateDto dto) {
		return sqlSession.selectOne("WindowMapper.getSummonerItemPickRate", dto); 
	}
	@Override
	public int loginCheck(String inputId) {
		System.out.println(inputId);
		return sqlSession.selectOne("WindowMapper.loginCheck", inputId);
	}

	@Override
    public int getMainCampId(String puuid) {
       return sqlSession.selectOne("WindowMapper.getMainCampId", puuid);
    }
	
	@Override
	public getShardBuildOnDto getLastMatchShard(Map<String, Object> param) {
		String matchId = sqlSession.selectOne("WindowMapper.getMainChampLastMatchId",param);
		String summoerId = sqlSession.selectOne("WindowMapper.getSummonerId",param.get("puuid"));
		Map<String, Object> Param = new HashMap<>();
		Param.put("matchId",matchId);
		Param.put("summoerId",summoerId);
		
		MatchShardsDto dto = sqlSession.selectOne("WindowMapper.getLastMatchShard", Param);
		
		String url1 = (sqlSession.selectOne("WindowMapper.shard",dto.getOffense()));
		String url2 = (sqlSession.selectOne("WindowMapper.shard",dto.getFlex()));
		String url3 = (sqlSession.selectOne("WindowMapper.shard",dto.getDefense()));
		
		getShardBuildOnDto dto2 = new getShardBuildOnDto(url1,url2,url3);
		return dto2;
	}

	@Override
	public BuildRuneDto getChampionRuneBuild(String ChampionName) {
		String ChampionId = sqlSession.selectOne("WindowMapper.getChampionId", ChampionName);
		return sqlSession.selectOne("WindowMapper.ChampionRuneBuild", ChampionId);
	}

	@Override
	public String searchSummoner(String id) {
		return sqlSession.selectOne("WindowMapper.searchSummoner",id);
	}
	@Override
	public boolean checkSummoner(String id) {
		if ((int)sqlSession.selectOne("WindowMapper.checkSummoner",id) > 0) {
			return true;
		}
		return false;
	}
	@Override
	public boolean checkChampion(String champName) {
		if((int)sqlSession.selectOne("WindowMapper.checkChampion", champName) > 0) {
			return true;
		}
		return false;
	}


}
