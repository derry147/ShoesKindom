<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
<title>登入</title>
<style type="text/css">
	

</style>
<script type="text/javascript">
	function refreshCaptcha(imgTarget){
		//alert(imgTarget.src);
		imgTarget.src="images/captcha.png?refresh="+new Date();		
	}

</script>
</head>
<style type="text/css">
	
	.form{
		
		width:350px;
		height:250px;
	
		position:fixed;
		top:45%;
		right:20%;
		margin-top: 100px;	
		text-align: left;
	}
	#login{
		width:500px;
		height:800px;
		background: blue;		
	}
	.col{
		width:250px;height:30px; background:#FFF5EE; opacity:0.8;border:1px solid gray;border-radius: 8px;
	}
	.col0{
		width:165px;height:30px; background:#FFF5EE; opacity:0.8;border:1px solid gray;border-radius: 8px;
	}
	.loginbutton{
		width:255px;height:40px; border:1px solid white; border-radius: 8px; 
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
		
<body>
<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="title" name="subtitle"/>
</jsp:include>
<article style="min-height: 70vh">
	<img style="width:100%" src="<%=request.getContextPath() %>/images/loginbackground.jpg">			
		<div id="loginform">
			<form class="form" action="login.do" method="POST">
				<p>					
					<input class="col" placeholder="Email" name="email" required>
					<!--<input class="col" type="checkbox" name="auto" value="on">記住我  -->
				</p>
				<p>						
					<input class="col" type="password" placeholder="密碼" name="password" required>
				</p>
				<p>							
					<input class="col0" type="text" placeholder="驗證碼" name="captcha" required>
					<img style="vertical-align: middle;cursor:pointer;" src="images/captcha.png" onclick="refreshCaptcha(this)"
						alt="captcha圖片" title="點選圖片可更新驗證碼">
				</p>
				<input class="loginbutton" type="submit" value="Login">
			</form>
		</div>
		<%=errors!=null?errors:"" %>
</body>
</html>