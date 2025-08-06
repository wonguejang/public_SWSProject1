package com.wg.service.championDetail;

import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.ChampDetailItemsGroupDto;
import com.wg.dto.RiotDto.MatchRunesDto;
import com.wg.dto.RiotDto.MatchSkillsDto;

public interface ChampionDetailService {
	
	//챔피언 별 아이템 선택
	//dto에 1코어3개, 2코어 3개, 3코어 3개 를 리스트에 담음
	ChampDetailItemsGroupDto getItemsFromChampForCoreByChampNameService(String champName);	
	
	//챔피언별 스킬트리 
	//챔피언 이름으로 해당 챔피언의 스킬트리 가져오기
	MatchSkillsDto getSkillTreeByChampNameService(String champName);	
	
	//챔피언별 룬 빌드
	// 챔피언 이름으로 해당 챔피언의 룬트리 가져오기
	MatchRunesDto getRuneTreeByChampNameService(String champName);	
	
	//챔피언 정보 보내기 (승률 쿼리문 두개 써서 값 구해서 보내기)
	//한글이름으로 승률 가져오고 영어 이름으로 url과 이름가져오기
	ChampDetailChampionDto getChampInfoByChampNameService(String KchampName); 

	//한글명으로 영어명 가져오기
	String getEchampNameByKchampNameService(String KchampName);	// 한글명으로 영어이름 가져와

	//랜덤번호의 챔피언 이름 가져오기
	String getChampNameByRandomServcie();	// 랜덤으로 챔피언 이름 가져오기
	
	//챔피언 이름 있는지 확인
	boolean getChampionService(String kChampName); // 챔피언 이름 가져오기
	
}
