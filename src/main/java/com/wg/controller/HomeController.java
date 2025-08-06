package com.wg.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hc.BuildBoardDto.getBuildPostDto;
import com.hc.dao.buildPostDao;
import com.hc.service.SummonerInfoService;
import com.wg.dto.Board.FreeBoardDto;
import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.ChampDetailItemsGroupDto;
import com.wg.dto.RiotDto.MatchRunesDto;
import com.wg.dto.RiotDto.MatchSkillsDto;
import com.wg.dto.RiotDto.RankDto;
import com.wg.service.RiotGamesApiService;
import com.wg.service.board.BoardService;
import com.wg.service.championDetail.ChampionDetailService;

@Controller
public class HomeController {
	@Autowired
	BoardService boardSvc;
	
	@Autowired
	RiotGamesApiService riotApiSvc;
	
	@Autowired
	ChampionDetailService championDSI;
	
	@Autowired
	SummonerInfoService summonerInfoSvc;
	
	@Autowired
	buildPostDao buildDao;
	
	//링크 실행시 최초의 위치
	@RequestMapping("/")
	public String home(Model model, HttpServletRequest request, HttpSession session) {
		//id값이 null이 아니면 session에 값 담기
		String id = request.getParameter("id");
		if (id != null)
			session.setAttribute("id", id);

		//api값 체크하기
		//boolean apiCheck = riotApiSvc.getApiResonseService();
		//System.out.println("컨트롤러 apiCheck : " + apiCheck);
		//스와이퍼에 뿌릴 로테이션챔피언 정보 보내기
		List<ChampDetailChampionDto> rotationChamp = riotApiSvc.getRotationChampByApiService();
		if(rotationChamp.size() < 20) {
			model.addAttribute("api_message","API오류로 인해 DB에서 화면 내용을 대체합니다.");
		}
		
		//하단 게시글 목록에 자유게시판 게시글 보내기
		int page = 1;
		List<FreeBoardDto> listBoard = null;
		
		try {
			listBoard = boardSvc.listBoardByPageNum(page);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//하단 게시글 목록에 빌드 게시판 게시글 보내기
		//추후 추가예정
		request.setAttribute("rotationChamp", rotationChamp);
		model.addAttribute("rotationChamp", rotationChamp);
		request.setAttribute("listBoard", listBoard);
		model.addAttribute("dto", listBoard);	// 나중에 받기

		Map<String, Object> param = new HashMap<>();
		param.put("start", 1);
		param.put("end", 5);
		List<getBuildPostDto>buildList = buildDao.buildPostList(param);
		model.addAttribute("buildList",buildList);
		
		return "2조홈최종";
	}
	
	//로그아웃 세션 지우기
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		//세션 내용 지우기
		session.invalidate();
		
		return "redirect:/"; // 홈화면으로 이동
	}
	
	//랭킹화면으로 이동
	@RequestMapping("summonerRank")
	public String raking() {
		//단순 이동
		return "소환사랭킹";
	}
	
	//랭킹화면에 뿌려줄 정보 페이지에 진입하면 한번 실행(그후 무한스크롤시 실행)
	@RequestMapping("rankList")
	@ResponseBody
	public List<RankDto> rankingList(Integer page) {
		//ajax에서 data로 보내주는 값
		if(page == null) page = 1;
		
		List<RankDto> rankList = riotApiSvc.getRankListService(page);
		
		return rankList;
	}
	
	//여기확인
	//랭킹에서 갱신!
	@RequestMapping("rankingUpdate")
	public String rankingUpdate() {
		System.out.println("페이지 이동 실행");
		riotApiSvc.updateRanking();
		return "redirect:/summonerRank";
	}
	

	//챔피언 상세
	@RequestMapping("champinoDetail")
	public String champinoDetail(String champName, HttpServletRequest request, Model model) {
		//랜덤으로 챔프 가져오기(챔피언 검색입력이 없을 시에 사용)
		String randomChampName = championDSI.getChampNameByRandomServcie();
		
		//champName 이 없다면 랜덤으로 챔프이름을 넣어줌
		if(champName==null || champName.isEmpty()) 
			champName = randomChampName;

		//넘어온 챔피언 이름으로 챔피언 검색해서 결과값없으면 홈화면으로 이동시킴
		boolean searchCheck = championDSI.getChampionService(champName);
		
		//검색 내용이 있다면
		if(searchCheck) {
			String EchampName = championDSI.getEchampNameByKchampNameService(champName);
			
			//챔프가져오기
			ChampDetailChampionDto champDto = championDSI.getChampInfoByChampNameService(champName);
			//아이템 그룹dto가져오기(안에 list들었음)
			ChampDetailItemsGroupDto itemGroupDto = championDSI.getItemsFromChampForCoreByChampNameService(EchampName);
			
			//스킬트리 dto 가져오기
			MatchSkillsDto skillDto = championDSI.getSkillTreeByChampNameService(EchampName);
			//룬 트리가져오기
			MatchRunesDto runeDto = championDSI.getRuneTreeByChampNameService(EchampName);
			
			request.setAttribute("champDto", champDto);
			request.setAttribute("itemGroupDto", itemGroupDto);
			request.setAttribute("skillDto", skillDto.getSkillDtoList());
			request.setAttribute("skillOrder", Arrays.asList("Q","W","E","R"));
			request.setAttribute("runeDto", runeDto);

			model.addAttribute("RuneBuildOn" ,summonerInfoSvc.getRuneBuildOn(champName));
			
			int mainRuneType = summonerInfoSvc.selectRunebackground(summonerInfoSvc.getSummonerRuneBuild(champName).getCbrChampMain1());
			int subRuneType = summonerInfoSvc.selectRunebackground(summonerInfoSvc.getSummonerRuneBuild(champName).getCbrChampSub1());
			model.addAttribute("mainrunebackground", summonerInfoSvc.getMainRunePage(mainRuneType));
			model.addAttribute("subrunebackground", summonerInfoSvc.getSubRunePage(subRuneType));

			return "챔피언상세보기";

		}else {
			model.addAttribute("search_miss_message","검색어를 확인하세요");
			return "forward:/";
		}
	}


}
