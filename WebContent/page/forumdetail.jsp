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
		<title>JP Interactive Class | Class Forum</title>
		
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
	    
		<%-- 背景为白色
		<link href="<%=path%>/css/bootstrap.css" rel='stylesheet' type='text/css' /> 
		--%>
		<link href="<%=path%>/css/theme.css" rel='stylesheet' type='text/css' />
		
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
		<script type="text/javascript" src="<%=path%>/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
		
		<script type="text/javascript">
	            var timer;
	            function gE(x){ return document.getElementById(x);} 
	            function loginOut(){window.location.href="<%=path%>/user?type=teacherLogout";}
			
			    $(document).ready(function(){
	                init1();
	                if (timer == undefined){
	                   timer = window.setInterval(init1,1000);
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
			                	     $("#result").append("<h4 class=\"m_3\"><font size=\"3px\" face=\"Segoe UI Semilight\" color=\"black\">"+obj[i].createTime +"</h4>");
			                	     $("#result").append("<h4 class=\"m_3\"><font size=\"5px\" face=\"Segoe UI Semilight\"  color=\"black\" >" + obj[i].msgContent + "</h4>");
				                     $("#result").append("<br>");
			                   }        		  	            
			  	         }  
		  	        });	
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
		                <li class="sub-menu">
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
		                	<h3 class="page-header"><i class="fa fa-envelope-o"></i> Lecture ${requestScope.classID} Forum</h3>                 					  
		                </div>
		            </div>
		            <br>
						
					<div style="padding:20px 50px 20px; background-color: #FFFFFF" id="result"></div>

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
		
		<!-- custom form validation script for this page-->
		<script src="/js/form-validation-script.js"></script>
		<!-- custome script for all page-->
		<script src="/js/scripts.js"></script>

	</body>
</html>