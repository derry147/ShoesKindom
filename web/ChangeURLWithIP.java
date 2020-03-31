package uuu.s2k.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class ChangeURLWithIP
 */
@WebFilter("/*")
public class ChangeURLWithIP implements Filter {
	private String[] hostName = {"localhost", "i-00"};
	
    /**
     * Default constructor. 
     */
    public ChangeURLWithIP() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		String url = ((HttpServletRequest)request).getRequestURL().toString();
		String ipAddress = java.net.InetAddress.getLocalHost().getHostAddress(); 
		if(url.indexOf(hostName[0])>0 || url.indexOf(hostName[1])>0) {
			url = url.replace(hostName[0], ipAddress);
			url = url.replace(hostName[1], ipAddress);
			System.out.println(url);
			((HttpServletResponse)response).sendRedirect(url);
			return;
		}
		chain.doFilter(request, response);
		
	}
	


	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
