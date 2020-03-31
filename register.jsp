<%@page import="uuu.s2k.entity.Customer"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>註冊</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/vgb.css">
		<style type="text/css">
		form{ position:relative; top:80px; left:20px}
		</style>
		<script type="text/javascript">
			function refreshCaptcha(imgTarget) {
				//alert(imgTarget.src);
				imgTarget.src = "images/captcha_register.png?refresh="+new Date();
			}		
		</script>
	</head>
	<%
		List<String> errors = (List<String>)request.getAttribute("errors");
	%>
	<body>
		<jsp:include page="/subviews/header.jsp">
			<jsp:param name="subtitle" value="註冊新會員"/>			
		</jsp:include>		
		<article>
		<%= errors!=null?errors.toString():"" %>
		<form action="register.do" method="POST" id="memberForm">
			<p>
				<label>帳號:</label> 
				<input type="email" placeholder="請輸入Email" name="email" required
					value="<%= request.getParameter("email")==null?"": request.getParameter("email")%>">
			</p>
			<p>
				<label>密碼:</label>			
				<input type="password" placeholder="請輸入密碼" name="password1" 
					minlength="6" maxlength="20" required><br>
				<label>確認:</label>			
				<input type="password" placeholder="請輸入確認密碼" name="password2" 
					minlength="6" maxlength="20" required>
			</p>
			<p>
				<label>姓名:</label> 
				<input placeholder="請輸入姓名" name="name" required 
					value="<%= request.getParameter("name")==null?"": request.getParameter("name")%>">
			</p>
			<p>
				<label>生日:</label>			
				<input type="date" placeholder="請輸入生日" name="birthday" required max="2020-01-13"
					value="<%= request.getParameter("birthday")==null?"": request.getParameter("birthday")%>">
			</p>
			<p>
				<label>性別:</label>			
				<input type="radio" name="gender" required value='<%=Customer.MALE%>' 
					<%= String.valueOf(Customer.MALE).equals(request.getParameter("gender"))?"checked":""%>><label>男</label>
				<input type="radio" name="gender" required value='<%=Customer.FEMALE%>'
					<%= String.valueOf(Customer.FEMALE).equals(request.getParameter("gender"))?"checked":""%>><label>女</label>
			</p>
			
			<p>
				<label>地址:</label>
				<textarea rows="2" cols="20" name="address"><%= request.getParameter("address")==null?"": request.getParameter("address")%></textarea>
			</p>
			<p>
				<label>電話:</label>			
				<input type="tel" placeholder="請輸入電話" name="phone"
					value="<%= request.getParameter("phone")==null?"": request.getParameter("phone")%>">
			</p>			
			<p>
				<label>驗證碼:</label>			
				<input type="text" placeholder="請輸入驗證碼" name="captcha" required autocomplete="off">
				<img style="vertical-align: middle;" src="images/captcha_register.png" 
						alt="captcha圖片" title="點選圖片可更新驗證碼" onclick="refreshCaptcha(this)">
			</p>
			<input type="submit" value="確定">
			<%=errors!=null?errors:"" %>
		</form>		
		</article>
		
	</body>
</html>