<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴(삭제) 처리</title>
</head>
<body>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDAO memberDAO = MemberDAO.getInstance();

int cnt = memberDAO.deleteMember(id, pwd);

// cnt가 1이면 삭제 완료, 0이면 삭제가 안된 상태 
out.print("<script>");
if(cnt == 1) { // 삭제가 잘 되었을 시 
	session.removeAttribute("memberId");
	out.print("alert('회원 탈퇴가 정상적으로 완료되었습니다.');");
	out.print("location='../shopping/shopAll.jsp'");
} else { // 삭제가 되지 않았을 시
	out.print("alert(`회원 탈퇴가 되지 않았습니다.\n다시 시도해주세요.`);history.back();");
} 
out.print("</script>");
%>
	
	
</body>
</html>