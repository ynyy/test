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
		<title>JP Interactive Class | Create quiz</title>
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
   		   
	  	        if(gE("quizname").value==""){
	  		        alert("Quiz name cannot be empty.");
	  		    	return false;
	  		    }
  		    
	  		    if(gE("classname").value==""){
	  		        alert("The quiz must affiliate an existing class.");
	  		    	return false;
	  		    }
  		    return true;
  		  }
          
          $(document).ready(function(){
              init1();
              module();
          }); 
       
          function init1(){
              $.ajax({  
	 	        async :false,  
	 	        cache:true,  
	 	        type: 'POST',  
	 	        url: "<%=path%>/module?type=classJson", //请求的action路径  
	 	        error: function() {//请求失败处理函数  
	 	            alert('Return error!');  
	 	            //jQuery('#registeruserDiv').hideLoading();	
	 	        },  
	 	        success:function(data){ //请求成功后处理函数。    
	 	             var obj= eval('('+ data + ')');   
	                  for (var i = 0; i<obj.length; i++){ 
	                    $("#classname").append("<option value='"+obj[i].classID+"'>"+obj[i].className+"</option>");
	                  }
	                 
	 	             //jQuery('#registeruserDiv').hideLoading();	
	 	        }  
 	        });	
          } 


		</script>
		<script type="text/javascript">
        function module(){
            $.ajax({  
	 	        async :false,  
	 	        cache:true,  
	 	        type: 'POST',  
	 	        url: "<%=path%>/module?type=moduleJson", //请求的action路径  
	 	        error: function () {//请求失败处理函数  
	 	            alert('Return error!');  
	 	            //jQuery('#registeruserDiv').hideLoading();	
	 	        },  
	 	        success:function(data){ //请求成功后处理函数。    
	 	             var obj= eval('('+ data + ')');   
	                  for (var i = 0; i<obj.length; i++){  
	                	//#moduleID代表获取id为moduleID的容器，此处获取的是select下拉选框
	                    $("#moduleID").append("<option value='"+obj[i].moduleID+"'>"+obj[i].modulename+"</option>");  
	                  }        
	 	             //jQuery('#registeruserDiv').hideLoading();	
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
					         <h3 class="page-header"><i class="icon_book"></i>Create New Quiz</h3>					                 
		                </div>
		            </div>
		            <br>
		            
		            <div id="left">
		            	<a href="<%=path%>/select?type=MCQ"> MCQ</a>
		            	<a href="<%=path%>/select?type=shortAnswer"> short answer</a>
		            	<a href="<%=path%>/select?type=scale"> scale</a>
		            </div>
		            <!-- Form validations start-->
		                <section class="panel" id="classInfoPanel">
		                    <header class="panel-heading">
		                     
		                    </header>
		                    <div class="panel-body">
		                        <div class="form">
		                            <form class="form-validate form-horizontal" role="form"  action="<%=path %>/quiz?type=quizAdd" method="post"  onsubmit="return check()">
		                                <div class="form-group ">
		                                <!--label的for规定label与哪一个表单元素绑定  -->
		                                    <label for="quizname" class="control-label col-lg-2">Quiz Name <span class="required">*</span></label>
		                                    <div class="col-lg-10">
		                                        <input class="form-control" id="quizname" name="quizname" placeholder="Enter the name of the new quiz" type="text" required />
		                                    </div>
		                                </div>
		                                <div class="form-group ">
		                                <!--label的for规定label与哪一个表单元素绑定  -->
		                                    <label for="classname" class="control-label col-lg-2"> Affiliated Lecture <span class="required">*</span></label>
		                                    <div class="col-lg-10">
			                                    <select class="form-control" id="classname" name="classname"></select>
		                                    </div>
		                                </div>
				                         <div class="form-group ">
		                                    <label for="moduleID" class="control-label col-lg-2">Module Name <span class="required">*</span></label>
		                                    <div class="col-lg-10">
			                                    <select class="form-control" id="moduleID" name="moduleID"></select>
		                                    </div>
		                                </div>
		                                <div class="form-group ">
		                                <!--label的for规定label与哪一个表单元素绑定  -->
		                                    <label for="comment" class="control-label col-lg-2"> Date of the Quiz <span class="required">*</span></label>
		                                    <div class="col-lg-10">
		                                        <input class="form-control" id="comment" name="comment" placeholder="Enter the date of the new quiz" type="text" required />
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <div class="col-lg-offset-2 col-lg-10">
		                                        <button class="btn btn-primary" type="submit">Create Quiz</button>
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