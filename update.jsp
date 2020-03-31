<%@page import="uuu.s2k.entity.Customer"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>修改會員</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<style type="text/css">
		.form{
			margin-top: 100px;	
		}
		</style>
		<script type="text/javascript">
			function refreshCaptcha(imgTarget) {
				//alert(imgTarget.src);
				imgTarget.src = "../images/captcha_register.png?refresh="+new Date();
			}		
		</script>	
	<style type="text/css">
		.form{
		position:fixed;
		top:50px;
		left:20px;
		color:white;	
		margin-top: 100px;	
	}
	</style>
	</head>
	<%
		Customer member = (Customer)session.getAttribute("member");
		List<String> errors = (List<String>)request.getAttribute("errors");	
	%>
	<body style="margin:0px">
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="修改會員" name="subtitle"/>
		</jsp:include>	
		
		<img style="width:100%; height:100%"; src="<%= request.getContextPath()%>/images/background.jpg">
		<form class="form" action="update.do" method="POST">
		<p>
			<label>輸入Email:</label>
			<input type="email" placeholder="請輸入email" name="email" required
				value="<%= request.getParameter("email")==null?(member!=null?member.getEmail():""):request.getParameter("email") %>">				
		</p>
		<p>
			<label>輸入密碼:</label>
			<input type= "password" placeholder="請輸入6~20字元的密碼" name="password"
				maxlength="20" minlength="6" required><br>		
		</p>
		<p>
			<label>確認密碼:</label>
			<input type= "password" placeholder="再輸入一次密碼" name="password2"  required>
				
		</p>
		<p>
			<label>輸入姓名:</label>
			<input placeholder="請輸入姓名"  name="name" required
				value="${not empty param.name?param.name:sessionScope.member.name}" placeholder='請輸入姓名'>
		</p>
		<p>
			<label>輸入生日:</label> 
				<input name='birthday' value="${not empty param.birthday?param.birthday:sessionScope.member.birthday}" required type='date'>
		</p>
		<p>
			<label>輸入性別:</label> 
				<input type='radio' name='gender' id='male' 
					<%=(request.getParameter("gender")!=null && request.getParameter("gender").charAt(0)==Customer.MALE ||
						(request.getMethod().equals("GET") && member.getGender()==Customer.MALE)?"checked":"")%>
					value="<%= Customer.MALE %>" required><label>男</label> 
				<input type='radio' name='gender' id='female'				
					${param.gender.equals(String.valueOf(Customer.FEMALE)) || (pageContext.request.method.equals("GET") && member.gender==Customer.FEMALE)?"checked":""} 
					value="<%= Customer.FEMALE %>" required><label>女</label>
			</p>		
		<p>
			<label>輸入地址:</label>
			<textarea name='address'>${not empty param.address?param.address:sessionScope.member.address}</textarea>
		</p>
		<p>
			<label>驗證碼</label>
			<input type="text" placeholder="請輸入驗證碼" name="captcha" required>
			<img style="vertical-align: middle;cursor:pointer;" src="../images/captcha_register.png" onclick="refreshCaptcha(this)"
				alt="captcha圖片" title="點選圖片可更新驗證碼">
		</p>
		<p>
			<input type="submit" value="確定修改">
			<%= errors!=null?errors:"" %>
		</form> 
		
	</body>
</html>