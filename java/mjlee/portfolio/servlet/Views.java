package mjlee.portfolio.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mjlee.portfolio.dao.MemberDao;
import mjlee.portfolio.dao.MemberDto;
import mjlee.portfolio.dao.ProductDao;

/**
 * Servlet implementation class Views
 */
@WebServlet("*.view")
public class Views extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Views() {
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
		HttpSession session= request.getSession();
		String path= request.getServletPath();
		System.out.println(path);
		if(path.equals("/login.view")) {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else if(path.equals("/logout.view")) {
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}else if(path.equals("/mypage.view")) {
			request.getRequestDispatcher("mypage.do").forward(request, response);
		}else if(path.equals("/join.view")) {
			request.getRequestDispatcher("joinNew_terms.jsp").forward(request, response);
		}else if(path.equals("/main.view")) {
			ProductDao dao= new ProductDao();
			request.setAttribute("mainCandles", dao.mainCandles());
			request.getRequestDispatcher("main.jsp").forward(request, response);
		}else if(path.equals("/edit.view")) {
			request.getRequestDispatcher("edit.jsp").forward(request, response);
		}else if(path.equals("/findAccount.view")){
			request.getRequestDispatcher("findAccount.jsp").forward(request, response);
		}else if(path.equals("/candles.view")){
			request.getRequestDispatcher("candles.product").forward(request, response);
		}else if(path.equals("/cart.view")) {
			ProductDao pdao= new ProductDao();
			MemberDao mdao= new MemberDao();
			MemberDto temp= mdao.tempAccount((String)(session.getAttribute("id")));
			request.setAttribute("res", pdao.getCart(temp.getNo()));
			request.getRequestDispatcher("/products/cart.jsp").forward(request, response);
		}
	}
}
