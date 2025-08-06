package com.wg.service.championDetail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wg.dao.championDetail.ChampionDetailDao;
import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.ChampDetailItemsGroupDto;
import com.wg.dto.RiotDto.MatchRunesDto;
import com.wg.dto.RiotDto.MatchSkillsDto;

@Service
public class ChampionDetailServiceImpl implements ChampionDetailService {
	@Autowired
	ChampionDetailDao dao;

	//챔피언 별 사용한 아이템을 dto에 1코어3개, 2코어 3개, 3코어 3개 를 리스트에 담음
	@Override
	public ChampDetailItemsGroupDto getItemsFromChampForCoreByChampNameService(String champName) {
		ChampDetailItemsGroupDto chamionDetailItemList = dao.getItemsFromChampForCoreByChampName(champName);
		return chamionDetailItemList;
	}
	
	//챔피언 이름으로 해당 챔피언의 스킬트리 가져오기
	@Override
	public MatchSkillsDto getSkillTreeByChampNameService(String champName) {
		MatchSkillsDto ChampionSkillTree = dao.getSkillTreeByChampName(champName);
		return ChampionSkillTree;
	}

	//챔피언 이름으로 해당 챔피언의 룬트리 가져오기
	@Override
	public MatchRunesDto getRuneTreeByChampNameService(String champName) {
		MatchRunesDto championRuneTree = dao.getRuneTreeByChampName(champName);
		return championRuneTree;
	}

	//챔피언 정보 보내기 (승률 쿼리문 두개 써서 값 구해서 보내기)
	//한글이름으로 승률 가져오고 영어 이름으로 url과 이름가져오기
	@Override
	public ChampDetailChampionDto getChampInfoByChampNameService(String KchampName) {
		ChampDetailChampionDto ChampDetailDto = dao.getChampInfoByChampName(KchampName);
		return ChampDetailDto;
	}

	//랜덤으로 가져온 챔피언 이름 리턴
	@Override
	public String getChampNameByRandomServcie() {
		String randomChampName = dao.getChampNameByRandom();
		return randomChampName;
	}

	//검색어와 일치하는 챔피언이있는지 확인
	@Override
	public boolean getChampionService(String kChampName) {
		boolean checkResult = dao.getChampion(kChampName);
		
		//검색 챔피언이 있으면 true를 리턴
		if(checkResult) {
			return checkResult;
		}
		//검색과 일치하지 않는다면 false 리턴
		return false;
	}

	//한글명(챔피언이름)으로 영문(챔피언이름) 가져오기
	@Override
	public String getEchampNameByKchampNameService(String KchampName) {
		String EchampName = dao.getEchampNameByKchampName(KchampName);
		return EchampName;
	}

	
}
