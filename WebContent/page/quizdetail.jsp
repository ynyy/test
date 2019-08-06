<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="java.text.SimpleDateFormat" />
<jsp:directive.page import="java.util.Date" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
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
<title>JP Interactive Class | Quiz Detail</title>

<!-- Bootstrap CSS -->
<link href="<%=path%>/css/bootstrap.min.css" rel='stylesheet' />
<!-- Bootstrap theme -->
<link href="<%=path%>/css/bootstrap-theme.css" rel='stylesheet' />
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

<link rel="stylesheet" type="text/css"
	href="<%=path %>/themes/default/css/umeditor.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--图片显示路径 --><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=path %>/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=path %>/umeditor.min.js"></script>
<script type="text/javascript" src="<%=path %>/lang/zh-cn/zh-cn.js"></script>

<!--Echart script-->
<%-- <script type="text/javascript" src="<%=path %>/js/dist/echarts.js"
	charset="UTF-8"></script>
 --%>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>

<script type="text/javascript">
function delConfirm(){ var i=window.confirm("Are you sure to delete the mcq?");  return i;} 
</script>

<script type="text/javascript">
	            var timer;
	            function gE(x){ return document.getElementById(x);} 
	            function loginOut(){window.location.href="<%=path%>/user?type=teacherLogout";}
			
			    $(document).ready(function(){
	                init1();
	                if (timer == undefined){
	                  timer = window.setInterval(init1,30000); 
	                }
	            }); 
			  
			    function init1(){
			    	var _scrollTop = $(document).scrollTop();
		             $.ajax({  
			  	         async :false,  
			  	         cache:true,  
			  	         type: 'POST',  
			  	         url: "<%=path%>/quiz?type=mcqResultJson&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}",//请求的action路径  
			  	         error: function () {//请求失败处理函数  
			  	             alert('Return error.');  
			  	             //jQuery('#registeruserDiv').hideLoading();	
			  	         },  
			  	         success:function(data){ //请求成功后处理函数。    
			  	             var obj= eval('(' + data + ')');
			  	               //$("#result").empty("");  //#result为获取id为result的标签
			  	             var html = '';
			  	           	 
		  	            	 for (var i = 0; i < obj.length; i++){
		  	            		 var key=obj[i].url;
			              //       html = html + ("<h3 class=\"m_3\"><font face=\"Calibri\" color=\"#003D79\">Result histogram:</h3>");
			                     html = html + ("<h3 class=\"m_3\"><font face=\"Calibri\" color=\"#003D79\">Question " + (i+1) + "  : " + "</h3>");
			                     html = html + ("<a href=\"<%=path%>/quiz?type=mcqDelFromQuiz&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}&mcqID="+obj[i].mcqID+"\" onclick=\"return delConfirm();\"> <span class=\"badge bg-primary\">Delete MCQ</span></a>");
			                     html = html + ("<a href=\"<%=path%>/quiz?type=mcqEdit&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}&mcqID="+obj[i].mcqID+"\" > <span class=\"badge bg-primary\">Edit MCQ</span></a>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"5px\" face=\"Segoe UI Semilight\"  color=\"black\">"+obj[i].mcqTitle+"</h4>");
			                     if(key!="null"){
			                     html = html + ("<div><img src="+obj[i].url+"></div>"); }
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"black\">Option A: "+obj[i].optionA+"  ("+obj[i].cntOfOptionA+" times)"+"</h4>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"black\">Option B: "+obj[i].optionB+"  ("+obj[i].cntOfOptionB+" times)"+"</h4>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"black\">Option C: "+obj[i].optionC+"  ("+obj[i].cntOfOptionC+" times)"+"</h4>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"black\">Option D: "+obj[i].optionD+"  ("+obj[i].cntOfOptionD+" times)"+"</h4>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"blue\">Correct option: "+obj[i].crtAnswer+"</h4>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"blue\">Total answer count: "+obj[i].totalTimes+"</h4>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"blue\">Correct answer count: "+obj[i].correctTimes+"</h4>");
			                     html = html + ("<h4 class=\"m_3\"><font size=\"4px\" face=\"Segoe UI Semilight\" color=\"blue\">Correct rate: "+obj[i].correctRatio+"</h4>");
			                     html = html + ("<h3 class=\"m_3\"><font face=\"Calibri\" color=\"#003D79\">Result histogram:</h3>");
			                     html = html + ("<div style=\"background-color: #FFFFFF; width:40%; height:300px; \" id=\"histogram" +i+"\"></div>");
			                     html = html +("</br>");
		                   } 
		                   $("#result").html(html);  
			                  
			                for (var i = 0; i < obj.length; i++){
			                	  var array = new Array();
		                	    array.push(obj[i].cntOfOptionA);  
			         	        array.push(obj[i].cntOfOptionB); 
			         	        array.push(obj[i].cntOfOptionC); 
			         	        array.push(obj[i].cntOfOptionD); 
			                    adddata(i,array);
			                 } 
				              $(document).scrollTop(_scrollTop);
			  	         }  
		  	        });	
	           } 
			
			    function addElementDiv(obj){
			    	var parent = document.getElementById(obj);
			    	var child = document.createElement("histogram");
			    	//child.setAttribute("id","newDiv");
			    	div.innerHTML = ("Histogram for the mcq");
			    	parent.appendChild(child);
			    }
			 		    
				function deleteMcq(){
				    $.ajax({  
		  	        async :false,  
		  	        cache:true,  
		  	        type: 'POST',  
		  	        url: "<%=path%>/timu?type=timuDel&classID=${requestScope.classID}",
		  	        error: function () { //请求失败处理函数  
		  	            alert('Return error.');  
		  	            //jQuery('#registeruserDiv').hideLoading();	
		  	        },  
		  	        success:function(data){ //请求成功后处理函数。    
		                 if(data.indexOf("success")>=0){
		                     alert("Delete MCQ succeed!");
		                     window.location.reload();
		                 }else{
		                    alert(data);
		                 }
		  	        }  
		  	        });	
				}  
			

		    /* E-chart configuration ends */
		    //new  E-chart  start 
		    

		    
		    
    	</script>
</head>

<body>

	<!-- container section start -->
	<section id="container">
		<!--header start-->
		<header class="header dark-bg">
			<div class="toggle-nav">
				<div class="icon-reorder tooltips"
					data-original-title="Toggle Navigation" data-placement="bottom"></div>
			</div>

			<!--logo start-->
			<a href="<%=path%>/module?type=mylecture" class="logo">JP <span
				class="lite">Interact</span></a>
			<!--logo end-->


		</header>
		<!--header end-->

		<!--sidebar start-->
		<aside>
			<div id="sidebar" class="nav-collapse ">
				<!-- sidebar menu start-->
				<ul class="sidebar-menu">
					<li class="sub-menu"><a href="<%=path%>/module?type=mylecture">
							<i class="icon_house_alt"></i> <span>My Lectures</span>
					</a></li>
					<li class="sub-menu"><a href="<%=path%>/quiz?type=myquiz">
							<i class="icon_question"></i> <span>My Quizzes</span>
					</a></li>
					<li class="sub-menu"><a href="<%=path%>/page/myinfo.jsp">
							<i class="icon_document_alt"></i> <span>Change Password</span>
					</a></li>
					<li class="sub-menu"><a href="javascript:void(0)"
						onclick="loginOut()"> <i class="icon_star_alt"></i> <span>Log
								out</span>
					</a></li>
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
						<h3 class="page-header">
							<i class="fa fa-list-alt"></i> Current Attempt
							ID：${requestScope.attemptID}
						</h3>
						<button class="btn btn-primary" type="button"
							style="background-color:#003D79; color:#FFFFFF"
							onclick="window.location.href='<%=path%>/quiz?type=enterAddMcq&classID=${requestScope.classID}&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}'">Add
							New MCQ</button>
							<button class="btn btn-primary" type="button"
							style="background-color:#003D79; color:#FFFFFF"
							onclick="window.location.href='<%=path%>/quiz?type=enterMcqBank&classID=${requestScope.classID}&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}'">View MCQ bank</button>
					</div>
				</div>

				<br>

				<!-- <!-- 此标签存放mcq题目及result -->
				<div style="padding:20px 50px 20px; background-color: #FFFFFF"
					id="result"></div>
				<!-- <div id="histogram"></div> -->
				
				 <div id="containers" style="height: 100%"></div>

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
	
	<script type="text/javascript">
	function adddata(i,array){
		 console.log("array--->"+array);
		var app = {};
		app.title = 'histogram';
		var option = {
				color: ['#3398DB'],
				tooltip : {
				    trigger: 'axis',
				    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				        type : 'shadow'        // 可选为：'line' | 'shadow'
				    }
				},
				grid: {
				    left: '3%',
				    right: '4%',
				    bottom: '3%',
				    containLabel: true
				},
				xAxis : [
				    {
				        type : 'category',
				        data : ['A', 'B', 'C', 'D'],
				        axisTick: {
				            alignWithLabel: true
				        }
				    }
				],
				yAxis : [
				    {
				        type : 'value'
				    }
				],
				series : [
				    {
				        name:'number of students',
				        type:'bar',
				        barWidth: '60%',
				        data:array
				      /*   data:[10, 52, 200, 334] */
				    }
				]
				};
		var dom = document.getElementById("histogram"+i);
		var myChart = echarts.init(dom);
		myChart.setOption(option, true);
	}
	</script>
	
	

</body>
  





</html>