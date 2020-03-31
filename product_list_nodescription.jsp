<%@page import="uuu.s2k.entity.Outlet"%>
<%@page import="uuu.s2k.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.s2k.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>鞋二帝國</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/fancybox/jquery.fancybox.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
<style type="text/css">
	body{background: #F9F7F7;}

	.productList li{		
		background:white;
		display: inline-block;
		width:300px;
		height:280px;
		vertical-align: top;
		text-align: center;
		box-shadow: gray 10px 10px 20px;
		padding: 10px;
		position: relative; top:100px;
		margin:10px;
		border-radius:25px; 
	}
	.productList img{
		margin:auto;
		width: 80px;	
	}
	.productList li:hover{
		transform: scale(1.05,1.1);	
	}
	.pricefontsize{
		font-size: 1.2em;
		color:red;
		font-weight: bold;
	}
	
	#search{position: fixed;
			top: 80px; left: 0; z-index: 10}
</style>
<script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous"></script>
<script src="<%= request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>
  <script>
	function getProduct(pid){
		notAjax = false;	 //false:開啟ajax效果, true:	關閉ajax效果
		//alert("getProduct");
		//console.log("getProduct");			
		if(notAjax){
			//送出同步GET請求
			location.href="product.jsp?productId="+pid;
		}else{
			//送出非同步GET請求
			//alert("getProduct");
			$.ajax({
				url:"product_ajax.jsp?productId="+pid,
				method:"GET"
			}).done(getProductDoneHandler);
		}
	}
	
	function getProductDoneHandler(data, status, xhr){
		//console.log(data);
		//console.log("test123");		
		//data用fancybox.open打開在#productDetail
		$('#productDetail').html(data);
		$.fancybox.open({
		    src  : '#productDetail',
		    type : 'inline',
		    opts : {
		      afterShow : function( instance, current) {
		        console.info('done!');
		      }
		    }
		 });
	}
</script>

</head>
 
<%
	//1.將request中的form data取出
	String keyword = request.getParameter("keyword");
	//2.呼叫商業邏輯
	ProductService service = new ProductService();
	List<Product> list = null;
	if(keyword!=null && (keyword=keyword.trim()).length()>0){
		list = service.getProductsByKeyword(keyword);
	}else{
		keyword="";
		list = service.getAllProducts();
	}
%>

<body>
		
		<jsp:include page="/subviews/header.jsp" >
				<jsp:param value="man" name="subtitle"/>
		</jsp:include>
		<!--<%= list %>  -->
		<div style="border-radius:25px; width:750px;height:auto;" id="productDetail"></div>
		<article style="min-height:70vhl; position: relative;top:60px; left:80px">
			<form id="search">
				<input type="search" placeholder="請輸入查詢關鍵字" 
					name="keyword" value="<%=keyword %>">
				<input type="submit" value="查詢">
			</form>
			<% if(list!=null && list.size()>0){//3.將查詢結果顯示在html上%>
			<ul class= "productList">
				<%	for(int i=0;i<list.size();i++){ 
					Product p = list.get(i);
				%>
				<li class="productBlock">
					<a href="javascript:getProduct(<%= p.getId() %>)" >
						<img style="width:150px" src="<%= p.getPhotoUrl() %>" onerror="getImage(this)">
					</a>
				</li>			
				<%} %>	
			</ul>
			<%}else{ %>
			<p>查無產品!</p>
			<%} %>		
		</article>
		<%@include file="/subviews/footer.jsp" %>	
</body>
</html>