<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 삭제 처리</title>
</head>
<body>
<%

String pageNum = request.getParameter("pageNum");
// 아이디만 겟방식으로 넘겨받아서 검색해 삭제 처리
int product_id = Integer.parseInt(request.getParameter("product_id"));
ProductDAO productDAO = ProductDAO.getInstance();
productDAO.deleteProduct(product_id);
response.sendRedirect("productList.jsp?pageNum=" + pageNum);
%>
</body>
</html>