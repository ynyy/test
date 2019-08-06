<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="java.text.SimpleDateFormat"/>
<jsp:directive.page import="java.util.Date"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %> 
<%@ page import="com.orm.Tuser"%>
<%
String path = request.getContextPath();
Tuser user=null;
if((Tuser)request.getSession().getAttribute("user")!=null){
	user=(Tuser)request.getSession().getAttribute("user");
}

	if(user==null){
%>
		<script type="text/javascript">
			alert("Please login first!");
			window.location.href="<%=path%>/page/login.jsp";
		</script>
    <%
		return;
	 }
	%>

<!DOCTYPE HTML>
<html>
	<head>
		<title>JP Interactive Class | Self Information</title>
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
		<script type="text/javascript" src="<%=path %>/js/popup.js"></script>
		<script type="text/javascript">
		  function gE(x){ return document.getElementById(x);} 
          function loginOut(){window.location.href="<%=path%>/user?type=teacherLogout";}
	      function check(){
		   
	        if(gE("oldpw").value==""){
		        alert("Present password cannot be empty.");
		    	return false;
		    }
		    
		    if(gE("loginpw").value==""){
		        alert("Password cannot be empty.");
		    	return false;
		    }
		    
		    if(gE("confirpw").value==""){
		        alert("Confirm password cannot be empty.");
		    	return false;
		    }
		    
		    if(gE("confirpw").value!=gE("loginpw").value){
		        alert("Passwords don't match.");
		    	return false;
		    }
		    
		    /* if(gE("fujian").value==""){
	        alert("用户头像必须上传");
	    	return false;
	    	} */
		    
		    return true;
		  }
 
		  function up(){
		        var pop=new Popup({ contentType:1,isReloadOnClose:false,width:400,height:200});
	            pop.setContent("contentUrl","<%=path %>/upload/upload.jsp");
	            pop.setContent("title","文件上传");
	            pop.build();
	            pop.show();
		  }  
        </script>
	</head>
	
	<body>
		<!-- container section start -->
		<section id="container">
		    <!--header start-->
		    <header class="header dark-bg">
		        <div class="toggle-nav">
		            <div class="icon-reorder tooltips" data-original-title="Toggle Navigation" data-placement="bottom"></div>
		        </div>
		
		        <!--logo start-->
		        <a href="<%=path%>/module?type=mylecture" class="logo">JP <span class="lite">Interact</span></a>
		        <!--logo end-->
		
		    </header>
		    <!--header end-->
		
		    <!--sidebar start-->
		    <aside>
		        <div id="sidebar"  class="nav-collapse ">
		            <!-- sidebar menu start-->
		            <ul class="sidebar-menu">
		                <li class="sub-menu">
		                    <a href="<%=path%>/module?type=mylecture">
		                        <i class="icon_house_alt"></i>
		                        <span>My Lectures</span>
		                    </a>
		                </li>
		                <li class="sub-menu">
		                    <a href="<%=path%>/quiz?type=myquiz">
		                        <i class="icon_question"></i>
		                        <span>My Quizzes</span>
		                    </a>
		                </li>
		                <li class="active">
		                    <a href="<%=path%>/page/myinfo.jsp">
		                        <i class="icon_document_alt"></i>
		                        <span>Change Password</span>
		                    </a>
		                </li>
		                <li class="sub-menu">
		                    <a href="javascript:void(0)" onclick="loginOut()">
		                        <i class="icon_star_alt"></i>
		                        <span>Log out</span>
		                    </a>
		                </li>
		            </ul>
		            <!-- sidebar menu end-->
		        </div>
		    </aside>
		    <!--sidebar end-->
		    
		    <!--main content start-->
		    <section id="main-content">
		        <section class="wrapper">
		            <br>
		            <div class="row">
		                <div class="col-lg-12">		        		               	                        
					         <h3 class="page-header"><i class="icon_box-selected"></i>Change Password</h3>					                 
		                </div>
		            </div>
		            <br>
		            
		            <!-- Form validations start-->
		                <section class="panel" id="classInfoPanel">
		                    <header class="panel-heading">
		                        Change Password
		                    </header>
		                    <div class="panel-body">
		                        <div class="form">
		                            <form class="form-validate form-horizontal" role="form"  action="<%=path%>/user?type=teacherEdit" method="post"  onsubmit="return check()">      

		                                <div class="form-group">
		                                    <label for="userNameInfo" class="control-label col-lg-2">User Name  </label>
		                                    <div class="col-lg-10">
		                                    	<!-- input type="text" class="form-control" id="loginname" name="loginname"  value="${sessionScope.user.loginname}"-->	                        
		                                    <label for="userNameInfo" class="control-label col-lg-2"> ${sessionScope.user.loginname}</label>
												</div>  
		                                </div>
		                                <div class="form-group">
		                                    <label for="oldpsw" class="control-label col-lg-2">Enter the present password <span class="required">*</span></label>
		                                    <div class="col-lg-10">
		                                    	<input type="password" class="form-control" id="oldpw" name="oldpw" value="">			            
		                                    </div>
		                                </div>
		                                		<div class="form-group">
		                                    <label for="pwdInfo" class="control-label col-lg-2">New Password <span class="required">*</span></label>
		                                    <div class="col-lg-10">
		                                    	<input type="password" class="form-control" id="loginpw" name="loginpw" value="${sessionScope.user.loginpsw}">			            
		                                    </div>
		                                </div>
		                                 <div class="form-group">
		                                    <label for="pwdConfirmInfo" class="control-label col-lg-2">Confirm Password <span class="required">*</span></label>
		                                    <div class="col-lg-10">
		                                    	<input type="password" class="form-control" id="confirpw" name="confirpw" value="${sessionScope.user.loginpsw}">
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <div class="col-lg-offset-2 col-lg-10">
		                                        <button class="btn btn-primary" type="submit">Confirm</button>
		                                    </div>
		                                </div>         
		                            </form>
		                        </div>
		                    </div>
		                </section>
		                <!-- Form validations end-->
		        </section>
		        <!--Wrapper end-->
		    </section>
		    <!--main content end-->
		</section>
		<!-- container section end -->
		
		<!-- javascripts -->
		<script src="/js/jquery.js"></script>
		<script src="/js/bootstrap.min.js"></script>
		<!-- nice scroll -->
		<script src="/js/jquery.scrollTo.min.js"></script>
		<script src="/js/jquery.nicescroll.js" type="text/javascript"></script>
		<!-- jquery validate js -->
		<script type="text/javascript" src="/js/jquery.validate.min.js"></script>
		
		<!-- custom show create class window script for this page-->
		<script src="/js/create-class-script.js"></script>
		<!-- custom form validation script for this page-->
		<script src="/js/form-validation-script.js"></script>
		<!-- custome script for all page-->
		<script src="/js/scripts.js"></script>		
		
	</body>
</html>