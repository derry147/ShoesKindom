package uuu.s2k.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.s2k.entity.Product;
import uuu.s2k.entity.ShoppingCart;
import uuu.s2k.service.ProductService;



/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/add_cart.do")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		//1.取得request的Form Data
		String productId = request.getParameter("productId");
		String sizeCode = request.getParameter("sizeCode");
		String quantity = request.getParameter("quantity");
		
		if(productId==null || productId.length()==0) {
			errors.add("加入購物車必須有產品編號");
		}
		
		if(quantity==null || !quantity.matches("\\d+")) {
			errors.add("加入購物車必須有購買數量");
		}
		
		//2.若無誤，則呼叫商業邏輯
		if(errors.isEmpty()) {
			ProductService pService = new ProductService();			
			try {
				Product p = pService.getProductById(productId);
				if(p!=null) {
					
					HttpSession session = request.getSession();
					ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
					if(cart==null) {
						cart = new ShoppingCart();
						session.setAttribute("cart", cart);
					}					
					cart.addCart(p, sizeCode, Integer.parseInt(quantity));					
				} else {
					this.log("無法加入購物車-查無產品:" + productId);
					errors.add("無法加入購物車-查無產品:" + productId);
				}				
			}catch(Exception ex) {
				this.log("加入購物車失敗", ex);
				errors.add("加入購物車失敗-" + ex);
			}			
		}
		
		System.out.println("加入購物車失敗之錯誤清單: " + errors);
		
		String ajax = request.getParameter("ajax");
		System.out.println(ajax);
		
		if("true".equals(ajax)) {
			//3. 非同步請求: 內部轉交到購物車數量畫面(small_cart.jsp)
			request.getRequestDispatcher("/small_cart.jsp").forward(request, response);
		}else {
			//3. 同步請求: 外部轉交到購物車畫面(cart.jsp)
			response.sendRedirect(request.getContextPath() + "/product_list.jsp");
		}
		return;
	}

}
