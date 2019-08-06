<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MCQ Title</title>
<script type="text/javascript"src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script> 
<script type="text/javascript"src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script> 
</head>
<body>
<h1>UEditor--MCQ Title</h1>

<!--style给定宽度可以影响编辑器的最终宽度-->
<script type="text/plain" id="myEditor">
<p>Insert your MCQ Title here</p>
</script>
<script type="text/javascript">
// UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;

UE.getEditor('myEditor',{
//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
toolbars:[['FullScreen','simpleupload','insertimage', 'insertcode','Undo', 'Redo','test','spechars','fontsize']],
//focus时自动清空初始化时的内容
autoClearinitialContent:true,
//关闭字数统计
wordCount:false,
//关闭elementPath
elementPathEnabled:false,
//默认的编辑区域高度
initialFrameHeight:300
//更多其他参数，请参考ueditor.config.js中的配置项
});
/* UE.Editor.prototype.getActionUrl = function(action) {
//这里很重要，很重要，很重要，要和配置中的imageActionName值一样
if (action == 'fileUploadServlet') {
//这里调用后端我们写的图片上传接口
return 'http://localhost:8081/Test/fileUploadServlet';
}else{
return this._bkGetActionUrl.call(this, action);
}
} */


</script>

</body>

</html>