<%@page import="uuu.s2k.entity.PaymentType"%>
<%@page import="uuu.s2k.entity.Size"%>
<%@page import="uuu.s2k.entity.Product"%>
<%@page import="uuu.s2k.entity.OrderItem"%>
<%@page import="uuu.s2k.entity.Order"%>
<%@page import="uuu.s2k.service.OrderService"%>
<%@page import="uuu.s2k.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>檢視訂單</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
<style type="text/css">
	body{
		font-weight:bold;
		color:white;   
    	background-image: url(<%= request.getContextPath()%>/images/background.jpg);
	}
	
	#orderItemTable td, #cartTable th {
		  border: 1px solid #cbc;	
		 	  
		  padding: 2px 5px;
		}	
		#orderItemTable tr:hover {background-color: #ddd;}	
		#orderItemTable th {
		  padding-top: 3px;
		  padding-bottom: 3px;
		  background-color: darkgray;
		  color: white;
		}
		
		#orderItemTable{width:85%;margin: auto;border-collapse: collapse;}
		.orderItemImage{width:48px;vertical-align: middle;}
		
		#article{position: relative;top: 150px; left: 0px;}
</style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp" >
		<jsp:param value="檢視訂單" name="subtitle"/>
	</jsp:include>			
	<%
		String orderId=request.getParameter("orderId");
		Customer member = (Customer)session.getAttribute("member");
		OrderService service = new OrderService();
		
		Order order = service.getOrderById(orderId);		
	%>
	<article id="article"; style="min-height: 70vh">
	<%--= order --%>
	<% if(order!=null) {%>
		<div>
			編號: <%= order.getId() %> 訂購日期時間: <%= order.getOrderDate() %> <%= order.getOrderTime() %>,處理狀態: <%=order.getStatus() %> <br>  
			付款: <%= order.getPaymentType().getDescription() %> 
				  <%= order.getPaymentFee()>0?","+order.getPaymentFee()+"元":"" %>
				  <%= order.getPaymentNote()!=null?","+order.getPaymentNote():"" %>
				  <% if(order.getPaymentType() == PaymentType.ATM && order.getStatus()==0) {%>				  
				  	<a href="paid.jsp">通知已轉帳</a><br>
				  <% } %>
			貨運: <%= order.getShippingType().getDescription() %> 
				  <%= order.getShippingFee()>0?","+order.getShippingFee()+"元":"" %>
				  <%= order.getShippingNote()!=null?","+order.getShippingNote():"" %><br>
			收件人: <%= order.getRecipientName() %>, <%=order.getRecipientEmail() %>, <%=order.getRecipientPhone() %><br>
			收件地址: <%= order.getShippingAddress() %>
		</div>
		<div>
			<hr>
			<% if(order.getOrderItemsList()!=null) {%>
			<table id="orderItemTable">
				<caption>訂單明細</caption>
				<tbody>
				<% for(OrderItem item:order.getOrderItemsList()) {
					Product p = item.getProduct();
					Size size = item.getSize();	
				%>
					<tr>
					<td><%= item.getProduct().getId() %></td>
						<td>
							<img class="orderItemImage" src="<%= p.getPhotoUrl() %>">
							<%= p.getName() %>
						</td>
						<td><%= size!=null?size.getSizeCode():"" %></td>
						<td><%= item.getPrice() %></td>
						<td><%= item.getQuantity() %></td>	
					</tr>
				<%} %>
				</tbody>
				
			</table>
			<%} %>
		</div>
		
	<%}else{ %>
		<p>查無此訂單</p>
	<%} %>
	</article>
	
</body>

</html>

