<%@page import="uuu.s2k.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">

<%
	ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
%>
<%= cart!=null && cart.getTotalQuantity()>0?cart.getTotalQuantity():""%>