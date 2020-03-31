package uuu.s2k.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.s2k.entity.Customer;
import uuu.s2k.entity.VGBException;
import uuu.s2k.service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet(name = "RegisterServlet", urlPatterns = "/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		List<String> errors = new ArrayList<>();
		// 1.取得request中的Form Data，並檢查之
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		String gender = request.getParameter("gender");		
		String birthday = request.getParameter("birthday");
		String address = request.getParameter("address");	
		String captcha = request.getParameter("captcha");

		if (email == null || email.length() == 0) {
			errors.add("必須輸入帳號");
		}

		if (password1 == null || password1.length() == 0 
				|| !password1.equals(password2)){
			errors.add("必須輸入一致的密碼與確認密碼");
		}

		if (name == null || name.length() == 0) {
			errors.add("必須輸入姓名");
		}

		if (gender == null || gender.length() == 0) {
			errors.add("必須輸入性別");
		}
		
		if (birthday == null || birthday.length() == 0) {
			errors.add("必須輸入生日");
		}

		HttpSession session = request.getSession();
		if (captcha == null || captcha.length() == 0) {			
			errors.add("必須輸入驗證碼");
		}else {
			String oldCaptcha = (String)session.getAttribute("RegisterCaptchaServlet");
			if(!captcha.equalsIgnoreCase(oldCaptcha)) {
				System.out.println("test1: "+oldCaptcha);
				System.out.println("test2: "+captcha);				
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("RegisterCaptchaServlet");

		// 2. 若檢查無誤則呼叫商業邏輯
		if (errors.isEmpty()) {
			try {
				uuu.s2k.entity.Customer c = new Customer();
				c.setEmail(email);
				c.setName(name);
				c.setPassword(password1);
				c.setGender(gender.charAt(0));			
				c.setBirthday(birthday);
				c.setAddress(address);				

				
				CustomerService service = new CustomerService();
				service.register(c);

				// 3.1 forward to 成功畫面: register_ok.jsp
				RequestDispatcher dispatcher = 
						request.getRequestDispatcher("/register_ok.jsp");
				request.setAttribute("customer", c);
				
				dispatcher.forward(request, response);
				return;
			} catch(uuu.s2k.entity.DataInvalidException e) {
				errors.add(e.toString());	//給user看的			
			} catch (VGBException ex) {
				this.log("註冊失敗", ex);//給admin的
				errors.add(ex.getMessage());//給user的
			} catch (Exception ex) {
				this.log("註冊發生非預期錯誤", ex);//給admin的
				errors.add("註冊發生非預期錯誤"+ex.getMessage());//給user的
			}
		}

		// 3.2forward to 失敗畫面: register.jsp
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("/register.jsp");
		request.setAttribute("errors", errors);
		
		dispatcher.forward(request, response);
		//return;
	}

}
