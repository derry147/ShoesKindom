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

import uuu.s2k.entity.Customer;
import uuu.s2k.entity.Order;
import uuu.s2k.entity.PaymentType;
import uuu.s2k.entity.ShippingType;
import uuu.s2k.entity.ShoppingCart;
import uuu.s2k.entity.VGBException;
import uuu.s2k.service.OrderService;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/member/check_out.do")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer member = (Customer)session.getAttribute("member");
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
		if(cart==null || cart.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/member.Cart.jsp");
			return;
		}
		List<String> errors = new ArrayList<>();
		//1.取得form的data
		String paymentType =request.getParameter("paymentType");
		String shippingType =request.getParameter("shippingType");
		String recipientName =request.getParameter("recipientName");
		String recipientEmail =request.getParameter("recipientEmail");
		String recipientPhone =request.getParameter("recipientPhone");
		String recipientAddress =request.getParameter("recipientAddress");
		
		if(paymentType==null || paymentType.length()==0) {
			errors.add("必須選擇付款方式");
		}
		if(shippingType==null || shippingType.length()==0) {
			errors.add("必須選擇貨運方式");
		}
		if(recipientName==null || recipientName.length()==0) {
			errors.add("必須填寫收貨人");
		}
		if(recipientEmail==null || recipientEmail.length()==0) {
			errors.add("必須選擇收貨人email");
		}
		if(recipientPhone==null || recipientPhone.length()==0) {
			errors.add("必須選擇收貨人電話");
		}
		if(recipientAddress==null || recipientAddress.length()==0) {
			errors.add("必須選擇收貨人地址");
		}
		
		//2.若無誤則呼叫商業邏輯
		if(errors.isEmpty()) {
			try {
				Order order = new Order();
				order.setMember(member);
				order.add(cart);
				
				PaymentType pType = PaymentType.valueOf(paymentType);
				order.setPaymentType(pType);
				order.setPaymentFee(pType.getFee());
				
				ShippingType shType = ShippingType.valueOf(shippingType);
				order.setShippingType(shType);
				order.setShippingFee(shType.getFee());
				
				order.setRecipientName(recipientName);
				order.setRecipientEmail(recipientEmail);
				order.setRecipientPhone(recipientPhone);
				order.setShippingAddress(recipientAddress);
				
				OrderService orderService = new OrderService();
				orderService.createOrder(order);
				
				//3.1成功則forward給/member/check_out_ok.jsp
				session.removeAttribute("cart");//結帳成功,則將cart清空
				
				request.setAttribute("order",order);
				//加入信用卡串接程式(以下紅色粗體字部分)       

	            //若paymentType=PaymentType.CARD則轉交/WEB-INF/credit_card.jsp來送出對於第三方支付的請求

	                if(order.getPaymentType()==PaymentType.CARD){                   

	                 request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);                   

	                 return;

	             }
				
				
				request.getRequestDispatcher("/member/orders_history.jsp").forward(request, response);
				return;
			}catch(VGBException ex){
				this.log(ex.getMessage(), ex);
				errors.add(ex.getMessage() + ":" + ex);
			}catch(Exception ex) {
				this.log("建立訂單發生非預期錯誤", ex);
				errors.add("建立訂單發生非預期錯誤:" + ex);
			}		
			
		}
		
		//3.2內部轉交/member/check_out_ok.jsp
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("/member/check_out.jsp").forward(request, response);
	}

}
