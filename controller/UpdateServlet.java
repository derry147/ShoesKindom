package uuu.s2k.controller;

import java.io.IOException;
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
import uuu.s2k.entity.DataInvalidException;
import uuu.s2k.entity.VGBException;
import uuu.s2k.service.CustomerService;

/**
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/member/update.do")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		List<String> errors = new ArrayList<>();
		
		//1讀取form data
		String email = request.getParameter("email");
		String pwd = request.getParameter("password");
		String pwd2 = request.getParameter("password2");
		String name = request.getParameter("name");
		String birthday = request.getParameter("birthday");
		String gender = request.getParameter("gender");
		String address = request.getParameter("address");
		String captcha = request.getParameter("captcha");
		
		if(email==null || email.length()<=0) {
			errors.add("帳號必須輸入註冊信箱");
		}
		if(pwd==null || pwd.length()<=0) {
			errors.add("必須輸入密碼");
		}
		if(pwd2==null || pwd2.length()<=0 || !pwd2.equals(pwd)) {
			errors.add("確認密碼必須相同");
		}
		if(name==null || name.length()<=0) {
			errors.add("帳號必須輸入姓名");
		}
		if(birthday==null || birthday.length()<=0) {
			errors.add("必須輸入生日");
		}
		if(gender==null || gender.length()<=0) {
			errors.add("必須輸入性別");
		}
		if(address==null || address.length()<=0) {
			errors.add("必須輸入地址");
		}
		if(captcha == null || captcha.length() == 0) {			
			errors.add("必須輸入驗證碼");
		}
		
		HttpSession session = request.getSession();
		if (captcha == null || captcha.length() == 0) {			
			errors.add("必須輸入驗證碼");
		}else {
			String oldCaptcha = (String)session.getAttribute("RegisterCaptchaServlet");
			if(!captcha.equalsIgnoreCase(oldCaptcha)) {							
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("RegisterCaptchaServlet");
		
		//2.輸入商業邏輯
		if(errors.isEmpty()) {
			try {
				Customer c = new Customer();
				c.setEmail(email);
				c.setPassword(pwd);
				c.setName(name);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				c.setAddress(address);
				
				CustomerService service = new CustomerService();
				service.update(c);
				
				//3.1 forward to 產生成功畫面 
				session.setAttribute("customer", c);						
				response.sendRedirect(request.getContextPath());
				return;		
			}catch(DataInvalidException e) {
				errors.add(e.toString());//給user看
			}catch(VGBException e) {
				this.log("修改失敗", e);
				errors.add(e.getMessage());
			}catch(Exception e) {
				this.log("修改時發生非預期錯誤", e);
				errors.add("修改時發生非預期錯誤"+e.getMessage());
			}
		}
		System.out.println(errors);
		//3.2產生失敗畫面
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("/member/update.jsp");
		dispatcher.forward(request, response);
		return;		
	}

}
