package mjlee.portfolio.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MailManager {
	private String host="smtp.gmail.com";
	private final String sender="vigdsing@gmail.com";
	private final String password="fmlokjshuzuwfuzj";
	private Session session;
	private PrintWriter out;
	
	public MailManager() {
		super();
		// TODO Auto-generated constructor stub
		Properties prop= new Properties();
		prop.put("mail.smtp.host", host);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.port", 587);
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
		session= Session.getDefaultInstance(prop, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sender, password);
			}
		});
	}
	
	public String sendAuth(String to) throws ServletException, IOException {
		String random="";
		while(random.length()!=4) {
			random += (int)(Math.random()*10);
		}
		try {
			MimeMessage auth= new MimeMessage(session);
			auth.setFrom(new InternetAddress(sender));
			auth.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			auth.setSubject("Newyork candles - 이메일 인증");
			auth.setContent("이메일 인증 번호를 입력하세요 : "+random, "text/html; charset=euc-kr");
			Transport.send(auth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return random;
	}
	
	public void sendWelcome(String to) {
		try {
			MimeMessage welcome= new MimeMessage(session);
			welcome.setFrom(new InternetAddress(sender));
			welcome.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			welcome.setSubject("Newyork candles - 회원 가입 성공하였습니다.");
			welcome.setContent("지금부터 가입한 아이디로 Newyork candles을 이용할 수 있습니다.", "text/html; charset=euc-kr");
			Transport.send(welcome);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean sendPwMail(String to, String pw, String id) {
		String loginLink= "<a href=\"http://vigdsing.cafe24.com/portfolio/login.view\">로그인 하러 가기</a>";
		try {
			MimeMessage mail= new MimeMessage(session);
			mail.setFrom(new InternetAddress(sender));
			mail.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			mail.setSubject("Newyork candles - 비밀번호 찾기 결과");
			mail.setContent("<h4>["+id+"] 님의 비밀번호는 ["+pw+"] 입니다.</h4><br/><p>로그인 후 반드시 비밀번호를 변경해주세요.</p><br/>"+loginLink, "text/html; charset=euc-kr");
			Transport.send(mail);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}


/*
 *
 request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//고정값
		String subject="메일 보내기 테스트";
		String content="메일 아주 잘 갑니당";
		String host="smtp.naver.com";
		final String user="joonmma@naver.com";
		final String password="Qudtlsdk803!";
		
		//받는사람 주소
		String to= "vigdsing@gmail.com";
		
		//세션 설정
		Properties prop= new Properties();
		prop.put("mail.smtp.host", host);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.port", 587);
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.naver.com");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
		Session session= Session.getDefaultInstance(prop, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		System.out.println("1");
		
		try {
			MimeMessage msg= new MimeMessage(session);
			msg.setFrom(new InternetAddress(user));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			msg.setSubject(subject);
			msg.setContent(content, "text/html; charset=euc-kr");
			System.out.println("2");
			
			Transport.send(msg);
			System.out.println("message send successfully......");
			System.out.println("3");
			
			PrintWriter out= response.getWriter();
			out.println("<script> alert('메일 전송 성공') </script>");
		} catch (Exception e) {
			e.printStackTrace();
		}
 */