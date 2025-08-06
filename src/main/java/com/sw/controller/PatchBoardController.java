package com.sw.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sw.dto.PatchBoardDto;
import com.sw.dto.ReplyBoardDto;
import com.sw.service.MarkDownService;
import com.sw.service.PatchBoardService;
import com.sw.service.ReplyBoardService;
import com.wg.dto.Member.MemberDto;

@Controller
@RequestMapping("/patch")
public class PatchBoardController {
	
	@Autowired
    private PatchBoardService service;
	
    @Autowired
    private PatchBoardService patchBoardService;
    
    @Autowired
    private ReplyBoardService replyService;

    @Autowired
    private ReplyBoardService replyBoardService;
    
    @Autowired
    private MarkDownService mdsService;

    // 게시글 목록 보기
    @GetMapping("/patchlist")
    public String list(Model model) {
        List<PatchBoardDto> list = patchBoardService.getAllPosts();

        model.addAttribute("list", list);
        return "patchBoard1";  // 게시글 목록 JSP
    }

    // 게시글 상세 보기 + 댓글 목록 같이 조회
    @GetMapping("/patchdetail")
    public String detail(@RequestParam("pBno") int pBno, Model model) {
    	patchBoardService.increaseViewCount(pBno);  //조회수 증가
    	System.out.println("📌 컨트롤러 도착! p_bno = " + pBno);
        PatchBoardDto dto = patchBoardService.getPostById(pBno);
        List<ReplyBoardDto> replyList = replyService.getRepliesByBoardBno(pBno);

        for(ReplyBoardDto dto2 : replyList) {
        	System.out.println(dto2.getrContent());
        }
        
        String htmlContent = mdsService.markdownToHtml(dto.getpContent());
        
        model.addAttribute("htmlContent",htmlContent);
        model.addAttribute("dto", dto);
        model.addAttribute("replyList", replyList);

        return "patchBoard2";
    }
    
 // 글쓰기 화면 진입 (GET)
    @RequestMapping("/patchwrite")
    public String writer(HttpSession session) {

        // [1] 등급 꺼내오기
        Integer grade = (Integer) session.getAttribute("grade");

        // [2] 등급이 없거나 1이 아니면 글쓰기 막기
        if (grade == null || grade != 1) {
            return "redirect:/patch/patchlist";
        }

        // [3] 글쓰기 화면 JSP로 이동
        return "patchBoard3";
    }

    // 글쓰기 처리 (POST)
    @PostMapping("/patchwrite")
    public String writePost(PatchBoardDto dto, HttpSession session) {

        // [1] 등급 확인
        Integer grade = (Integer) session.getAttribute("grade");
        if (grade == null || grade != 1) {
            return "redirect:/patch/patchlist";
        }

        // [2] 로그인한 사용자 정보 꺼내기
        MemberDto member = (MemberDto) session.getAttribute("loginUser");
        System.out.println("[글쓰기 시도] 세션에서 꺼낸 loginUser: " + member);
        String writerName;

        // [3] 닉네임이 있으면 사용, 없으면 아이디 사용
        if (member != null && member.getUserName() != null && !member.getUserName().trim().isEmpty()) {
        	System.out.println("[글쓰기 시도] 닉네임: " + member.getUserName() + ", 아이디: " + member.getUserId());
            writerName = member.getUserName();
        } else if (member != null) {
            writerName = member.getUserId();
        } else {
            writerName = "익명"; // 세션에 로그인 정보 없으면 익명 처리
        }

        // [4] 작성자 정보 DTO에 저장
        dto.setpWriter(writerName);

        // [5] 글 저장
        patchBoardService.insertPost(dto);

        // [6] 목록으로 이동
        return "redirect:/patch/patchlist";
    }
    //미니 검색창 조건에 맞게 검색
    @GetMapping("/search")
    public String search(
            @RequestParam("category") String category,
            @RequestParam("keyword") String keyword,
            Model model) {

        List<PatchBoardDto> searchResult = patchBoardService.searchPosts(category, keyword);
        model.addAttribute("list", searchResult);
        return "patchBoard1";  // 목록 JSP 그대로 사용
    }

    
   
	 // 추천 버튼 눌렀을 때 추천 수 증가
	    @PostMapping("/like")
	    @ResponseBody
	    public ResponseEntity<Map<String, Object>> increaseLike(@RequestParam("pBno") int pBno) {
	        patchBoardService.increaseLike(pBno);
	        return ResponseEntity.ok(Map.of("result", "success"));
	    }
	    //비추천
	    @PostMapping("/unlike")
	    @ResponseBody
	    public ResponseEntity<Map<String, Object>> increaseUnlike(@RequestParam("pBno") int pBno) {
	        patchBoardService.increaseUnLike(pBno);
	        return ResponseEntity.ok(Map.of("result", "success"));
	    }
	



}
