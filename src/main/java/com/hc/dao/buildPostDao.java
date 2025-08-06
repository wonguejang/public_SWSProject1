package com.hc.dao;

import java.util.List;
import java.util.Map;

import com.hc.BuildBoardDto.ReplyBoardDto;
import com.hc.BuildBoardDto.getBuildPostDto;
import com.hc.BuildBoardDto.getBuildPostImageDto;
import com.hc.BuildBoardDto.getBuildPostImageItemDto;
import com.hc.BuildBoardDto.getBuildPostWriteRuneImageDto;
import com.hc.BuildBoardDto.getBuildPostWriteSpellImageDto;
import com.hc.BuildBoardDto.selectBoxDto;

public interface buildPostDao {
	// 빌드게시판 전체 Post개수 조회 인터페이스
	int buildPostTotalCount();
	
	//전체 or 검색된 게시물 List get 인터페이스
	List<getBuildPostDto> buildPostList(Map<String, Object> param);
	List<getBuildPostDto> buildPostList(Map<String, Object> param,String boardCheckSerch);
	
	//게시물 detail 접속 인터페이스
	getBuildPostDto getBoardByBno(int bno);
	
	//조회수 업데이트 인터페이스
	void updateCheck(int bno);
	
	//정렬된 전체 or 검색된 게시물 List get 인터페이스
	List<getBuildPostDto> getSelectIdBuildPostList(Map<String, Object> param);
	List<getBuildPostDto> getSelectIdBuildPostList(Map<String, Object> param, String boardCheckSerch);
	
	//selectBox List get인터페이스
	List<selectBoxDto> getSelectBox ();
	
	//너네 뭐니..? 만들려다 말았나.. rating은 추천수인데.. 추천수 db 만들려다 보류해서 남은 잔재인가.. 일단 남겨둠
	int getSelectRating(int bno);
	String getRatingUse(int bno);
	
	//전체 or 검색된 마크다운 입력 이미지 get 서비스
//--------------------------------------------------------------------------------------------------------------
	List<getBuildPostImageDto> getBuiltPostWriteChampionImage();
	List<getBuildPostImageDto> getBuiltPostWriteChampionImage(String inputName);
	List<getBuildPostImageItemDto>getBuildPostWriteItemImage();
	List<getBuildPostImageItemDto>getBuildPostWriteItemImage(String inputName);
	List<getBuildPostWriteRuneImageDto>getBuildPostWriteRuneImage();
	List<getBuildPostWriteRuneImageDto>getBuildPostWriteRuneImage(String inputName);
	List<getBuildPostWriteSpellImageDto>getBuildPostWriteSpellImage();
	List<getBuildPostWriteSpellImageDto>getBuildPostWriteSpellImage(String inputName);
//--------------------------------------------------------------------------------------------------------------	
	
	//merge라고했지만 그냥 insert update로 나눴음 아 편해 야발 뭣하러 머지썻냐 ㅠ merge를 잘 써야 조회속도가 배로 빨라지는건 알겠는데 작성속도는 배로 느려요..
	void mergeBuildPost(String selectId, String title, String content, String writer);
	void mergeBuildPost(Integer bno, String selectId, String title, String content, String writer);
	
	//지워 게시물!
	void deleteBuildPost(Integer bno);
	
	//작성해! 댓글!
	void insertBuildReply(String comment, int bno, String user_name);
	
	//가져와! 댓글!
	List<ReplyBoardDto> getReplies(int bno);
	
	//영~차! 댓글 수정 삭제
	void editBuildReply(Map<String, Object> param);
	void deleteReply(int bno, int rno);
}
