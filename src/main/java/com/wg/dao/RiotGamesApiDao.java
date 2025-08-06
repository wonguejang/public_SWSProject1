package com.wg.dao;

import java.util.List;

import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.MatchsDto;
import com.wg.dto.RiotDto.RankDto;
import com.wg.dto.RiotDto.SummonerInfoDto;

public interface RiotGamesApiDao {
	
	//api 호출의 결과 체크
	boolean getApiResonse(); //api 호출시 200인지 아닌지 (200은 정상 그 외는 api오류 - 만료 등)
	
	//로테이션 챔프 받아오기
	List<ChampDetailChampionDto> getRotationChampByApi();	// 라이엇 api로 로테이션 챔 받기

	//소환사 랭킹 받아오기 (1~300)
	List<SummonerInfoDto> getRankingByApi();	// 라이어 api로 소환사 랭킹 받아와서
	
	//소환사명 가져오기
	List<SummonerInfoDto> getSummonerDetailforApi();	// 위에서(랭킹)으로 받아온 puuid로 소환사명 받기
	
	//소환사명 db의 내용과 비교해서 저장하기
	public int checkSummonerIdForRanking();	//summonerId(소환사명)가 있는지 확인해서 있으면 업뎃 없으면 인설트실행
	
	//소환사 아이콘 저장
	List<SummonerInfoDto> getIconByPuuid();	// puuid로 소환사 정보를 가져와 아이콘 정보를 담아두기
	
	//기존아이콘이 없는지 bd에서 확인후 저장
	int updateIconIsNull();	// 위에서 받아온 내용을 기반으로 쿼리문으로 조건 검사후 없는 곳에 아이콘 업데이트
	
	//매치 아이디 받아오기
	List<MatchsDto> getMatchIdFromDB();	//db에 저장된 매치아이디 가져와서 저장
	
	//랭커 가져오기
	List<RankDto> getRankList(int rnum1, int rnum2); //페이징으로 10명씩 랭커 가져오기
}