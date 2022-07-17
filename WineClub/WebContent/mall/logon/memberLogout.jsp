<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
	<%
	/*
	< 세션을 삭제하는 방법 2가지 >
	1. session.invalidate();
		-> 모든 세션을 무효화(삭제)
	2. session.removeAttribute(세션이름);
		-> 세션 이름에 해당하는 세션만 삭제ㅣ
	*/

	session.invalidate();
	
		
	%>
	<script>
		alert('로그아웃 되었습니다.');
		location = '../shopping/shopAll.jsp';
	</script>
</body>
</html>