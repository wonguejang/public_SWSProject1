package com.sw.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sw.dto.ReplyBoardDto;
import com.sw.service.ReplyBoardService;
import com.wg.dto.Member.MemberDto;
import com.wg.service.MemberService;
@RequestMapping("/reply")

@Controller
public class ReplyBoardController {

    @Autowired
    private ReplyBoardService replyBoardService;
    
    @Autowired
    private MemberService memberService;


    // 댓글 등록
    @PostMapping("/insertReply.do")
    public String insertReply(ReplyBoardDto dto, HttpSession session) {
        String writer = (String) session.getAttribute("user_name");
        System.out.println("작성자 잇냐? "+writer);
        if (writer == null || writer.isEmpty()) {
            return "redirect:/login"; // 로그인 안 되어있으면 로그인으로
        }
        dto.setrWriter(writer);
        
        // 값 확인용 로그 추가
        System.out.println("insertReply 컨트롤러에서 dto 확인:");
        System.out.println("rWriter = " + dto.getrWriter());
        System.out.println("rContent = " + dto.getrContent());
        System.out.println("rPBoardBno = " + dto.getrPBoardBno());
        
        replyBoardService.insertReply(dto);
        return "redirect:/patch/patchdetail?pBno=" + dto.getrPBoardBno();
    }


    // 댓글 삭제
    @PostMapping("/delete")
    public String deleteReply(@RequestParam("rno") int rno,
                              @RequestParam("bno") int bno,
                              HttpSession session) {
        MemberDto member = (MemberDto) session.getAttribute("loginUser"); // 수정

        if (member == null) return "redirect:/login";

        String sessionUserName = member.getUserName();
        int userGrade = member.getGrade();

        ReplyBoardDto reply = replyBoardService.getReplyByRno(rno);

        if (reply != null && (userGrade == 1 || reply.getrWriter().equals(sessionUserName))) {
            replyBoardService.deleteReply(rno);
            System.out.println("✅ 댓글 삭제 성공!");
        } else {
            System.out.println("❌ 삭제 실패: 권한 없음 또는 댓글 없음");
        }

        return "redirect:/patch/patchdetail?pBno=" + bno;
    }



    // 댓글 수정 폼
    @GetMapping("/updateReplyForm.do")
    public String updateReplyForm(@RequestParam("rno") int rno,
                                   @RequestParam("bno") int bno,
                                   HttpSession session,
                                   Model model) {
        ReplyBoardDto reply = replyBoardService.getReplyByRno(rno);
        String sessionUser = (String) session.getAttribute("user_name");

        
        
        if (reply != null && reply.getrWriter().equals(sessionUser)) {
            model.addAttribute("reply", reply);
            model.addAttribute("bno", bno);
            return "replyUpdateForm"; // 수정 JSP
        } else {
            return "redirect:/patch/patchdetail?pBno=" + bno;
        }
    }

    // 댓글 수정 처리
    @PostMapping("/updateReply.do")
    public String updateReply(ReplyBoardDto dto, HttpSession session) {
        String sessionUser = (String) session.getAttribute("user_name");

        if (dto.getrWriter().equals(sessionUser)) {
            replyBoardService.updateReply(dto);
        }
        return "redirect:/patch/patchdetail?pBno=" + dto.getrPBoardBno();
    }
}
