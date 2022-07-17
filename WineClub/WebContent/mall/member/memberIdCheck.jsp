<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
<%
// ID 중복 체크 처리 
String id = request.getParameter("id");
 
MemberDAO memberDAO = MemberDAO.getInstance();
memberDAO.checkID(id);
int cnt = memberDAO.checkID(id); 
%>

<script>
<%if(cnt > 0) {%> <%-- 가입가능한 아이디--%>
	alert('만들 수 있는 아이디입니다.');
<%} else {%> <%-- c--%>
	alert(`중복되는 아이디가 있습니다.\n아이디를 다시 입력해주세요.`)
<%} %>
history.back();
</script>

</body>
</html>