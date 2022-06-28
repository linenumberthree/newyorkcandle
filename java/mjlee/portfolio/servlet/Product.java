package mjlee.portfolio.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mjlee.portfolio.dao.ProductDao;

/**
 * Servlet implementation class product
 */
@WebServlet("*.product")
public class Product extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Product() {
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
		System.out.println("PATH:.........."+path);
		if(path.equals("/candles.product")){
			ProductDao dao= new ProductDao();
			int page= 1;
			if(request.getParameter("page")!=null) {
				page= Integer.parseInt(request.getParameter("page"));
			}
			int start= ((int)Math.floor((page-1)/10))*10 +1;
			int totalPage= (int)Math.ceil(dao.getCandleCount()/10.0);
			request.setAttribute("candleList", dao.getAllCandles(page));
			request.setAttribute("start", start);
			request.setAttribute("end", (totalPage<(start+9)?totalPage:start+9));
			request.setAttribute("current", page);
			request.setAttribute("totalPage", totalPage);
			request.getRequestDispatcher("/products/candles.jsp").forward(request, response);
		}else if(path.equals("/search.product")){
			String[] scent= request.getParameterValues("scent[]");
			String[] effect= request.getParameterValues("effect[]");
			String[] place= request.getParameterValues("place[]");
			String name= request.getParameter("productName");
			ProductDao dao= new ProductDao(); PrintWriter out= response.getWriter();
			if(name!="") {
				out.print(dao.searchProductByName(name));
			}else {
				out.print(dao.search(scent, effect, place));
			}
		}else if(path.equals("/price.product")) {
			String optionVal= request.getParameter("option");
			int productNo= (Integer.parseInt(request.getParameter("productNo").replace("candleOption", "")));
			ProductDao dao= new ProductDao();
			PrintWriter out= response.getWriter();
			int price= dao.getOptionPrice(productNo, optionVal);
			out.print(productNo+"/"+price);
		}else if(path.equals("/detail.product")) { 
			int catNo= Integer.parseInt(request.getParameter("catNo")); 
			int productNo= Integer.parseInt(request.getParameter("productNo")); 
			ProductDao dao= new ProductDao(); 
			request.setAttribute("res", dao.getProductInfo(catNo, productNo));
			request.getRequestDispatcher("/products/detail.jsp").forward(request, response); 
		}
			 
	}
}
