package com.wg.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wg.dto.Board.FreeBoardDto;
import com.wg.dto.Board.FreeBoardWriteChampDto;
import com.wg.dto.Board.FreeBoardWriteItemDto;
import com.wg.dto.Board.FreeBoardWriteRuneDto;
import com.wg.dto.Board.FreeBoardWriteSpellDto;
import com.wg.dto.Board.ReplyBoardDto;
import com.wg.service.MarkdownService;
import com.wg.service.board.BoardService;

@Controller
public class FreeBoardController {
	@Autowired
	BoardService boardSvc;
	
	@Autowired
	MarkdownService mds;

	//게시글 보기
	@RequestMapping("list")
	public String list(Integer page, HttpServletRequest request, HttpSession session) {
		if (page == null)
			page = 1;
		String id = request.getParameter("id");
		if (id != null)
			session.setAttribute("id", id);

		List<FreeBoardDto> listBoard = null;
		try {
			listBoard = boardSvc.listBoardByPageNum(page);
		} catch (Exception e) {
			e.printStackTrace();
		}

		int startPageNum = (page / 5 - (page % 5 == 0 ? 1 : 0)) * 5 + 1;
		int endPageNum = startPageNum + 4;
		int lastPageNum = 0;
		try {
			lastPageNum = boardSvc.getLastPageNumberService();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (endPageNum > lastPageNum)
			endPageNum = lastPageNum;

		request.setAttribute("listBoard", listBoard);
		request.setAttribute("pageNum", page);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("lastPageNum", lastPageNum);

		return "자유게시판";
	}
	
	//게시글 목록들 가져오기
	@RequestMapping("getBoardList")
	@ResponseBody
	public List<FreeBoardDto> getBoardList(int page) {
		if(page <= 0) page = 1;
		
		List<FreeBoardDto> listBoard = null;
		try {
			listBoard = boardSvc.listBoardByPageNum(page);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return listBoard;
	}
	
	//게시글 검색용 바디만 보내기
	@RequestMapping("searchBoardList")
	@ResponseBody
	public List<FreeBoardDto> getBoardListBySearch(@RequestParam("category")String category
											  ,@RequestParam("boardSearch") String boardSearch) {
		
		List<FreeBoardDto> listBoardBySearch = boardSvc.getBoardListBySearchService(category, boardSearch);
		 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 원하는 날짜 포맷 설정
	    
	    for (FreeBoardDto board : listBoardBySearch) {
	        String formattedDate = sdf.format(board.getfDate());  // fDate를 포맷된 문자열로 변환
	        board.setfFormattedDate(formattedDate);  // 포맷된 날짜를 fFormattedDate에 저장
	    }
		
		return listBoardBySearch;
	}
	
	//게시글 작성페이지로 이동 (session에 id가 담겨있음)
	@RequestMapping("boardWrite")
	public String boardWrite() {

		return "자유게시판게시글작성";
	}

	//게시글 작성시 하단에 그려지는 챔피언
	@RequestMapping("boardWriteChamp")
	@ResponseBody
	public List<FreeBoardWriteChampDto> boardWriteChamp() {

		return boardSvc.getBoardWriteChampService(); //
	}
	//게시글 작성시 하단에 그려지는 룬
	@RequestMapping("boardWriteRune")
	@ResponseBody
	public List<FreeBoardWriteRuneDto> boardWriteRune() {

		return boardSvc.getBoardWriteRuneService();
	}
	//게시글 작성시 하단에 그려지는 아이템
	@RequestMapping("boardWriteItem")
	@ResponseBody
	public List<FreeBoardWriteItemDto> boardWriteItem() {

		return boardSvc.getBoardWriteItemService();
	}
	//게시글 작성시 하단에 그려지는 스펠
	@RequestMapping("boardWriteSpell")
	@ResponseBody
	public List<FreeBoardWriteSpellDto> boardWriteSpell() {

		return boardSvc.getBoardWriteSpellService();
	}

	//게시글 작성완료시 리다이렉트로 게시글 목록으로 이동
	@RequestMapping("BoardWriteAction")
	public String boardWriteAction(String title, String content, HttpSession session) {
		System.out.println("게시글 작성 내용 : " + content);
		// 여기 작업
		String id = (String) session.getAttribute("id");
		String writer = null;

		try {
			writer = boardSvc.getWriterByUserIdService(id);
		} catch (Exception e) {
			e.printStackTrace();
		}

		boardSvc.insertBoardWriterService(title, content, writer);

		return "redirect:/list";
	}
	
	//게시글 상세보기 이동시 내용들
	@RequestMapping("BoardDetail")
	public String boardDetail(HttpServletRequest request, HttpSession session, Model model) {
		int bno = Integer.parseInt(request.getParameter("bno"));
		int pageNum = Integer.parseInt(request.getParameter("page"));
		String id = (String)session.getAttribute("id");
		System.out.println("이름 : " + id);

		if(id != null) {
			String idWriter = boardSvc.getWriterByUserIdService(id);
			model.addAttribute("idWriter",idWriter);
			System.out.println("작성자 : " +idWriter);
		}
		
		// bno 보내서 해당 아이디가 이 게시글을 봤는지 체크 하고 ++하기
		boardSvc.updateViewCountService(bno, session);

		// 게시글 가져오기
		FreeBoardDto detail = boardSvc.getlistBoardByBnoService(bno);
		
		// 마크다운으로 변환하기
		String contentHtml = mds.markdownToHtml(detail.getfContent());
		
		request.setAttribute("contentHtml", contentHtml);
		
		List<ReplyBoardDto> replyList = null;
		try {
			replyList = boardSvc.getReplyBoardByBnoService(bno);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("bno",bno);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("dto",detail);
		model.addAttribute("replyList", replyList);
		//request.setAttribute("replyList", replyList);
		//request.setAttribute("bno", bno);
		//request.setAttribute("dto", detail);

		return "자유게시판게시글보기";
	}
	
	//게시글 삭제 버튼 띄우기
	@RequestMapping("buttonUpDate")
	@ResponseBody
	public boolean buttonUpDate(int bno, String id) {
		
		//bno번호로 게시글의 작성자 가져오기
		String writerByBno = boardSvc.getWriterByBnoService(bno);
		//현재 로그인한 id의 작성자 가져오기
		String writerById = boardSvc.getWriterByUserIdService(id);
		//if(게시글 작성자 == id의 닉네임) return ture;
		if(writerByBno.equals(writerById)) {
			return true;
		}
		
		return false;
	}
	
	//게시글 삭제(바디용)
	@RequestMapping("deleteContentById")
	@ResponseBody
	public boolean deleteContentById(String id, int bno) {
		
		int result = boardSvc.deletContentByWriterBnoService(id, bno);

		if(result == 1) {
			return true;
		}
		
		return false;
	}
	
	//게시글 수정페이지로 이동
	@RequestMapping("updateContentById")
	public String updateContentWrite(HttpSession session, HttpServletRequest request, int bno) {
		
		FreeBoardDto dto = boardSvc.getlistBoardByBnoService(bno);
		
		//마크다운
		String encodingContent = mds.markdownToHtml(dto.getfContent());
		
		request.setAttribute("encodingContent", encodingContent);
		request.setAttribute("dto", dto);
		
		return "자유게시판게시글수정";
	}
	
	//게시글 수정 db처리후 게시판 이동
	@RequestMapping("updateContentAction")
	public String updateContentById(int bno, String title, String content) {
		System.out.println("게시글 수정 내용 들어오냐 ? : "+content);
		//update처리
		boardSvc.updateContentByBnoService(bno, title, content);
	
				
		return "redirect:/list";
	}
	
	// 게시글 추천 / 추천수 가져와서 ajax로 주기
	@RequestMapping("likeCount")
	public void likeCount(int bno, HttpSession session, HttpServletResponse response) {
		// 여기서 db처리
		int result = boardSvc.updateLikeCountService(bno, session);
		int likeCount = boardSvc.getLikeCountByBnoService(bno);

		response.setContentType("application/json;charset=UTF-8");
		String json = "{\"result\":" + result + ", \"count\":" + likeCount + "}";
		try {
			response.getWriter().write(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시글 비추천 / 비추천수 가져와서 ajax로 주기
	@RequestMapping("delikeCount")
	public void delikeCount(int bno, HttpSession session, HttpServletResponse response) {
		// DB처리.
		int result = boardSvc.updateDelikeCountService(bno, session);
		int delikeCount = boardSvc.getDelikeCountByBnoService(bno);

		response.setContentType("application/json;charset=UTF-8");
		String json = "{\"result\":" + result + ", \"count\":" + delikeCount + "}";
		try {
			response.getWriter().write(json);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	// 댓글 작성(바디용)
	@RequestMapping("insertReply")
	@ResponseBody
	public String insertReply(int bno, HttpSession session, String content) {
		String id = (String) session.getAttribute("id");
		String writer = boardSvc.getWriterByUserIdService(id);
		// db처리
		boardSvc.insertReplyFreeBoard(bno, writer, content);
		session.setAttribute(id, writer);

		return "success";	//response가 "success"
	}
	
	//댓글 삭제하기
	@RequestMapping("deleteReplyFromId")
	@ResponseBody
	public boolean deleteReplyFromId(String id, int rno) {
		System.out.println("컨트롤러 id : " + id);
		//어떠한 기능으로 인한 true false 체크
		int check = boardSvc.deleteReplyBoardByRnorWriterService(rno, id);
		System.out.println("컨트롤러 check (1성공): "+check);
		if(check == 1) {
			return true;
		}
		
		return false;
	}

	//게시글의 댓글들 받아오기 (바디용)
	@RequestMapping("getReplyList")
	@ResponseBody
	public List<ReplyBoardDto> getReplyList(HttpSession session, int bno) {
		// 댓글들 받아오기
		
		return boardSvc.getReplyBoardByBnoService(bno);
	}

	//댓글 삭제
	@RequestMapping("deleteReply")
	@ResponseBody
	public boolean deleteReply(int rno, HttpServletResponse response, HttpSession session) {
		String id = (String) session.getAttribute("id");
		String rWriter = boardSvc.getWriterByUserIdService(id);
		
		int deleteReplyResult = 0;
		try {
			deleteReplyResult = boardSvc.deleteReplyBoardByRnorWriterService(rno, rWriter);
			System.out.println("댓글 삭제 리턴 (deleteReplyResult): " +deleteReplyResult);
			return deleteReplyResult == 1;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;

	}

}
