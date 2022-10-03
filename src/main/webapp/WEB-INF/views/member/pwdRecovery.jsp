<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<h1>비밀번호 찾기</h1>
<form action="findPwd.do" method="post">
회원님의 아이디를 입력하세요.<br>
<label>아이디 : <input type="text" name="userid"></label><br>
회원님의 이메일 주소를 입력하세요.<br>
<label>이메일 : <input type="email" name="email"></label><p>
<input type="submit" value="비밀번호 찾기 ">
</form>
<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/main.do'">홈으로 이동</button>
</body>
</html>