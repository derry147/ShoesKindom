<%@page import="uuu.s2k.entity.Outlet"%>
<%@page import="uuu.s2k.service.ProductService"%>
<%@page import="uuu.s2k.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
	<title>產品明細</title>
	<style>		
		#form{	background: gray;
				position: relative;
				top: 80px; 
				left: 0; 
				width:500px;height:200px;vertical-align:middle;
				border-radius: 25px;
		}
		
		.selectedImage{box-shadow: red 0 0 3px;border: maroon 1px solid ;}
	</style>
	<script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous"></script>
	  <script>			
		
	  	function changeImage(){
	  		$("#productImage").attr("src", $(this).attr("src"));
	  	}
	  	
	  	function sendAddCartRequest(){
	  		notAjax = false;
	  		if(notAjax==false){
	  			//送出ajax請求
	  			//alert("ajax");
	  			$.ajax({
	  				url: $("#productForm").attr("action")+"?ajax="+(!notAjax),
	  				method: $("#productForm").attr("method"),
	  				data: $("#productForm").serialize()
	  			}).done(addCartDoneHandler); //指定addCart完成後的回呼(CallBack)程式	  			
	  		}	  		
	  		
	  		//當notAjax==true則使用同步請求(繼續form submit)，否則就取消form submit
	  		return notAjax;	  	
	  	}
	  	
	  	function addCartDoneHandler(data, textStatus, jqXHR){
	  		alert("加入購物車成功");
	  		$("#cartTotalQuantity").text(data);	  		
	  	}
	  </script>
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="產品明細" name="subtitle"/>
	</jsp:include>
	<%
		//1. 取得request中的parameter
		String productId = request.getParameter("productId");
		Product p = null;
		
		//2. 呼叫商業邏輯 
		if(productId!=null){
			ProductService service = new ProductService();			
			p = service.getProductById(productId);
		}
	%>			
	<article style ="min-height:70vh">
		<!-- 3.將結果顯示畫面上 -->		
		<% if(p!=null){ %>
		<div id="form">
			<img id="productImage" style='float:left;width:40%;max-width:320px' src="<%= p.getPhotoUrl() %>">
			<div style='float:left;width:45%'>
			<form id="productForm" 	action="add_cart.do" method="POST">
				<h4><%=p.getName() %></h4>
				<% if(p instanceof Outlet) {%>
				<div>定價:<%= ((Outlet)p).getListPrice() %>  </div>
				<% } %>
				<div><%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %> <%= p.getUnitPrice() %> 元</div>
					<input type="hidden" name="productId" value=<%= p.getId()%>>
					數量: <input type="number" name="quantity" min='1' max='<%= p.getStock()%>' required><br>
					庫存: <%= p.getStock() %>	<br>			
					<button type="submit">加入購物車</button>				
				</div>				
			</form>
			<div style="clear:both;width:85%;min-width: 12em">
				<br><hr>
				<div>
					<%=p.getDescription() %>	
				</div>					
			</div>
		</div>
		<%}else{ %>
			<p>查無此商品(id:<%= productId %>)</p>
		<%} %>
	</article>
	<%@include file="/subviews/footer.jsp" %>
</body>
</html>		
