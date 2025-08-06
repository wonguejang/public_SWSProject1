package com.hc.dao;

public interface buildDao {
	//서머너 빌드 merge 인터페이스 
	public void margeChampionBuildItem();
	public void mergeSummonerBuildItem(String puuid);
	public void mergeChampionBuildRunes();
	public void mergeSummonerBuildRunes(String puuid);
	public void mergeChampionBuildSkills();
	public void mergeSummonerBuildSkills(String puuid);
	public void mergeChampionBuildSpell();
	public void mergeSummonerBuildSpell(String puuid);
}