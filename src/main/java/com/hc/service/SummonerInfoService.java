package com.hc.service;

import java.util.List;

import com.hc.dto.BuildItemDto;
import com.hc.dto.BuildItemURLDto;
import com.hc.dto.BuildItemWinAndPickRateDto;
import com.hc.dto.BuildRuneDto;
import com.hc.dto.BuildSkillDto;
import com.hc.dto.BuildSpellDto;
import com.hc.dto.SummonerInfoDto;
import com.hc.dto.getRuneBuildOnDto;
import com.hc.dto.getShardBuildOnDto;
import com.hc.dto.main3champDto;
import com.hc.dto.mainRunePageDto;
import com.hc.dto.shardDto;
import com.hc.dto.subRunePageDto;
import com.hc.dto.matchDetailDtoFolder.totalDetailDto;


public interface SummonerInfoService {
	//조회된 소환사 puuid 조회 인터페이스
	public abstract String getPuuid(String userId);
	
	//조회된 소환사 최근매치 조회 인터페이스
	public abstract List<String> getMatchId(String puuid, String inputId); 
	
	//조회된 소환사 매치중 기록되지않은 matchinsert하는 인터페이스
	public abstract void insertMatch(String matchId, String puuid);
	
	//조회된 소환사 info 조회하는 인터페이스(티어,승,패,전체판수 등에서 승률따위를 가져와서 info에 넣기위함)
	public abstract void getTier(String puuid, String userId, int icon);
	
	//조회된 소환사 info 불러오는 인터페이스
	public abstract SummonerInfoDto getSummonerInfo(String puuid);
	
	//조회된 소환사 주챔기준 빌드 get 인터페이스 
//----------------------------------------------------------------------------------------------------
	public abstract BuildItemDto getSummonerItemBuild(String puuid);
	public abstract BuildRuneDto getSummonerRuneBuild(String puuid);
	public abstract BuildSkillDto getSummonerSkillBuild(String puuid);
	public abstract BuildSpellDto getSummonerSpellBuild(String puuid);
//----------------------------------------------------------------------------------------------------
	
	//머지 buildDao내용 전체실행 인터페이스 
	public abstract void mergeBuild(String puuid);
	
	//summonerinfo merge 인터페이스
	public abstract void MergeSummonerInfo(SummonerInfoDto dto);
	
	//소환사 주챔기준 background 룬빌드 탐색 인터페이스
	public abstract int selectRunebackground(int rune);
	
	//소환사 주챔기준으로 조회된 룬빌드로 백그라운드 이미지로 생성할 case문 실행 인터페이스 이때 노가다 지렸는데
	public abstract mainRunePageDto getMainRunePage(int runeType);
	public abstract subRunePageDto getSubRunePage(int runeType);
	
	//백그라운드 파편 이미지 인터페이스
	public abstract shardDto getAllShard();
	
	//서머너 주챔 아이템 빌드의 url 가져오는 인터페이스
	public abstract BuildItemURLDto getSBIURL(BuildItemDto dto);
	
	//소환사 상세페이지에 출력할 해당 소환사가 해당 아이템으로플레이했을대 얼마의 승률을 얻었고 얼마의 픽률을 얻었는지 가져오는 인터페이스(1 2 3위)
	public abstract BuildItemWinAndPickRateDto getSBIWRANDPR(String puuid, int champId, BuildItemDto dto);
	
	//주챔 3개 찾아오는 인터페이스
	public abstract List<main3champDto> getMain3Champ(String puuid);
	
	//detailContainer에 올릴 List 리턴 인터페이스 Dto 한번 보면 이해할거임
	public abstract List<totalDetailDto> getTotalDetail(String MatchId, String puuid);
	
	public abstract getRuneBuildOnDto getRuneBuildOn(String puuid);
	
	public abstract getShardBuildOnDto getShardBuildOn(String puuid);
	
	public abstract List<String> getOnlyMatchId(String puuid);
	
	public abstract String getOnlyPuuid(String id);
	
	public abstract String searchSummoner(String id);
	
	public abstract boolean checkSummoner(String id);
	
	public abstract boolean checkChampion(String champName);
	
}
