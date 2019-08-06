<%@ page contentType="text/html" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %> 
<%@ page import="com.orm.Tuser"%>
<jsp:directive.page import="java.text.SimpleDateFormat"/>
<jsp:directive.page import="java.util.Date"/>

<%
String path = request.getContextPath();
Tuser user=null;
if((Tuser)request.getSession().getAttribute("user")!=null){
	user=(Tuser)request.getSession().getAttribute("user");}
%>

<!DOCTYPE HTML>
<html lang="en">
	<head>
		<title>JP Interactive Class | Login</title>
		
		<!-- Bootstrap CSS -->
		<link href="<%=path%>/css/bootstrap.min.css" rel='stylesheet'/>
		<!-- Bootstrap theme -->
		<link href="<%=path%>/css/bootstrap-theme.css" rel='stylesheet'/>
		
	    <!-- font icon -->
	    <link href="<%=path%>/css/elegant-icons-style.css" rel="stylesheet" />
	    <link href="<%=path%>/css/font-awesome.css" rel="stylesheet" />
	    <!-- Custom styles -->
	    <link href="<%=path%>/css/style.css" rel="stylesheet">
	    <link href="<%=path%>/css/style-responsive.css" rel="stylesheet" />
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="application/x-javascript"> 
			addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); 
			function hideURLbar(){ window.scrollTo(0,1); }
        </script>
        
		<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
	</head>
	
	<body class="login-img3-body">
		<div class="container">
			<form class="login-form" action="<%=path%>/user?type=teacherLogin" method="post">
        		<div class="login-wrap">
		            <p class="login-img"><i class="icon_lock_alt"></i></p>
		            <div class="input-group">
		                <span class="input-group-addon"><i class="icon_profile"></i></span>
		                <input type="text" name="loginName" id="loginName" class="form-control" placeholder="Username" autofocus>
		            </div>
		            <div class="input-group">
		                <span class="input-group-addon"><i class="icon_key_alt"></i></span>
		                <input type="password" name="loginPw" id="loginPw" class="form-control" placeholder="Password" autofocus>
		            </div>
		            <label class="checkbox">
		                <input type="checkbox" value="remember-me"> Remember me
		            </label>
		            <button class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
		     	</div>
		     </form>
		</div>
	</body>
	
</html>	