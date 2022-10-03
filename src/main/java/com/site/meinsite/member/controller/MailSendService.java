package com.site.meinsite.member.controller;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailSendService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int auth_num;

	//이메일 인증번호 전송
	public String mailMessage(String email) {
		Random rdm = new Random();
		int checkNum = rdm.nextInt(888888) + 111111;
		System.out.println("인증번호 : " +  checkNum);
		auth_num = checkNum;
		
		String setFrom = "holyromanempire16th@gmail.com";
		String toMail = email;
		String title = "회원 가입 인증 이메일입니다";
		String content = "인증 번호는 " + auth_num + "입니다."
				+ "<br>" + "해당 인증번호를 인증번호 확인란에 넣어 주세요.";
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(auth_num);
	}
	
	//임시비밀번호 발급
	public String sendTempPwd(String userid, String email) {
		String memberKey = 
				RandomStringUtils.random(10, 33, 125, false, false);
		System.out.println("임시비밀번호 : " +  memberKey);
		String setFrom = "holyromanempire16th@gmail.com";
		String toMail = email;
		String title = "임시 비밀번호를 발급해드립니다.";
		String content = "안녕하세요. " + userid + "님, <br>" +
				"임시비밀번호는 " + memberKey + "입니다. <br>" +
				"임시비밀번호로 로그인 후, 비밀번호를 변경해 주세요.";
		mailSend(setFrom, toMail, title, content);
		return memberKey;
	}
	

	private void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		//true 매개값 전달 시 multipart 형식 메세지 전달 가능. 문자 인코딩 설정도 가능함.
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			// true 전달 > html 형식으로 전송, 작성하지 않을 시 단순 텍스트 전달
			helper.setText(content, true);
			mailSender.send(message);
		} catch(MessagingException e) {
			e.printStackTrace();
		}
	}
	
}
