<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
body{
	margin: 50px;
}

</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
function capture(){
	location.href="capture.do";
}
</script>
</head>
<body>
<iframe src="http://127.0.0.1:5000/stream?src=0" width="640" height="360" scrolling="no"></iframe>
<button id="camCapture" name="camCapture" onclick="capture();">카메라 촬영하기</button><br>
<form action="captureEnroll.do" method="post">
<textarea id="extractedTxt" name="extractedTxt" rows="2" cols="30" readonly>${ usermail }</textarea>
</form>
</body>
</html>