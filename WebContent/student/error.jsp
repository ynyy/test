<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.orm.Tuser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

java.text.SimpleDateFormat  df = new  java.text.SimpleDateFormat("yyyy-MM-dd");

%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no"/>
<title>JP Interactive Class | Alert page</title>
<link href="<%=path %>/css/main.css" rel="stylesheet" type="text/css">
<link href="<%=path %>/css/s1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path %>/js/zepto.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/banner.js"></script>
<script type="text/javascript" src="<%=path %>/js/touchslider.dev.js"></script>
<script type="text/javascript" src="<%=path %>/js/fastclick.js"></script>

<script>
function closewindow(){
    if (confirm("Are you sure to exit?")) {  
        window.opener = null;  
        window.open('', '_self');  
        window.close()  
    } else {
    }  
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

<div class="shopimg"><img src="<%=path %>/upload/unSub.jpeg" width="500" height="500"  alt=""/></div>

<div class="publick_box mdxx">
	  <br>
      	<h1 align="center">Sorry, please do not resubmit your answer!</h1>
      <br>
</div>

<%-- <div align="center" class="tijiao" >
	<input type="button" style="width:300px" class="tjbtn" value="Continue" onclick="javascript:window.location.href='<%=path%>/module?type=classAll'">
</div> --%>

</body>
</html>
