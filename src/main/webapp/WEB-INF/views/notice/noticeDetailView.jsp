<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<hr>
<h2 align="center">${ requestScope.notice.noticeno } 번 공지글 상세보기</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td>${ notice.noticetitle }</td></tr>
	<tr><th>작성자</th><td>${ notice.noticewriter }</td></tr>
	<tr><th>날 짜</th><td>${ notice.noticedate }</td></tr>
	<tr><th>첨부파일</th>
		<td>
		<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
		<c:if test="${ !empty notice.original_filepath }">
			<c:url var="nfd" value="nfdown.do">
				<c:param name="ofile" value="${ notice.original_filepath }" />
				<c:param name="rfile" value="${ notice.rename_filepath }" />
			</c:url>
			<a href="${ nfd }">${ notice.original_filepath }</a>
		</c:if>
		<!-- 첨부파일이 없다면 공백으로 처리함 -->
		<c:if test="${ empty notice.original_filepath }">
			&nbsp;
		</c:if>
		</td>
	</tr>
	<tr><th>내 용</th><td>${ notice.noticecontent }</td></tr>
	<tr><th colspan="2">
		<button onclick="javascript:history.go(-1)">목록</button>
	</th></tr>

</table>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>