<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
찾으시는 아이디는 ${ requestScope.find_id }입니다.<p>
<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/main.do'">홈으로 이동</button>
</body>
</html>