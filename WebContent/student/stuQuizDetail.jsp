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
<title>JP Interactive Class | Quiz Detail</title>
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/s1.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script>
function closewindow(){
    if (confirm("Are you sure to exit?")) {  
        window.opener = null;  
        window.open('', '_self');  
        window.close()  
    } else {
    }  
}

$(function(){
	$("#chartRoomBtn").click(function(){
		window.location.href="<%=path%>/room?classID=" + $("#classID").val();
		})
	})
</script>

<script language="javascript">
    function checkForm() {  //用来检查是否勾选了所有题目
        var ipts = document.getElementById('tableid').getElementsByTagName('input'), checked = 0, notchecked = 0;
        for(var i=0;i<ipts.length;i++)
            if (ipts[i].type == 'radio') {
                ipts[i].checked ? checked++ : notchecked++;
            }
	        if (checked!=((i-1)/4)){
	        	alert('You still have ' + (((i-1)/4)-checked)+' MCQs to finish the quiz!');
	        	return false;
	        }
    }
</script>
<script>
    function checkChecked() {  //用来检查是否勾选了所有题目
        var ipts = document.getElementById('tableid').getElementsByTagName('input'), checked = 0, notchecked = 0;
        for(var i=0;i<ipts.length;i++)
            if (ipts[i].type == 'radio') {
                ipts[i].checked ? checked++ : notchecked++;
                //checked=checked/4;
                //notchecked=notchecked/4;
            }
      //  alert('已勾选：' + checked);
      //  alert('You still have' + (((i-1)/4)-checked)+'question to finish the MCQ!');
      // alert(i-1);
        if (checked!=((i-2)/4)){
        	alert('You still have ' + (((i-2)/4)-checked)+' questions to finish the MCQ!');
        	return false;}
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


	<!--Content-->
	<div class="mdlist">
		<form action="<%=path%>/quiz?type=answerAdd" name="" id="tableid" method="post">
			<input type="hidden" id="attemptID" name="attemptID" value="${requestScope.attemptID}">
			<input type="hidden" id="quizID" name="quizID" value="${requestScope.quizID}">
			<ul>
				<li style="font-size:24px"><strong>You are in the quiz: ${requestScope.attemptID}</strong></li>
				<c:forEach items="${sessionScope.mcqContentList}" varStatus="sta" var="mcq">
					<li >
			
					
					</style-->
						<p class="name" >${sta.index+1}.${mcq.mcqTitle}</p>
						<p class="dizhi">
						<c:if test="${mcq.url!= null}">
   							<img  src=${mcq.url} height="90%" width="90%"><br/>
						</c:if>
							
							 <input type="radio" name="${mcq.mcqID}" value="A" style="border: 0" /><label for='opa'>  A: ${mcq.optionA}</label><br/> 
							 <input type="radio" name="${mcq.mcqID}" value="B" style="border: 0" /><label for='opb'>  B: ${mcq.optionB}</label><br/> 
							 <input type="radio" name="${mcq.mcqID}" value="C" style="border: 0" /><label for='opc'>  C: ${mcq.optionC}</label><br/> 
							 <input type="radio" name="${mcq.mcqID}" value="D" style="border: 0" /><label for='opd'>  D: ${mcq.optionD}</label><br/>
						
							
						</p>
					</li>
				</c:forEach>
				<li>
					<div align="center" class="tijiao">
						<button type="submit" style="width: 300px; display: inline-block;" onclick="return checkChecked()" class="tjbtn">Submit</button>
					</div>
				</li>
			</ul>
		</form>
	</div>
	<div align="center" class="tijiao">
		<!-- button id="chartRoomBtn" style="width: 300px; display: inline-block;" class="tjbtn">ChatRoom</button-->
	</div>
</body>
</html>
