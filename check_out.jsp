<%@page import="uuu.s2k.entity.ShippingType"%>
<%@page import="java.util.Set"%>
<%@page import="uuu.s2k.entity.PaymentType"%>
<%@page import="uuu.s2k.entity.Outlet"%>
<%@page import="uuu.s2k.entity.Product"%>
<%@page import="uuu.s2k.entity.Size"%>
<%@page import="uuu.s2k.entity.ShoppingCart"%>
<%@page import="uuu.s2k.entity.Customer"%>
<%@page import="uuu.s2k.entity.CartItem"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
<title>結帳</title>
<style>
		body{
		font-weight:bold;
		color:white;   
    	background-image: url(<%= request.getContextPath()%>/images/background.jpg);
	}
		#cartTable td, #cartTable th {
		  border: 1px solid #cbc;
		  padding: 2px 5px;
		}	
		#cartTable tr:hover {background-color: #ddd;}	
		#cartTable th {
		  padding-top: 3px;
		  padding-bottom: 3px;
		  background-color: darkgray;
		  color: white;
		}
		
		#cartTable{width:85%;margin: auto;border-collapse: collapse;
			position: relative;top:80px;background:black; opacity: 0.8
		}
		
		.cartItemImage{width:48px;vertical-align: middle;}
		#member input:not([type="checkbox"]){width:70%} 
		#recipient input:not([type="checkbox"]){width:70%}
		#cartform{position:relative; top: 80px; left:0}
		.buttonstyle{
			position:relative; top: 450px; left:1550px;
			background:#F0F8FF;
			width: 150px;
			height:40px;
			border-radius:10px; 
		}
		.buttonstyle:hover{
			color:red;
			font-weight:bold;
		}
</style>
<script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous"></script>
<script type="text/javascript">
	<% if (request.getParameter("paymentType")!=null ){%>
	$(function(){
		$("#paymentType").val("<%=request.getParameter("paymentType")%>");
		$("#shippingType").val("<%=request.getParameter("shippingType")%>");
	});
	<%}%>
	function copyMemberData(target){
		if($(target).prop("checked")){
			$("#recipientName").val($("#name").val());
			$("#recipientEmail").val($("#email").val());
			$("#recipientPhone").val($("#phone").val());
			$("#recipientAddress").val($("#address").val());
		}
	}
	
	function paymentTypeChange(){
		$("#recipientAddress").removeAttr("list");
		$("#recipientAddress").attr("autocomplete","on");
		$("#chooseStore").css("display", "none");
		switch($("#paymentType").val()){
			case 'SHOP':
				$("#recipientAddress").attr("list", "shopList");
				$("#recipientAddress").attr("autocomplete","off");
				break;
			case 'STORE':
				$("#recipientAddress").attr("autocomplete","off");
				$("#chooseStore").css("display", "inline");
				break;
				
		}
	}
	function calculateFeeWithAmount(){
		var paymentFee = 0;
		var shippingFee = 0;
		var totalAmount = parseFloat($("#totalAmount").text());
		if($("#paymentType").val().length>0){
			paymentFee = parseFloat($("#paymentType option:selected").attr("data-fee"));
		}
		
		if($("#shippingType").val().length>0){
			shippingFee = parseFloat($("#shippingType option:selected").attr("data-fee"));
		}
		console.log(paymentFee);
		console.log(shippingFee);
		console.log(totalAmount);
		$("#totalAmountWithFee").text(paymentFee+shippingFee+totalAmount);
	}
	
	function check_out_ok(){
		alert("結帳完成!");
	}
</script>


</head>
<body>
		<jsp:include page="/subviews/header.jsp" >
				<jsp:param value="title" name="subtitle"/>
		</jsp:include>
<article style="min-height: 70vh">		
	<%
		Customer member = (Customer)session.getAttribute("member"); //
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
	%>
	
	<form id="cartForm" action="check_out.do" method="Post">
	<% if(cart!=null && cart.size()>0) {%>
	<!-- 結帳畫面 -->		
		<table id="cartTable" >
			<caption>購 物 明 細</caption>
			<thead>
				<tr>
					<th></th><th>名 稱</th><th>尺寸</th><th>原 價</th><th>折扣</th><th>售價</th><th>數量</th>
				</tr>
			</thead>
			<tbody>	
				<% 
					Set<CartItem> itemSet = cart.getCartItemSet();
					//Iterator<CartItem> iterator = itemSet.iterator();					
					//while(iterator.hasNext()){
					//CartItem item = iterator.next();
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
					<td><%= cart.getQuantity(item) %></td>				
				</tr>
				<%} %>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5" style="text-align: right;">共<%=cart.size() %>項,
															<%=cart.getTotalQuantity() %>件</td>
					<td colspan="2">共<span id="totalAmount"><%= cart.getTotalAmount() %></span>元</td>
				</tr>
				<tr>
						<td colspan="4" >
							<div style="width:45%;min-width:300px;float:left">
								<label>付款方式:</label>
								<select id="paymentType" name="paymentType" onchange="paymentTypeChange()" required>
									<option value="">請選擇...</option>
									<% for(PaymentType pType:PaymentType.values()){%>
									<option value="<%= pType.name() %>" data-fee="<%= pType.getFee()%>"><%= pType %></option>
									<% } %>									
								</select>
							</div>
							<div style="width:45%;min-width:300px;float:left">
								<label>取貨方式:</label>
								<select id="shippingType" name="shippingType" required onchange="calculateFeeWithAmount()">
									<option value="">請選擇...</option>
									<% for(ShippingType shType:ShippingType.values()){%>
									<option value="<%= shType.name() %>" data-fee="<%= shType.getFee()%>"><%= shType %></option>									
									<%} %>
								</select>
							</div>
						</td>
						<td style="border-right:none;text-align: right">含物流費</td>
						<td style="border-left:none" colspan="2">共<span id="totalAmountWithFee"><%= cart.getTotalAmount() %></span>元</td>
					</tr>
					<tr>
						<td colspan="7" >							
							<fieldset id="member" style="width:46%;min-width:300px;float:left">
								<legend>訂購人</legend>
								<label for="name">姓名: </label><input readonly id="name" value="<%= member.getName()%>"><br>
								<label>電郵: </label><input readonly id="email" value="<%= member.getEmail()%>"><br>
								<label>電話: </label><input id="phone"><br>
								<label>地址: </label><input readonly id="address" value="${sessionScope.member.address}"><br>
							</fieldset>
							<fieldset id="recipient" style="width:50%;min-width:300px;float:left">
								<legend>收件人 <input type="checkbox" onchange="copyMemberData(this)"><label>同訂購人</label></legend>
								<label>姓名: </label><input required id="recipientName" name="recipientName" value="${param.recipientName}" ><br>
								<label>電郵: </label><input required id="recipientEmail" name="recipientEmail" value="${param.recipientEmail}" ><br>
								<label>電話: </label><input required id="recipientPhone" name="recipientPhone" value="${param.recipientPhone}" ><br>
								<label>地址: </label>
								<input required id="recipientAddress" name="recipientAddress" value="${not empty param.storeAddr?param.storeAddr:param.recipientAddress}" type="search">
								<datalist id="shopList">
								  <option value="復北門市: 台北市復興北路101號2樓">
								  <option value="新竹門市: 新竹市東區光復路二段295號1樓">
								  <option value="台中門市: 台中市西區臺灣大道二段309號1樓">
								  <option value="高雄門市: 高雄市前鎮區中山二路2號5樓">								  
								</datalist>
								<input id="chooseStore" style='width:auto;display:none' type='button' value='選擇超商' onclick='goEzShip()'>
								<br>
							</fieldset>							
						</td>						
					</tr>
					<input class="buttonstyle" type="submit" onclick="check_out_ok()" value="送出訂單" >
			</tfoot>		
		</table>
		
	</form>
	<script>
			function goEzShip() {
			    $("#recipientName").val($("#recipientName").val().trim());
			    $("#recipientEmail").val($("#recipientEmail").val().trim());
			    $("#recipientPhone").val($("#recipientPhone").val().trim());
			    $("#recipientAddress").val($("#recipientAddress").val().trim());
			    
			    var protocol = "<%=request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/"))%>";
			    var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
			    var url = protocol + "://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ez_ship_callback.jsp";
			    $("#rtURL").val(url);
			    
			    $("#webPara").val($("#cartForm").serialize());
			
			    //alert(url);
			    //alert($("#webPara").val());
			    //alert($("#cartForm").serialize());
			
			    $("#ezForm").submit();
			}
		</script>
        <form method="post" action="http://map.ezship.com.tw/ezship_map_web.jsp" id="ezForm">
            <input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 這裡可以隨便寫 -->
            <input type="hidden" name="processID" value="VGB201804230000005"> <!-- 購物網站自行產生之訂單編號, 這裡可以隨便寫 -->
            <input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->            
            <input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->            
            <input type="hidden" name="rtURL" id="rtURL" value=""><!-- 回傳路徑及程式名稱 -->
            <input type="hidden" id="webPara" name="webPara" value=""><!-- 我們網站所需的原Form Data。ezShip會將原值回傳，供我們網站帶回畫面用 -->
        </form>		
<%}else{ %>
	<p>購物車是空的，請<a href='<%= request.getContextPath()%>/products_list.jsp'>回到賣場</a>繼續購物</p>
<%} %>

</article>


</body>
</html>