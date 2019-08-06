<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.orm.Tuser"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<title>JP Interactive Class | Student Forum</title>
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/s1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.showLoading.min.js"></script>

<script type="text/javascript">
		var timer;
		function gE(x){ return document.getElementById(x);} 
		
		$(document).ready(function(){
		    init1();
		    if (timer == undefined){
		       timer = window.setInterval(init1,100);
		    }
		}); 
		
		function init1(){
		
		     $.ajax({  
			         async :false,  
			         cache:true,  
			         type: 'POST',  
			         url: "<%=path%>/message?type=messageJson&classID=${requestScope.classID}",//请求的action路径  
			         error: function () {//请求失败处理函数  
			             alert('Return error.');  
			             //jQuery('#registeruserDiv').hideLoading();	
			         },  
			         success:function(data){ //请求成功后处理函数。    
			             
			               var obj= eval('(' + data + ')');   
			               	 $("#result").empty("");  //#result为获取id为result的标签
		               	   for (var i = 0; i < obj.length; i++){
		            	     $("#result").append("<p class=\"m_desc\"><font size=\"2px\" face=\"Segoe UI Semilight\" color=\"grey\">"+obj[i].createTime +"</p>");
		            	     $("#result").append("<p class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\"  color=\"black\" >" + obj[i].msgContent + "</p>");
		                   }        		  	            
			         }  
		      });	
		} 
		
		function closewindow(){
			if(confirm("Are you sure to exit?")){
				window.opener = null;
				window.open('', '_self');
				window.close()
			}else{}
		} 	            
			
		$(function(){
			$("#btn_back_class").click(function(){
				window.location.href="<%=path%>/student/enterClassId.jsp";
			})
		})	
		
		$(function(){
			$("#btn_send_chat").click(function(){
				$.ajax({
					url: "<%=path%>/message?type=stuSendMsg",
					data: {
						"classID" : ${requestScope.classID},
						"msgContent" : $("#msgContent").val()
					},
					success: function(data, status){
						if(status == "success"){
							$("#msgContent").val("");
							//$('#roomIframe').attr('src', $('#roomIframe').attr('src'));
						}
					}
				});
			});
		})		
</script>    
</head>

<body>

	<!--Top-->
	<div class="lanm">
		<a href="javascript:history.back()"></a>
		<h1>
			 <a href="<%=path%>/student/enterClassId.jsp" style="color: #FFFFFF;">[Enter Class ID]</a>&nbsp;
		     <a href="<%=path%>/student/enterQuizId.jsp" style="color: #FFFFFF;">[Enter Quiz ID]</a>&nbsp;
		     <a href="javascript:void(0)"  onclick="closewindow();" style="color: #FFFFFF;">[Exit]</a>
		</h1>
	</div>
	
	<div>	
		</br>
		<div style=" margin: auto; padding:20px 30px 20px; background-color: #FFFFFF; width: 85%" id="result"></div>
		
		<div>
			</br>
			<div><h3>&nbspWelcome to JP class forum. Please enter your question below, using ENGLISH INPUT METHOD.</h3></div>
			<form action="#" method="post">
				<table style="width: 100%; text-align: center;">
					<tr>
						<td style="padding-top: 20px;">
							<textarea rows="6" cols="197" id="msgContent" style="border-color: black; width: 95%;"></textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
							
							<input type="button" id="btn_back_class" value="Back" class="tjbtn" style="width: 150px; display: inline-block; margin-top: 20px;"/> 
							<input type="button" id="btn_send_chat" value="Send" class="tjbtn" style="width: 150px; display: inline-block; margin-top: 20px;"/> 
						</td>
					</tr>
				</table>
			</form>
			
		</div>
	</div>
</body>
</html>
