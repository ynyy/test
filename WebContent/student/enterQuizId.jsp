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
<title>JP Interactive Class | Enter Quiz ID</title>
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/s1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.showLoading.min.js"></script>


<script type="text/javascript">

         function gE(x){ return document.getElementById(x);} 

		 function check(){
	    	 
	    	if(gE("quizID").value.length!=6){
		        alert("Quiz ID must be 6-digit number.");
		    	return false;
		    }
		    
		   $.ajax({  
  	        async :false,  
  	        cache:true,  
  	        type: 'POST',  
  	        url: "<%=path%>/quiz?type=judgeQuizIDExist&quizID="+gE("quizID").value, /* 请求的action路径 */  
  	        error: function () { //请求失败处理函数  
  	            alert('Return error.');  
  	            //jQuery('#registeruserDiv').hideLoading();	
  	        },  
  	        success:function(data){ //请求成功后处理函数。    
                 if(data.indexOf("success")>=0){
                     window.location.href = "<%=path%>/quiz?type=studentQuizDetail&attemptID=" + gE("quizID").value;
				}else{
					alert(data);
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

	<!--Enter ClassID-->
	<div class="tit01">
		<strong>Enter Quiz ID</strong>
	</div>
	<form name="formAdd" method="post" onsubmit="return check()">
		<div class="publick_box cx">
			<p>
				<span class="quizID">QuizID：</span>
				<span class="zdtxt"> <input type="text" id="quizID" name="quizID" /></span>
			</p>

			<div class="submit">
				<button type="button" class="tjbtn" onclick="check();">Enter</button>
			</div>

		</div>
	</form>
</body>
</html>
