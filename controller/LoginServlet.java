package uuu.s2k.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.s2k.entity.Customer;
import uuu.s2k.service.CustomerService;
import uuu.s2k.entity.VGBException;


/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		request.setCharacterEncoding("UTF-8");
		
		List<String> errors = new ArrayList<>();
		//1.取得request的form data,並檢查
		String email = request.getParameter("email");
		String pwd = request.getParameter("password");
		String captcha = request.getParameter("captcha");
		
		if(email==null || email.length()==0) {
			errors.add("必須輸入帳號");
		}
		if(pwd==null || pwd.length()==0) {
			errors.add("必須輸入密碼");
		}
		
		HttpSession session = request.getSession();		
		if(captcha==null || captcha.length()==0) {
			errors.add("必須輸入驗證碼");
		}else {
			String oldCaptcha = (String)session.getAttribute("CaptchaServlet");
			System.out.println("t: "+oldCaptcha);
			System.out.println("c: "+captcha);
			if(!captcha.equalsIgnoreCase(oldCaptcha)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("CaptchaServlet");
		
		//2.若無誤，呼叫商業邏輯
		
		if(errors.isEmpty()) {
			CustomerService service= new CustomerService();
			try {
				Customer c = service.login(email, pwd);				
				String auto = request.getParameter("auto");	
				//加上Cookie的示範
				Cookie emailCookie = new Cookie("email", email);
				Cookie autoCookie = new Cookie("auto", "checked");				
				if(auto!=null) {
					emailCookie.setMaxAge(7*24*60*60); //7 days
					autoCookie.setMaxAge(7*24*60*60); //7 days
				}else {
					emailCookie.setMaxAge(0); //delete cookie
					autoCookie.setMaxAge(0); //delete cookie
				}
				response.addCookie(emailCookie);
				response.addCookie(autoCookie);
				
				
				
				session.setAttribute("member", c);				
				
				//3.1 新的寫法redirect(外部轉址)成功畫面:首頁
				response.sendRedirect(request.getContextPath());
				return;
			
			} catch (VGBException e) {
				//e.printStackTrace(System.err);
				this.log("登入失敗", e);
				errors.add(e.getMessage());			
			} catch(Exception e) {//RuntimeException
				this.log("登入發生非預期錯誤", e);
				errors.add("登入發生非預期錯誤: "+e);
			}
		}
		//3.2forward(內部轉交)失敗畫面 /login.jsp
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = 
					request.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);
		return;
		
	}
}
