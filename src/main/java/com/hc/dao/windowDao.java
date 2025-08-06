package com.hc.dao;

import java.util.Map;

import com.hc.dto.BuildItemDto;
import com.hc.dto.BuildRuneDto;
import com.hc.dto.BuildSkillDto;
import com.hc.dto.BuildSpellDto;
import com.hc.dto.PickRateDto;
import com.hc.dto.SummonerInfoDto;
import com.hc.dto.WinRateAndPickRateDto;
import com.hc.dto.getShardBuildOnDto;

public interface windowDao {
	//조회된 소환사 주챔 id get 인터페이스
	String getChampionId(String puuid);
	
	//조회된 소환사 icon url get 인터페이스 (작명 잘못했었음 귀찮아서 그냥 사용함 종합하다가 문제생기면 이걸 바꾸는걸로)
	String getChapionImage(int iconId);
	
	//조회된 소환사 summonerinfo테이블 내용 전체 조회 인터페이스
	SummonerInfoDto getSummonerInfo(String puuid);
	
	//조회된 소환사 빌드 4종류 조회 인터페이스
	BuildItemDto getItemBuild(String puuid);
	BuildRuneDto getRuneBuild(String puuid);
	BuildSkillDto getSkillBuild(String puuid);
	BuildSpellDto getSpellBuild(String puuid);
	
	//이름만 다르고 championId 인터페이스랑 완전히 같은 기능, 하나 빼도 괜찮은데 지금은 문제생길수있으니까 디팩토링 작업은 차순위로 미룸
	String getSummonerIcon(int icon);
	
	//검색된 chapion image Url 조회 인터페이스
	String getSummonerChapionImage(int chapionId);
	
	//검색된 Rune image url 조회 인터페이스
	String selectRuneUrl(int Rune);
	
	//검색된 챔피언 id 한글이름 조회 인터페이스
	String selectChampKoreaName(int id);
	
	//파편 검색된 image url 조회 인터페이스 
	String getshard(int id);
	
	//item image url 조회 인터페이스
	String SelectItemImage(int id);
	
	//조회된 소환사 아이템 사용률 승률
	WinRateAndPickRateDto getSummonerItemWinrate(PickRateDto dto);
	
	//로그인 체크 왜 일로왔누...
	int loginCheck(String inputId);
	
	int getMainCampId(String puuid);
	
	getShardBuildOnDto getLastMatchShard(Map<String, Object> param);
	
	BuildRuneDto getChampionRuneBuild(String ChampionName); //룬그리기
	
	String searchSummoner(String id);
	
	boolean checkSummoner(String id);
	
	boolean checkChampion(String champName);

}
