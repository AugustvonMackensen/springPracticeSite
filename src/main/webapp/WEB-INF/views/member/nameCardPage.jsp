<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script text="text/javascript">
function capCamera(){
	location.href = "camCamera.do";
}

function imgUpload(){
	location.href = "uploadImage.do";
}
</script>
</head>
<body>
<image id="preImage" src="" onchange="chkCard();">
<p>
<button type="button" onclick="capCamera();">카메라로 촬영</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button type="button" onclick="imgUpload();">이미지 등록</button>
<br>
</body>
</html>