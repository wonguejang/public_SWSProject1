package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

class Ranker {
	String userId;
	String puuid;
}

@Component
public class CheckRanker {
	@Value("${riot.api.key}")
	private String API_KEY;
	
	String urlStr = String.format("https://kr.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5");
	String urlStr2 = String.format("https://kr.api.riotgames.com/lol/league/v4/grandmasterleagues/by-queue/RANKED_SOLO_5x5");
	// URL 연결
	List<String>puuidList = new ArrayList<String>();
	public List<String> CheckRanker() {
		try {
			// URL 인코딩 처리 (공백 등 특수문자)
			System.out.println(API_KEY);
			URL url = new URL(urlStr);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			// GET 메소드와 헤더 설정
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Riot-Token", API_KEY);
			int responseCode = con.getResponseCode();
			System.out.println(responseCode);
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
				
				JSONObject json = new JSONObject(response.toString()); // 전체 JSON 파싱
				JSONArray entries = json.getJSONArray("entries");      

				for (int i = 0; i < entries.length(); i++) {
				    JSONObject entry = entries.getJSONObject(i);      
				    String puuid = entry.getString("puuid");
				    puuidList.add(puuid);
				    System.out.println(i+"번째 PUUID: " + puuidList.get(i));
				}
			}
			return puuidList;
			
		} catch (Exception e){
			e.printStackTrace();
		}
		return puuidList;
	}
	
	public List<String> CheckRanker2() {
		try {
			// URL 인코딩 처리 (공백 등 특수문자)
			URL url = new URL(urlStr2);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			// GET 메소드와 헤더 설정
			con.setRequestMethod("GET");
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
				
				JSONObject json = new JSONObject(response.toString()); // 전체 JSON 파싱
				JSONArray entries = json.getJSONArray("entries");      

				for (int i = 0; i < entries.length(); i++) {
				    JSONObject entry = entries.getJSONObject(i);      
				    String puuid = entry.getString("puuid");
				    puuidList.add(puuid);
				    System.out.println(i+"번째 PUUID: " + puuidList.get(i));
				}
			}
			return puuidList;
			
		} catch (Exception e){
			e.printStackTrace();
		}
		return puuidList;
	}
}
