package com.hc.service;

import java.util.List;
import java.util.Map;

import com.hc.BuildBoardDto.ReplyBoardDto;
import com.hc.BuildBoardDto.getBuildPostDto;
import com.hc.BuildBoardDto.getBuildPostImageDto;
import com.hc.BuildBoardDto.getBuildPostImageItemDto;
import com.hc.BuildBoardDto.getBuildPostWriteRuneImageDto;
import com.hc.BuildBoardDto.getBuildPostWriteSpellImageDto;
import com.hc.BuildBoardDto.selectBoxDto;

public interface BuildBoardService {
	//빌드게시판 전체 Post개수 구하는 인터페이스
	int getTotalPosts();
	
	//빌드게시판 페이지네이션 범위 POST get인터페이스
	public abstract List<getBuildPostDto> getBuildPostList(Map<String, Object> param, String boardCheckSerch);
	
	//빌드 게시물 디테일 접속 인터페이스
	public abstract getBuildPostDto getBoardByBno(int bno);
	
	//빌드게시판 전체 or 검색된 내용으로 정렬조회하는 인터페이스
	public abstract List<getBuildPostDto> getSelectIdBuildPostList(Map<String, Object> param ,String boardCheckSerch);
	
	//빌드게시판 챔피언 selectBox에 append할 내용 List로 get하는 인터페이스
	public abstract List<selectBoxDto> getSelectBox ();
	
	//추천수 업데이트하는 인터페이스
	public abstract String updateRating(int bno, String user_name);

	
	//게시물 write 할때 마크다운에 이미지 넣는 container에 이미지 아이디 이름 정보 가져오는 인터페이스들
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	public abstract List<getBuildPostImageDto> getBuiltPostWriteChampionImage(String inputName);
	public abstract List<getBuildPostImageItemDto>getBuildPostWriteItemImage(String inputName);
	public abstract List<getBuildPostWriteRuneImageDto>getBuildPostWriteRuneImage(String inputName);
	public abstract List<getBuildPostWriteSpellImageDto>getBuildPostWriteSpellImage(String inputName);
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	//게시물 merge하는 인터페이스
	public abstract void mergeBuildPost(Integer bno, String selectId, String title, String content, String writer);
	
	//게시물 지우는 인터페이스
	public abstract void deleteBuildPost(Integer bno);
	
	//게시물 댓글 insert 인터페이스
	public abstract void insertBuildReply(String comment, int bno, String user_name);
	
	//조회된 게시물 댓글정보 조회 인터페이스
	public abstract List<ReplyBoardDto> getReplies(int bno);
	
	//댓글 수정 인터페이스
	public abstract void editBuildReply(Map<String, Object> param);
	
	//댓글 삭제 인터페이스
	public abstract void deleteReply(int bno, int rno);
}
