package com.wg.controller;

import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wg.dao.MemberDao;
import com.wg.dto.Member.MemberDto;
import com.wg.service.MailService;
import com.wg.service.MemberService;
import com.wg.service.TokenService;

@Controller
public class loginController {
	@Autowired
	MemberService dao;   // 회원 관련 DB 작업 처리

	@Autowired
    private MemberService memberService;   //마이페이지 기능
	
	@Value("${client.id}")
	private String clientId;
	
	@Value("${client.secret}")
	private String clientSecret;

    // 마이페이지 이동
    @GetMapping("/mypage")
    public String mypage() {
        return "mypage";
    }

    // 닉네임 설정 처리
    @PostMapping("/setNickname")
    public String setNickname(@RequestParam("user_name") String userName, HttpSession session, RedirectAttributes rttr) {
        String userId = (String) session.getAttribute("id");   // 로그인 ID 가져오기
         
        System.out.println("userId: " + userId + ", userName: " + userName);  // 디버깅용

        if (userId != null) {
            MemberDto dto = new MemberDto();
            dto.setUserId(userId);
            dto.setUserName(userName);

            memberService.updateUserName(dto);
            session.setAttribute("user_name", userName);  // 닉네임 세션 반영
            System.out.println("user_name : " + userName);
            rttr.addFlashAttribute("nicknameSuccess", "닉네임이 설정되었습니다.");               //수정
        } else {
            rttr.addFlashAttribute("nicknameSuccess", "로그인 세션이 없습니다.");
        }

        return "redirect:/";  // 설정 후 마이페이지 이동
    }

    //회원가입
	@GetMapping("/signUp")                                  //회원가입
	public String getsignUp() {
		System.out.println(">>>>>>>>>>>>>>>>>> signUp");    //잘 되는 지 확인
		return "signUp";
	}
	
	@PostMapping("/signUpAction")
	public String postSignUp(@RequestParam("user_id") String userId,
	                         @RequestParam("user_pw") String userPw,
	                         @RequestParam("user_pw_check") String userPwCheck,
	                         RedirectAttributes rttr,
	                         Model model) {
	    if (!userPw.equals(userPwCheck)) {
	        model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
	        return "signUp";
	    }

	    // 여기서 비밀번호 암호화
	    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	    String hashedPw = encoder.encode(userPw);  // 🔐 암호화된 비밀번호

	    // dto에 암호화된 비밀번호를 넣음
	    MemberDto dto = new MemberDto();
	    dto.setUserId(userId);
	    dto.setUserPw(hashedPw);  
	    dto.setUserName("default");   // 기본 닉네임 설정
	    dto.setPwHint(null);
	    dto.setGrade(0);  // 일반 회원

	    dao.insert(dto);  // DB에 저장
	    rttr.addFlashAttribute("joinSuccess", "회원가입되셨습니다. 축하합니다!");
	    return "redirect:/login";  // 성공 시 로그인 페이지로
	}

	@PostMapping("/checkId")
	@ResponseBody
	public String checkId(@RequestParam("user_id") String userId) {
	    try {
	        MemberDto user = dao.findById(userId);
	        return (user == null) ? "available" : "duplicate";   // 사용 가능 여부 반환
	    } catch (Exception e) {
	        e.printStackTrace(); // 콘솔에 자세한 오류 출력
	        return "error";       // 오류 메시지
	    }
	}
	// 로그인 화면 보여주는 GET 요청
	@GetMapping("/login")
	public String getLoginPage() {
	    return "login";  // login.jsp 를 반환 (로그인 폼 페이지)
	}

	// 로그인 처리 POST 요청
	@PostMapping("/login")
	public String postLogin(@RequestParam("user_id") String userId,
	                        @RequestParam("user_pw") String userPw,
	                        Model model,
	                        HttpSession session) {

	    // ① DB에서 해당 ID로 사용자 정보 조회
	    MemberDto user = dao.findById(userId); 

	    // ② 사용자 정보 로그 출력
	    if (user != null) {
	        System.out.println("[로그인 시도] 등급: " + user.getGrade() +
	                           " / ID: " + user.getUserId() +
	                           " / 닉네임: " + user.getUserName());

	        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

	        // ③ 비밀번호 일치 여부 확인
	        if (encoder.matches(userPw, user.getUserPw())) {

	            // ④ 로그인 성공 시 세션에 사용자 정보 저장
	            session.setAttribute("id", user.getUserId());        // 아이디 문자열
	            session.setAttribute("user_name", user.getUserName());   // 닉네임 문자열
	            session.setAttribute("loginUser", user);                  // ✅ 전체 MemberDto (작성자 확인용)
	            System.out.println("[로그인 완료] 세션에 저장된 loginUser: " + session.getAttribute("loginUser"));
	            session.setAttribute("grade", user.getGrade());           // 등급 (글쓰기 제한용)
	            // 디버깅용 출력
	            System.out.println("[세션 저장됨] user_name: " + user.getUserName());

	            // ⑤ 홈으로 이동
	            return "redirect:/";
	        }
	    }

	    // ⑥ 로그인 실패 시 메시지 출력 + 다시 로그인 페이지
	    model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
	    return "login";
	}

	//카카오톡
	@PostMapping("/kakaoLogin")
    @ResponseBody
    public String kakaoLogin(@RequestParam("email") String email,
                             @RequestParam("nickname") String nickname,
                             HttpSession session) {

        MemberDto dto = dao.findById(email);
        if (dto == null) {
            dto = new MemberDto();
            dto.setUserId(email);
            dto.setUserName(nickname);
            dto.setUserPw("kakao_oauth"); // 식별용
            dto.setGrade(0);
            dao.insert(dto);
        }

        // 세션 저장
        session.setAttribute("loginUser", dto);
        session.setAttribute("id", dto.getUserId());
        session.setAttribute("user_name", dto.getUserName());
        session.setAttribute("grade", dto.getGrade());

        return "success";
    }
	
	//구글 로그인
	@RequestMapping("/google/callback")
	@ResponseBody // 중요: JSP 리턴 안 하고 HTML 반환
	public String googleCallback(@RequestParam("code") String code, HttpSession session) {
		System.out.println("googlecallback 진입완료");
	    // === 1. 액세스 토큰 요청 ===
	    String tokenUrl = "https://oauth2.googleapis.com/token";

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	    params.add("code", code);
	    params.add("client_id", clientId);
	    params.add("client_secret", clientSecret);
	    params.add("redirect_uri", "http://localhost:9090/projectboard/google/callback");
	    params.add("grant_type", "authorization_code");

	    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
	    ResponseEntity<Map> response = null;
	    try {
	    	response = restTemplate.postForEntity(tokenUrl, request, Map.class);
	    	System.out.println("response try: " +response);
	    }catch(HttpClientErrorException e) {
	    	System.out.println("respone catch : " + response);
	    	 System.out.println(">>> 상태코드: " + e.getStatusCode());
    	    System.out.println(">>> 응답본문: " + e.getResponseBodyAsString());
	    	e.printStackTrace();
	    }
	    System.out.println("code = " + code);
	    System.out.println("response status = " + response.getStatusCode());
	    System.out.println("response body = " + response.getBody());

	    String accessToken = (String) response.getBody().get("access_token");

	    // === 2. 사용자 정보 요청 ===
	    HttpHeaders infoHeaders = new HttpHeaders();
	    infoHeaders.setBearerAuth(accessToken);
	    HttpEntity<?> infoRequest = new HttpEntity<>(infoHeaders);

	    ResponseEntity<Map> userInfoResponse = restTemplate.exchange(
	        "https://www.googleapis.com/oauth2/v2/userinfo",
	        HttpMethod.GET,
	        infoRequest,
	        Map.class
	        
	    );
	 // [3] 사용자 정보 추출
	    Map<String, Object> userInfo = userInfoResponse.getBody();
	    String email = (String) userInfo.get("email");
	    String name = (String) userInfo.get("name");
	    
	    // === 3. DB 등록 ===
	    MemberDto dto = dao.findById(email);
	    if (dto == null) {
	        dto = new MemberDto();
	        dto.setUserId(email);
	        dto.setUserName(name);
	        dto.setUserPw("google_oauth");
	        dto.setPwHint(null);
	        dto.setGrade(0);
	        dao.insert(dto);
	    }
//	    System.out.println("유저아이디 : " +dto.getUserId());
	    
	    String id = dto.getUserId();
	    String userName = dto.getUserName();
	    session.setAttribute("id", id);
	    session.setAttribute("loginUser", dto);
	    session.setAttribute("userName", userName);
//	    System.out.println("api로그인 시 닉네임 : " + userName);
	    // === 4. 팝업 닫고 메시지 전송 ===
	    return "<script>window.opener.postMessage('google-login-success', '*'); window.close();</script>";
	}
	
	
	
	
	
	//비밀번호 찾기
	@Autowired
    TokenService tokenService;

    @Autowired
    MailService mailService;

    @Autowired
    MemberDao memberDao;

    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    /** 
     * 1단계: 이메일 입력 화면
     */
    @GetMapping("/reset-password")
    public String showEmailForm() {
        return "resetPwStep1"; // updatePw.jsp
    }

    /**
     * 2단계: 이메일 제출 → 토큰 생성 및 메일 발송
     */
    @PostMapping("/sendResetEmail")
    public String sendResetEmail(@RequestParam("user_id") String userId, Model model) {
    	System.out.println("메서드 진입 : [DEBUG] 해당 이메일로 가입된 계정 없음");
    	MemberDto user = memberDao.findById(userId);

        if (user == null) {
        	System.out.println("user(dto) = null : [DEBUG] 해당 이메일로 가입된 계정 없음");
        	model.addAttribute("error", "해당 이메일로 가입된 계정이 없습니다.");
            return "resetPwStep1";
        }

        // 토큰 생성 및 메일 발송
        String token = tokenService.createToken(userId);
        System.out.println("토큰 아래 : [DEBUG] 해당 이메일로 가입된 계정 없음");
        try {
            mailService.sendResetEmail(userId, token);
        } catch (MessagingException e) {
        	System.out.println("캐치문 : [DEBUG] 해당 이메일로 가입된 계정 없음");
            e.printStackTrace();
            model.addAttribute("error", "메일 전송에 실패했습니다.");
            return "resetPwStep1";
        }

        return "resetPwStep2"; // updatePw2.jsp
    }

    /**
     * 3단계: 이메일로 받은 링크 → 비밀번호 변경 화면
     */
    @GetMapping("/reset-password-form")
    public String showResetForm(@RequestParam("token") String token, Model model) {
    	String userId = tokenService.getUserIdByToken(token);
        if (userId == null) {
            model.addAttribute("error", "유효하지 않은 토큰입니다.");
            return "resetPwStep1"; // 다시 이메일 입력으로
        }
        model.addAttribute("token", token);
        return "resetPwStep3"; // updatePw3.jsp
    }

    /**
     * 4단계: 비밀번호 재설정 처리
     */
    @PostMapping("/resetPassword")
    public String resetPassword(
            @RequestParam("token") String token,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            Model model) {

        String userId = tokenService.getUserIdByToken(token);
        if (userId == null) {
            model.addAttribute("error", "토큰이 만료되었거나 유효하지 않습니다.");
            return "resetPwStep1";
        }
        	
        System.out.println("token: " + token);
        System.out.println("userId from tokenService: " + userId);
        
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("token", token);
            model.addAttribute("error", "비밀번호가 서로 일치하지 않습니다.");
            return "resetPwStep3";
        }

        // 비밀번호 암호화 및 DB 업데이트
        String hashedPw = encoder.encode(newPassword);
        System.out.println(hashedPw);
        memberDao.updatePassword(userId, hashedPw);

        // 토큰 무효화
        tokenService.invalidateToken(token);

        return "resetPwStep4"; // updatePw4.jsp
    }


}
