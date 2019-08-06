<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<title>Welcome to the class ${className} forum.</title>
<style type="text/css">
.div_chat {
	margin: 0 auto;
	background-color: none;
	border: 1px solid #555555;
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<div id="div_chat" class="chat" >
		<table style="width: 100%;">
			<c:forEach var="msg" items="${msgList}">
				<c:if test="${msg.userIp != localIP}">
					<tr align="left">
						<td colspan="1" style="width: 54px;"><img src="<%=path%>/images/other.png" width="50" height="40" /></td>
						<td colspan="9">${msg.userIp}- ${msg.createTime}</td>
					</tr>
					<tr align="left">
						<td colspan="10" style="padding-left: 54px;">${msg.msgContent}</td>  <!-- 如果是别人发言，显示在左边，1列为头像，9列用来显示内容 -->
					</tr>
				</c:if>
				<c:if test="${msg.userIp == localIP}">
					<tr align="right">
						<td colspan="9">${msg.userIp}- ${msg.createTime}</td>
						<td colspan="1" style="width: 54px;"><img src="<%=path%>/images/local.png" width="50" height="40" /></td>
					</tr>
					<tr align="right">
						<td colspan="10" style="padding-right: 54px;">${msg.msgContent}</td> <!-- 如果是自己发言，显示在右边，9列用来显示内容 1列为头像， -->
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</div>
</body>
</html>
