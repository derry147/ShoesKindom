package uuu.s2k.controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uuu.s2k.entity.Customer;
import uuu.s2k.entity.VGBException;
import uuu.s2k.service.OrderService;

/**
 * Servlet implementation class CreditCardCallBackServlet
 */
@WebServlet("/member/credit_card_back.do")
public class CreditCardCallBackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreditCardCallBackServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {

        Customer member = (Customer)request.getSession().getAttribute("member");

 

        //1. 取得request中的parameter

        String amount = request.getParameter("amount");

        String auth_code = request.getParameter("auth_code");

        String card4no = request.getParameter("card4no");

        String card6no = request.getParameter("card6no");

        String merchantTradeNo = request.getParameter("MerchantTradeNo");

        String process_date = request.getParameter("process_date");

        String paymentTypeChargeFee = request.getParameter("PaymentTypeChargeFee");

        int orderId = 0;

        Integer oid = (Integer)request.getSession().getAttribute("credit_card_order_id");

        if(oid!=null){//取出session中的訂單編號

            orderId = oid;

            request.getSession().removeAttribute("credit_card_order_id");

        }

        //2. 呼叫商業邏輯       

        OrderService service=new OrderService();

        try {

            service.updateStatusToPAID(orderId, member.getEmail(),card6no,card4no,auth_code,process_date,amount);

        } catch (VGBException ex) {

            Logger.getLogger(CreditCardCallBackServlet.class.getName()).log(Level.SEVERE, "信用卡授權發生錯誤", ex);

        }

           

        //3. redirect to /member/orders_history.jsp (或"/member/order.jsp?orderId=" + orderId)      

        response.sendRedirect(request.getContextPath() + "/member/orders_history.jsp");

       

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
