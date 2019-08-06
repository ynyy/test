<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getAttribute("path").toString();
	String message = request.getAttribute("message").toString();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<script language="javascript">
    <% if(message != null) { %>
		alert("<%=message%>");
	<% } %>
	<% if(path != null) { %>
		document.location.href = "<%=path%>";
	<% } else {%>
		window.history.back();
	<% } %>
</script>
</html>
