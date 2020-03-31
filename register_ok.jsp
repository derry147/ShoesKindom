<%@page import="uuu.s2k.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>註冊成功</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/vgb.css">
</head>
<%	
	Customer c = (Customer)request.getAttribute("customer");
%>
<body>		
		<h2>恭喜，<%=c!=null?c.getName():"" %>，您已經完成註冊!</h2>
		<h3><a href="<%= request.getContextPath() %>/login.jsp">按此進行登入</a></h3>		
</body>
</html>