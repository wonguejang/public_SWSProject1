package com.hc.dao;

import java.util.List;

import com.hc.dto.MatchItemsDto;
import com.hc.dto.matchDetailDtoFolder.matchsDto;
import com.hc.dto.matchDetailDtoFolder.selectDetailDto;

public interface totalDetailDao {
	//매치 디테일에 필요한 내용 전체 조회 List 작성 인터페이스 들
	
	//1. 현재 조회된 매치에 참여한 소환사들 경기기록 조회 List
	List<selectDetailDto> selectDetail(String MatchId);
	
	//2. 조회된 매치 승리팀 패배님 구하는 조회 인터페이스
	matchsDto selectMatchs(String MatchId);
	
	//소환사의 사용 아이템 구하는 인터페이스
	MatchItemsDto selectMatchItem(String MatchId, String mdSummonerId);
}
