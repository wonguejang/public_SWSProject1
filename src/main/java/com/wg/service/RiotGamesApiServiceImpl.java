package com.wg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wg.dao.RiotGamesApiDao;
import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.RankDto;

@Service
public class RiotGamesApiServiceImpl implements RiotGamesApiService {
	@Autowired
	RiotGamesApiDao dao;
	
	//api키가 살아있는지 체크
	@Override
	public boolean getApiResonseService() {

		boolean result = dao.getApiResonse();
		System.out.println("응답코드 200일때 : true / 아니면 false : " + result);

		//응답코드가 200이면 조건문 실행 후 return true
		if(result) {
			return result;
		}
		
		return false;
	}
	
	//라이엇 api 불러와서 로테이션 챔피언 받기
	@Override
	public List<ChampDetailChampionDto> getRotationChampByApiService() {
		return dao.getRotationChampByApi();
	}

	@Override
	public List<RankDto> getRankListService(int page) {
		//page번호를 사용해 한번에 10명씩 담아줌
		int end = page * 10;
		int start = end  -9;

		List<RankDto> rankList = null;
		
		try {
			rankList = dao.getRankList(start, end);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return rankList; 
	}
	
	//랭킹 갱신
	@Override
	public void updateRanking() {
		//단순 실행
		int result = dao.checkSummonerIdForRanking();
		System.out.println("성공이냐? : " + result);
	}

	
}
