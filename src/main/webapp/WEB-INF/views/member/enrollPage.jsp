<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
table th { background-color: #99ffff; }
table#outer { border:2px solid navy; }
input#validchkMessage {
	box-shadow: none;
  	border-bottom: none;
  	outline: none;
    border: none;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

//아이디 중복 체크 확인을 위한 ajax 실행 처리용 함수
//ajax(asynchronous Javascript and Xml) :
//페이지를 바꾸지 않고, 서버와 통신하는 기술임 
//(서버측에 서비스 요청하고 결과 받음)

function dupCheckId(){
	// 입력된 아이디가 중복되지 않았는지 확인 : jQuery.ajax() 사용
	//jQuery는 $ 로 줄일 수 있음
	//jQuery.ajax(); => $.ajax();
	const idchkMsg = $('#idDupCheckMsg');

	$.ajax({
		url: "idchk.do",
		type: "post",
		data: { userid: $("#userid").val() },
		success: function(data){
			console.log("sucess : " + data);
			if(data == "ok"){
				idchkMsg.html("사용 가능한 아이디입니다.");
				idchkMsg.css('color', 'green');
			} else{
				idchkMsg.html("이미 가입된 회원의 아이디입니다.");
				idchkMsg.css('color', 'red');
				$("#userid").select();
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	});
	
	idMinLength = document.getElementById("userid").value.length;
	if(idMinLength < 4){
		idchkMsg.html("아이디는 최소 4자 이상이어야 합니다.");
		idchkMsg.css('color', 'red');
	}
}


function chkPwd(){
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	var passRule = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;
	const chkPwdRuleMsg = $('#pwRuleChk');
	
	if(passRule.test(pwd1) === false){
		chkPwdRuleMsg.html("비밀번호는 8~16자의 영문 대소문자와 숫자, 특수문자를 적어도 하나는 포함해야 합니다.");
		chkPwdRuleMsg.css('color', 'red');
	}else{
		chkPwdRuleMsg.html("");
	}
	
}

function validPW(){
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	const chkpwdMsg = $('#chkPwdMessage');
	
	if(pwd1 !== pwd2){
		chkpwdMsg.html("비밀번호가 일치하지 않습니다.");
		chkpwdMsg.css('color', 'red');
	}else {
		chkpwdMsg.html("비밀번호가 일치합니다.");
		chkpwdMsg.css('color', 'green');
	}
}
function validate(){
	
	//전송보내기 전(submit 버튼 클릭시) 입력값 유효한 값인지 검사
	//아이디 유효성 검사
	form = document.signUp;
	if(form.userid.value.length < 4){
		alert("아이디 최소길이는 4글자입니다.");
		document.getElementById("userid").select();
		return false;
	}
	
	if(document.getElementById("idDupCheckMsg").innerHTML !== '사용 가능한 아이디입니다.'){
		alert("이미 가입된 회원의 아이디입니다.");
		return false;
	}
	
	//암호화 암호확인이 일치하는지 확인
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	
	if(pwd1 !== pwd2){
		alert("비밀번호가 일치하지 않습니다.");
		document.getElementById("upwd1").select();
		return false;	//전송 안 함
	}
	
	var passRule = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;
	if(passRule.test(pwd1) === false){
		alert("비밀번호는 8~16자의 영문 대소문자와 숫자, 특수문자를 적어도 하나는 포함해야 합니다.");
		return false;
	}
	
	if(document.getElementById("emailStatus").innerHTML === '이메일을 입력하셨거나 변경하셨네요. 이메일 인증을 하세요.'){
		 alert("이메일이 인증되지 않았습니다. 인증해 주세요.");
		 document.getElementById("usermail").select();
		 return false;
	}
	
	if(document.getElementById("validchkMessage").innerHTML !== '인증번호가 일치합니다.'){
		alert("인증번호를 제대로 입력해주세요.");
		document.getElementById("validnum").select();
		return false;
	}
	
	return true;	// 전송함
}
//이메일 값 변경여부 확인
function statusMail(){
	const mailStatusMsg = $('#emailStatus');
	mailStatusMsg.html('이메일을 입력하셨거나 변경하셨네요. 이메일 인증을 하세요.');
	mailStatusMsg.css('color', 'blue');
}

//이메일 인증
function validateMail(){
	console.log("동작되었음");
	const email = $('#usermail').val(); //이메일 주소값 얻어오기
	console.log("이메일 : " + email); //오는지 확인
	const checkInput = $('.mailcheck-input'); // 인증번호 입력하는 곳
	const mailStatusMsg = $('#emailStatus');
	
	$.ajax({
		type: 'get',
		url: '<c:url value="/mailCheck.do?email="/>' + email, //GET 방식이므로 url 뒤에 email 붙이기 가능
		success: function(data){
			if(data != "failure"){
				console.log("data : " + data);
				checkInput.attr('disabled', false);
				code = data;
				alert('인증번호가 전송되었습니다.');
				return false;
				
			} else {
				alert('가입된 회원의 이메일입니다.');
				mailStatusMsg.html('가입된 회원의 이메일입니다.');
				mailStatusMsg.css('color', 'red');
				$('#usermail').select();
				return false;
			}
		}
	}); //end ajax
} //end send mail

//인증번호 비교
//blur : focus가 벗어나는 경우 발생
function chkCode(){
	const inputCode = document.getElementById("validnum").value;
	const resultMsg = $('#validchkMessage');
	const mailStatusMsg = $('#emailStatus');
	
	if(inputCode == code){
		resultMsg.html('인증번호가 일치합니다.');
		resultMsg.css('color', 'green');
		mailStatusMsg.html('인증되었습니다.');
		mailStatusMsg.css('color', 'green');
	} else{		
		resultMsg.html('인증번호가 일치하지 않습니다.');
		resultMsg.css('color', 'red');
		mailStatusMsg.html('이메일 인증이 실패하였습니다.');
		mailStatusMsg.css('color', 'red');
	}	
}
</script>
</head>
<body>
<h1 align="center">회원 가입 페이지</h1>
<br>
<form action="enroll.do" method="post" id="signUp" name="signUp" onsubmit="return validate();">
<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
	<tr>
		<th colspan="2">회원 정보를 입력해 주세요.
		(* 표시는 필수입력 항목입니다.)
	</th></tr>
	<tr>
		<th width="120">* 이 름</th>
		<td><input type="text" name="username" maxlength="6" required></td>
	</tr>
	<tr>
		<th width="120">* 아이디</th>
		<td><input type="text" name="userid" id="userid" maxlength="10" oninput="dupCheckId();" required><br>
			<span id="idDupCheckMsg"></span>
		</td>
	</tr>
	<tr>
		<th width="120">* 암 호</th>
		<td>
			<input type="password" name="userpwd" id="upwd1" minlength="8" maxlength="16" oninput="chkPwd();" required><br>
			<span id="pwRuleChk"></span>
		</td>
	</tr>
	<tr>
		<th width="120">* 암호확인</th>
		<td>
			<input type="password" minlength="8" maxlength="16" id="upwd2" oninput="validPW();"><br>
			<span id="chkPwdMessage"></span>
		</td>
	</tr>
	<tr>
		<th width="120">* 이메일</th>
		<td>
			<input type="email" name="email" id="usermail" oninput="statusMail();" required> &nbsp;&nbsp;
			<input type="button" id="mailChkbtn" value="인증" onclick="return validateMail();"><br>
			<span id ="emailStatus"></span>
		</td>
	</tr>
	<tr>
		<th width="120">* 인증번호</th>
		<td class="mailcheck">
			<input type="text" id="validnum" name="validnum" class="mailcheck-input" placeholder="인증번호" disabled="disabled" maxlength="6" oninput="chkCode();" required><br>
			<span id="validchkMessage"></span>
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="가입하기"> &nbsp;
			<a href="main.do">시작페이지로 이동</a>
		</th>
	</tr>
</table>
</form>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>