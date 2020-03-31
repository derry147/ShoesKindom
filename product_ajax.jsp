<%@page import="uuu.s2k.entity.Outlet"%>
<%@page import="uuu.s2k.service.ProductService"%>
<%@page import="uuu.s2k.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>	
 <style type="text/css">
 	#price{
 		font-size: 1.2em;
		color:red;
		font-weight: bold;
 	}
 	#form{ 
 		font-size:1.5em;
 		display: flex;
		flex-direction:row;		
 		
 	}
 	.addcartbutton{
 		width:150px;
 		height:50px;
 		background:#666666 ;
 		color:white;
 		font-weight:bold;
 		border: 1px solid gray;
 		border-radius: 10px;
 		position: relative; top:60px;
 	}
 	.addcartbutton:hover{ 		
 		background: white;
 		color:#880000;
 	}
 	
 	#productImage{
 		width:65%;
 		position: relative; top:60px;left:30px
 	}
 	#productForm{	 		
 		width:200px;
 		height:500px;
 		float:right;
 		position: relative; top:90px;right:-20px;
 	}
 	#productDetail.fancybox-content{		
		width:1000px;height:700px;
		background-image: url(<%= request.getContextPath()%>/images/productbackgroundphoto-03.jpg);		
 	}
 </style>
		
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

	  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">

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
		<!-- 3.將結果顯示畫面上 -->		
		<% if(p!=null){ %>
		<div id="form">
			<img id="productImage" src="<%= p.getPhotoUrl() %>">
			<div style='width:45%'>
				<form id="productForm" 	action="add_cart.do" method="POST">
					<p><h4><%=p.getName() %></h4></p>
					<% if(p instanceof Outlet) {%>
					<p><div>定價:<%= ((Outlet)p).getListPrice() %>  </div></p>
					<% } %>
					<p><div id="price"><%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %> <%= p.getUnitPrice() %> 元</div></p>
						<p><input type="hidden"  name="productId" value="<%= p.getId() %>">
						尺寸:<select name="sizeCode" required>
								<option value=""></option>
								<option value="260">26cm</option>
								<option value="265">26.5cm</option>
								<option value="270">27cm</option>
								<option value="275">27.5cm</option>
								<option value="280">28cm</option>
								<option value="285">28.5cm</option>
								<option value="290">29cm</option>
								<option value="295">29.5cm</option>
								<option value="300">30cm</option>
								<option value="305">30.5cm</option>						
							</select></p>
						<p>數量: <input type="number" name="quantity" min='1' max='<%= p.getStock()%>' required></p>
						<p>庫存: <%= p.getStock() %></p>		
						<p><input class="addcartbutton" type="submit" value="加入購物車"></input></form>		
					</div>				
				</form>				
			</div>
			<%}else{ %>
				<p>查無此商品(id:<%= productId %>)</p>
			<%} %>
		</div>
		<img src="">