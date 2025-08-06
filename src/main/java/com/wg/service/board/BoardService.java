package com.wg.service.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.wg.dto.Board.FreeBoardDto;
import com.wg.dto.Board.FreeBoardWriteChampDto;
import com.wg.dto.Board.FreeBoardWriteItemDto;
import com.wg.dto.Board.FreeBoardWriteRuneDto;
import com.wg.dto.Board.FreeBoardWriteSpellDto;
import com.wg.dto.Board.ReplyBoardDto;

public interface BoardService {
	// 페이지 번호로 게시글  받아오기
	List<FreeBoardDto> listBoardByPageNum(int page); //page로 시작번호 끝번호 만들어주기
	
	// 마지막 페이지 번호 가져오기
	int getLastPageNumberService();	
	
	// 게시글 작성							
	void insertBoardWriterService(String title, String content, String writer); //title - 제목, content - 내용 , writer 작성자(유저닉네임) 
	
	//게시글 삭제하기 						
	int deletContentByWriterBnoService(String id, int bno); //id로 writer받아와서 삭제	
	
	//해당 게시글의 작성자 가져오기
	String getWriterByBnoService(int bno);	// 게시글 번호로 작성자 가져오기

	//id로 닉네임(작성자) 받기
	String getWriterByUserIdService(String id);	//유저 id로 작성자 받기
	
	//해당게시글 번호의 내용 모두 받아오기
	FreeBoardDto getlistBoardByBnoService(int bno); // 게시글 번호조회해서 게시글 상세보기
	
	//해당게시글 번호의 내용 업데이트				title - 기존글 작성자,  content 기존 게시글 내용
	int updateContentByBnoService(int bno, String title, String content); //게시글 번호로 게시글 내용 받아오고 그 내용을 수정
	
	//조회수 올리기
	int updateViewCountService(int bno, HttpSession session);	//해당 번호의 게시글 조회수 증가
	
	//게시글에 댓글 달기
	int insertReplyFreeBoard(int bno, String writer, String content); //bno 게시글 번호 writer 댓글 작성자, content 댓글 내용
	
	//게시글에 달린 댓글들 가져오기
	List<ReplyBoardDto> getReplyBoardByBnoService(int bno);	//게시글 번호로 해당 게시글에 달린 댓글 모두 가져오기
	
	//게시글 추천					//bno 게시글 번호, session 중복추천 방지를 위해 사용
	int updateLikeCountService(int bno, HttpSession session);	// 게시글 번호의 추천수 올리기
	
	//게시글 비추천					//bno 게시글 번호, session 중복비추천 방지를 위해 사용
	int updateDelikeCountService(int bno, HttpSession session);	// 게시글 번호의 비추천수 올리기
	
	//게시글 추천수 가져오기
	int getLikeCountByBnoService(int bno); // 게시글 번호에 해당하는 추천수 가져오기
	
	//게시글 비 추천수 가져오기
	int getDelikeCountByBnoService(int bno); //게시글 번호에 해당하는 비추천수 가져오기
	
	//댓글 삭제
	int deleteReplyBoardByRnorWriterService(int rno, String id); //댓글 번호에 작성자(id로 작성자 받아옴)가 같을때 댓글 삭제

	//게시글 작성시 하단에 추가할 챔피언 내용 
	List<FreeBoardWriteChampDto> getBoardWriteChampService();	// 다오 기능 사용해서 챔피언 이미지와 이름 가져오기

	//게시글 작성시 하단에 추가할 룬 내용
	List<FreeBoardWriteRuneDto> getBoardWriteRuneService();	// 다오 기능을 사용해서 룬 이미지와 이름 등 가져오기
	
	//게시글 작성시 하단에 추가할 아이템 내용
	List<FreeBoardWriteItemDto> getBoardWriteItemService();	// 다오 기능을 사용해서 아이템 이미지와 이름 등 가져오기
	
	//게시글 작성시 하단에 추가할 스펠 내용
	List<FreeBoardWriteSpellDto> getBoardWriteSpellService(); // 다오 기능을 사용해서 스펠 이미지와 이름 등 가져오기

	//게시글 검색
	List<FreeBoardDto> getBoardListBySearchService(String category, String boardSearch); //게시글 검색어로 게시글 가져오기
}
