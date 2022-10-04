<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
div.lineA{
	height : 100px;
	border : 1px solid gray;
	float : left;
	position : relative;
	left : 100px;
	margin: 5px;
	padding: 5px;
}
div#banner{
	width : 650px;
	padding: 0;
}
div#banner img {
	margin: 0;
	padding: 0;
	width: 650px;
	height: 110px;
}
div#loginBox {
	width: 274px;
	font-size: 9pt;
	text-align: left;
	padding-left: 20px;
}
div#loginBox button {
	width: 250px;
	height: 35px;
	background-color: navy;
	color: white;
	margin-top: 10px;
	margin-bottom: 15px;
	font-size: 14pt;
	font-weight: bold;
}
section {
	position: relative;
	left: 100px;
}
section>div {
	width: 360px;
	background: #ccffff;
}
section div table {
	width: 350px;
	background: white;
}
</style>
<script type="text/javascript">
//자동 실행이 되게 하려면
//jquery(document.ready(function(){})); => 줄임말로 표현함
function mvNameCardPage(){
	location.href = "namecardPage.do";
}

function mvEnrollPage(){
	location.href = "enrollPage.do";
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<div>
<button type="button" id="nameCardPage" onclick="mvNameCardPage();">명함으로 회원가입</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button type="button" id="mvEnrollPage" onclick="mvEnrollPage();">일반 회원가입</button>
</div>
<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>