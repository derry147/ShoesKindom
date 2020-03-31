<%@page import="java.time.LocalDate"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>鞋二帝國</title>		
		<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  		<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
		<jsp:include page="/subviews/header.jsp" />
		<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
 		<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>
		 <script type="text/javascript" src="slick/slick.min.js"></script>
		
		<meta name= "viewport" content="widtg=device-width, initial-scale=1.0">
		<style>
			body{
				margin: 0;
				background: #F9F7F7;
				width:100%;
				margin:0
			}			
			.div1,.div2{
				background: #F9F7F7;			
			}
			
			.div2{
				width:100%;		
			}
			.outer{
				width: 100%;
				margin-left:auto;
			}
			#icon{
				z-index:3;
				width:30px;
				position:fixed;
				bottom: 10px;
				left: 5px;
			}
			#icon img{
				width:100%;
				height:auto;
				margin-top: 20px;
			}
			
			.slick-next {
  				right: 20px;
  			}  
  			.slick-prev {
  				left:20px;
  				z-index: 99;
  			}
  			.footer{ width:100%; height:200px;}
  			#icon img:hover{
				transform: scale(1.5,1.2);	
			}
			
			.inner{
				
			}
			.row0 div{
				
				width:400px;
				flex-grow: 1;
				flex-shrink: 0;
			}
			.row0 div img{
				width: 80%;
				margin: 10px;
				padding-top: 10px;
			}
			.row0{
				display: flex;
				flex-direction:row; 
				position: relative;top:0 ;left: 40px; 
			}
		</style>
		
	</head>
	<body>
		
		<div class="outer">			
			<div class="div1">
				<ul id="icon">
					<img src="images/fbicon-04.png"><br><br>
					<img src="images/twittericon-04.png"><br><br>
					<img src="images/igicon-04.png"><br><br>
					<img src="images/lineicon-04.png">
				</ul>
			</div>
			<div class="div2">
				<div style="width: 100%;"class="turn">
					<img src="<%=request.getContextPath() %>/images/vans banner without icon-06.jpg">
					<img src="<%=request.getContextPath() %>/images/jordan banner -05.jpg">
					<img src="<%=request.getContextPath() %>/images/adidas banner-06.jpg">
					<img src="<%=request.getContextPath() %>/images/kidbanner.jpg">
				</div>
			</div>
			<div class="inner">
				<div class="row0 row1">
					<div><img src="images/nike-04.jpg"></div>
					<div><img src="images/men-04.jpg"></div>
					<div><img src="images/adidas-04.jpg"></div>
				</div>
				<div class="row0 row2">
					<div><img src="images/women-04.jpg"></div>
					<div><img src="images/jordan-04.jpg"></div>
					<div><img src="images/kids-04.jpg"></div>
				</div>
				<div class="row0 row3">
					<div><img src="images/converse-04.jpg"></div>
					<div><img src="images/sale-04.jpg"></div>
					<div><img src="images/vans-04.jpg"></div>
				</div>
			</div>
			
		</div>
		
	</body>
	
	<script type="text/javascript">
    $(document).ready(function(){
      $(".turn").slick({
       	
      });
    });
  </script>
</html>
<%@include file="/subviews/footer.jsp" %>