package com.wg.dao.championDetail;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.ChampDetailItemsGroupDto;
import com.wg.dto.RiotDto.MatchItemsDto;
import com.wg.dto.RiotDto.MatchRunesDto;
import com.wg.dto.RiotDto.MatchSkillsDto;

@Repository
public class ChampionDetailDaoImpl implements ChampionDetailDao {
	@Autowired
	SqlSession sqlSession;
	
	//리스트에 3개씩 담은 객체 3개를 만들어서 dto에 담아서 리턴하기
	@Override
	public ChampDetailItemsGroupDto getItemsFromChampForCoreByChampName(String champName) {
		List<MatchItemsDto> items1List = sqlSession.selectList("ChampionDetail.selectItemByChampFrom1Core", champName);
		List<MatchItemsDto> items2List = sqlSession.selectList("ChampionDetail.selectItemByChampFrom2Core", champName);
		List<MatchItemsDto> items3List = sqlSession.selectList("ChampionDetail.selectItemByChampFrom3Core", champName);
		
		ChampDetailItemsGroupDto groupItem = new ChampDetailItemsGroupDto();
		groupItem.setItem1List(items1List);	//1코어 아이템 3개
		groupItem.setItem2List(items2List);	//2코어 아이템 3개
		groupItem.setItem3List(items3List);	//3코어 아이템 3개
		
		return groupItem;
	}
	
	
	//챔피언 이름으로 해당 챔피언의 스킬 트리 받아오기
	@Override
	public MatchSkillsDto getSkillTreeByChampName(String champName) {
		MatchSkillsDto skillTree = sqlSession.selectOne("ChampionDetail.selectSkillTreeByChamp",champName);
		return skillTree;
	}

	//챔피언 이름으로 해당 챔피언의 룬 트리 받아오기
	@Override
	public MatchRunesDto getRuneTreeByChampName(String champName) {
		MatchRunesDto runeTree = sqlSession.selectOne("ChampionDetail.selectRuneTreeByChamp",champName);
		return runeTree;
	}

	//챔피언 이름으로 이름,사진,승,패를 가져옴 승률은 따로계산
	@Override
	public ChampDetailChampionDto getChampInfoByChampName(String KchampName) {
		String EchampName = sqlSession.selectOne("ChampionDetail.selecteKchampNameTranslate", KchampName);
		ChampDetailChampionDto champDto = sqlSession.selectOne("ChampionDetail.selectWinLoseForWinRate",EchampName);
//		System.out.println("번역전 : " + KchampName + " / 번역후 : " + EchampName);
		
		//아래의것 실행되면서 앞의 결과가 덮어씌워짐 그래서 쿼리문 실행하고 다시 set해줌
		int win = champDto.getWin();
		int lose = champDto.getLose();
		double winRate = (win * 100.0) / (win + lose);
		double winRateResult = Math.round(winRate * 100.0) / 100.0;
		champDto = sqlSession.selectOne("ChampionDetail.selectChampNameAndUrl",KchampName);
		champDto.setWin(win);
		champDto.setLose(lose);
		champDto.setWinRate(winRateResult);
		
		return champDto;
	}

	//랜덤으로 챔프 이름 가져오기
	@Override
	public String getChampNameByRandom() {
		//여기서 그 배열들의 번호를 난수 발생해서 나온값을 검색어가 없을 떄 자리에 넣어주기
		int random = (int)(Math.random()*170)+1;
		//여기서 챔피언 이름들 배열로 받아서 넣고 (sql)
		String randomChampName = sqlSession.selectOne("ChampionDetail.selectRandomChampNameByNum",random);
		
		return randomChampName;
	}

	//검색된 챔피언이 있는지 확인
	@Override
	public boolean getChampion(String kChampName) {
		int searchResult = sqlSession.selectOne("ChampionDetail.selectCheckChampName",kChampName);
		System.out.println("결과 확인 1-true, 2-false : " + searchResult);
		
		if(searchResult == 1) {
			return true;
		}
		return false;
	}
	
	//한글명으로 영어 이름 가져오기
	@Override
	public String getEchampNameByKchampName(String KchampName) {
		String EchampName = sqlSession.selectOne("ChampionDetail.selecteKchampNameTranslate",KchampName);
		return EchampName;
	}

}
