<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script text="text/javascript">
function previewImage(f){
	var file = f.files;
	
	//확장자 체크
	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){
		alert("gif, jpg, png 파일만 선택해 주세요.")
		
		f.outerHTML = f.outerHTML;
		
		document.getElementById('preview').innerHTML = "";
	} else{
		//FileReader 객체 사용
		var reader = new FileReader();
		
		//파일 읽기 완료시 실행
		reader.onload = function(input){
			document.getElementById('preview').innerHTML = '<img src="' + input.target.result + '">';
		}
		
		//파일 읽기
		reader.readAsDataURL(file[0]);
	}

}
</script>
</head>
<body>
<div class="namecard-upload">
	<input type="file" name="nameCardFile" id="nameCardImg" accept="image/*" onchange="previewImage(this);" required>
</div>
<div id="preview"></div>
</body>
</html>