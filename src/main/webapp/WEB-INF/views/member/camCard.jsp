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
<br>

<py-script> 
 import os 
 
 os.system('./resources/python/main.exe')

</py-script>
<iframe src="http://localhost:5000/stream?src=0" width="650" height="480">
</iframe>
<br>

<button onclick="javascript:location.href=capture.do;">사진 저장하기</button>

<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>