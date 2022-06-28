package mjlee.portfolio.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mjlee.portfolio.controller.MailManager;
import mjlee.portfolio.dao.MemberDao;
import mjlee.portfolio.dao.MemberDto;
import mjlee.portfolio.dao.ProductDao;

/**
 * Servlet implementation class memberLog
 */
@WebServlet("*.do")
public class memberLog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public memberLog() {
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
		HttpSession session= request.getSession();
		PrintWriter out= response.getWriter();
		System.out.println(path);
		if(path.equals("/login.do")) {
			MemberDao dao= new MemberDao();
			if(dao.login(request.getParameter("loginId"), request.getParameter("loginPw"))) {
				String rem= request.getParameter("remember");		//체크박스값 가져오기
				String id= request.getParameter("loginId");
				System.out.println(rem+"/"+id);
				if(rem!=null){	// 체크되어있다면
					Cookie save= new Cookie(id, "checked");  	//쿠키에 아이디, 체크됨 저장
					save.setMaxAge(600);
					response.addCookie(save);
					System.out.println(save.getName());
				}else{
					String cookie= request.getHeader("cookie");
					if(cookie!=null){
						Cookie[] c= request.getCookies();	// 체크 안됐으면 쿠키 전부 초기화
						for(int i=0; i<c.length; i++){
							if(c[i].getName().equals(id)) {
								c[i].setMaxAge(0);
								response.addCookie(c[i]);
							}
						}
					}
				}
				session.setAttribute("id", request.getParameter("loginId"));
				session.setAttribute("signIn", true);
				request.getRequestDispatcher("main.view").forward(request, response);
			}else {
				out.println("<script> alert('계정 정보가 존재하지 않습니다.'); location.href='login.view'; </script>");
			}
		}else if(path.equals("/logout.do")) {
			session.removeAttribute("id");
			session.setAttribute("signIn", false);
			out.println("<script> alert('로그아웃 되었습니다.'); location.href='main.view'; </script>");
		}else if(path.equals("/mypage.do")) {
			MemberDao dao= new MemberDao();
			String tempId= (String)session.getAttribute("id");
			session.setAttribute("tempAccount", dao.tempAccount(tempId));
			request.getRequestDispatcher("mypage.jsp").forward(request, response);
		}else if(path.equals("/terminate.do")) {
			MemberDao dao= new MemberDao();
			String tempId= (String)session.getAttribute("id");
			if(dao.terminate(tempId)) {
				session.removeAttribute("id");
				session.setAttribute("signIn", false);
				out.println("<script> alert('계정 탈퇴 되었습니다.'); location.href='main.view'; </script>");
			}
		}else if(path.equals("/memberEdit.do")) {
			MemberDao dao= new MemberDao();
			//필수
			String name= request.getParameter("editName");
			String id= request.getParameter("editId");
			String pw= request.getParameter("editNewPw");
			String email= request.getParameter("editEmail");
			//선택
			if(request.getParameter("editAddPost")!=null && request.getParameter("editPhone")==null) {
				String postNo= request.getParameter("editAddPost");
				String address= request.getParameter("editAdd")+" / "+request.getParameter("editAddDetail");
				if(dao.updateExceptPhone(name, id, pw, email, postNo, address)) {
					session.removeAttribute("tempAccount");
					session.setAttribute("tempAccount", dao.tempAccount(id));
					out.println("<script> alert('수정되었습니다.'); location.href='mypage.view'; </script>");
				}else {
					out.println("<script> alert('수정 실패: 관리자에게 문의하세요.'); location.href='main.view'; </script>");
				}
			}else if(request.getParameter("editAddPost")==null && request.getParameter("editPhone")!=null) {
				String phone= request.getParameter("editPhone");
				if(dao.updateExceptAdd(name, id, pw, email, phone)) {
					session.removeAttribute("tempAccount");
					session.setAttribute("tempAccount", dao.tempAccount(id));
					out.println("<script> alert('수정되었습니다.'); location.href='mypage.view'; </script>");
				}else {
					out.println("<script> alert('수정 실패: 관리자에게 문의하세요.'); location.href='main.view'; </script>");
				}
			}else {
				String postNo= request.getParameter("editAddPost");
				String address= request.getParameter("editAdd")+" / "+request.getParameter("editAddDetail");
				String phone= request.getParameter("editPhone");
				if(dao.updateWithAllParams(name, id, pw, email, postNo, address, phone)) {
					session.removeAttribute("tempAccount");
					session.setAttribute("tempAccount", dao.tempAccount(id));
					out.println("<script> alert('수정되었습니다.'); location.href='mypage.view'; </script>");
				}else {
					out.println("<script> alert('수정 실패: 관리자에게 문의하세요.'); location.href='main.view'; </script>");
				}
			}
		}else if(path.equals("/findId.do")) {
			MemberDao dao= new MemberDao();
			String name= request.getParameter("findId_name");
			String email= request.getParameter("findId_email");
			String result= dao.findId(name, email);
			if(!result.equals("-")) {
				MailManager mail= new MailManager();
				out.println(mail.sendAuth(email)+"/"+result);
			}else {
				out.println("error");
			}
		}else if(path.equals("/findPw.do")) {
			MemberDao dao= new MemberDao();
			String id= request.getParameter("findPw_id");
			String email= request.getParameter("findPw_email");
			String result= dao.findPw(id, email);
			if(!result.equals("-")) {
				MailManager mail= new MailManager();
				out.println(mail.sendAuth(email)+"/"+result);
			}else {
				out.println("error");
			}
		}else if(path.equals("/findPwSendMail.do")) {
			MemberDao dao= new MemberDao();
			String id= request.getParameter("findPw_id");
			String email= request.getParameter("findPw_email");
			String pw= request.getParameter("foundPw");
			MailManager mail= new MailManager();
			if(!mail.sendPwMail(email, pw, id)) {
				out.println("error");
			}else {
				out.println("success");
			}
		}else if(path.contains("/cart")){
			if(session.getAttribute("signIn")!=null && (boolean)(session.getAttribute("signIn"))) {
				if(path.equals("/cart.do")) {
					int productNo= Integer.parseInt(request.getParameter("productNo"));
					int catNo= Integer.parseInt(request.getParameter("catNo"));
					int count= Integer.parseInt(request.getParameter("count"));
					String option= request.getParameter("option");
					ProductDao pdao= new ProductDao();
					MemberDao mdao= new MemberDao();
					MemberDto temp= mdao.tempAccount((String)(session.getAttribute("id")));
					if(pdao.addToCart(temp, catNo, productNo, option, count)) {
						System.out.println("CART - SUCCESS");
						//request.getRequestDispatcher("cart.view").forward(request, response);
						out.println("<script> location.href= 'cart.view'; </script>" );
					}else {
						out.println("<script> alert('실패: 관리자에게 문의하세요.'); </script>");
						System.out.println("CART INSERT - FAILURE: CHECK LOG");
					}
				}else if(path.equals("/cartUpdate.do")) {
					int productNo= Integer.parseInt(request.getParameter("productNo"));
					int count= Integer.parseInt(request.getParameter("count"));
					String option= request.getParameter("option");
					int optionPrice= (option.equals("S")?10000:option.equals("M")?15000:18000);
					ProductDao pdao= new ProductDao();
					MemberDao mdao= new MemberDao();
					int memberNo= mdao.tempAccount((String)(session.getAttribute("id"))).getNo();
					if(pdao.updateCart(count, productNo, option, memberNo)) {
						out.print(count+"/"+(count*optionPrice));
					}
				}else if(path.equals("/cart_deleteAll.do")) {
					ProductDao pdao= new ProductDao();
					MemberDao mdao= new MemberDao();
					int memberNo= mdao.tempAccount((String)(session.getAttribute("id"))).getNo();
					if(pdao.resetCart(memberNo)) {
						out.print("<script> location.href='cart.view'; </script>");
					}else {
						out.print("<script> alert('실패: 관리자에게 문의하세요.'); location.href='cart.view'; </script>");
					}
				}else if(path.equals("/cart_deleteSelected.do")) {
					String[] delList= request.getParameterValues("deleteList[]");
					System.out.println(delList.toString());
					ProductDao pdao= new ProductDao();
					MemberDao mdao= new MemberDao();
					int memberNo= mdao.tempAccount((String)(session.getAttribute("id"))).getNo();
					boolean res= true;
					while(res) {
						for(String s : delList) {
							res= pdao.deleteCart(Integer.parseInt(s.split("/")[0]), s.split("/")[1], memberNo);
						}
						break;
					}
					out.print(pdao.getCart(memberNo).toString());
				}
			}else {
				out.println("<script> alert('로그인 후 이용 바랍니다.'); location.href='login.view'; </script>");
			}
		}
	}

}
