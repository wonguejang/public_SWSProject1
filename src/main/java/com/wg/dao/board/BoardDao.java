package com.wg.dao.board;

import java.util.List;

import com.wg.dto.Board.FreeBoardDto;
import com.wg.dto.Board.FreeBoardWriteChampDto;
import com.wg.dto.Board.FreeBoardWriteItemDto;
import com.wg.dto.Board.FreeBoardWriteRuneDto;
import com.wg.dto.Board.FreeBoardWriteSpellDto;
import com.wg.dto.Board.ReplyBoardDto;

public interface BoardDao {
	// 페이지 네이션으로 게시글 받아오기
	List<FreeBoardDto> listBoard(int rnum1, int rnum2);	//rnum1 시작번호 rnum2 끝번호
	
	//마지막 페이지 번호 가져오기
	int getLastPageNumber();	
	
	//게시글 작성하기
	int insertBoardWriter(String title, String content, String writer); //titlt 제목, content 게시글 내용, writer 작성자	
	
	//게시글 삭제
	int deletContentByWriterBno(String id, int bno);	// id로 해당 게시글 번호(bno)의 게시글 삭제

	//게시글 작성에 사용할 챔피언 사진등
	List<FreeBoardWriteChampDto> getBoardWriteChamp(); 
	
	//게시글 작성에 사용할 룬 사진등
	List<FreeBoardWriteRuneDto> getBoardWriteRune();
	
	//게시글 작성에 사용할 아이템 사진등
	List<FreeBoardWriteItemDto> getBoardWriteItem(); 
	
	//게시글 작성에 사용할 스펠 사진등
	List<FreeBoardWriteSpellDto> getBoardWriteSpell();
	
	//게시글 검색
	List<FreeBoardDto> getBoardListBySearch(String category, String boardSearch);  //게시글 검색시 비슷하거나 일치하는 게시글 가져오기
	
	//게시글 번호의 작성자 
	String getWriterByBno(int bno);	// 게시글 번호로 게시글 작성자 가져오기 return fWriter
	
	//로그인 id로 닉네임(fWrtier)받기
	String getWriterByUserId(String id); //로그인 id 로 작성자 받기. return f_Writer
	
	//게시글 상세보기
	FreeBoardDto listBoard(int bno); //게시글 번호의 게시글 내용보기
	
	//게시글 수정
	int updateContentByBno(int bno, String title, String content); //게시글 번호로 내용을 가져와서 제목 내용 수정
	
	//조회수 증가
	int viewCount(int bno);	//해당 게시글(게시글 번호의)글을 클릭하여 조회시 증가
	
	//해당 게시글의 내용을 보고 댓글 달기
	int replyFreeBoard(int bno, String writer, String content); // bno -> 게시글 번호, writer - 댓글 작성자, content - 댓글내용
	
	//게시글의 댓글 보여주기
	List<ReplyBoardDto> replyBoardByBno(int bno);	// (bno - 게시글 번호) 게시글에달린 댓글 가져오기
	
	//게시글 추천!
	int likeCount(int bno);	// 게시글 번호의 추천수 올리기
	
	//게시글 비추천
	int deLikeCount(int bno); // 게시글 번호의 비추천 수 올리기
	
	//추천 수 가져오기
	int getLikeCountByBno(int bno);	// 게시글 번호(bno)의 추천수 가져오기
	
	//비추천 수 가져오기
	int getDelikeCountByBno(int bno);	// 게시글 번호(bno)의 비추천수 가져오기
	
	//댓글 삭제하기
	int deleteReply(int rno, String id); // 댓글번호(rno)의 작성자가 id의 닉네임과 같다면 삭제(id로 닉네임(작성자)받아오기
}
