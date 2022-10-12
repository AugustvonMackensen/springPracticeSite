<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
 <link 
      rel="stylesheet" 
      href="https://pyscript.net/alpha/pyscript.css" 
    /> 
    <script 
      defer 
      src="https://pyscript.net/alpha/pyscript.js"
    ></script> 
    <py-env>         
    - paths:
      - "./resources/python/main.exe"
    </py-env>
    <py-config>
      - autoclose_loader: true
      - runtimes:
        -
          src: "https://cdn.jsdelivr.net/pyodide/dev/full/pyodide.js"
          name: pyodide-0.20
          lang: python
    </py-config>

</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" /> 
<hr>
<h1></h1>
<br>
<py-script> 
 import os 
 os.system('./resources/python/main.exe')
</py-script>
<img src="http://localhost:5000/stream?src=0" width="650" height="480" id="cam">
<br>
<canvas id="canvas" width="640" height="480"></canvas>
<button id="snap" type="submit" name="upfile">캡처하기</button>&nbsp;&nbsp;&nbsp;
<button onclick="javascript:location.href='uploadImage.do'">명함 등록페이지로 이동</button>
<script>
const video = document.getElementById('cam');
const canvas = document.getElementById('canvas');
const snap = document.getElementById('snap');

		var context = canvas.getContext('2d');
		var image = canvas.toDataURL();
		snap.addEventListener("click", function(){
		   context.drawImage(video, 0, 0, 640, 480);
		   
		});


</script>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>