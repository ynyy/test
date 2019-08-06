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
		<title>JP Interactive Class | My Classes</title>
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
        
		<script type="text/javascript">
          	function loginOut(){window.location.href="<%=path%>/user?type=teacherLogout";}
		</script>
		
		<script type="text/javascript">
			function delConfirm(){ var i=window.confirm("Are you sure to delete the lecture record?");  return i;} 
		</script>
		<script type="text/javascript">
			function enableConfirm(){ var i=window.confirm("Are you sure to enable this lecure?");  return i;} 
		</script>
		</script>
				<script type="text/javascript">
			function disableConfirm(){ var i=window.confirm("Are you sure to disable this lecture?");  return i;} 
		</script>
		<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
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
		
		       
		
		          
		
		        </div>
		    </header>
		    <!--header end-->
		
		    <!--sidebar start-->
		    <aside>
		        <div id="sidebar"  class="nav-collapse ">
		            <!-- sidebar menu start-->
		            <ul class="sidebar-menu">
		                <li class="active">
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
		               		 <%if (user!=null){%>                             
					             <h3 class="page-header"><i class="icon_genius"></i> <%=user.getLoginname()%>'s Lectures</h3>					                 
					         <%}%>          
		                </div>
		            </div>
		            <div>
		                <button class="btn btn-primary" type="button" onclick="window.location='/jplecture/page/addclass.jsp'"> Create Lecture</button>
		            </div>
		            <br>
		
		                <!--Project Activity start-->
		                <section class="panel">
		                    <div class="panel-body">
		                        <div class="row">
		                            <div class="col-lg-8 task-progress pull-left">
		                                <h1>Lectures List</h1>
		                            </div>
		                        </div>
		                    </div>
		                    <table class="table table-hover personal-task">
		                        <tbody>
			                        <!--表头开始-->
			                        <tr>
			                        	<td><span style="font-weight:bold;">Number</span></td>
			                        	<td><span style="font-weight:bold;">Lecture ID</span></td>
			                            <td><span style="font-weight:bold;">Lecture Name</span></td>
			                            <td><span style="font-weight:bold;">Module Name</span></td>
			                            <td><span style="font-weight:bold;">Date</span></td>
			                            <td><span style="font-weight:bold;">Date Created</span></td>
			                            <td><span style="font-weight:bold;">Lecture Forum Link</span></td>
			                            <td><span style="text-align:center;display:block; font-weight:bold;">Operation</span></td>
			                             <td><span style="text-align:center;display:block; font-weight:bold;">Status</span></td>
			                        </tr>
			                        <!--表头结束-->
			                        
			                        <c:forEach items="${requestScope.classList}" var="classinfo"  varStatus="number">
										<tr href="<%=path%>/message?type=teacherForumDetail&classID=${classinfo.classID}">
											<td>
				                                ${number.index+1}
				                            </td>
											<td>
				                                <span class="badge bg-important">${classinfo.classID}</span>
				                            </td>
				                            <td>
					                            <a href="<%=path%>/message?type=teacherForumDetail&classID=${classinfo.classID}">
					                            	${classinfo.className}
					                            </a>
				                            </td>
				                            <td>
				                                ${classinfo.moduleName}
				                            </td>
				                             <td>
				                                ${classinfo.comment}
				                            </td>
				                            <td>
				                                ${classinfo.classCreatetime}
				                            </td>
				                            <td>				                      
					                            <a href="<%=path%>/message?type=teacherForumDetail&classID=${classinfo.classID}">
					                            	Enter Class Forum
					                            </a>
				                            </td>
				                            <td>				                      
					                            <div style="text-align:center;display:block;">
						                            <a href="<%=path%>/module?type=classDel&classID=${classinfo.classID}" onclick="return delConfirm();">
						                            	<span class="badge bg-primary">Delete</span>
						                            </a>
					                            </div>	
					                            </div>	
					                           		<div style="text-align:center;display:block;">
						                            <a href="<%=path%>/module?type=lectureEnable&classID=${classinfo.classID}" onclick="return enableConfirm();">
						                            	<span class="badge bg-primary">Enable</span>
						                            </a>
					                           		 </div>	
					                           	<div style="text-align:center;display:block;">
						                            <a href="<%=path%>/module?type=lectureDisable&classID=${classinfo.classID}" onclick="return disableConfirm();">
						                            	<span class="badge bg-primary">Disable</span>
						                            </a>
					                            </div>
				                            </td>
				                           	<td>
				                                ${classinfo.status}
				                            </td>
				                        </tr>	
									</c:forEach>
		                        </tbody>
		                    </table>
		                    
		                </section>
		                <!--Project Activity end-->
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