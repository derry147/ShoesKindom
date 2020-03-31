<%@page import="uuu.s2k.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.s2k.service.ProductService"%>
<%@page import="uuu.s2k.entity.ShoppingCart"%>
<%@page import="uuu.s2k.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<%
Customer member = (Customer)session.getAttribute("member");	
ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
%>
<header>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/fancybox/jquery.fancybox.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
		<style type="text/css">
			.menu{
				
				margin: 0;
				height: 60px;
				position:fixed;
				left: -40px;
				top:0;
				opacity: 1;
				width: 100%;
				padding: 10px 0px;
				z-index: 3;
			}
			#menuItem{position: relative;top:0;left:580px}
			li {float:left;margin: 0px 15px;}
			ul{list-style:none;}
			.menu img:hover{transform: scale(1.5,1.2);}
			#memberSet{
				width:120px;
				height:180px;
				background:#87CEFA;
				opacity:1;
				border-radius: 10px;
			}
			.memberSetOuter{
				position: fixed;
				top:70px;
				right: 20px;
				display:none;
			}
			
			.memberSetOpen{
				display: block;
			}
			
			#memberSet img{
				margin-top: 10px;			
			}
			.searchcol{
				background:#AAAAAA; opacity:0.9;border:1px solid gray;border-radius: 8px;position: relative;top:-10px;right:50px
			}
			.searchbutton{
				width:30px;position: relative;top:0px;right:50px
			}	
				
		</style>
<script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous"></script>
<script src="<%= request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>
<script>
	function login(){
		//alert("testlogin");
		notAjax = true;	 //false:開啟ajax效果, true:	關閉ajax效果
		//alert("getProduct");
		//console.log("getProduct");			
		if(notAjax){
			//送出同步GET請求
			location.href="login.jsp";
		}else{
			//送出非同步GET請求
			//alert("getProduct");
			$.ajax({
				url:"login_ajax.jsp",
				method:"GET"
			}).done(loginDoneHandler);
		}
	}
	function loginDoneHandler(data, status, xhr){
		//console.log(data);
		console.log("test123");		
		//data用fancybox.open打開在#productDetail
		$('#memberDetail').html(data);
		console.log(data);	
		$.fancybox.open({
		    src  : '#memberDetail',
		    type : 'inline',
		    opts : {
		      afterShow : function( instance, current) {
		        console.info('done!');
		      }
		    }
		 });
	}
	function register(){
		//alert("testlogin");
		notAjax = false;	 //false:開啟ajax效果, true:	關閉ajax效果
		//alert("getProduct");
		//console.log("getProduct");			
		if(notAjax){
			//送出同步GET請求
			location.href="register.jsp";
		}else{
			//送出非同步GET請求
			//alert("getProduct");
			$.ajax({
				url:"register_ajax.jsp",
				method:"GET"
			}).done(registerDoneHandler);
		}
	}
	function registerDoneHandler(data, status, xhr){
		//console.log(data);
		console.log("test123");		
		//data用fancybox.open打開在#productDetail
		$('#registermemberDetail').html(data);
		console.log(data);	
		$.fancybox.open({
		    src  : '#registermemberDetail',
		    type : 'inline',
		    opts : {
		      afterShow : function( instance, current) {
		        console.info('done!');
		      }
		    }
		 });
	}
	$(document).ready(init);
	function init(){
		//$("#hide").click(hideHandler);
		//$("#show").click(showHandler);
		$("#toggle").click(toggleHandler);
	}
	function toggleHandler(){
		$(".memberSetOuter").toggleClass("memberSetOpen");		
		//$("#memberSetOuter").css("display","block");
		//$("#memberSet").toggle("fast");//slow normal fast
		
		//$("#demo").slideToggle(500);
		//$("#demo").fadeToggle(500);
	}
	
</script>
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
</header>		
		<div class="menu">
			<ul>			
				<li>
					<a href="<%= request.getContextPath() %>/index.jsp">
						<img src="<%= request.getContextPath() %>/images/logov2.png" style="width:150px;height: auto; position:fixed;top:-10px;left:-5px;">
					</a>
				</li>			
				<div id="menuItem">
					<li class="menuItem"><a href="<%= request.getContextPath() %>/product_list.jsp">
						<img style=" width:80px;vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/men-02.png"></a>				
					</li>
					<li ><a href="<%= request.getContextPath() %>/product_list.jsp">
						<img style=" vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/women-02.png"></a>				
					</li>
					<li><a href="<%= request.getContextPath() %>/product_list.jsp">
						<img style=" vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/kid-02.png"></a>				
					</li>
					<li><a href="<%= request.getContextPath() %>/product_list.jsp">
						<img style=" vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/brand-02.png"></a>				
					</li>
					<li><a href="<%= request.getContextPath() %>/product_list.jsp">
						<img style=" vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/sale-02.png"></a>				
					</li>	
				</div>					
				<!-- <li><a href="<%= request.getContextPath() %>/information.jsp">
					<img style=" vertical-align: middle; text-decoration: none;"
						src="<%= request.getContextPath() %>/images/information.png"></a>
				</li> -->
				<!--<li><img style="width: 35px; vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/search-01.png">
						</li>  -->
				<span style="float: right">	
				<%if(member==null){//未登入 %>
				<div id="memberDetail"></div> 
				
				<li><a href="javascript:login()">
						<img style="width: 30px; vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/member.png"></a>
				</li>
				<div id="registermemberDetail"></div>
				<!-- <li><a href="javascript:register()">
					<img style="width: 35px; vertical-align: middle; text-decoration: none;" 
						src="<%= request.getContextPath() %>/images/register.png"></a>
				</li> -->
				<%}else{ //已登入%>
				<li>
					<img  id="toggle" style="width: 30px; vertical-align: middle; text-decoration: none;"
						src="<%= request.getContextPath() %>/images/member.png"></a>
				</li>
				
				<%} %>
				</span>
				
				<span style="float: right ;color:#FF0088; font-weight: bold;">
					<a href="<%= request.getContextPath() %>/member/cart.jsp">
						<img style="width: 30px; vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/cart.png">
						<span id="cartTotalQuantity" style="font-weight: bold; color:#FF0088">
							<%= cart!=null && cart.getTotalQuantity()>0?cart.getTotalQuantity():"" %>
					</a>
					<%=member!=null?"Hi,"+member.getName():"" %>
					<li>
						<form id="search" action="<%= request.getContextPath() %>/product_list.jsp">
							<input class="search1 searchcol" type="search" name="keyword" value="<%=keyword %>">
							<input class="search1 searchbutton" type="image" src="<%= request.getContextPath() %>/images/search-02.png" >
						</form>
					</li>										
				</span>
								
			</ul>
			<div id= "memberSetOuter" class="memberSetOuter">	
				<div id="memberSet">
					<p><a href="<%= request.getContextPath() %>/logout.do">
						<img style="width: 60px; vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/logout-03.png"></a></p>
					<p><a href="<%= request.getContextPath() %>/member/update.jsp">
						<img style="width: 100px; vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/updatemember-02.png"></a></p>
					<p><a href="<%= request.getContextPath() %>/member/orders_history.jsp">
						<img style="width: 100px; vertical-align: middle; text-decoration: none;"
							src="<%= request.getContextPath() %>/images/ordershistory-02.png"></a></p>
				</div>
			</div>
		</div>