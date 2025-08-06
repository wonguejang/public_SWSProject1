package com.hc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hc.BuildBoardDto.ReplyBoardDto;
import com.hc.BuildBoardDto.getBuildPostDto;
import com.hc.BuildBoardDto.getBuildPostImageDto;
import com.hc.BuildBoardDto.getBuildPostImageItemDto;
import com.hc.BuildBoardDto.getBuildPostWriteRuneImageDto;
import com.hc.BuildBoardDto.getBuildPostWriteSpellImageDto;
import com.hc.BuildBoardDto.selectBoxDto;


@Repository
public class buildPostDaoImpl implements buildPostDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int buildPostTotalCount() {
		return sqlSession.selectOne("WindowMapper.buildPostTotalCount");
	}
	@Override
	public List<getBuildPostDto> buildPostList(Map<String, Object> param){
		return sqlSession.selectList("WindowMapper.buildPostList",param);
	}
	@Override
	public List<getBuildPostDto> buildPostList(Map<String, Object> param, String boardCheckSerch){
		param.put("boardCheckSerch", boardCheckSerch);
		return sqlSession.selectList("WindowMapper.buildPostListAndSerch",param);
	}
	@Override
	public getBuildPostDto getBoardByBno(int bno) {
		return sqlSession.selectOne("WindowMapper.getBoardByBno", bno);
	}
	@Override
	public void updateCheck(int bno) {
		int inputcheck = sqlSession.selectOne("BuildPostMapper.selectCheck", bno);
		inputcheck++;
		Map<String, Object> param = new HashMap<>();
		param.put("bno", bno);
		param.put("inputcheck", inputcheck);
		sqlSession.update("BuildPostMapper.updateCheck", param);
	}
	@Override
	public List<getBuildPostDto> getSelectIdBuildPostList(Map<String, Object> param) {
	    return sqlSession.selectList("WindowMapper.getSelectIdBuildPostList", param);
	}
	@Override
	public List<getBuildPostDto> getSelectIdBuildPostList(Map<String, Object> param, String boardCheckSerch) {
		param.put("boardCheckSerch", boardCheckSerch.trim());
		return sqlSession.selectList("WindowMapper.getSelectIdBuildPostListAndSerch", param);
	}
	
	@Override
	public List<selectBoxDto> getSelectBox () {
		return sqlSession.selectList("WindowMapper.getSelectBox");
	}
	@Override
	public int getSelectRating(int bno) {
		return sqlSession.selectOne("BuildPostMapper.getSelectRating",bno);
	}
	@Override
	public String getRatingUse(int bno) {
		int check = sqlSession.selectOne("BuildPostMapper.getSelectRating",bno);
		check++;
		Map<String, Object> param = new HashMap<>();
		param.put("bno", bno);
		param.put("check", check);
		sqlSession.update("BuildPostMapper.updateRatingUse", param);
		return "success";
	}
	// 검색어 없을때 챔피언이미지 검색
	@Override
	public List<getBuildPostImageDto> getBuiltPostWriteChampionImage(){
		List<getBuildPostImageDto>list = sqlSession.selectList("BuildPostMapper.getBuildPostImage");
		//최종 목표로는 여기서 list 랑 아이템 list2 뽑아서 두 값을 합친 list3 뽑아서 리턴
		return list;
	}
	// 검색어 있을때 챔피언 이미지 검색
	@Override
	public List<getBuildPostImageDto> getBuiltPostWriteChampionImage(String inputName){
		List<getBuildPostImageDto>list = sqlSession.selectList("BuildPostMapper.getBuildPostImageSelectChampion", inputName);
		//최종 목표로는 여기서 list 랑 아이템 list2 뽑아서 두 값을 합친 list3 뽑아서 리턴 같음
		return list;
	}
	@Override
	public List<getBuildPostImageItemDto>getBuildPostWriteItemImage(){
		List<getBuildPostImageItemDto>list = sqlSession.selectList("BuildPostMapper.getBuildPostWriteItemImage");
		return list;
	}
	@Override
	public List<getBuildPostImageItemDto>getBuildPostWriteItemImage(String inputName){
		List<getBuildPostImageItemDto>list =sqlSession.selectList("BuildPostMapper.getBuildPostWriteItemImageSelect", inputName);
		return list;
	}
	@Override
	public List<getBuildPostWriteRuneImageDto>getBuildPostWriteRuneImage(){
		List<getBuildPostWriteRuneImageDto>list = sqlSession.selectList("BuildPostMapper.getBuildPostWriteRuneImage");
		return list;
	}
	@Override
	public List<getBuildPostWriteRuneImageDto>getBuildPostWriteRuneImage(String inputName){
		List<getBuildPostWriteRuneImageDto>list = sqlSession.selectList("BuildPostMapper.getBuildPostWriteRuneImageSelect", inputName);
		return list;
	}
	@Override
	public List<getBuildPostWriteSpellImageDto>getBuildPostWriteSpellImage(){
		List<getBuildPostWriteSpellImageDto>list = sqlSession.selectList("BuildPostMapper.getBuildPostWriteSpellImage");
		return list;
	}
	@Override
	public List<getBuildPostWriteSpellImageDto>getBuildPostWriteSpellImage(String inputName){
		List<getBuildPostWriteSpellImageDto>list = sqlSession.selectList("BuildPostMapper.getBuildPostWriteSpellImageSelect", inputName);
		return list;
	}
	@Override
	public void mergeBuildPost(String selectId, String title, String content, String writer) {
		getBuildPostDto dto = new getBuildPostDto(0, selectId, title, content, writer, "흐히힣코딩재미땅", 0, 0);
		sqlSession.insert("BuildPostMapper.insertBuildPost",dto);
	}
	@Override
	public void mergeBuildPost(Integer bno, String selectId, String title, String content, String writer) {
		title = title + " [수정됨]";
		getBuildPostDto dto = new getBuildPostDto(bno, selectId, title, content, writer, "흐히힣코딩재미땅", 0, 0);
		sqlSession.update("BuildPostMapper.updateBuildPost",dto);
	}
	@Override
	public void deleteBuildPost(Integer bno) {
		sqlSession.delete("BuildPostMapper.deleteAllReply",bno);
		sqlSession.delete("BuildPostMapper.deleteBuildPost",bno);
	}
	@Override
	public void insertBuildReply(String comment, int bno, String user_name) {
		String rWriter = user_name;
		ReplyBoardDto dto = new ReplyBoardDto(rWriter, null, comment, 0, 0, bno, 0);
		sqlSession.insert("BuildPostMapper.insertBuildReply", dto);
	}
	@Override
	public List<ReplyBoardDto> getReplies(int bno) {
		List<ReplyBoardDto> list = sqlSession.selectList("BuildPostMapper.getReplies", bno);
		return list;
	}
	@Override
	public void editBuildReply(Map<String, Object> param) {
		sqlSession.update("BuildPostMapper.editBuildReply",param);
	}
	@Override
	public void deleteReply(int bno, int rno) {
		Map<String, Object> param = new HashMap<>();
		param.put("bno", bno);
	    param.put("rno", rno);
		sqlSession.delete("BuildPostMapper.deleteReply", param);
	}
}
