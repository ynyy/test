<%@ page language="java" pageEncoding="UTF-8"   contentType="text/html; charset=UTF-8" %>
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
<title>JP Interactive Class | Reuse MCQ</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- modi -->

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

<link href="<%=path%>/css/theme.css" rel='stylesheet' type='text/css' />

<link rel="stylesheet" type="text/css"
	href="<%=path%>/themes/default/css/umeditor.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript" src="<%=path%>/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=path%>/umeditor.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=path%>/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=path%>/umeditor.min.js"></script>
<script type="text/javascript" src="<%=path%>/lang/en/en.js"></script>
<!-- modi -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ueditor/lang/en/en.js"></script>
<!-- end modi -->
<script type="text/javascript">
	var timer;
	function gE(x) {
		return document.getElementById(x);
	}
	function loginOut() {
		window.location.href = "<%=path%>/user?type=teacherLogout";
	}

	function check() {
		if (gE("optionA").value == "") {
			alert("Option A cannot be empty.");
			return;
		}

		if (gE("optionB").value == "") {
			alert("Option B cannot be empty.");
			return;
		}

		if (gE("optionC").value == "") {
			alert("Option C cannot be empty.");
			return;
		}

		if (gE("optionD").value == "") {
			alert("Option D cannot be empty.");
			return;
		}


		var ed = UE.getEditor('myEditor');

	
		var opA=gE("optionA").value;
		var opB=gE("optionB").value;
		var opC=gE("optionC").value;
		var opD=gE("optionD").value;
	//	var url="${url}";
		//String url4use=(String)(url);
	//	alert("url:"+url);
		
		$.ajax({
			async : false,
			cache : true,
			type : 'POST',
			url : "<%=path%>/quiz?type=mcqUpdate&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}&mcqID=${requestScope.mcqID}",
			data : {
				optionA : opA,
				optionB : opB,
				optionC : opC,
				optionD : opD,
				mcqTitle : ed.getContent(),
				mcqAnswer : encodeURI(encodeURI(gE("mcqAnswer").value)),
			//	url: "${url}"
			//		alert("${url}");
			},
			error : function() { //请求失败处理函数  
				alert('Ajax return error. ');

			},
			success : function(data) { //请求成功后处理函数。
				window.location.href="<%=path%>/quiz?type=teacherQuizDetail&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}&classID=${requestScope.classID}"; 
				alert('Edit MCQ success!');
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
					<li class="sub-menu"><a
						href="<%=path%>/quiz?type=teacherQuizDetail&classID=${requestScope.classID}&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}">
							<i class="icon_question"></i> <span>Return Quiz</span>
					</a></li>
					<li class="sub-menu"><a href="<%=path%>/page/myinfo.jsp">
							<i class="icon_document_alt"></i> <span>Self Information</span>
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
						<h3 class="page-header" style="color:black;">
							<i class="fa fa-list-alt"></i> Mcq Reusing
						</h3>
					</div>
				</div>

				<div class="cont span_2_of_3">
					<div class="labout span_1_of_a1">
						<form action="uploadimage" method="post">
							<h4 class="page-header" style="color:black; font-weight:bold;">
								Question Content</h4>

							<script type="text/plain" id="myEditor"
								style="width:600px; height:200px;"><p>${mcq_title}</p></script>
						</form>
						<script type="text/javascript">
						
							// UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
						
							UE.getEditor('myEditor', {
								//选择自己需要的工具按钮名称
								toolbars : [ [ 'FullScreen', 'insertimage', 'Undo', 'Redo', 'test', 'spechars' ] ],
								//focus时自动清空初始化时的内容
								autoClearinitialContent : true,
								//关闭字数统计
								wordCount : false,
								//关闭elementPath
								elementPathEnabled : false,
								//默认的编辑区域高度
								initialFrameHeight : 300,
								entertag:'br',
							//更多其他参数，请参考ueditor.config.js中的配置项
							});
							/* UE.Editor.prototype.getActionUrl = function(action) {
							//这里很重要，很重要，很重要，要和配置中的imageActionName值一样
							if (action == 'quiz_servlet') {
							//这里调用后端我们写的图片上传接口
							return 'http://localhost:8080/jplecture/quiz_servlet';
							}else{
							return this._bkGetActionUrl.call(this, action);
							}
							} */
						</script>

						<div></div>
						<form action="" method="post">
							<br /> 
							<B>Option A : </B> <input type="text/javascript"
								class="form-control" style="width:600px;" id="optionA"
								name="optionA" value="${mcq_optionA}" /> <br /> 
							<B>Option B : </B> <input type="text/javascript" class="form-control"
								style="width:600px;" id="optionB" name="optionB"
								placeholder="Enter option B here" value="${mcq_optionB}" /> <br />
							<B>Option C : </B> <input type="text/javascript"
								class="form-control" style="width:600px;" id="optionC"
								name="optionC" placeholder="Enter option C here"
								value="${mcq_optionC}" /> <br /> 
							<B>Option D : </B> <input
								type="text/javascript" class="form-control" style="width:600px;"
								id="optionD" name="optionD" placeholder="Enter option D here"
								value="${mcq_optionD}" /> <br /> <B>Answer : </B> <br /> <select
								class="form-control" id="mcqAnswer" name="mcqAnswer"
								style="width:80px; height:30px;">
								<option value="A">A</option>
								<option value="B">B</option>
								<option value="C">C</option>
								<option value="D">D</option>
							</select> <br /> <br />
							<%-- <button
								style=" background-color: #003D79;  font-size: 15px; color: #FFFFFF;"
								type="button" class="btn btn-primary"
								onclick="window.location.href='<%=path%>/quiz?type=reuseEditing&mcqID=${requestScope.mcqID}&quizID=${requestScope.quizID}&attemptID=${requestScope.attemptID}'">Confirm
								to Add</button> --%>
								
							   <button
								style=" background-color: #003D79;  font-size: 15px; color: #FFFFFF;"
								type="button" class="btn btn-primary"
								onclick="check()">Confirm
								to Add</button>	
								
							<br /> <br />
					</div>
				</div>
				</form>
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

	<!-- 		<script type="text/javascript">
		    //实例化编辑器
		    var um = UM.getEditor('myEditor');  
	    </script> -->

	<script type="text/javascript">
		$("#mcqAnswer option[value='A']").removeAttr("selected");
		
		$("#mcqAnswer option[value='${mcq_answer}']").attr("selected", "selected")
	</script>


</body>
</html>
