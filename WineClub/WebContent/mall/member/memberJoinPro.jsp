<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	
	<!-- 액션 태그 사용 -->
	<jsp:useBean id="member" class="mall.member.MemberDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="member"/>
	
	<%
	// 완전한 주소: address(도로명 주소) + address2(상세 주소)
	String address2 = request.getParameter("address2"); 
	String address = member.getAddress() + " " + address2;
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.insertMember(member);
	%>
	
	<script>
	<%if(cnt > 0) {%> <%-- cnt가 1, 데이터 추가에 성공했을 때 --%>
		alert('회원 가입에 성공하였습니다.')
		location = '../shopping/shopAll.jsp';
	<%} else {%> <%-- cnt가 0, 데이터 추가에 실패했을 때 --%>
		alert('회원가입에 실패하셨습니다.');
		history.back();
	<%} %>
	</script>
	
</body>
</html>