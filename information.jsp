<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/s2k.css">
    <title>客戶服務</title>    
    <script src="../jquery.js"></script>
    <script>
    var geo = undefined;
    
    $(document).ready(init);
    function init(){
        //判斷是否支援Geo Location
        if(geo = getGeoLocation()){
            $("#title").text("Geolocation is supported.");
            /*write code here*/
            //geo.getCurrentPosition(showCoords);
            geo.watchPosition(showCoords, errorHandler);

        }else{
            $("#title").text("Geolocation is not supported.");
        }
        
        $("#myBtn").click(mapHandler);
    }
    function mapHandler(){
    	var address = $("#myText").val();
    	$("#myIframe").attr("src","https://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q="+address+"&z=16&output=embed&t=");
    }
    
    function getGeoLocation()
    {
        if(navigator.geolocation){
            return navigator.geolocation;
        }else{
            return undefined;
        }
    }
    
    function showCoords(e){
        var lat = e.coords.latitude;
        var lon = e.coords.longitude;
        $("#latitude").text(lat.toString());
        $("#longitude").text(lon.toString());
        $("#myIframe").attr("src","https://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q="+lat+","+lon+"&z=16&output=embed&t=");
    }
    
    function errorHandler(error){
    	switch(error.code){
		case error.TIMEOUT:
			alert("TIMEOUT");
			break;
		case error.POSITION_UNAVAILABLE:
			alert("POSITION_UNAVAILABLE");
			break;
		case error.PERMISSION_DENIED:
			alert("PERMISSION_DENIED");
    	}
    }
    </script>
    <style type="text/css">
    	
    	body{    		
    		color:white;   
    		background-image: url(<%= request.getContextPath()%>/images/background.jpg);
    	} 		
    	#info{
    		position: relative;top:180px;
    		width:100%;
    		text-align:center;
    	}	
    	
    	form{
    	
    	}
    	#form{}
    	.mailus{background: #FA8072;width:140px; height:30px;font-weight: bold;border-radius: 10px;
    	 border:1px solid black}
    	 
    	.fbus{background: #4169E1;}
    	.igus{background: #D87093;}
    	
    	#myText{width:500px}    
    	#qa details{
    		margin:30px;    		
    		position:relative;left:26%;
    		border:0.5px solid white;
    		border-radius: 10px;
    		width:900px;
    		height:30px;
    		font-weight: bold;
    		background:#696969;
    		color:white;
    		text-align:left;
    	}	
    	p{background:	darkslategray;}
    	

    </style>
</head>

<body>
<jsp:include page="/subviews/header.jsp" >
	<jsp:param value="man" name="subtitle"/>
</jsp:include>
<div id="info">
	<div id="qa">
		 <details>
		  <summary>Q：Shoes2Kindom是否有實體店面可以試用及購買商品?</summary>
		  <p>A：目前我們僅在桃園有實體店面，您可以與我們聯繫詢問您想看貨的商品是否有展示品，避免您多跑一趟。</p>
		 </details>
		 <details>
		  <summary>Q：網路商店與實體店鋪的價格是否相同？</summary>
		  <p>A：價格將與實體店鋪相同。惟舉辦特別促銷活動時，網路商店會針對特定商品進行特價販售，敬請諒解。</p>
		 </details>
		 <details>
		  <summary>Q：如何獲得【Shoes2Kindom】網路商店最新活動及商品訊息？</summary>
		  <p>A：歡迎您於本網站訂閱【ABC-MART】電子報，除定期提供您最新活動以及商品訊息外，亦會不定期舉辦各種電子報會員專屬優惠。</p>
		 </details>
		 <details>
		  <summary>Q：可以直接從台灣【Shoes2Kindom】網路商店訂購日本【Shoes2Kindom】的商品嗎？</summary>
		  <p>A：非常抱歉，目前沒有提供訂購日本或其他地區之【Shoes2Kindom】商品的服務，煩請諒解。</p>
		 </details>
		 <details>
		  <summary>Q：哪些店鋪有販售童鞋？</summary>
		  <p>A：除網路商店之外，其他販售實體店鋪請至店鋪資訊STORE查詢。</p>
		 </details>
	</div>
	<form id="form">
		<h1 id="title">客戶服務</h1><h4>專屬電話訂購及免費遞送服務                   歡迎致電 (02) 25149191（每天: 10:00 - 21:30）</h4>
		
	    <table>    	
	        <tr>
	        	<td id="latitude"></td>
	            <td id="longitude"></td>
	        </tr>
	    </table>
	   
	    <input type="text" id="myText"><input type="button" id="myBtn" value="Map"><br><br>
	    <iframe id="myIframe" width='900' height='500' frameborder='0' scrolling='no' marginheight='0' marginwidth='0' src='https://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q=恆逸教育訓練中心&z=16&output=embed&t='></iframe>
	    
	<!--iframe width="800" height="450" src="https://www.youtube.com/embed/F5KJuZnNH1o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe-->
		<div>
		<span class= "span" style="width:100%;position:relative ;left:41%; display: flex;flex-direction: row;">
			<span class="span1">
				<h1>聯絡我們:</h1>				
					<h4>台北市復興北路99號14樓</h4>
					<h4>TEL：(02)25149191</h4>				
			</span>		
			<span class="span1">
				<h1>電郵我們:</h1>
				<h6>我們的客服代表將會盡快回覆</h6>
				<button class="mailus">請填寫您的信息</button>
			</span>
		</span>
		
	</form>	
</div>
</body>

</html>
