package com.wg.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wg.dto.RiotDto.ChampDetailChampionDto;
import com.wg.dto.RiotDto.MatchsDto;
import com.wg.dto.RiotDto.RankDto;
import com.wg.dto.RiotDto.SummonerInfoDto;

@Repository
public class RiotGamesApiDaoImpl implements RiotGamesApiDao {
	@Value("${riot.api.key}")
    private String API_KEY;
	
	private JdbcTemplate jdbcTemplate;
	
	private RestTemplate restTemplate;
	
	public RiotGamesApiDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
		this.restTemplate = new RestTemplate();
	}
	
	@Autowired
	SqlSession sqlSession;
	
	//api 호출시 200인지 아닌지 판단
	@Override
	public boolean getApiResonse() {
		//기본적으로 로테이션 챔프가 받아와 지는지로 체크
	    String url = "https://kr.api.riotgames.com/lol/platform/v3/champion-rotations";
	    HttpHeaders headers = new HttpHeaders();
	    //토큰에 api_key를 set함
	    headers.set("X-Riot-Token", API_KEY);
	    
	    HttpEntity<Void> entity = new HttpEntity<>(headers);
	    try {
	        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
	        return response.getStatusCode() == HttpStatus.OK;  // 200일 때만 true 리턴
	    } catch (Exception e) {
	        return false;  // 예외나 200 이외 상태면 false 리턴
	    }
	}
	
	//라이엇 api를 사용해 로테이션 챔프 받아오고 그걸로 챔프 내용 가져오기
	@Override
	public List<ChampDetailChampionDto> getRotationChampByApi() {
		List<Integer> champId = null;
		//바로 체크해도 되지만 이해를 위해 한번 담아서 사용
		boolean apiCheck = getApiResonse();
		
		//api요청이 200이면 - 즉, api키가 유효하면 아래 코드 실행
		if(apiCheck) {
			try {
				//로테이션 챔프를 받기 위해 api 요청
				String url = "https://kr.api.riotgames.com/lol/platform/v3/champion-rotations?api_key="+API_KEY;
				//http요청을 간편하게 하기 위해 RestTemplate객체 생성
				RestTemplate rtp = new RestTemplate();
				//RestTemplate객체를 사용해 get요청을 응답을 JSON(문자열)으로 받음
				String json = rtp.getForObject(url, String.class);
				
				//JSON파싱을 위해 ObjectMapper객체 생성
				ObjectMapper mapper = new ObjectMapper();
				//받아온 JSON문자열을 트리구조로 파싱해서 root에 담는다
				JsonNode root = mapper.readTree(json);
				//root.get으로 원하는 내용의 배열 노드를 가져옴(로테이션챔프)
				JsonNode idsNode = root.get("freeChampionIds");
				//챔프아이디를 담을 어레이 리스트를 초기화
				champId = new ArrayList<>();
				//for-each문을 사용해 순회
				for(JsonNode cId : idsNode) {
					//챔프아이디를 순회하며 담는다(.asInt를 사용해 변환 후 담음 중요!)
					champId.add(cId.asInt());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		//api키 요청이 불량하다면 즉, api키가 모종의 이유로 작동하지 않을떄
		}else {
			Random rd = new Random();
			//set객체를 성한다.(중복값 제거에 탁월함)
			Set<Integer> uniqueRandom = new HashSet<>();
			
			//while문을 사용해 원하는 갯수가 될때까지 반복
			while(uniqueRandom.size() < 15) {
				//챔프아이디가 170개라 그중에 랜덤으로 담음
				//나중에 개선의 방향성이 충분히 있음
				uniqueRandom.add(rd.nextInt(170)+1);
			}
			//챔프 아이디를 담을 리스트를 초기화	
			champId = new ArrayList<>();
			//for-each문을 돌며 리스트에 값(중복x)을 담아줌
			for(Integer number : uniqueRandom) {
				champId.add(number);
			}
			
		}
		//이제 받아온 챔프id로 db에 저장된 챔피언 정보들을 받아온다 (메서드화 가능성 높음)
		List<ChampDetailChampionDto> rotationChamp = new ArrayList<>();
		int cnt = 0;
		//반복문을 돌며 해당 챔피언 아이디가 가진 승리와 패배를 가져옴
		for(Integer cId : champId) {
			ChampDetailChampionDto rotationChampId = sqlSession.selectOne("RiotGamesApiMapper.selectChampByIdForWin", cId);
			ChampDetailChampionDto loseDto = sqlSession.selectOne("RiotGamesApiMapper.selectChampByIdForLose", cId);
			
			//신챔들은 승률이 없어서 가끔 오류 날지도...? 예외처리를 위해 작성
			if(rotationChampId == null || loseDto == null) {
				System.out.println("데이터 없음 : " + cId + "현재 인덱스 : " + cnt++);
				continue;
			}
			//승률 계산을 위한 작업
			int win = rotationChampId.getWin();
			int lose = loseDto.getLose();
			//승률을 만들어줌(소숫점 두번쨰 자리까지만)
			double winRate = win + lose > 0 ? Math.round((win * 100.0 / (win + lose)) * 100.0) / 100.0 : 0.0;
			
			//set을 통해서 값을 담아줌
			rotationChampId.setLose(lose);
			rotationChampId.setWinRate(winRate);
			//최종적으로 모든 정보를 담고있는곳에 담고 
			rotationChamp.add(rotationChampId);
		}
		//로테이션 챔프의 정보들을 담아서 리턴해줌
		return rotationChamp;
	}

	// 라이엇 api를 이용해서 랭킹 받아오기
	@Override
	public List<SummonerInfoDto> getRankingByApi() {
		//리턴할 리스트를 초기화
		List<SummonerInfoDto> rankList = new ArrayList<>();
		
		int apiCheck = 0;
		try {
			
			//요청을 보낼 곳에 주소를 url에 저장
			String url = "https://kr.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5?api_key="+API_KEY;
			//http요청을 간편하게 하기 위해 RestTemplate객체 생성
			RestTemplate restTemplate = new RestTemplate();
			//RestTemplate객체를 사용해 get요청을 응답을 JSON(문자열)으로 받음
			String json = restTemplate.getForObject(url, String.class);
			
			//JSON파싱을 위해 ObjectMapper객체 생성
			ObjectMapper mapper = new ObjectMapper();
			//받아온 JSON문자열을 트리구조로 파싱해서 root에 담는다
			JsonNode root = mapper.readTree(json);
			//root.get으로 원하는 내용의 배열 노드를 가져옴(랭킹)
			JsonNode entries = root.get("entries");
			
			//for-each문을 돌며 필요한 정보를 저장
			for(JsonNode node : entries) {
				SummonerInfoDto dto = new SummonerInfoDto();
				//puuid, 리그포인트, 승리수, 패배수를 변환하여 dto객체에 set함
				dto.setPuuid(node.get("puuid").asText());
				dto.setLeaguePoints(node.get("leaguePoints").asInt());
				dto.setWin(node.get("wins").asInt());
				dto.setLose(node.get("losses").asInt());
				
				//승수와 패배수를 이용해 승률을 계산
				int win = dto.getWin();
				int lose = dto.getLose();
				//승률을 만들어줌(소숫점 두번쨰 자리까지만)
				double winRate = win + lose > 0 ? Math.round((win * 100.0 / (win + lose)) * 100.0) / 100.0 : 0.0;
				
				//승률을 dto객체에 저장함
				dto.setWinRate(winRate);
				//예외적으로 챌린저까지만 랭킹을 보여주는 중이라 고정적으로 챌린저 저장
				dto.setRanks("CHALLENGER");
				System.out.println("이름 : " +dto.getSummonerId()+" 포인트 : " +dto.getLeaguePoints() + " 승률 : " + dto.getWinRate());
				//순회 할때마다 리스트에 dto객체를 담아줌
				rankList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		//만들어진 랭커들의 정보를 담은 리스트를 리턴
		System.out.println("\n \n 첫 메서드 실행 끝 \n \n");
		return rankList;
	}
	
	// 랭킹으로 받아온 puuid로 소환사이름 받기
	@Override
	public List<SummonerInfoDto> getSummonerDetailforApi() {
		System.out.println("두번쨰 진행 \n");
		//리스트에 랭커들의 정보를 담은 메서드 실행 (위에서 작성한 메서드)
		List<SummonerInfoDto> rankList = getRankingByApi();
		
		int apiCheck = 0;
		//for-each문을 돌면서 랭커정보에 들어있는 puuid를 사용해 api를 요청
		for(SummonerInfoDto dto : rankList) {
			try {
				//호출제한이 걸릴 수 있어서 쓰레드 걸어둠
				if(apiCheck > 0 && apiCheck%20==0) {
					Thread.sleep(25_000);
				}
				//puuid를 담아서 아래 url 요청으로 보내줌
				String puuid = dto.getPuuid();
				String url = "https://asia.api.riotgames.com/riot/account/v1/accounts/by-puuid/" + puuid + "?api_key=" + API_KEY;
				//http 요청을 간단하게 하기위해 RestTemplate객체 생성
				RestTemplate restTemplate = new RestTemplate();
				//RestTemplate객체를 사용해 get요청을 응답을 JSON(문자열)으로 받음
				String json = restTemplate.getForObject(url, String.class);
				//받아온 JSON문자열을 트리구조로 파싱해서 root에 담는다
				ObjectMapper mapper = new ObjectMapper();
				//root.get으로 원하는 내용의 배열 노드를 가져옴(랭킹)
				JsonNode root = mapper.readTree(json);
				//소환사 아이디는 태그까지 들어가야해서 각각 변환(text)한 값을 #을 포함하여
				//문자열 더하기 한후 아이디에 set해줌
				dto.setSummonerId((root.get("gameName").asText())+"#"+(root.get("tagLine").asText()));
				System.out.println((apiCheck + 1) +"소환사 이름 : " + dto.getSummonerId()+"\t포인트 : " +dto.getLeaguePoints() + "\t승률 : " + dto.getWinRate());
				
				apiCheck++;
			}catch (HttpClientErrorException.TooManyRequests e) {
				//생각보다 2초가 짧은건지 여러개의 api요청 연속 실행으로 인한것인지
				//혹시 모르는 429(요청횟수초과)를 피해가기 위한 예외처리
	            System.err.println("429 오류: 잠시 대기합니다.");
	            try {
	            	//여유롭게 3초 더줌
	                Thread.sleep(3000);
	            } catch (InterruptedException ie) {
	                ie.printStackTrace();
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
		System.out.println("두번쨰 종료 \n\n");
		//추가된 정보를 포함한 랭커리스트를 리턴함
		return rankList;
	}
	
	// 받아온 랭킹을 인설트 할찌 업데이트할지 쿼리문을 사용해서 검사후 실행
	@Override
	public int checkSummonerIdForRanking() {
		System.out.println("세번쨰 실행 \n \n");
		//랭커들의 정보가 담겨있는 리스트를 리턴하는 메서드를 실행하고 리스트에 담아줌
		List<SummonerInfoDto> summonerRanking = getSummonerDetailforApi();
		//for-each문을 돌며 해당 아이디가 db에 있는지 확인함
		int update = 0;
		int insert = 0;
		int resultCheck = 1;
		for(SummonerInfoDto dto : summonerRanking) {
			//아이디로 select문 실행시 결과가 있으면 1 없으면 0이 나오는걸 이용
			System.out.println(resultCheck++ +"번째 dto.getSummonerId : " + dto.getSummonerId());
			int idCheck = sqlSession.selectOne("RiotGamesApiMapper.selectCheckSummonerId", dto.getSummonerId());
			int puuidCheck = sqlSession.selectOne("RiotGamesApiMapper.selectCheckPuuid", dto.getPuuid());
			
			int result = 0;
			//idCheck가 1이면 이미 db에 있기때문에 update 실행
			if(idCheck == 1) {
				//여기서 업데이트
				update++;
				result = sqlSession.update("RiotGamesApiMapper.updateSommonerByRankingBoard", dto);
			} else if(puuidCheck == 1){
				update++;
				result = sqlSession.update("RiotGamesApiMapper.updateSommonerByRankingBoard", dto);
			} else {	//idCheck가 1이 아니라면 새로운 정보를 insert
				//여기서 인서트
				insert++;
				result = sqlSession.insert("RiotGamesApiMapper.insertRankingBoard",dto);
			}
			//혹시 모를 경우를 위해서 작성
			//result는 insert, update시 1이어야함
			//그래서 1이 아닌 경우가 있다면 db에서 쿼리문 실행하다가
			//문제가 생긴것으로 판단 0을 return해버림
			if(result != 1) {
				return 0;	//인서트 or 업데이트가 하나라도 실패하면 0 리턴
			}
		}
		System.out.println("세번쨰 끝 update : " + update +"\n insert : " + insert);
		//모든 쿼리문이 성공햇다면 1을 리턴
		return 1;
	}

	//랭커들이 가진 puuid로 그 소환사가 사용하는 icon가져오기
	@Override
	public List<SummonerInfoDto> getIconByPuuid() {
		//랭커의 기본적인 정보를 리스트형식으로 리턴하는 메서드 실행 후 담아줌
		List<SummonerInfoDto> iconList = getRankingByApi();
		//http요청을 간편하게 하기위해 RestTemplate객체 생성
		RestTemplate restTemplate = new RestTemplate();
		
		int apiCheck = 0;
		//for-each문을 돌면서 코드 실행
		for(SummonerInfoDto dto : iconList) {
			try	{
				//api요청 제한수를 감안한 스레드
				if(apiCheck > 0 && apiCheck%20==0) {
					Thread.sleep(25_000);
				}
				//리스트의 dto에 담긴 puuid를 담아주고
				String puuid = dto.getPuuid();
				//puuid로 엔드포인트 요청을 보내줌
				String url = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/" + puuid + "?api_key=" + API_KEY;
				//get방식으로 요청을 보내서 json형태로 받아서 담아줌
				String json = restTemplate.getForObject(url, String.class);
				//받아온 JSON문자열을 트리구조로 파싱해서 root에 담는다
				ObjectMapper mapper = new ObjectMapper();
				//root.get으로 원하는 내용의 배열 노드를 가져옴(아이콘)
				JsonNode root = mapper.readTree(json);
				
				//해당 키에 들어있는 값을 int인코딩후 담아주고
				int iconId = root.get("profileIconId").asInt();
				//데이터 드레곤에 아이콘 정보를 url로 받아옴
				String iconUrl = "https://ddragon.leagueoflegends.com/cdn/13.14.1/img/profileicon/" + iconId + ".png";
				
				//해당 객체의 iconUrl자리에 set해줌
				dto.setSummonerIcon(iconId);
				System.out.println("가져와 진 아이콘 콘 번호"+dto.getSummonerIcon() + " / 해당 url" + iconUrl);
				apiCheck++;
			} catch (HttpClientErrorException.TooManyRequests e) {
				//생각보다 2초가 짧은건지 여러개의 api요청 연속 실행으로 인한것인지
				//혹시 모르는 429(요청횟수초과)를 피해가기 위한 예외처리
	            System.err.println("429 오류: 잠시 대기합니다.");
	            try {
	            	//여유롭게 3초 더줌
	                Thread.sleep(3000);
	            } catch (InterruptedException ie) {
	                ie.printStackTrace();
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		}
		//icon이 담긴 리스트 리턴
		return iconList;
	}

	//위에서 get해온 아이콘을 update해줌
	@Override
	public int updateIconIsNull() {
		List<SummonerInfoDto> list = getIconByPuuid();
		int check = 0;
		for(SummonerInfoDto dto : list) {
			//영향받은 행의 개수를 정할 check에 쿼리 결과를 담음
			check = sqlSession.selectOne("RiotGamesApiMapper.selectIconIsNull", dto.getPuuid());
			
			//icon이 같더라도 update해버림
			//추후 icon이 현재와 같으면 update안하게 처리 가능
			//puuid가 있다면 update해줌
			if(check > 0) {
				sqlSession.update("RiotGamesApiMapper.updateSummonerIcon",dto);
			}
		}
		//마지막에 실행된 쿼리문이 check에 1을 담음 
		return check;	//0이면 실패? 1이면 성공
	}

	//db에서 matchId가져오기
	@Override
	public List<MatchsDto> getMatchIdFromDB() {
		//db에서 가져온 내용을 리스트에 담아 리턴
		List<MatchsDto> matchIdDto = sqlSession.selectList("ChampionDetail.selectGetMatchId");
		
		return matchIdDto;
	}

	
	//페이지 번호로 랭킹페이지 리스트 받아오기 ( 승,패,리그포인트,puuid )
	@Override
	public List<RankDto> getRankList(int rnum1, int rnum2) {
		//여기서 db 실행
		//이거 실행하면 업데이트 되는거임
//		checkSummonerIdForRanking();
		
		//시작번호와 끝번호로 해서 맵에 담아서 매퍼에 전달
		HashMap<String, Integer> map1 = new HashMap<>();
		map1.put("rnum1", rnum1);
		map1.put("rnum2", rnum2);
		
		return sqlSession.selectList("RankMapper.RankingList", map1);
	}

	
		

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
