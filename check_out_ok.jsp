<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>結帳成功</title>
</head>
<body>
<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="結帳成功" name="subtitle"/>
	</jsp:include>			
	<article style="min-height: 70vh">
		${requestScope.order}
		${requestScope.errors}
	</article>
	<%@include file="/subviews/footer.jsp" %>
</body>
</html>