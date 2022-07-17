<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 등록 처리 페이지</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String memberId = (String) session.getAttribute("memberId");
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
}
%>

<jsp:useBean id="cart" class="mall.cart.CartDTO" />
<jsp:setProperty property="*" name="cart"/>

<%

// 카트 정보 확인
// System.out.print(cart);

CartDAO cartDAO = CartDAO.getInstance();

// 장바구니 중복 상품 확인
// 이미 존재하는 상품이면 수량을 수정하고, 존재하지 않는 상품이면 상품을 추가
// cart_id, product_id, buy_count
int cart_id = 0;
int buy_count = 0;
List<CartDTO> cartList = cartDAO.getCartList(memberId);
for(CartDTO dto : cartList) {
	if(dto.getProduct_id() == cart.getProduct_id()) {
		cart_id = dto.getCart_id();
		buy_count = dto.getBuy_count();
	}
}
if(cart_id == 0) { 													// 카트에 중복된 상품이 없음 -> 카드에 새 상품을 추가
	cartDAO.insertCart(cart);
} else { 		   													// 카트에 중복된 상품이 있음 -> 이미 존재하는 상품의 수량을 수정 
	cartDAO.updateCart(cart_id, buy_count+cart.getBuy_count()); 	// 존재하는 상품수량 + 새로 추가한 상품수량
}

response.sendRedirect("cartList.jsp");



%>
</body>
</html>