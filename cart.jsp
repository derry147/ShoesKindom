
<%@page import="uuu.s2k.entity.CartItem"%>
<%@page import="uuu.s2k.entity.Product"%>
<%@page import="uuu.s2k.entity.Size"%>
<%@page import="java.util.Set"%>
<%@page import="uuu.s2k.entity.Outlet"%>
<%@page import="uuu.s2k.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
   	
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
	<title>購物車</title>
<style type="text/css">
	body{font-family: Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", "LiHei Pro", 
   "微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;}
	
	body{
		font-weight:bold;
		color:white;   
    	background-image: url(<%= request.getContextPath()%>/images/background.jpg);
	}
		
	#cartform{position:relative;top:180px;left:0;}
	#cartTable{width:85%;margin:auto;border-collapse: collapse;}
	#cartTable td,#cartTable th{
		border:1px solid #cbc;padding: 8px;
	}
	#cartform tr:hover{background: #ddd }
	#cartform th{
		padding-top: 12px;
		padding-bottom: 12px;
		background: darkgray;
		color: white;
	}
	.cartItemImage{width:48px;vertical-align: middle;}
	.buttonStyle{
		position:relative;top:20px;left:1000px;
		width:150px;
 		height:50px;
 		background: #880000;
 		color:white;
 		border: 0.1px solid black;
 		border-radius: 10px;
 		font-weight:bold;
	}
	.backlist{
		position:relative;left:150px;
		width:400px;
		background: #00BFFF;
		color:white;
		font-weight:bold;
	}
	.buttonStyle:hover{
 		transform: scale(1.1,1.1);
 		background: white;
 		color:#880000;
 		border:1.5px solid #880000;
 	}
 	.backlist:hover{
 		transform: scale(1.1,1.1);
 		background: white;
 		color:#00BFFF;
 		font-weight:bold;
 		border:1.5px solid #00BFFF;
 	}
</style>
<script>
	function checkOut(){
		location.href="check_out.jsp"
	}
	function backlist(){
		location.href="<%= request.getContextPath()%>/product_list.jsp";
	}

</script>	
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="購物車" name="subtitle"/>
	</jsp:include>	
	<%
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
	%>
<article style="min-height: 70vh">			
	<form id="cartform" action="update_cart.do" method="GET">		
	<% if(cart!=null && cart.size()>0){ %>
		<table id="cartTable" >
			<caption style="font-weight:bold;">購 物 明 細</caption>
			<thead>
				<tr>
					<th></th><th>名 稱</th><th>尺寸</th><th>原 價</th><th>折扣</th><th>售價</th><th>數量</th><th>刪除</th>
				</tr>
			</thead>
			<tbody>	
				<%
					Set<CartItem> itemSet = cart.getCartItemSet();
					for(CartItem item:itemSet){
						Product p = item.getProduct();
						Size size = item.getSize();
					
				%>	
				<tr>
					<td><%=item.getProduct().getId() %></td>
					<td>
						<img class="cartItemImage" src="<%=p.getPhotoUrl() %>">
						<%=p.getName() %>
					</td>											
					<td><%= size.getSizeCode() %></td>
					<td><%=p instanceof Outlet?((Outlet)p).getListPrice():p.getUnitPrice() %></td>
					<td><%=p instanceof Outlet?((Outlet)p).getDiscountString():""%></td>
					<td><%=p.getUnitPrice() %></td>
					<td><input type="number" name="quantity<%=item.hashCode() %>" value='<%= cart.getQuantity(item)%>'
								min='<%=p.getStock()>1?1:0 %>' max='<%= p.getStock()>10?10:p.getStock()%>'></td>
					<td><input type="checkbox" name="delete<%=item.hashCode()%>"></td>
				</tr>
				<%} %>
				
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6" style="text-align: right;">共<%=cart.size() %>項,
															<%=cart.getTotalQuantity() %>件</td>
					<td colspan="2">共<%= cart.getTotalAmount() %>元</td>
				</tr>
				
			</tfoot>		
		</table>
		<%}else{ %>
			<P>購物車是空的，<a href="<%= request.getContextPath() %>/product_list.jsp">請回賣場
		<%} %>
		<div >			
			<input class="buttonStyle backlist" type="button" value="繼續逛逛" onclick="backlist()">
			<input class="buttonStyle" type="submit" value="修改購物車">
			<input class="buttonStyle" type="button" value="結帳" onclick="checkOut()">
		</div>
	</form>
</article>
	
</body>
</html>