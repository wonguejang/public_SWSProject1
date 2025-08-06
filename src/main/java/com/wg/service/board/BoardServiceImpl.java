package com.wg.service.board;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wg.dao.board.BoardDao;
import com.wg.dto.Board.FreeBoardDto;
import com.wg.dto.Board.FreeBoardWriteChampDto;
import com.wg.dto.Board.FreeBoardWriteItemDto;
import com.wg.dto.Board.FreeBoardWriteRuneDto;
import com.wg.dto.Board.FreeBoardWriteSpellDto;
import com.wg.dto.Board.ReplyBoardDto;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDao dao;
	
	//게시글 10개씩 받아오기
	@Override
	public List<FreeBoardDto> listBoardByPageNum(int page) {
		//page로 시작 번호와 끝번호 만들기
		//page가 1일때 1~10까지만 가져옴
		int end = page * 10;
		int start = end - 9;
		
		List<FreeBoardDto> listBoard = null;
		try {
			listBoard = dao.listBoard(start, end);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return listBoard;
	}
	
	// 위 메서드를 사용해서 받아온 id 로 게시글 삭제하기
	@Override
	public int deletContentByWriterBnoService(String id, int bno) {
		int result = 0;
		
		result = dao.deletContentByWriterBno(id, bno);//dao단에서 id를 writer로 바꿔줌
		
		//삭제 성공시 일로 들어와야함
		if(result == 1) {
			return result; //성공하면 1
		}
		
		return result; // 실패해서 0
	}
	
	//마지막 페이지 가져오기
	@Override
	public int getLastPageNumberService() {
		return dao.getLastPageNumber(); //단순 호출
	}

	// 게시글 작성하기
	@Override
	public void insertBoardWriterService(String title, String content, String writer) {
		dao.insertBoardWriter(title, content, writer); // 단순 실행
	}
	
	// 게시글 번호(bno)의 작성자 가져오기 - 게시글로 작성자에 접근
	@Override
	public String getWriterByBnoService(int bno) {
		//게시글 작성자와 로그인한 사람이 같은지 판별용
		String writer = dao.getWriterByBno(bno); 
		return writer;
	}

	//id(user_id)로 작성자(닉네임) 가져오기 - id로 작성자에 접근
	@Override
	public String getWriterByUserIdService(String id) {
		//로그인한 사람의 닉네임(작성자)를 받기 위의 메서드와 함께 사용
		String writer = dao.getWriterByUserId(id);
		return writer;
	}

	//게시글 번호로 게시글 상세보기 - 게시글 번호에 해당하는 모든 내용 받기 
	@Override
	public FreeBoardDto getlistBoardByBnoService(int bno) {
		FreeBoardDto boardDetail = null;
		
		try {
			boardDetail = dao.listBoard(bno);
			if (boardDetail != null && boardDetail.getfDate() != null) {
				//날짜 포멧을 설정해서 수정해줌
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 M월 d일 a h:mm", Locale.KOREA);
				//boardDetailDto에 fDate이 잇고 날짜 포멧 수정용도 있음
	            boardDetail.setfFormattedDate(sdf.format(boardDetail.getfDate()));
	        }
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return boardDetail; //담겨진 값들을 담아서 리턴
	}

	//게시글 번호로 해당게시글 업데이트
	@Override
	public int updateContentByBnoService(int bno, String title, String content) {
		
		int result = 0;
		
		result = dao.updateContentByBno(bno, title, content);

		//업데이트 성공시 result를 리턴
		if(result == 1) {
			return result;
		}
		
		return result; //실패시 0리턴
	}
	
	//게시글 번호로 조회수 올리고 session으로 중복 추천 막기
	@Override
	public int updateViewCountService(int bno, HttpSession session) {
		//bno가 가변 수 여서 session의 값들이 여러개로 저장됨
		//최초에는 담긴 session이 없기 때문에 아래 조건문이 실행이 안됨
		if(session.getAttribute("result_"+bno)!=null) {
			return 0; // 아래 실행 안시키고 리턴 시켜버리기
		}
		
		//조회 수 증가
		int check = 0 ;
		check = dao.viewCount(bno);
		//코드의 실행에 따라 session에 해당 게시글 번호 확인 여부가 저장됨
		//이후 같은 코드의 실행시 위의 조건문에 의해 조회수 증가가 실행되지 않음.
		session.setAttribute("result_"+bno, "true");    // "true" is meaningless.
		
		if(check == 1) {
			return check;
		}
		return check; // 실패시 0 리턴
	}

	//게시글 번호에 댓글 달기 
	@Override
	public int insertReplyFreeBoard(int bno, String writer, String content) {
		int result = 0;
		result = dao.replyFreeBoard(bno, writer, content);
		
		//성공시 1 리턴
		if(result == 1) {
			return result;
		}
		return result; // 실패시 0 리턴
	}

	//게시글 번호의 댓글들 가져오기
	@Override
	public List<ReplyBoardDto> getReplyBoardByBnoService(int bno) {
		return dao.replyBoardByBno(bno);
	}

	//게시글 번호의 추천수 올리기 session으로 중복 추천 방지
	@Override
	public int updateLikeCountService(int bno, HttpSession session) {
		//session에 같은 내용이 들어있으면 돌려보냄 (증가 x)
		if(session.getAttribute("likeCount_"+bno) != null) {
			return 0;
		}
		
		int check = 0;
		check = dao.likeCount(bno);
		//성공시 session에 담아서 추천했는지 확인(중복추천 방지) 1리턴
		if(check == 1) {
			session.setAttribute("likeCount_"+bno, "true");
			return check;
		}
		
		return check; // 실패시 0리턴
	}

	//게시글 번호의 비추천수 올리기 session으로 중복 비추천 방지
	@Override
	public int updateDelikeCountService(int bno, HttpSession session) {
		//session에 같은 내용이 있으면 0리턴(0은 비추천 실패 숫자가 증가하지 않음)
		if(session.getAttribute("delikeCount_"+bno) != null) {
			return 0;
		}
		
		int check = 0;
		check = dao.deLikeCount(bno);
		
		//성공시 session에 값을 담고(중복방지용) 1을 리턴
		if(check == 1) {
			session.setAttribute("delikeCount_"+bno, "true");
			return check;
		}
		
		return check; // 실패시 0 리턴
	}

	//게시글 번호의 추천 수 가져오기
	@Override
	public int getLikeCountByBnoService(int bno) {
		int likeResult = 0;
		try {
			likeResult = dao.getLikeCountByBno(bno);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return likeResult;
	}

	//게시글 번호의 비추천수 가져오기
	@Override
	public int getDelikeCountByBnoService(int bno) {
		int delikeResult = 0;
		try {
			delikeResult = dao.getDelikeCountByBno(bno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return delikeResult;
	}
	
	//게시글의 댓글 번호를 받고 id는 writer로 받아서 rno와 writer로 댓글 삭제
	@Override
	public int deleteReplyBoardByRnorWriterService(int rno, String id) {
		System.out.println("서비스임플 id : " +id);
		//로그인해있는 id로 rWiteter(댓글작성자)를 받아서 전달함
		String rWriter = dao.getWriterByUserId(id);
		
		int deleteCheck = 0;
		try {
			deleteCheck = dao.deleteReply(rno, rWriter);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//성공시 1리턴
		if(deleteCheck == 1) {
			return deleteCheck;
		}
		
		return deleteCheck; //실패시 0 리턴
	}

	//게시글 작성시 하단에 그려주는 친구들
	//챔피언 정보들 받아오기
	@Override
	public List<FreeBoardWriteChampDto> getBoardWriteChampService() {
		return dao.getBoardWriteChamp();
	}
	//룬 정보들 받아오기
	@Override
	public List<FreeBoardWriteRuneDto> getBoardWriteRuneService() {
		return dao.getBoardWriteRune();
	}
	//아이템 정보들 받아오기
	@Override
	public List<FreeBoardWriteItemDto> getBoardWriteItemService() {
		return dao.getBoardWriteItem();
	}
	//스펠 정보들 받아오기
	@Override
	public List<FreeBoardWriteSpellDto> getBoardWriteSpellService() {
		return dao.getBoardWriteSpell();
	}

	//게시물 검색
	@Override
	public List<FreeBoardDto> getBoardListBySearchService(String category, String boardSearch) {
		// category (제목, 내용, 제목+내용), boardSearch 게시물 검색 내용
		List<FreeBoardDto> resultList = dao.getBoardListBySearch(category, boardSearch);

		return resultList;
	}
	

}
