<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<style type="text/css">
	
	.form{	
	margin-top: -20px
	}
			
	
</style>
<%
		List<String> errors = (List<String>)request.getAttribute("errors");	
		//取得Cookie		
		String email="";		
		String auto ="";
		Cookie[] allCookies = request.getCookies();
		if(allCookies!=null && allCookies.length>0){
			for(int i=0;i<allCookies.length;i++){
				if("email".equals(allCookies[i].getName())){
					email = allCookies[i].getValue();
				}else if("auto".equals(allCookies[i].getName())){
					auto = allCookies[i].getValue();
				}
			}
		}
		%>
		<script>
			function login(){
				notAjax = false;
		  		if(notAjax==false){
		  			//送出ajax請求
		  			//alert("ajax");
		  			$.ajax({
		  				url: $("#loginForm").attr("action")+"?ajax="+(!notAjax),
		  				method: $("#loginForm").attr("method"),
		  				data: $("#loginForm").serialize()
		  			}).done(loginDoneHandler); //指定addCart完成後的回呼(CallBack)程式	  			
		  		}	  		
		  		
		  		//當notAjax==true則使用同步請求(繼續form submit)，否則就取消form submit
		  		return notAjax;	  	
			}
			function loginDoneHandler(data){
				//alert(data);
				if(false){
					$('#memberDetail').html(data);					
				}else{
					location.href="<%= request.getContextPath()%>";
				}
				
			}
		
		</script>
		
		<form id="loginForm" class="form" action="login.do" method="POST" onsubmit="return login()">
			<table>
				<h1>會員登入</h1>
				<p>
					<label>帳號: </label>
					<input placeholder="請輸入Email" name="email" required>
					<input type="checkbox" name="auto" value="on">記住我的帳號
				</p>
				<p>
					<label>密碼:</label>			
					<input type="password" placeholder="請輸入密碼" name="password" required>
				</p>
				<p>
					<label>驗證碼:</label>			
					<input type="text" placeholder="請輸入驗證碼" name="captcha" required>
					<img style="vertical-align: middle;cursor:pointer;" src="images/captcha.png" onclick="refreshCaptcha(this)"
						alt="captcha圖片" title="點選圖片可更新驗證碼">
				</p>
				<input style="background: #BB5500" type="submit" value="確定登入">
			</table>
		</form>
		