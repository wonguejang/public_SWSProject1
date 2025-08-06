package com.wg.service;

import java.util.List;

import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.RankDto;

public interface RiotGamesApiService {
	
	//api호출 결과를 확인할 메서드
	boolean getApiResonseService(); //api 호출시 200인지 아닌지 (200은 정상 그외는 api오류 - 만료 등)
	
	//홈화면에서 사용할 로테이션 챔프 정보
	List<ChampDetailChampionDto> getRotationChampByApiService();	// 라이엇 api로 로테이션 챔 받아와서 챔피언 정보 받아오기
	
	//소환사 랭키화면에서 사용할 랭커리스트
	List<RankDto> getRankListService(int page);	//페이지 번호로 랭킹 리스트 받아오기
	
	//랭킹 갱신
	void updateRanking();	//랭킹 버튼 클릭시갱신
}
