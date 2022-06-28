package mjlee.portfolio.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mjlee.portfolio.controller.MailManager;
import mjlee.portfolio.dao.MemberDao;

/**
 * Servlet implementation class newMember
 */
@WebServlet("*.join")
public class newMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public newMember() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}
	
	private void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String path= request.getServletPath();
		PrintWriter out= response.getWriter();
		System.out.println(path);
		if(path.equals("/termsChecked.join")) {
			request.setAttribute("termsChecked", true);
			request.getRequestDispatcher("joinNew.jsp").forward(request, response);
		}else if(path.equals("/joinNew.join")) {
			MemberDao dao= new MemberDao();
			//필수값: 이름 아이디 비밀번호 이메일
			String name= request.getParameter("joinName");
			String id= request.getParameter("joinId");
			String pw= request.getParameter("joinPw");
			String email= request.getParameter("joinEmail");
			String ip= InetAddress.getLocalHost().getHostAddress();
			//선택값: 핸드폰번호 우편번호 주소
			if(request.getParameter("joinAddPost")!="" && request.getParameter("joinPhone")!="") {
				String postno= request.getParameter("joinAddPost");
				String address= request.getParameter("joinAdd")+" / "+request.getParameter("joinAddDetail");
				String phone= request.getParameter("joinPhone");
				if(dao.joinWithAllParams(name, id, pw, email, postno, address, phone, ip)>0) {
					new MailManager().sendWelcome(email);
					out.println("<script> alert('회원 가입 성공'); location.href='main.view'; </script>");
				}else {
					out.println("<script> alert('회원 가입 실패'); location.href='main.view'; </script>");
				}
			}else if(request.getParameter("joinPhone")!="" && request.getParameter("joinAddPost")=="") {
				String phone= request.getParameter("joinPhone");
				if(dao.joinExceptAdd(name, id, pw, email, phone, ip)>0) {
					new MailManager().sendWelcome(email);
					out.println("<script> alert('회원 가입 성공'); location.href='main.view'; </script>");
				}else {
					out.println("<script> alert('회원 가입 실패'); location.href='main.view'; </script>");
				}
			}else if(request.getParameter("joinPhone")=="" && request.getParameter("joinAddPost")!="") {
				String postno= request.getParameter("joinAddPost");
				String address= request.getParameter("joinAdd")+" / "+request.getParameter("joinAddDetail");
				if(dao.joinExceptPhone(name, id, pw, email, postno, address, ip)>0) {
					new MailManager().sendWelcome(email);
					out.println("<script> alert('회원 가입 성공'); location.href='main.view'; </script>");
				}else {
					out.println("<script> alert('회원 가입 실패'); location.href='main.view'; </script>");
				}
			}else if(request.getParameter("joinPhone")=="" && request.getParameter("joinAddPost")=="") {
				if(dao.joinOnlyNecessary(name, id, pw, email, ip)>0) {
					new MailManager().sendWelcome(email);
					out.println("<script> alert('회원 가입 성공'); location.href='main.view'; </script>");
				}else {
					out.println("<script> alert('회원 가입 실패'); location.href='main.view'; </script>");
				}
			}
		}else if(path.equals("/emailAuthCheck.join")) {
			MemberDao dao= new MemberDao();
			if(dao.checkDupEmail(request.getParameter("joinEmailAuth"))) {
				MailManager mail= new MailManager();
				out.println(mail.sendAuth(request.getParameter("joinEmailAuth")));
			}else {
				out.println("error");
			}
		}else if(path.equals("/idDupCheck.join")) {
			MemberDao dao= new MemberDao();
			if(!dao.checkDupId(request.getParameter("joinId"))) {
				out.println(0);
			}else {
				out.println(1);
			}
		}
	}

}
