<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<h2 align="center">새 공지글 등록 페이지</h2>
<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
	반드시 enctype 속성을 form 태그에 추가해야 됨
	enctype = "multipart/form-data" 값을 지정해야 함
	method ="post" 로 지정해야 함
 -->
<form action="ninsert.do" method="post" enctype="multipart/form-data">
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td><input type="text" name="noticetitle"></td></tr>
	<tr><th>작성자</th><td><input type="text" name="noticewriter" readonly value="${ sessionScope.loginMember.userid }"></td></tr>
	<tr><th>첨부파일</th><td><input type="file" name="upfile"></td></tr>
	<tr><th>내 용</th><td><textarea rows="5" cols="50" name="noticecontent"></textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="등록하기"> &nbsp;
      	<input type="reset" value="작성취소"> &nbsp;
		<button onclick="javascript:history.go(-1)">목록</button>
	</th></tr>

</table>
</form>

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</form>
</body>
</html>