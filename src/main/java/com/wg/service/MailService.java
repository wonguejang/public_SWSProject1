package com.wg.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    @Autowired
    private JavaMailSender mailSender;

    private static final String FROM = "qkrdndcjf03@gmail.com";   // 발신자 이메일 주소 (고정)

    public void sendResetEmail(String to, String token) throws MessagingException {
        String subject = "비밀번호 재설정 링크";
        // 재설정 링크 URL (토큰 포함)
        String resetLink = "http://localhost:9090/projectboard/reset-password-form?token=" + token;
        // 메일 본문 (HTML 형식)
        String content = "<h3>비밀번호 재설정 안내</h3>"
                       + "<p>아래 링크를 클릭하여 비밀번호를 재설정하세요:</p>"
                       + "<a href='" + resetLink + "'>비밀번호 재설정</a>";
        // 이메일 메시지 생성 (MIME 형식)
        MimeMessage message = mailSender.createMimeMessage();
        // Helper를 사용해 이메일 구성 (true: multipart 메시지 허용)
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        
        // 수신자, 제목, 발신자, 본문 설정
        helper.setTo(to);
        helper.setSubject(subject);
        helper.setFrom(FROM);
        helper.setText(content, true);  // HTML 사용
        // 메일 발송
        mailSender.send(message);
    }
}
