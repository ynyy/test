<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Welcome to the ${className} chat room！</title>
<%
	String path = request.getContextPath(); //获得工程名
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/"; //协议+服务器+端口+路径
%>
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/s1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>  <!-- 应用ajax  -->
<style type="text/css">

body {
	margin: 0 auto;
}

.chatTitle {
	margin: 0 auto;
	text-align: center;
	height: 50px;
	line-height: 50px;
	width: 100%;
}

.iframeDiv{
	width: 100%;
}
</style>
</head>
<body>
	<div class="chatTitle">
		<h3>Welcome to the ${className} chat room</h3>
	</div>
	<div class="iframeDiv">
		<iframe id="roomIframe" src="<%=path%>/roomIframe?classID=${classID}" height="60%" width="100%" frameborder="0"></iframe>
	</div>
	<form action="#" method="post">
		<table style="width: 100%; text-align: center;">
			<tr>
				<td style="padding-top: 20px;"><textarea rows="6" cols="197" id="msgContent" style="border-color: black; width: 98%;"></textarea></td>
			</tr>
			<tr>
				<td align="center">
					<input type="button" id="btn_send_chat" value="Send" class="tjbtn" style="width: 300px; display: inline-block; margin-top: 20px;"/> 
					<input type="button" id="btn_back_class" value="Back" class="tjbtn" style="width: 300px; display: inline-block; margin-top: 20px;"/> 
				</td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
$(function(){  
    changeWH();  
    $(".chatTitle").css("width", $(document).width());
});  

function changeWH(){  
$("#roomIframe").width($(document).width());  
}  

window.onresize=function(){    
 changeWH();    

}   
//		function refresh(){                        //目前无需定时刷新
//			var xmlReq;
//			try{
//				xmlReq = new XMLHttpRequest();
//				var web = "<%=path%>/roomIframe?classID=${classID}";
//				xmlReq.open("GET", web, true);
//				xmlReq.onreadystatechange=function(){
//					if(xmlReq.readyState == 2){
//						$('#roomIframe').attr('src', $("#roomIframe").attr("src"));
//					}
//				}
//				xmlReq.send();
//			}catch(e){ 
//				alert(e)
//			}
//		}
//		setInterval("refresh()", 2000);
	$(function(){                       //不知为何删了就发不出去消息
		window.scrollTo(0,9999999) 
		$("#btn_send_chat").click(function(){
			$.ajax({
				url: "<%=path%>/message",
				data: {
					"classID" : ${classID},
					"msgContent" : $("#msgContent").val()
				},
				success: function(data, status){
					if(status == "success"){
						$("#msgContent").val("");
						$('#roomIframe').attr('src', $('#roomIframe').attr('src'));
					}
				}
			});
		});

		$("#btn_back_class").click(function(){
			window.location.href = "<%=path%>/student/enterbyclassid.jsp"
		});
	})
</script>
</html>
