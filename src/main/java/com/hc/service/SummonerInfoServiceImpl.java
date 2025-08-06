package com.hc.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.hc.dao.MatchDao;
import com.hc.dao.buildDao;
import com.hc.dao.totalDetailDao;
import com.hc.dao.windowDao;
import com.hc.dto.BuildItemDto;
import com.hc.dto.BuildItemURLDto;
import com.hc.dto.BuildItemWinAndPickRateDto;
import com.hc.dto.BuildRuneDto;
import com.hc.dto.BuildSkillDto;
import com.hc.dto.BuildSpellDto;
import com.hc.dto.MatchDetailDto;
import com.hc.dto.MatchItemsDto;
import com.hc.dto.MatchRunesDto;
import com.hc.dto.MatchShardsDto;
import com.hc.dto.MatchSkillsDto;
import com.hc.dto.MatchSpellDto;
import com.hc.dto.MatchsDto;
import com.hc.dto.PickRateDto;
import com.hc.dto.SummonerInfoDto;
import com.hc.dto.getRuneBuildOnDto;
import com.hc.dto.getShardBuildOnDto;
import com.hc.dto.main3champDto;
import com.hc.dto.mainRunePageDto;
import com.hc.dto.shardDto;
import com.hc.dto.subRunePageDto;
import com.hc.dto.matchDetailDtoFolder.matchsDto;
import com.hc.dto.matchDetailDtoFolder.selectDetailDto;
import com.hc.dto.matchDetailDtoFolder.totalDetailDto;

import util.RateLimitChecker;
@Service
public class SummonerInfoServiceImpl implements SummonerInfoService {
	@Value("${riot.api.key}")
	String API_KEY;
	@Autowired
	MatchDao dao;
	@Autowired
	windowDao dao2;
	@Autowired
	buildDao dao3;
	@Autowired
	totalDetailDao totalDetaildao;
	
	//여기임 	
	//KR_7725485750
	
	@Autowired
	SqlSession sqlsession;
	
	
	@Autowired
	RateLimitChecker checker;

	@Override
	public String getPuuid(String inputId) {
	    String puuid = null;
	    String gameName = inputId;
	    int index = gameName.indexOf("#");
	    System.out.println("id : "+inputId+"\n몇번쨰? "+index);
	    String tagLine = gameName.substring(index + 1);
	    gameName = gameName.substring(0, index);
	    try {
	    	String encodedGameName = URLEncoder.encode(gameName, "UTF-8").replace("+", "%20");
	    	String encodedTagLine = URLEncoder.encode(tagLine, "UTF-8").replace("+", "%20");
	        String urlStr = String.format("https://asia.api.riotgames.com/riot/account/v1/accounts/by-riot-id/%s/%s",
	                encodedGameName, encodedTagLine);

	        URL url = new URL(urlStr);
	        HttpURLConnection con = (HttpURLConnection) url.openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("X-Riot-Token", API_KEY);

	        int responseCode = con.getResponseCode();
	        System.out.println("리스폰 코드! : " + responseCode);

	        if (responseCode == 200) {
	            String appRateLimitCount = con.getHeaderField("X-App-Rate-Limit-Count");
	            checker.checkSafe(appRateLimitCount);

	            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            StringBuilder response = new StringBuilder();
	            String inputLine;
	            while ((inputLine = in.readLine()) != null) {
	                response.append(inputLine);
	            }
	            in.close();
	            
	            JSONObject json = new JSONObject(response.toString());
	            puuid = json.getString("puuid");
	            return puuid;
	        }
	        else {
	        	System.out.println("responseCode가 200이 아니라 검색된 아이디의 puuid만 반환함");
	        	puuid = dao.getOnlyPuuid(inputId);
	        	return puuid;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return puuid;
	}
	@Override
	public List<String> getMatchId(String puuid, String inputId) {
		List<String> list1 = new ArrayList<>();
		try {
			// URL 인코딩   start=? count=? 경기 조회 횟수조절 현재 100경기
			String urlStr = String.format("https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/%s/ids?queue=420&type=ranked&start=0&count=10",puuid);
			// URL 연결
			URL url = new URL(urlStr);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			// HTTP 요청 방식을 GET으로 설정
			con.setRequestMethod("GET");
			// Riot API 서버에 인증을 위해 필요한 헤더를 추가
			con.setRequestProperty("X-Riot-Token", API_KEY);
			int responseCode = con.getResponseCode();
			if (responseCode == 200) {
				// 응답 읽기
				// 밑에 세줄 RateLimitChecker 내용.
				String appRateLimitCount = con.getHeaderField("X-App-Rate-Limit-Count");
				RateLimitChecker checker = new RateLimitChecker();
				checker.checkSafe(appRateLimitCount);
				BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String inputLine;
				StringBuilder response = new StringBuilder();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				JSONArray arr = new JSONArray(response.toString());
				for (int i=0; i<=arr.length()-1; i++) {
					String matchId = arr.getString(i);
					list1.add(matchId);
					int cnt = dao.getMatchId(matchId); 
					if(cnt == 0 ) {
						insertMatch(matchId, puuid);
					}
				}
				return list1;
			}
			else {
				System.out.println("reseponse값이 200이 아니라서 API미사용 getMatchId로 넘어감");
				return dao.getOnlyMatchId(inputId);
			}
		} catch (Exception e){
			System.out.println("get matchId 실패!!");
		}
		return list1;
	}


	@Override
	public void insertMatch(String matchId, String puuid1) {
		System.out.println("puuid1 이거 중요함 : " + puuid1);
		try {
			String urlStr = String.format("https://asia.api.riotgames.com/lol/match/v5/matches/%s",matchId);
			// URL 연결
			URL url = new URL(urlStr);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			// HTTP 요청 방식을 GET으로 설정
			con.setRequestMethod("GET");
			// Riot API 서버에 인증을 위해 필요한 헤더를 추가
			con.setRequestProperty("X-Riot-Token", API_KEY);
			int responseCode = con.getResponseCode();
			if (responseCode == 200) {
				// 응답 읽기
				// 밑에 세줄 RateLimitChecker 내용.
				String appRateLimitCount = con.getHeaderField("X-App-Rate-Limit-Count");
				RateLimitChecker checker = new RateLimitChecker();
				checker.checkSafe(appRateLimitCount);

				BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String inputLine;
				StringBuilder response = new StringBuilder();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				
				// 플레이어전적상세 데이터 선언
				JSONObject matchJson = new JSONObject(response.toString());
				JSONObject info = matchJson.getJSONObject("info");  // <- info 먼저 추출

				JSONArray detailInfo = info.getJSONArray("participants");
				JSONArray teams = info.getJSONArray("teams");

				int[][][] skillArr = 플레이어전적상세스킬(matchId, API_KEY);

				JSONObject team1 = teams.getJSONObject(0);
				JSONArray bans1 = team1.getJSONArray("bans");
				JSONObject team2 = teams.getJSONObject(1);
				JSONArray bans2 = team2.getJSONArray("bans");
				int ban = 0;
				String puuid = null;
				int profileIcon = 0;
				JSONObject team3 = teams.getJSONObject(0);
				JSONObject team4 = teams.getJSONObject(1);
				int winnerTeam = team3.getBoolean("win") ? team3.getInt("teamId") : team4.getInt("teamId");
				
				
				//   경기 종료시간 및 진행시간 추출
				int startStemp;
				long endStemp;
				int endstemp;
				String timeSeed = response.toString().replace("gameEndTimestamp","|");
				int timeidx = timeSeed.indexOf("|");
				endStemp = Long.parseLong(timeSeed.substring(timeidx+3,timeidx+16));      // 게임끝난 시간 Long type
				timeSeed = response.toString().replace("gameEndTimestamp","|");            // 게임끝난 시간 int type(오차제거)
				endstemp = Integer.parseInt(timeSeed.substring(timeidx+8,timeidx+16));
				timeSeed = response.toString().replace("gameStartTimestamp","|");
				timeidx = timeSeed.indexOf("|");
				startStemp = Integer.parseInt(timeSeed.substring(timeidx+8,timeidx+16));   // 게임시작 시간 int type(오차제거)
				int MatchTime = endstemp - startStemp;                              // MatchTime (진행시간) 추출
				//            String matchTime = MatchTime/60000 + "분" + MatchTime%60000/1000 + "초";
				int matchTime = MatchTime/1000;
				System.out.println("\n게임시간 : "+matchTime+"초");
				// UTC 이후(1970-01-01T00:00:00Z)의 밀리초로 인스턴트 객체를 생성한다는 뜻
				Instant endInstant = Instant.ofEpochMilli(endStemp);
				// 서울 시간으로 변환
				ZonedDateTime realTime = endInstant.atZone(ZoneId.of("Asia/Seoul"));
				String RealTime = realTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				String sysoutTime = realTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).replace(" 13시"," 오후1시").replace(" 14시"," 오후2시").replace(" 15시:"," 오후3시").replace(" 16시"," 오후4시").replace(" 17시"," 오후5시").replace(" 18시"," 오후6시").replace(" 19시"," 오후7시").replace(" 20시"," 오후8시").replace(" 21시"," 오후9시").replace(" 22시"," 오후10시").replace(" 23시"," 오후11시").replace(" 12시"," 오후12시");
//				//insertMatchs
				MatchsDto MatchDto = new MatchsDto(matchId,RealTime,matchTime, winnerTeam);
				dao.insertMatchs(MatchDto);
				for (int i = 0; i<= detailInfo.length()-1; i++) {
					if (i <5) {
						ban=bans1.getJSONObject(i).getInt("championId");
					}
					else {ban=bans2.getJSONObject(i-5).getInt("championId");}
					JSONObject player = detailInfo.getJSONObject(i);
					String summonerId = player.getString("summonerId");
					puuid = player.getString("puuid");
					System.out.println("puuid : " + puuid);
					String gameName = player.getString("riotIdGameName");
					String tagLine = player.getString("riotIdTagline");
					String userFullName = gameName + "#" + tagLine;
					String playChampName = player.getString("championName");
					int playChampId = player.getInt("championId");
					int kills = player.getInt("kills"); 
					int deaths = player.getInt("deaths");
					int assists = player.getInt("assists");
					int damage = player.getInt("totalDamageDealtToChampions");
					int teamId = player.getInt("teamId");
					profileIcon = player.getInt("profileIcon");
	                JSONObject perks = player.getJSONObject("perks");
	                JSONObject statPerks = perks.getJSONObject("statPerks");
	                JSONArray styles = perks.getJSONArray("styles");
	                JSONArray mainRuneSelection = styles.getJSONObject(0).getJSONArray("selections");
	                JSONArray subRuneSelection = styles.getJSONObject(1).getJSONArray("selections");
	                int statOffense = statPerks.getInt("offense");
	                int statFlex = statPerks.getInt("flex");
	                int statDefense = statPerks.getInt("defense");
	                MatchItemsDto itemDto = new MatchItemsDto(matchId, userFullName, player.getInt("item0"), player.getInt("item1"), player.getInt("item2"), player.getInt("item3"), player.getInt("item4"), player.getInt("item5"), player.getInt("item6")); 
	                MatchRunesDto runeDto = new MatchRunesDto(matchId, userFullName, mainRuneSelection.getJSONObject(0).getInt("perk"), mainRuneSelection.getJSONObject(1).getInt("perk"), mainRuneSelection.getJSONObject(2).getInt("perk"), mainRuneSelection.getJSONObject(3).getInt("perk"), subRuneSelection.getJSONObject(0).getInt("perk"), subRuneSelection.getJSONObject(1).getInt("perk"));
	                MatchSkillsDto skillDto = new MatchSkillsDto(matchId, userFullName, skillArr[i][0][0], skillArr[i][1][0], skillArr[i][2][0], skillArr[i][3][0], skillArr[i][4][0], skillArr[i][5][0], skillArr[i][6][0], skillArr[i][7][0], skillArr[i][8][0], skillArr[i][9][0], skillArr[i][10][0], skillArr[i][11][0], skillArr[i][12][0], skillArr[i][13][0], skillArr[i][14][0], skillArr[i][15][0], skillArr[i][16][0], skillArr[i][17][0]);
	                MatchSpellDto spellDto = new MatchSpellDto(matchId, userFullName, player.getInt("summoner1Id"), player.getInt("summoner2Id"));
	                MatchDetailDto MatchDetailDto = new MatchDetailDto(matchId, userFullName, playChampName, playChampId, kills, deaths, assists, damage, teamId, ban, puuid);
	                MatchShardsDto ShardsDto = new MatchShardsDto(matchId, userFullName, statOffense, statFlex,	statDefense); 
	                
	                System.out.println("여기인가?"+MatchDetailDto.getMd_summoner_id());
	                
	                dao.insertMatchDetail(MatchDetailDto);
	                dao.insertMatchItem(itemDto);
	                dao.insertMatchRunes(runeDto);
	                dao.insertMatchSkills(skillDto);
	                dao.insertMatchSpell(spellDto);
	                dao.insertMatchShard(ShardsDto);
	                if (puuid.equals(puuid1)) {
	                	System.out.println("if 조건 활성화됨");
	                	System.out.println("오류그만해 아이콘 새끼야   "+profileIcon);
	                	getTier(puuid,userFullName,profileIcon);
	                }
	            }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void getTier(String puuid, String userId, int icon) {
		System.out.println("getTier 여기임 : " +puuid +"/"+"\n"+ userId +"/" +icon);
		try {
			String urlStr = String.format("https://kr.api.riotgames.com/lol/league/v4/entries/by-puuid/%s",puuid);
			String encodedGameName = URLEncoder.encode(userId, "UTF-8");
			// URL 연결
			URL url = new URL(urlStr);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			// GET 메소드와 헤더 설정
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Riot-Token", API_KEY);

			int responseCode = con.getResponseCode();

			if (responseCode == 200) {
				System.out.println("getTier responseCode :" +responseCode);
				// 응답 읽기
				// 밑에 세줄 RateLimitChecker 내용.
				String appRateLimitCount = con.getHeaderField("X-App-Rate-Limit-Count");
				RateLimitChecker checker = new RateLimitChecker();
				checker.checkSafe(appRateLimitCount);

				BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String inputLine;
				StringBuilder response = new StringBuilder();

				// 플레이어티어보기 데이터 선언
				String rank;
				int leaguePoints;
				int wins;
				int losses;
				double winRate;



				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				System.out.println("\n-티어보기 응답 성공 - ");

				//   티어 추출
				String tierSeed = response.toString().replace("\"tier\"","|");
				int tierIdx = tierSeed.indexOf("|");
				if (tierIdx != -1) {
					tierSeed = tierSeed.substring(tierIdx+3);
					tierIdx = tierSeed.indexOf("\"");
					String tier = tierSeed.substring(0,tierIdx);
					//   랭크 추출
					String rankSeed = response.toString().replace("\"rank\"","|");
					int rankIdx = rankSeed.indexOf("|");
					rankSeed = rankSeed.substring(rankIdx+3);
					rankIdx = rankSeed.indexOf("\"");
					rank = rankSeed.substring(0,rankIdx);
					rank = tier+rank;
				}
				else {
					rank = null;
					System.out.println(rank);
				}
				//   리그 포인트 추출
				String leaguePointSeed = response.toString().replace("\"leaguePoints\"","|");
				int leaguePointIdx = leaguePointSeed.indexOf("|");
				if (leaguePointIdx != -1) {
					leaguePointSeed = leaguePointSeed.substring(leaguePointIdx+2);
					leaguePointIdx = leaguePointSeed.indexOf(",");
					leaguePoints = Integer.parseInt(leaguePointSeed.substring(0,leaguePointIdx));
					System.out.println("리그포인트 : "+leaguePoints);
				}
				else {
					leaguePoints = 0;
					System.out.println(leaguePoints);
				}
				//   랭크 승리횟수 추출
				String winSeed = response.toString().replace("\"wins\"","|");
				int winIdx = winSeed.indexOf("|");
				if(winIdx != -1) {
					winSeed = winSeed.substring(winIdx+2);
					winIdx = winSeed.indexOf(",");
					wins = Integer.parseInt(winSeed.substring(0,winIdx));
					System.out.println("승리 수 : " + wins);
					//   랭크 패배횟수 추출
					String losseSeed = response.toString().replace("\"losses\"","|");
					int losseIdx = losseSeed.indexOf("|");
					losseSeed = losseSeed.substring(losseIdx+2);
					losseIdx = losseSeed.indexOf(",");
					losses = Integer.parseInt(losseSeed.substring(0,losseIdx));
					System.out.println("패배 수 : " + losses);
					//   승률(winRate) 추출
					winRate = (wins/(double)(losses+wins)*100);   //소수 많이나옴 ex)57.16781537896
					winRate = Math.round(winRate*100.0)/100.0;         //2자리까지만 표현
					System.out.println("승률 : " + winRate+"\n");
				}
				else {
					wins = 0;
					losses = 0;
					winRate = 0;
					System.out.println("승리 수 : " + wins + "\n패배 수 : " + losses + "\n승률 : " + winRate);

				}
				System.out.println(icon);
				SummonerInfoDto dto = new SummonerInfoDto(puuid, userId, "null", 0, rank, leaguePoints, winRate, wins, losses, icon);
				System.out.println("dto.getSummonerIcon 여기임 : "+dto.getSummonerIcon());
				dao.MergeSummonerInfo(dto);
				dao.selectSummonerMainChamp(puuid);
			} 
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	static int[][][] 플레이어전적상세스킬(String MatchArr,String API_KEY) throws Exception {
		String Matchid = MatchArr;
		try {
			// URL 인코딩
			String urlStr = String.format("https://asia.api.riotgames.com/lol/match/v5/matches/%s/timeline", Matchid);

			// URL 연결
			URL url = new URL(urlStr);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			// HTTP 요청 방식을 GET으로 설정
			con.setRequestMethod("GET");
			// Riot API 서버에 인증을 위해 필요한 헤더를 추가
			con.setRequestProperty("X-Riot-Token", API_KEY);

			int responseCode = con.getResponseCode();

			if (responseCode == 200) {
				// 응답 읽기
				// 밑에 세줄 RateLimitChecker 내용.
				String appRateLimitCount = con.getHeaderField("X-App-Rate-Limit-Count");
				RateLimitChecker checker = new RateLimitChecker();
				checker.checkSafe(appRateLimitCount);

				BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String inputLine;
				StringBuilder response = new StringBuilder();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				System.out.println("HttpURL 연결 성공 응답 성공:");

				String skillSeed = response.toString().replace("\"skillSlot\":", "|");
				int[][][] skillOrder = new int[10][18][2]; // [참가자][레벨][스킬슬롯, 타임스탬프]
				int[] skillCounts = {0,0,0,0,0,0,0,0,0,0}; // 각 참가자의 현재 레벨 카운트
				skillSeed = skillSeed.replace("\"SKILL_LEVEL_UP\"","@");
				while (skillSeed.contains("|")) {            //type\":\"SKILL_LEVEL_UP 이라는 내용을 본문이 포함하고있는지 확인하고 없으면 반복문 정지
					// ptcpId 추출
					int idx = skillSeed.indexOf("|")-5;
					skillSeed = skillSeed.substring(idx);

					String tempSkillSeed = skillSeed;
					int tempSkillIdx = tempSkillSeed.indexOf("@")+1;

					tempSkillSeed = tempSkillSeed.substring(0, tempSkillIdx);
					idx = tempSkillSeed.indexOf(":")+1;

					int tempIdx = tempSkillSeed.indexOf(",");
					int ptcpId = Integer.parseInt(tempSkillSeed.substring(idx, tempIdx));
					// ptcp = participant (경기 참여자)
					//ptcpId는 기존 상세보기에서는 애초에 ptcpId 순서대로 조회가 되기때문에 첨삭했던 내용으로 skill 코드를 만들면서 문제가된 뒤죽박죽 스킬상승때문에 해당 스킬을 올린 유저를 특정하기 어려워서 만듬
					// skillSlot 추출
					tempSkillIdx = tempSkillSeed.indexOf("|");
					tempSkillSeed = tempSkillSeed.substring(tempSkillIdx+1);
					tempIdx = tempSkillSeed.indexOf(",");
					int skillSlot = Integer.parseInt(tempSkillSeed.substring(0, tempIdx));
					// timestamp 추출
					tempIdx = tempSkillSeed.indexOf("\"timestamp\":");
					tempSkillSeed = tempSkillSeed.substring(tempIdx+12);
					tempIdx = tempSkillSeed.indexOf(",");
					int timestamp = Integer.parseInt(tempSkillSeed.substring(0, tempIdx));

					// 배열에 저장
					skillOrder[ptcpId-1][skillCounts[ptcpId-1]][0] = skillSlot;
					skillOrder[ptcpId-1][skillCounts[ptcpId-1]][1] = timestamp;
					if(skillCounts[ptcpId-1] <= 16) {
						skillCounts[ptcpId-1] = skillCounts[ptcpId-1]+1;   //처음 1렙 시작이라 이게맞음. 
					}
					// 다음 탐색을 위해 잘라줌
					skillSeed = skillSeed.substring(skillSeed.indexOf("@")+1);
				}
				return skillOrder;
			}
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("전적 상세보기 실패!");
		}
		int[][][] skillOrder = new int[10][18][2];
		return skillOrder;
	}
	
	
	public void mergeBuild(String puuid) {
		dao3.mergeSummonerBuildItem(puuid);
		dao3.mergeSummonerBuildRunes(puuid);
		dao3.mergeSummonerBuildSkills(puuid);
		dao3.mergeSummonerBuildSpell(puuid);
	}
	
	public SummonerInfoDto getSummonerInfo(String puuid) {
		return dao2.getSummonerInfo(puuid);	
	}
	
	public BuildItemDto getSummonerItemBuild(String puuid) {
		return dao2.getItemBuild(puuid);
	}
	
	public BuildRuneDto getSummonerRuneBuild(String puuid) {
		if(puuid.length()>=50) {
			return dao2.getRuneBuild(puuid);
		}
		else if(puuid.length()<50) {
			return dao2.getChampionRuneBuild(puuid);
		}
		return null;
	}

	public BuildRuneDto getChampionRuneBuild(String ChampionName) {
		return dao2.getChampionRuneBuild(ChampionName);
	}
	
	public BuildSkillDto getSummonerSkillBuild(String puuid) {
		return dao2.getSkillBuild(puuid);
	}
	
	public BuildSpellDto getSummonerSpellBuild(String puuid) {
		return dao2.getSpellBuild(puuid);
	}
	
	public void MergeSummonerInfo(SummonerInfoDto dto) {
		dao.MergeSummonerInfo(dto);
	}
	
	public int selectRunebackground(int rune) {
		return dao.getRuneBackGround(rune);
	}
	
	public getRuneBuildOnDto getRuneBuildOn(String puuid) {
		if(puuid.length()>=50) {
			getRuneBuildOnDto dto = new getRuneBuildOnDto(dao2.selectRuneUrl(getSummonerRuneBuild(puuid).getCbrChampMain1()), dao2.selectRuneUrl(getSummonerRuneBuild(puuid).getCbrChampMain2()), dao2.selectRuneUrl(getSummonerRuneBuild(puuid).getCbrChampMain3()), dao2.selectRuneUrl(getSummonerRuneBuild(puuid).getCbrChampMain4()), dao2.selectRuneUrl(getSummonerRuneBuild(puuid).getCbrChampSub1()), dao2.selectRuneUrl(getSummonerRuneBuild(puuid).getCbrChampSub2()));
			System.out.println("URL 테스트 바로 여기입니다..!"+dto.getRuneUrL_1()+ dto.getRuneUrL_2()+dto.getRuneUrL_3()+dto.getRuneUrL_4()+dto.getRuneUrL_5()+dto.getRuneUrL_6());
			return dto;
		}
		else if(puuid.length()<50){
			System.out.println("여긴왔는데" + dao2.selectRuneUrl(getChampionRuneBuild(puuid).getCbrChampMain1()));
			getRuneBuildOnDto dto = new getRuneBuildOnDto(dao2.selectRuneUrl(getChampionRuneBuild(puuid).getCbrChampMain1()), dao2.selectRuneUrl(getChampionRuneBuild(puuid).getCbrChampMain2()), dao2.selectRuneUrl(getChampionRuneBuild(puuid).getCbrChampMain3()), dao2.selectRuneUrl(getChampionRuneBuild(puuid).getCbrChampMain4()), dao2.selectRuneUrl(getChampionRuneBuild(puuid).getCbrChampSub1()), dao2.selectRuneUrl(getChampionRuneBuild(puuid).getCbrChampSub2()));
			System.out.println("URL 테스트 바로 여기입니다..!"+dto.getRuneUrL_1()+ dto.getRuneUrL_2()+dto.getRuneUrL_3()+dto.getRuneUrL_4()+dto.getRuneUrL_5()+dto.getRuneUrL_6());
			return dto;
		}
		return null;
	}

	
	public getShardBuildOnDto getShardBuildOn(String puuid) {
		int champId = dao2.getMainCampId(puuid);
		Map<String, Object> param = new HashMap<>();
		param.put("puuid", puuid);
		param.put("champId", champId);
		return dao2.getLastMatchShard(param);
	}
	
	
	public mainRunePageDto getMainRunePage(int runeType) {
		mainRunePageDto dto;
		switch (runeType) {
		case 1: dto = new mainRunePageDto(dao2.selectRuneUrl(8005), dao2.selectRuneUrl(8008), dao2.selectRuneUrl(8021), dao2.selectRuneUrl(9101), dao2.selectRuneUrl(9111), dao2.selectRuneUrl(8009), dao2.selectRuneUrl(9104), dao2.selectRuneUrl(9105), dao2.selectRuneUrl(9103), dao2.selectRuneUrl(8014), dao2.selectRuneUrl(8017), dao2.selectRuneUrl(8299)); return dto;
		case 2: dto = new mainRunePageDto(dao2.selectRuneUrl(8112), dao2.selectRuneUrl(8128), dao2.selectRuneUrl(9923), dao2.selectRuneUrl(8126), dao2.selectRuneUrl(8139), dao2.selectRuneUrl(8143), dao2.selectRuneUrl(8137), dao2.selectRuneUrl(8140), dao2.selectRuneUrl(8141), dao2.selectRuneUrl(8135), dao2.selectRuneUrl(8105), dao2.selectRuneUrl(8106)); return dto;
		case 3: dto = new mainRunePageDto(dao2.selectRuneUrl(8214), dao2.selectRuneUrl(8229), dao2.selectRuneUrl(8230), dao2.selectRuneUrl(8224), dao2.selectRuneUrl(8226), dao2.selectRuneUrl(8275), dao2.selectRuneUrl(8210), dao2.selectRuneUrl(8234), dao2.selectRuneUrl(8233), dao2.selectRuneUrl(8237), dao2.selectRuneUrl(8232), dao2.selectRuneUrl(8236)); return dto;
		case 4: dto = new mainRunePageDto(dao2.selectRuneUrl(8437), dao2.selectRuneUrl(8439), dao2.selectRuneUrl(8465), dao2.selectRuneUrl(8446), dao2.selectRuneUrl(8463), dao2.selectRuneUrl(8401), dao2.selectRuneUrl(8429), dao2.selectRuneUrl(8444), dao2.selectRuneUrl(8473), dao2.selectRuneUrl(8451), dao2.selectRuneUrl(8453), dao2.selectRuneUrl(8242)); return dto;
		case 5: dto = new mainRunePageDto(dao2.selectRuneUrl(8351), dao2.selectRuneUrl(8360), dao2.selectRuneUrl(8369), dao2.selectRuneUrl(8306), dao2.selectRuneUrl(8304), dao2.selectRuneUrl(8321), dao2.selectRuneUrl(8313), dao2.selectRuneUrl(8352), dao2.selectRuneUrl(8345), dao2.selectRuneUrl(8347), dao2.selectRuneUrl(8410), dao2.selectRuneUrl(8316)); return dto; 
		default: return null;   
		}
	}
	
	public subRunePageDto getSubRunePage(int runeType) {
		subRunePageDto dto;
		switch (runeType) {
		case 1: dto = new subRunePageDto(dao2.selectRuneUrl(9101), dao2.selectRuneUrl(9111), dao2.selectRuneUrl(8009), dao2.selectRuneUrl(9104), dao2.selectRuneUrl(9105), dao2.selectRuneUrl(9103), dao2.selectRuneUrl(8014), dao2.selectRuneUrl(8017), dao2.selectRuneUrl(8299)); return dto;
		case 2: dto = new subRunePageDto(dao2.selectRuneUrl(8126), dao2.selectRuneUrl(8139), dao2.selectRuneUrl(8143), dao2.selectRuneUrl(8137), dao2.selectRuneUrl(8140), dao2.selectRuneUrl(8141), dao2.selectRuneUrl(8135), dao2.selectRuneUrl(8105), dao2.selectRuneUrl(8106)); return dto;
		case 3: dto = new subRunePageDto(dao2.selectRuneUrl(8224), dao2.selectRuneUrl(8226), dao2.selectRuneUrl(8275), dao2.selectRuneUrl(8210), dao2.selectRuneUrl(8234), dao2.selectRuneUrl(8233), dao2.selectRuneUrl(8237), dao2.selectRuneUrl(8232), dao2.selectRuneUrl(8236)); return dto;
		case 4: dto = new subRunePageDto(dao2.selectRuneUrl(8446), dao2.selectRuneUrl(8463), dao2.selectRuneUrl(8401), dao2.selectRuneUrl(8429), dao2.selectRuneUrl(8444), dao2.selectRuneUrl(8473), dao2.selectRuneUrl(8451), dao2.selectRuneUrl(8453), dao2.selectRuneUrl(8242)); return dto;
		case 5: dto = new subRunePageDto(dao2.selectRuneUrl(8306), dao2.selectRuneUrl(8304), dao2.selectRuneUrl(8321), dao2.selectRuneUrl(8313), dao2.selectRuneUrl(8352), dao2.selectRuneUrl(8345), dao2.selectRuneUrl(8347), dao2.selectRuneUrl(8410), dao2.selectRuneUrl(8316)); return dto;
		default: return null;
		}
	}
	
	public shardDto getAllShard() {
		shardDto dto = new shardDto(dao2.getshard(5001), dao2.getshard(5005), dao2.getshard(5007), dao2.getshard(5008),	dao2.getshard(5010), dao2.getshard(5011), dao2.getshard(5013));
		return dto;
	}
	
	public BuildItemURLDto getSBIURL(BuildItemDto dto) {
		BuildItemURLDto dto2 = new BuildItemURLDto(dao2.SelectItemImage(dto.getCbiItem1()), dao2.SelectItemImage(dto.getCbiItem2()), dao2.SelectItemImage(dto.getCbiItem3()), dao2.SelectItemImage(dto.getCbiItem21()), dao2.SelectItemImage(dto.getCbiItem22()), dao2.SelectItemImage(dto.getCbiItem23()), dao2.SelectItemImage(dto.getCbiItem31()), dao2.SelectItemImage(dto.getCbiItem32()), dao2.SelectItemImage(dto.getCbiItem33()));
		return dto2;
	}
	
	public BuildItemWinAndPickRateDto getSBIWRANDPR(String puuid, int champId, BuildItemDto dto) {
		PickRateDto dto1 = new PickRateDto(puuid, champId, dto.getCbiItem1());
		PickRateDto dto2 = new PickRateDto(puuid, champId, dto.getCbiItem2());
		PickRateDto dto3 = new PickRateDto(puuid, champId, dto.getCbiItem3());
		PickRateDto dto4 = new PickRateDto(puuid, champId, dto.getCbiItem33());
		PickRateDto dto5 = new PickRateDto(puuid, champId, dto.getCbiItem22());
		PickRateDto dto6 = new PickRateDto(puuid, champId, dto.getCbiItem23());
		BuildItemWinAndPickRateDto dto8 = new BuildItemWinAndPickRateDto(
				dao2.getSummonerItemWinrate(dto1).getWinRate(), dao2.getSummonerItemWinrate(dto1).getPikRate(),
				dao2.getSummonerItemWinrate(dto2).getWinRate(), dao2.getSummonerItemWinrate(dto2).getPikRate(), 
				dao2.getSummonerItemWinrate(dto3).getWinRate(), dao2.getSummonerItemWinrate(dto3).getPikRate(), 
				dao2.getSummonerItemWinrate(dto4).getWinRate(), dao2.getSummonerItemWinrate(dto4).getPikRate(),
				dao2.getSummonerItemWinrate(dto5).getWinRate(), dao2.getSummonerItemWinrate(dto5).getPikRate(),
				dao2.getSummonerItemWinrate(dto6).getWinRate(), dao2.getSummonerItemWinrate(dto6).getPikRate());
		return dto8;
	}
	
	public List<main3champDto> getMain3Champ(String puuid){
		List<Map<String, Object>> result = sqlsession.selectList("matchMapper.selectSummonerMainChamp2WithWinRate", puuid);
	    List<main3champDto>list1 = new ArrayList<>();
	    for (Map<String, Object> row : result) {
	    	main3champDto dto = new main3champDto(
			 	(String) row.get("PLAYER_CHAMP"),
    		    ((Number) row.get("CHAMP_ID")).intValue(),
    		    ((Number) row.get("TOTAL_CNT")).intValue(),
    		    ((Number) row.get("WIN_CNT")).intValue(),
    		    ((Number) row.get("LOSE_CNT")).intValue(),
    		    ((Number) row.get("WIN_RATE")).doubleValue(),
    		    ((Number) row.get("KDA")).doubleValue());
	    	list1.add(dto);
	    }
	    System.out.println(list1.get(0).getPlayerChamp());
		return list1;
	}
	
	//하나에 매치에 대해서 10개의 데이터를 반환함 11번째는 조회된 소환사의 데이터 10개의 데이터중에도 소환사의 데이터로 들어가는 내용들이있음 (더미) 
	public List<totalDetailDto> getTotalDetail(String MatchId,String puuid) {
		List<selectDetailDto>list1 = totalDetaildao.selectDetail(MatchId);
		matchsDto dto = totalDetaildao.selectMatchs(MatchId);
		List<totalDetailDto>list2 = new ArrayList<>();
		String realTime = ""+(dto.getPlayTime()/60)+":"+(dto.getPlayTime()%60);
		int cnt=0;
		LocalDateTime endTime = LocalDateTime.parse("2025-07-18 03:54:22.0", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));
		long days = ChronoUnit.DAYS.between(endTime, LocalDateTime.now());
		String result = days + "일 전";
		
		String winOrLosses = "패배";
		System.out.println("endTime : " + dto.getEndTime());
		System.out.println("매치 사이즈" + list1.size());
		for(int i=0; i<=list1.size()-1; i++) {
			MatchItemsDto dto2 = totalDetaildao.selectMatchItem(MatchId, list1.get(i).getMdSummonerId());
			String URL = dao2.getSummonerChapionImage(list1.get(i).getChampId());
			totalDetailDto totaldto = new totalDetailDto(
					MatchId, list1.get(i).getMdSummonerId(), list1.get(i).getPlayerChamp(), list1.get(i).getChampId(),
					list1.get(i).getPlayerKills(), list1.get(i).getPlayerDeaths(), list1.get(i).getPlayerAssists(), list1.get(i).getPlayerDamage(),
					list1.get(i).getTeamId(), list1.get(i).getBanPick(), list1.get(i).getPuuid(),
					dto2.getMatchItem1(), dto2.getMatchItem2(), dto2.getMatchItem3(), dto2.getMatchItem4(), dto2.getMatchItem5(), dto2.getMatchItem6(), dto2.getMatchItem7(),
					URL, result, realTime, dto.getWinnerTeam(), winOrLosses);
			list2.add(totaldto);
			if(puuid == list1.get(i).getPuuid()) {
				cnt = i;
				if(list1.get(i).getTeamId()==dto.getWinnerTeam()) {
					winOrLosses = "승리";
				}
			}
			if (cnt == 11) {
				break;
			}
			if (i==9) {
				i=cnt-1;
				cnt = 11;
			}
		}
		return list2;
	}
	@Override
	public String getOnlyPuuid(String id) {
		String puuid = dao.getOnlyPuuid(id); 
		return puuid;
	}
	@Override
	public List<String> getOnlyMatchId(String id){
		return dao.getOnlyMatchId(id);
	}
	@Override
	public String searchSummoner(String id) {
		return dao2.searchSummoner(id);
	}
	@Override
	public boolean checkSummoner(String id) {
		return dao2.checkSummoner(id);
	}
	@Override
	public boolean checkChampion(String champName) {
		return dao2.checkChampion(champName);
	}

}
