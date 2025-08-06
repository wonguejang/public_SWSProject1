package com.wg.dao.championDetail;

import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.ChampDetailItemsGroupDto;
import com.wg.dto.RiotDto.MatchRunesDto;
import com.wg.dto.RiotDto.MatchSkillsDto;

public interface ChampionDetailDao {
	
	//챔피언 별 아이템 선택
	ChampDetailItemsGroupDto getItemsFromChampForCoreByChampName(String champName);	//dto에 1코어3개, 2코어 3개, 3코어 3개 를 리스트에 담음
	
	//챔피언별 스킬트리 
	MatchSkillsDto getSkillTreeByChampName(String champName);// 챔피언 스킬트리 한줄 가져오기! 챔피언 이름으로
	
	//챔피언별 룬 빌드
	MatchRunesDto getRuneTreeByChampName(String champName);	// 챔피언 룬트리 한줄 가져오기 ! 챔피언 이름으로
	
	//챔피언 정보 보내기 (승률 쿼리문 두개 써서 값 구해서 보내기)
	ChampDetailChampionDto getChampInfoByChampName(String KchampName);	//챔피언의 이름,사진,승,패를 가져옴 승률은 따로계산
	
	//랜덤으로 챔피언 이름 가져오기
	String getChampNameByRandom();	// 랜덤으로 챔피언 이름 가져오기
	
	//검색된 챔이언이 있는지 확인
	boolean getChampion(String kChampName);	// 검색어에 맞는 챔피언이 있는지 확인
	
	//번역하기
	String getEchampNameByKchampName(String KchampName);	//한글명으로 영어 이름 가져오기
}
