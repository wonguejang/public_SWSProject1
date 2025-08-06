package com.hc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hc.dao.MatchDao;

import util.CheckRanker;

@Service
public class RankerAutoUpdateServiceImpl implements RankerAutoUpdateService {
	@Autowired
	MatchDao dao;
	
	@Autowired
	SummonerInfoService svc;
	
	@Autowired
	RankerAutoUpdateService svc2;
	
	//혹시 이거 파일도 utill에 안넣으셨으면 오류생기실거임 RateLimitChecker도 util에 넣어야하고
	@Autowired
	private CheckRanker checkRanker;
	
	@Override
	public void RankerAutoUpdateService() {
		System.out.println("테스트실험중");
		String insertName = "진돗개#0415";
	    List<String> RankerList = checkRanker.CheckRanker(); // 주입받은 빈 사용
	    for (String puuid : RankerList) {
	        System.out.println(puuid);
	        svc.getMatchId(puuid, insertName);
	    }
	}
}
