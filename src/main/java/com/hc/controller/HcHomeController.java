package com.hc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hc.BuildBoardDto.CommonImageDto;
import com.hc.BuildBoardDto.ReplyBoardDto;
import com.hc.BuildBoardDto.getBuildPostDto;
import com.hc.BuildBoardDto.selectBoxDto;
import com.hc.dao.buildPostDao;
import com.hc.dao.windowDao;
import com.hc.dto.matchDetailDtoFolder.totalDetailDto;
import com.hc.service.BuildBoardService;
import com.hc.service.SummonerInfoService;

@Controller
public class HcHomeController {
	
	@Value("${riot.api.key}")
	String API_KEY;
	
	//소환사상세페이지 서비스
	@Autowired
	SummonerInfoService svc;
	
	//빌드게시판 서비스
	@Autowired
	BuildBoardService svc2;
	
	//윈도우(화면 송출관련 dao)
	@Autowired
	windowDao dao;
	
	@Autowired
	buildPostDao dao2;
	
	//소환사 상세페이지 (홈에서 소환사 닉네임 검색시 이동 --> 화면상단 서치바에서 검색시 이동으로 --> if조건 검색된 아이디에 #이 안붙었으면 챔피언으로 sql문 검색, #이 붙었으면 해당 summonerinfo로 검색)
	@RequestMapping(value = "/summonerInfo", produces = "text/plain; charset=UTF-8")		// # 조건 확인 방법 = 검색된 input.indexOf("#") 의값이 -1이면 챔피언
	public String summoner(String id, Model model) throws Exception {
		if(id == null ||id.isEmpty()) id = "의 주#트리거";
		// 받은 아이디로 puuid 조회
		String puuid = svc.getPuuid(id);
		
		System.out.println(puuid);
		
		//얻은 puuid 값으로 최근 100경기 조회 -> DB 확인 같은 MatchId  DB안에 저장 안되있으면 탐색 + 검색 + summonerInfo 업데이트 후 모델에 전체 List값 add 
		List<String>matchlist = svc.getMatchId(puuid, id);
		model.addAttribute("matchlist", matchlist);
		
		//소환사 매치 디테일값 조회후 서머너 전체 빌드 merge gn model에 소환사DATA add
		svc.mergeBuild(puuid);
		model.addAttribute("puuid", puuid);
		model.addAttribute("info", svc.getSummonerInfo(puuid));
		
		//모든 백그라운드 샤드들 img url 구하는 메서드 + dto에 담아서 리턴 + model 에 add
		model.addAttribute("shardbackground", svc.getAllShard());
		
		//서머너인포서비스에서 매치데이터 가장 최근에 업데이트된 매치데이터를 기준으로 서머너iconId리턴
		int icon = svc.getSummonerInfo(puuid).getSummonerIcon();
		
		//챔피언Id 값 이름으로 변환 + 모델에 아이콘, 한글이름, 챔피언이미지 url , 소환사 itembuild add
		String ChampionKoreaName = dao.selectChampKoreaName(svc.getSummonerInfo(puuid).getSummonerChampId());
		model.addAttribute("ChampionKoreaName", ChampionKoreaName);
		model.addAttribute("summonericon", dao.getSummonerIcon(icon));
		model.addAttribute("summonerChampionImage", dao.getSummonerChapionImage(svc.getSummonerInfo(puuid).getSummonerChampId()));
		model.addAttribute("itembuild", svc.getSBIURL(svc.getSummonerItemBuild(puuid)));
		
		//totalDetailDto 필드 내용(MatchDetail Board에 들어가는 모든 내용)리턴 + model add
		List<List<totalDetailDto>> totalList = new ArrayList<>();
		for (int i=0; i<matchlist.size(); i++) {
		List<totalDetailDto> list = svc.getTotalDetail(matchlist.get(i), puuid);
		totalList.add(list);
		}
		model.addAttribute("totalDetail", totalList);

		//소환사가 사용한 주챔 아이템 빌드의 123 순위의 승률 및 선택률, 룬 빌드 리턴 model에 add
		model.addAttribute("itembuildRate", svc.getSBIWRANDPR(puuid, svc.getSummonerInfo(puuid).getSummonerChampId(), svc.getSummonerItemBuild(puuid)));
		model.addAttribute("main3champ", svc.getMain3Champ(puuid));
		model.addAttribute("runebuild", svc.getSummonerRuneBuild(puuid));
		
		//소환사 주챔 룬 빌드값에대해서 백 그라운드에 그릴 RuneType 정하기 (1, 2, 3, 4, 5)
		int mainRuneType = svc.selectRunebackground(svc.getSummonerRuneBuild(puuid).getCbrChampMain1());
		int subRuneType = svc.selectRunebackground(svc.getSummonerRuneBuild(puuid).getCbrChampSub1());
		
		model.addAttribute("ShardBuildOn",svc.getShardBuildOn(puuid));
		model.addAttribute("RuneBuildOn" ,svc.getRuneBuildOn(puuid));
		
		//룬 타입에 맞는 백그라운드 model에 add
		model.addAttribute("mainrunebackground", svc.getMainRunePage(mainRuneType));
		model.addAttribute("subrunebackground", svc.getSubRunePage(subRuneType));
		

		//스킬 빌드 및 스펠빌드 add
		model.addAttribute("skillbuild",svc.getSummonerSkillBuild(puuid));
		model.addAttribute("spellbuild",svc.getSummonerSpellBuild(puuid));
		
		return "summonerInfo";
	}
	
	
	//빌드게시판 이동 model 에 총 빌드게시판 게시물 갯수 Add
	@RequestMapping("/BUILD_BOARD3")
	public String BUILD_BOARD3(Model model) {
	    model.addAttribute("totalPosts", svc2.getTotalPosts());
	    return "BUILD_BOARD3";
	}
	
	//ajax 전체postList뽑는 url
	@RequestMapping("/getPost") // 겹칠 가능성 높음
	@ResponseBody
	public List<getBuildPostDto> getPost(@RequestParam int page, @RequestParam int size,  @RequestParam String boardCheckSerch) {
	    int start = (page - 1) * size + 1;
	    int end = page * size;
	    Map<String, Object> param = new HashMap<>();
	    param.put("start", start);
	    param.put("end", end);
	    return svc2.getBuildPostList(param, boardCheckSerch);
	}
	
	//ajax 선택된 postList뽑는 url
	@RequestMapping("/getSelectPost") // 이것도 겹칠 가능성있음
	@ResponseBody
	public List<getBuildPostDto> getPost(@RequestParam int page, @RequestParam int size, int selectId, @RequestParam String boardCheckSerch){
		int start = (page - 1) * size + 1;
	    int end = page * size;
	    Map<String, Object> param = new HashMap<>();
	    param.put("start", start);
	    param.put("end", end);
	    param.put("selectId", selectId);
		return svc2.getSelectIdBuildPostList(param, boardCheckSerch);
	}
	
	//빌드게시판 셀렉트박스에 append할 이미지url, id, name get하는 컨트롤러
	@RequestMapping("/getSelectBox") //겹..?칠수도?
	@ResponseBody
	public List<selectBoxDto> getSelectBox() {
		List<selectBoxDto> list1 = svc2.getSelectBox();
		return list1;
	}
	
	
	//빌드게시판 디테일 주소 모델에 detail내용과 총 게시물 개수 add
	@RequestMapping("/detail") // 겹칠 가능성 있음
	public String detail(@RequestParam("bbno") int bno, Model model) {
		getBuildPostDto detail = svc2.getBoardByBno(bno);
		model.addAttribute("detail", detail);
		model.addAttribute("totalPosts", svc2.getTotalPosts());
		dao2.updateCheck(bno);
		model.addAttribute("rating", dao2.getSelectRating(bno));
		return "BuildBoardDetail";
	}
	
	
	//빌드게시판 작성 form
	@RequestMapping ("/writeBuildPost")
	public String writeBuildPost(Model model, @RequestParam(value = "bno", required = false) Integer bno) {
		model.addAttribute("totalPost", svc2.getTotalPosts());
		model.addAttribute("SelectList", svc2.getSelectBox());
		return "writeBuildPost";
	}
	
	@PostMapping("/buildPostWrite")
	public String buildPostWrite(@RequestParam(value = "bno", required = false) Integer bno, @RequestParam("selectId") String selectId,@RequestParam("title") String title,@RequestParam("content") String content, HttpSession session) {
		// 서비스 호출로 insert 처리
		System.out.println(bno);
		String writer = (String) session.getAttribute("user_name");
		svc2.mergeBuildPost(bno, selectId, title, content, writer);
		return "redirect:/BUILD_BOARD3";
	}

	
	//빌드 게시판 deletePost
	@RequestMapping("/deleteBuildPost")
	public String deleteBuildPost(@RequestParam(value = "bno", required = false) Integer bno ){
		svc2.deleteBuildPost(bno);
		return "redirect:/BUILD_BOARD3";
	}
	
	//빌드 게시판에서 로그아웃하면 빌드게시판 List 페이지로 이동하는 내용 session객체 user_name를 remove함 --> 통합하면 id도 remove or 전체 user_name 내용 id로 통합
	@RequestMapping("/buildLogout")
	public String buildLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/BUILD_BOARD3";
	}

	
	//빌드 post 추천 svc 내용인데 지금은 추천 db를 따로 만들어두지 않아서 svc내용은 직선으로 추천이되는내용 -> 지금 한사람이 한 게시물에 여러번 추천이 가능함
	@RequestMapping("/updateRating") //겹칠가능성있음
	@ResponseBody
	public String updateRating(@RequestParam int bno, HttpSession session) {
		String user_name = (String)session.getAttribute("user_name");
		String success = svc2.updateRating(bno, user_name);
		if(success.equals("success")) {
			return "success";
		}
		return "false";
	}

	
	//아래 4개 빌드 게시판 insert 마크다운내용 간단하게 -> return값에 svc생성 및 스트림에 맵을 바로 생성해서 toList하는내용 (왜 바로 toList 안하냐면 자바 16이후부터는 toList가 그냥 붙지만 그 이전버전에는 아직 toList기능이 그렇게안됨!)
	//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//챔피언  --> 아직 챔피언클릭했을때 아이템 요소가 나오는게 아니라 챔피언이 그대로 마크다운에 올라가는 상태임 --> postMapper에 주석으로 만들어둔 코드있음 천천히 추가할 예정
	@ResponseBody
	@RequestMapping("/getBuildPostWriteChampionImage")
	public List<CommonImageDto> getChampionImage(String inputName) {
	    return svc2.getBuiltPostWriteChampionImage(inputName).stream()
	        .map(d -> new CommonImageDto(String.valueOf(d.getChampId()), d.getChampName(), d.getChampUrl()))
	        .collect(Collectors.toList());
	}
	//아이템
	@ResponseBody
	@RequestMapping("/getBuildPostWriteItemImage")
	public List<CommonImageDto> getItemImage(String inputName) {
	    return svc2.getBuildPostWriteItemImage(inputName).stream()
	        .map(d -> new CommonImageDto(d.getItemId(), d.getItemName(), d.getItemUrl()))
	        .collect(Collectors.toList());
	}
	//룬
	@ResponseBody
	@RequestMapping("/getBuildPostWriteRuneImage")
	public List<CommonImageDto> getRuneImage(String inputName) {
	    return svc2.getBuildPostWriteRuneImage(inputName).stream()
	        .map(d -> new CommonImageDto(String.valueOf(d.getRuneIdUNE_ID()), d.getRuneName(), d.getRuneUrl()))
	        .collect(Collectors.toList());
	}
	//스펠
	@ResponseBody
	@RequestMapping("/getBuildPostWriteSpellImage")
	public List<CommonImageDto> getSpellImage(String inputName) {
	    return svc2.getBuildPostWriteSpellImage(inputName).stream()
	        .map(d -> new CommonImageDto(String.valueOf(d.getSpellId()), d.getSpellName(), d.getSpellUrl()))
	        .collect(Collectors.toList());
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	//로그인 상태 확인 컨트롤러   ☆★☆★☆★☆★★겹칠 가능성 매우 높음★☆★☆★☆★☆★  ☆★☆★☆★☆★☆★☆★주의주의주의☆★☆★☆★☆★☆★☆★☆★
	@ResponseBody
	@RequestMapping("/checkLogin") //겹칠가능성 높음
	public boolean checkLogin(HttpSession session) {
		String name = (String)session.getAttribute("user_name");
		System.out.println("컨트롤러 name : " + name);
		
		if(name != null) {
			return true;
		}
		return false;
	}

	
	//빌드게시판 insert 댓글 컨트롤러
	@RequestMapping("/insertBuildReply")
	public String insertBuildReply(@RequestParam String comment, @RequestParam int bno, HttpSession session) {
		String user_name = (String)session.getAttribute("user_name");
		svc2.insertBuildReply(comment, bno, user_name);
		return "redirect:/detail?bbno=" + bno;
	}

	
	//빌드게시판 댓글 읽어오기 컨트롤러
	@RequestMapping("/getReplies")
	@ResponseBody
	public List<ReplyBoardDto> getReplies(@RequestParam int bno) {
		List<ReplyBoardDto>list = svc2.getReplies(bno); 
		return list;
	}
	
	//빌드게시판 작성자 본인일때만 생성되는 수정< btn 클릭시 >
	//댓글 수정 컨트롤러
	@PostMapping("/editBuildReply")
	@ResponseBody
	public String editBuildReply(@RequestParam Integer bno, @RequestParam Integer rno, @RequestParam String comment) {
		Map<String, Object> param = new HashMap<>();
		param.put("bno", bno);
	    param.put("rno", rno);
	    param.put("comment", comment);
	    svc2.editBuildReply(param);
		return "success";
	}
	
	//댓글 삭제 컨트롤러
	@PostMapping("/deleteReply")
	@ResponseBody
	public String deleteReply(@RequestParam Integer bno, @RequestParam Integer rno) {
		svc2.deleteReply(bno,rno);
		return "success";
	}
	
	@RequestMapping(value = "/searchSummoner", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String searchSummoner(@RequestParam String id) {
	    return svc.searchSummoner(id);
	}
	
	@RequestMapping("/checkSummoner")
	@ResponseBody
	public boolean checkSummoner(String id) {
		return svc.checkSummoner(id);
	}
	@RequestMapping("/checkChampion")
	@ResponseBody
	public boolean checkChampion(String champName) {
		return svc.checkChampion(champName);
	}
}