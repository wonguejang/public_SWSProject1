package com.hc.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hc.BuildBoardDto.ReplyBoardDto;
import com.hc.BuildBoardDto.getBuildPostDto;
import com.hc.BuildBoardDto.getBuildPostImageDto;
import com.hc.BuildBoardDto.getBuildPostImageItemDto;
import com.hc.BuildBoardDto.getBuildPostWriteRuneImageDto;
import com.hc.BuildBoardDto.getBuildPostWriteSpellImageDto;
import com.hc.BuildBoardDto.selectBoxDto;
import com.hc.dao.buildPostDao;

@Service
public class BuildBoardServiceImpl implements BuildBoardService {
    @Autowired
    private buildPostDao dao;
    
    //빌드게시판 페이지네이션 범위 POST boardCheckSerch(검색된내용)유무로 호출 dao -> 전체 or Like %검색된내용%
    @Override
    public List<getBuildPostDto> getBuildPostList(Map<String, Object> param, String boardCheckSerch){
    	if (boardCheckSerch != null && !boardCheckSerch.trim().isEmpty()) {
    		return dao.buildPostList(param, boardCheckSerch);
    	}
    	return dao.buildPostList(param);
    }
    
    //빌드게시판 전체 포스트수 구하는 서비스
    @Override
    public int getTotalPosts() {
    	return dao.buildPostTotalCount();
    }
    
    //빌드게시물 디테일 접속 구현 서비스
    @Override
    public getBuildPostDto getBoardByBno(int bno) {
    	return dao.getBoardByBno(bno);
    }
    
    //빌드게시판 전체 or 검색된 내용으로 정렬조회하는 인터페이스 특정 챔피언 정렬된 상태일때 (SelectId) 
    @Override
    public List<getBuildPostDto> getSelectIdBuildPostList(Map<String, Object> param,String boardCheckSerch){
    	if (boardCheckSerch != null && !boardCheckSerch.trim().isEmpty()) {
    		return dao.getSelectIdBuildPostList(param, boardCheckSerch);
    	}
    	return dao.getSelectIdBuildPostList(param);
    }
    //빌드게시판 selectBox에 append 할 객체들 get해오는 서비스
    @Override
    public List<selectBoxDto> getSelectBox () {
    	return dao.getSelectBox();
    }
    
    //추천수 업데이트 서비스 (제약조건 x)
    @Override
    public String updateRating(int bno, String user_name) {
    	if (user_name == null) {
    		return "loginFalse"; 
    	}
    	else return (dao.getRatingUse(bno));
    }

    
    //빌드 게시물 작성 페이지 or 수정 페이지 이미지 삽입 서비스들
//------------------------------------------------------------------------------------------------------------------------    
    @Override
    public List<getBuildPostImageDto> getBuiltPostWriteChampionImage(String inputName){
    	if (inputName == null || inputName.trim().isEmpty()) {//빈 문자열 검사 ""
    		return dao.getBuiltPostWriteChampionImage();
    	}
    	return dao.getBuiltPostWriteChampionImage(inputName);
    }
    @Override
    public List<getBuildPostImageItemDto>getBuildPostWriteItemImage(String inputName){
    	if (inputName == null || inputName.trim().isEmpty()) {//빈 문자열 검사 ""
    		return dao.getBuildPostWriteItemImage();
    	}
    	return dao.getBuildPostWriteItemImage(inputName);
    }
    @Override
    public List<getBuildPostWriteRuneImageDto>getBuildPostWriteRuneImage(String inputName){
    	if (inputName == null || inputName.trim().isEmpty()) {//빈 문자열 검사 ""
    		return dao.getBuildPostWriteRuneImage();
    	}
    	return dao.getBuildPostWriteRuneImage(inputName);
    }
    @Override
    public List<getBuildPostWriteSpellImageDto>getBuildPostWriteSpellImage(String inputName){
    	if (inputName == null || inputName.trim().isEmpty()) {//빈 문자열 검사 ""
    		return dao.getBuildPostWriteSpellImage();
    	}
    	return dao.getBuildPostWriteSpellImage(inputName);
    }
//------------------------------------------------------------------------------------------------------------------------ 
    
    //게시물 merge 서비스
    @Override
    public void mergeBuildPost(Integer bno, String selectId, String title, String content, String writer) {
    	if (bno == null) {
    		dao.mergeBuildPost(selectId,title,content,writer);
    	}
    	else dao.mergeBuildPost(bno,selectId,title,content,writer); 
    }
    
    //게시물 삭제 서비스
    @Override
    public void deleteBuildPost(Integer bno) {
    	dao.deleteBuildPost(bno);
    }
    
    //댓글 insert 서비스
    @Override
    public void insertBuildReply(String comment,int bno, String user_name) {
    	dao.insertBuildReply(comment, bno, user_name);
    }
    
    //조회된 detail페이지 전체댓글 조회 서비스
    @Override
    public List<ReplyBoardDto> getReplies(int bno) {
    	return dao.getReplies(bno);
    }
    
    //댓글 수정 서비스
    @Override
    public void editBuildReply(Map<String, Object> param) {
    	dao.editBuildReply(param);
    }
    
    //댓슬 삭제 서비스
    @Override
    public void deleteReply(int bno, int rno) {
    	dao.deleteReply(bno, rno);
    }
}
