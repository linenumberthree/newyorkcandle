package mjlee.portfolio.dao;

import java.io.IOException;
import java.net.InetAddress;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DaoTest
 */
@WebServlet("*.dao")
public class DaoTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
    MemberDaoTest dao;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DaoTest() {
        super();
        dao= new MemberDaoTest();
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
		if(path.contains("login")) {
			request.setAttribute("logInOut", dao.login(request.getParameter("loginId"), request.getParameter("loginPw")));
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}else if(path.contains("join")) {
			String id= request.getParameter("joinId");
			String name= request.getParameter("joinName");
			String pw= request.getParameter("joinPw");
			String ip= InetAddress.getLocalHost().getHostAddress();
			request.setAttribute("join", dao.join(name, id, pw, ip));
			request.setAttribute("joinRes", dao.selectOneByIp(id, ip));
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}else if(path.contains("editMember")) {
			String curPw= request.getParameter("editCurPw");
			String newPw= request.getParameter("editNewPw");
			String id= request.getParameter("editId");
			String name= request.getParameter("editName");
			String ip= InetAddress.getLocalHost().getHostAddress();
			System.out.println("여기까지 문제없움 1");
			if(dao.selectOneByPw(id, curPw)!=null) {
				System.out.println("여기까지 문제없움 2");
				request.setAttribute("edit", dao.editMember(name, id, newPw, ip));
				System.out.println("여기까지 문제없움 3");
				request.setAttribute("editRes", dao.selectOneByIp(id, ip));
				System.out.println("여기까지 문제없움 4");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}else {
				System.out.println("여기까지 문제없움 4");
				request.setAttribute("editAlert", "계정 정보를 찾을 수 없습니다.");
				System.out.println("여기까지 문제없움 5");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		}
	}
}
