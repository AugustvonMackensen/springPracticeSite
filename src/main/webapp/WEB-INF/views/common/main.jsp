<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연습용 사이트</title>
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
<script type="text/javascript"
src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
//자동 실행이 되게 하려면
//jquery(document.ready(function(){})); => 줄임말로 표현함
$(function(){
	/* 주기적으로 시간 간격을 두고 자동 실행되게 하려면
		자바스크립트 내장함수 setInterval(실행시킬 함수명, 시간밀리초)
		사용하면 됨
		예 : setInterval(movePage, 1000);
	*/
	//setInterval(function(){
		//console.log("setInterval() 로 자동 실행 확인.");
		
		//최근 공지글 3개 출력되게 함 : ajax 사용
		$.ajax({
			url: "ntop3.do",
			type: "post",
			dataType: "json",
			success: function(data){
				console.log("success : " + data); //Object로 출력
				
				//object => string 으로 바꿈
				var jsonStr = JSON.stringify(data);
				//string => json 객체로 바꿈
				var json = JSON.parse(jsonStr);
				
				
				//출력 문자열 준비
				var values = $("#newnotice").html("<tr><th>번호</th><th>제목</th><th>날짜</th></tr>");
				for(var i in json.list){	//인덱스 i가 자동 1씩 증가하는 루프문
					values += "<tr><td>" + json.list[i].noticeno
								+ "</td><td><a href='ndetail.do?noticeno="+ json.list[i].noticeno +"'>" 
								+ decodeURIComponent(json.list[i].noticetitle).replace(/\+/gi, " ")
								+"</a></td><td>" + json.list[i].noticedate
								+ "</td></tr>";
				} //for in
				
				$("#newnotice").html($("#newnotice").html() + values);
				
			},
			error: function(jqXHR, textStatus, errorThrown ){
				console.log("ntop3 error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
			}
		}); //ntop3do.ajax
		
		//조회수 많은 인기 게시원글 3개 조회 출력되게 함 : ajax 사용
		$.ajax({
			url: "btop3.do",
			type: "post",
			dataType: "json",
			success: function(data){
				console.log("success : " + data); //Object로 출력
				
				//object => string 으로 바꿈
				var jsonStr = JSON.stringify(data);
				//string => json 객체로 바꿈
				var json = JSON.parse(jsonStr);
				
				var bvalues = "";
				for(var i in json.list){	//인덱스 i가 자동 1씩 증가하는 루프문
					bvalues += "<tr><td>" + json.list[i].board_num
								+ "</td><td><a href='bdetail.do?board_num="+ json.list[i].board_num +"'>" 
								+ decodeURIComponent(json.list[i].board_title).replace(/\+/gi, " ")
								+"</a></td><td>" + json.list[i].board_readcount
								+ "</td></tr>";
				} //for in
				
				$("#toplist").html($("#toplist").html() + bvalues);
				
			},
			error: function(jqXHR, textStatus, errorThrown ){
				console.log("btop3 error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
			}
		});
		
		
	//}, 3000);	//3초마다 자동 실행됨

	
});

function movePage(){
	location.href = "loginPage.do";
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<center>
	<!-- 배너 이미지 표시 -->
	<div id="banner" class="lineA">
	<!-- EL 표기시 절대경로(context root에서 시작하는 경로) 표현
		context root => first/src/main/webapp 을 의미함
		webapp 에서 시작하는 경로를 절대경로라고 함
		jstl 표기 : /
		EL 표기 : ${ pageContext.servletContext.contextPath }
	 -->
		<img src="${ pageContext.servletContext.contextPath }/resources/images/photo2.jpg">
	</div>
	<!-- login 관련 영역 표시 -->
	<!-- 로그인 안 했을 때 : 세션 객체 안의 loginMember 가 없다면 -->
	<c:if test="${ empty sessionScope.loginMember }">
	<!-- if(session.getAttribute("loginMember") == null) -->
		<div id="loginBox" class="lineA">
			first 사이트 방문을 환영합니다.<br>
			<button onclick="movePage()">로그인 하세요</button><br>
			<a href="enrollPage.do">회원가입</a>
		</div>
	</c:if>
	<!-- 로그인 했을 때 : 일반회원인 경우 -->
	<c:if test="${ !empty loginMember and loginMember.admin ne 'Y' }">
	<!-- loginMember.admin == !session.getAttribute("loginMember").getAdmin.equals("Y") -->
		<div id="loginBox" class="lineA">
			${ loginMember.username }님<br>
			<button onclick="javascript:location.href='logout.do';">로그아웃</button>
			<!-- My Page 클릭시 연결대상과 전달값 지정 -->
			<c:url var="callMyinfo" value="/myinfo.do">
				<c:param name="userid" value="${ loginMember.userid }" />
			</c:url>
			<a href="${ callMyinfo }">My Page</a>
		</div>
	</c:if>
	<!-- 로그인 했을 때 : 관리자인 경우 -->
	<c:if test="${ !empty loginMember and loginMember.admin eq 'Y' }">
	<!-- if(session.getAttribute("loginMember") == null) -->
		<div id="loginBox" class="lineA">
			${ loginMember.username }님<br>
			<button onclick="javascript:location.href='logout.do';">로그아웃</button>
			<br><a>관리 페이지로 이동</a> &nbsp; &nbsp;
			<!-- My Page 클릭시 연결대상과 전달값 지정 -->
			<c:url var="callMyinfo" value="/myinfo.do">
				<c:param name="userid" value="${ loginMember.userid }" />
			</c:url>
			<a href="${ callMyinfo }">My Page</a>
		</div>
	</c:if>
</center>
<hr style="clear:both;">
<section>
	<!--  최근 등록된 공지글 3개 조회 출력 -->
	<div style="float:left; border:1px solid navy; padding:5px; margin:5px;">
		<h4>최근 공지글</h4>
		<table id="newnotice" border="1" cellspacing="0">
		</table>
	</div>
	
	<!--  조회수 많은 게시글 3개 조회 출력 -->
	<div style="float:left; border:1px solid navy; padding:5px; margin:5px;">
		<h4>인기 게시글</h4>
		<table id="toplist" border="1" cellspacing="0">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
			</tr>
		</table>
	</div>
</section>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>