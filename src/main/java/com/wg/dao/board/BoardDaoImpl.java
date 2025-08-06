package com.wg.dao.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wg.dto.Board.FreeBoardDto;
import com.wg.dto.Board.FreeBoardWriteChampDto;
import com.wg.dto.Board.FreeBoardWriteItemDto;
import com.wg.dto.Board.FreeBoardWriteRuneDto;
import com.wg.dto.Board.FreeBoardWriteSpellDto;
import com.wg.dto.Board.ReplyBoardDto;

@Repository
public class BoardDaoImpl implements BoardDao {
	@Autowired
	SqlSession sqlSession;
	
	//페이지 번호로 게시글 목록 가져오기 rnum1 시작번호, rnum2 끝번호
	@Override
	public List<FreeBoardDto> listBoard(int rnum1, int rnum2) {
		//매퍼에 값을 여러개 보낼떄 key:value로 해서 HashMap사용
		HashMap<String, Integer> map1 = new HashMap<>();
		map1.put("rnum1", rnum1);
		map1.put("rnum2", rnum2);
		
		return sqlSession.selectList("BoardMapper.selectBoardList",map1);
	}
	
	//게시글 마지막 페이지 가져오기
	@Override
	public int getLastPageNumber() {
		int totalCount = sqlSession.selectOne("BoardMapper.getLastPageNum");
		int pageSize = 10; //게시글을 10개에 한페이지라고 계산
		int lastPage = (totalCount % pageSize == 0) ? (totalCount / pageSize) : (totalCount / pageSize) + 1 ; 
		
		return lastPage;  
	} 

	//게시글 쓰기 크기가 너무 크면 끊어서 보내기
	@Override
	public int insertBoardWriter(String title, String content, String writer) {
		//오라클 특성상 varchar2타입은 4000byte, 
		//그러나 게시글 내용은 훨씬길어짐 그래서 clob타입으로 db를 설정하고
		//문자열을 잘라줌
		int contentMaxSize = 1333; //한글이 3바이트라서 안전하게 한번에 넣을떄 1333개씩
		List<String> insertClob = new ArrayList<>();
		int length = content.length();
		
		for(int i = 0; i <= length; i += contentMaxSize) {
			int end = Math.min(length, i+contentMaxSize);
			insertClob.add(content.substring(i,end));
		}
		FreeBoardDto dto = new FreeBoardDto();
		dto.setfTitle(title);
		dto.setfWriter(writer);
		dto.setfContent(insertClob.get(0));
		//selectkey 로 bno값 받아올꺼임
		sqlSession.insert("BoardMapper.insertBoardWrite", dto);
		
		//bno = insert되자마자 받아온 해당글의 게시글 번호
		int bno = dto.getfBno() + 1;
		for(int i = 1; i <= insertClob.size()-1; i++) {
			HashMap<String, Object> map1 = new HashMap<>();
			map1.put("bno", bno);
			map1.put("content", insertClob.get(i));
			//이렇게 담아진 insertClob의 내용이 매퍼에서 update됨(문자열 더하기)
			sqlSession.update("BoardMapper.toLongContent", map1);
		}
		
		//getfBno는 before실행으로 가져온거라서 1더해야 현재의 최대 bno값이된다
		return dto.getfBno()+1;
	}
	
	// id로 게시글 삭제하기
	@Override
	public int deletContentByWriterBno(String id, int bno) {
		//id로 작성자(닉네임) 받아오기
		String writer = getWriterByUserId(id);
		
		HashMap<String, Object> map1 = new HashMap<>();
		map1.put("writer", writer);
		map1.put("bno", bno);
		
		int result = sqlSession.delete("BoardMapper.deleteBoardContentByWriterId", map1);

		//영향받은 행의 개수 = result
		if(result == 1) {
			return result; //삭제 성공
		}
		
		return 0; // 0리턴시 실패
	}
	
	// 게시글 번호로 게시글 작성자 가져오기 return writer
	@Override
	public String getWriterByBno(int bno) {
		
		String writer = sqlSession.selectOne("BoardMapper.getWriterByBno", bno);
		
		return writer;
	}
	
	//유저 id로 작성자 가져오기
	@Override
	public String getWriterByUserId(String id) {
		
		String writer = sqlSession.selectOne("com.wg.dao.MemberDao.selectUserName",id);

		return writer;
	}

	//게시글 상세보기 bno는 게시글 번호
	@Override
	public FreeBoardDto listBoard(int bno) {
		FreeBoardDto dto = null;
		
		try {							
			dto = sqlSession.selectOne("BoardMapper.getListBoardByBno",bno); //게시글 번호의 내용들 dto에 담기
		}catch(Exception e) {
			e.printStackTrace();
		}

		return dto;
	}
	
	//게시글 번호로 게시글 수정
	@Override
	public int updateContentByBno(int bno, String title, String content) {
		//bno 게시글번호, title 작성자, content 수정된 내용
		HashMap<String, Object> map1 = new HashMap<>();
		map1.put("bno", bno);
		map1.put("title", title);
		map1.put("content", content);
		
		int result = sqlSession.update("BoardMapper.updateContentByBno", map1);
		
		//쿼리문 실행으로 영향받은 행의 개수
		if(result == 1) {
			return result;
		}
		
		return 0; //수정 실패
	}

	//조회수 올리기
	@Override
	public int viewCount(int bno) {
		//게시글 번호의 조회수 +1 업데이트
		return sqlSession.update("BoardMapper.updateCheck", bno);
	}

	// 게시글 번호의 댓글 달기 (작성자 내용 받아오기)
	@Override				//bno게시글 번호, writer 댓글 작성자, content 댓글 내용
	public int replyFreeBoard(int bno, String writer, String content) {
		HashMap<String, Object> map1 = new HashMap<>();
		map1.put("bno", bno);
		map1.put("writer", writer);
		map1.put("content", content);
		
		int result = sqlSession.insert("BoardMapper.freeBoardReplyBoardOfBno", map1); 
		
		//insert에 영향받은 행의 개수 1개면 성공
		if(result == 1) {
			return result;
		}
		
		return 0; // 실패
	}

	// 게시글 번호의 댓글리스트 가져오기
	@Override								//자유게시판 게시글 번호 bno
	public List<ReplyBoardDto> replyBoardByBno(int bno) {
		List<ReplyBoardDto> replyList = null;
		try {
			replyList = sqlSession.selectList("BoardMapper.relpyConentByFreeBoardBno", bno); 
		}catch(Exception e) { 
			e.printStackTrace(); 
		}
		
		return replyList;
	}

	// 게시글 번호로 추천 수 올리기
	@Override			//bno - 게시글 번호
	public int likeCount(int bno) {
		int result = 0;
		
		try{
			result = sqlSession.update("BoardMapper.updateLike", bno);
		}catch(Exception e) {
			e.printStackTrace();
		}
			
		//영향받은 행의 개수 1이면 성공
		if(result == 1) {
			return result; //return 1
		}
		
		return result; //업데이트 실패 return 0
	}
	
	// 게시글 번호로 비추천 수 올리기
	@Override				//bno - 게시글 번호
	public int deLikeCount(int bno) {
		int result = 0;
		
		try{
			result = sqlSession.update("BoardMapper.updateDeLiket", bno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//업데이트 성공시 영향받은 행의 개수 1
		if(result == 1) {
			return result; //return 1
		}
		
		return result; // 실패 return 0
	}

	//게시글 번호로 추천수 가져오기
	@Override
	public int getLikeCountByBno(int bno) {
		int likeCount = -1;	// -1나오면 실패한거임
		try {
			likeCount = sqlSession.selectOne("BoardMapper.selectFreeBoardF_like",bno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//받아온 추천수(기본0)이면 likeCount의 숫자를 리턴
		if(likeCount >= 0) {
			return likeCount;
		}
		
		return likeCount; //그외 실패시 초기의 -1이 리턴됨
	}

	//게시글 번호로 비추천수 가져옴
	@Override
	public int getDelikeCountByBno(int bno) {
		int delikeCount = -1; // 실패시 -1나옴
		try {
			delikeCount = sqlSession.selectOne("BoardMapper.selectFreeBoardF_delike",bno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//받아온 비추천수(기본0)이면 likeCount의 숫자를 리턴
		if(delikeCount >= 0) {
			return delikeCount;
		}
		
		return delikeCount;
	}

	//게시글 번호와 작성자id로 댓글 지우기
	@Override
	public int deleteReply(int rno, String writer) {
		//로그인한 id의 닉네임(작성자) 가져오기
		
		HashMap<String, Object> map1 = new HashMap<>();
		map1.put("rno", rno);
		map1.put("rWriter", writer);
		
		int deleteReplyCheck = 0;
		try {
			deleteReplyCheck = sqlSession.delete("BoardMapper.replyBoardDeleteFromWriter", map1);
		}catch(Exception e) {
			e.printStackTrace();
		}
		//영향받은 행의 개수가 1이면 성공
		if(deleteReplyCheck == 1) {
			return deleteReplyCheck;
		}
		
		return deleteReplyCheck; //실패면 초기설정값인 0 리턴
	}

	//게시글 작성시 champ그려기기
	@Override
	public List<FreeBoardWriteChampDto> getBoardWriteChamp() {
		return sqlSession.selectList("BoardMapper.getBoardWriteChamps");
	}

	//게시글 작성시 rune그려기기
	@Override
	public List<FreeBoardWriteRuneDto> getBoardWriteRune() {
		return sqlSession.selectList("BoardMapper.getBoardWriteRunes");
	}

	//게시글 작성시 item그려기기
	@Override
	public List<FreeBoardWriteItemDto> getBoardWriteItem() {
		return sqlSession.selectList("BoardMapper.getBoardWriteItems");
	}

	//게시글 작성시 spell그려기기
	@Override
	public List<FreeBoardWriteSpellDto> getBoardWriteSpell() {
		return sqlSession.selectList("BoardMapper.getBoardWriteSpells");
	}

	//게시물 검색 하기 (category - select박스의 제목,내용,제목+내용, || boardSearch - 검색 내용 )
	@Override
	public List<FreeBoardDto> getBoardListBySearch(String category, String boardSearch) {
		if(category.equals("제목")) {		//제목검색
			System.out.println("제목으로 검색 실행");
			List<FreeBoardDto> searchListTitle = sqlSession.selectList("BoardMapper.selectBoardByTitle", boardSearch);
			return searchListTitle;
		}else if(category.equals("내용")) {	// 내용 검색
			System.out.println("내용으로 검색 실행");
			List<FreeBoardDto> searchListContent = sqlSession.selectList("BoardMapper.selectBoardByContent",boardSearch);
			return searchListContent;
		}else { //제목 내용 검색 
			System.out.println("제목+내용으로 검색 실행");
			List<FreeBoardDto> searchListTitleContent = sqlSession.selectList("BoardMapper.selectBoardByContentOrTitle",boardSearch);
			return searchListTitleContent;
		}
	}

}
