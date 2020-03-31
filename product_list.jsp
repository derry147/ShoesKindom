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
	body{background:white;margin:0}

	.productList li{		
		margin-right:30px;
		background:#F9F7F7;
		display: inline-block;
		width:500px;
		height:550px;
		vertical-align: top;
		text-align: center;
		box-shadow: gray 1px 1px 2px;
		padding: 10px;
		position: relative; top:100px; left:-45px;
		margin:30px;
		border-radius:5px; 
		
	}
	.productList img{
		margin:auto;
		width: 400px;			
	}
	.productList img:hover{
		transform: scale(1.5,1.5);	
		transition: transform 2s;
	}
	.pricefontsize{
		font-size: 1.2em;
		
		font-weight: bold;
	}
	
	
	.productNamePrice{
		position:relative;
		top:0px;
		left:0
	}
	#productlistbanner img{
		width:100%;
		height:auto;
	}
	.abc:link {
		color: black;
		text-decoration: none;
	}
	.abc:hover {
		text-decoration: underline;
	}
	#shoesContainer {
		display:-webkit-flex;
		display:flex;
		-webkit-flex-direction:row;
		flex-direction:row;
		-webkit-align-items:center;
		align-items: center;/*stretch flex-start center flex-end */
		justify-content: center; /*flex-start center flex-end space-between space-around*/
		width: 100%;
		height: 139px;		
	}
	.shoesItem {
		width: 100px;
        height: 77px;
        text-align: center;
        font-weight: bold;
        margin-right: 100px;
        margin-top: -100px;
        position: relative;
        top:-10px;
        left: 200px;
        display:-webkit-flex;
		display:flex;
		-webkit-flex-direction:column;
		flex-direction:column;
		-webkit-align-items:center;
		align-items: center;
	}

</style>
<script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous"></script>
<script src="<%= request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>
  <script>
 
	$(document).ready(init);
	function init() {
		$(".shoesItem").animate({left:"20px"},2300);
	}
  
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
		<div id="productlistbanner">
			<img src="<%=request.getContextPath() %>/images/productlistbanner.jpg">
		</div>
		<nav style="width:100%; height:80px;">
			<ul id="shoesContainer" style="">
				<li class="shoesItem">
					<a class="shoesHref" href="">
						<img style="width:200px;height:200px;" src="<%= request.getContextPath() %>/images/flow1.png">						
						<span></span>
					</a>
				</li>
				<li class="shoesItem">
					<a class="shoesHref" href="">
						<img style="width:200px;height:200px;" src="<%= request.getContextPath() %>/images/flow2.png">
					</a>
				</li>
				<li class="shoesItem">
					<a class="shoesHref" href="">
						<img style="width:200px;height:200px;" src="<%= request.getContextPath() %>/images/flow3.png">
					</a>
				</li>
				<li class="shoesItem">
					<a class="shoesHref" href="">
						<img style="width:200px;height:200px;" src="<%= request.getContextPath() %>/images/flow4.png">
					</a>
				</li>
				<li class="shoesItem">
					<a class="shoesHref" href="">
						<img style="width:200px;height:200px;" src="<%= request.getContextPath() %>/images/flow5.png">
					</a>
				</li>
			</ul>
		</nav>
		
		<div style="border-radius:20px; margin:0;" id="productDetail"></div>
		<article style="min-height:70vhl; position: relative;top:0px; left:80px">
			
			<% if(list!=null && list.size()>0){//3.將查詢結果顯示在html上%>
			<ul class= "productList">
				<%	for(int i=0;i<list.size();i++){ 
					Product p = list.get(i);
				%>
				<li class="productBlock">
					<a class="abc" href="javascript:getProduct(<%= p.getId() %>)" >
						<img src="<%= p.getPhotoUrl() %>" onerror="getImage(this)">
						<span class="productNamePrice"><h2><%= p.getName().replace(keyword, "<span class='keyword'>"+keyword+"</span>") %></h2></a>
							<h5><%= p.getDescription() %></h5>
							<div class="pricefontsize productNamePrice">$:<%=p instanceof Outlet?((Outlet)p).getDiscountString()+",":"" %> <%= p.getUnitPrice() %> 元</div>										
						</span>
				</li>			
				<%} %>	
			</ul>
			<%}else{ %>
			<p>查無產品!</p>
			<%} %>
			
		</article>
		<!--<script src="https://apps.elfsight.com/p/platform.js" defer></script>
		<div class="elfsight-app-36807577-d6ef-4aec-869a-ed2104bf0468" "></div>  -->
		
<%@include file="/subviews/footer.jsp" %>
</body>
</html>