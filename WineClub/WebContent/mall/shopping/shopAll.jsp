<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 전체</title> 
<%-- bx-slider --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
</head>
<style>
#container { width: 1200px; margin: 0 auto; }
/* 신상품  */
.new_items { text-align: center; }
.new_items .slider { width: 100%; }
/* 추천상품 */
.good_items { text-align: center; }
.c_good_img { transition: transform, 1s; }
.c_good_img:hover { transform: scale(1.05); } /* 이미지가 커지는 효과 */
/* 상품 종류별 노출 */
</style>
<script>
// 슬라이더(slider), 캐러셀(carosel)
$(document).ready(function(){
    // bxSlider 사용 방법
    $('.slider').bxSlider({
        autoControls: true, 	// 기본값: false, 재생/정지 컨트롤 버튼 유무
        stopAutoOnClick: true,  // 기본값: false, 불릿을 누르고나면 슬라이드가 정지됨 (true)
        auto: true, 			// 기본값: false, 자동 슬라이드 전환 (자동으로 전환하지 않는게 기본값, false)
        autoHover: true,   		// 기본값: false, 마우스를 올렸을 때  슬라이드 중지 (마우스 올렸을 때 중지되는게 기본값)
        // 중요한 속성
        speed: 2000, 		// 화면전환 속도 -> 2초
        pause: 3000,	 	// 화면전환 속도 + 전환하는데에 지연 시간 -> 2초 + 1초 = 3초
        slideWidth: 220, 	// 이미지의 너비
        slideHeight: 340, 	// 이미지의 높이
        maxSlides: 5, 		// 이미지의 최대 노출 개수
        minSlides: 2, 		// 이미지의 최소 노출 개수
        moveSlides: 2, 		// 슬라이드 이동 개수
        slideMargin: 20, 	// 슬라이드 사이에 간격(마진)
        touchEnabled: false // 웹 화면의 touch 이벤트 제거 -> bxslider의 자체 터치 기능과 이미지 클릭시 이동 기능이 문제를 일으키므로 false로 만듬
    });
});

</script>
<body>
<%
ProductDAO productDAO = ProductDAO.getInstance();

// 메인1: 추천상품(모든 상품에서 최신상품 2개씩을 리스트에 담아서 리턴)
String[] nProducts = {"110", "120", "130", "210", "220", "310", 
		"320", "410", "420", "510", "520"};
List<ProductDTO> goodProductList = productDAO.getProductList(nProducts);

/* 데이터가 잘 넘어오는지 검사
for(ProductDTO product : goodProductList) {
	System.out.println(product.getProduct_id());
	System.out.println(product.getProduct_image());
}
*/
%>
<%-- 쇼핑몰 전체: 상단+메인+하단  --%>
<div id="container">
	<div> <%-- 상단 --%>
		<header><jsp:include page="../common/shopTop.jsp"/></header>
	</div>
	<div > <%-- 메인(본문) --%>
		<main>
			 <%-- 메인1: 신상품(100번대와 200번대)에서 신상품을 3개식 가져와서 bx-slider로 노출 --%>
			 <%-- 
			<article class="new_items"> 
				<h3>신상품</h3>
				<div class="slider">
				<%for(ProductDTO product : newProductList){%>
					<a href="shopContent.jsp?product_id=<%=product.getProduct_id() %>"><img src="/images_ezenmall/<%=product.getProduct_image()%>"></a>
				<%}%>
				</div>
			</article>
			--%>
			<article class="good_items"> <%-- 메인2: 추천상품(모든 상품에서 신상품 1개씩을 가져와서 slick으로 노출) --%>
				<h3>추천 상품</h3>
				<div class="slider">
				<%for(ProductDTO product : goodProductList){%>
					<a href="shopContent.jsp?product_id=<%=product.getProduct_id() %>">
					<img src="/images_wineclub/<%=product.getProduct_image()%>" class="c_good_img">
					</a>
				<%} %>
				</div>
				
			</article>
			<hr>
			<article class="best_items"><%-- 메인3: 베스트셀러(주문수량이 가장 많은 상품 20개를 가져와서 노출)--%>
			</article>
			
			<article class="kind_items"><%-- 메인4: 상품 종류별로 나열되도록 설정한 영역 --%>
				<jsp:include page="shopMain.jsp"/>
			</article>
		</main>
	</div>
	<div> <%-- 하단 --%>
		<footer><jsp:include page="../common/shopBottom.jsp"/></footer>
	</div>
</div>
</body>
</html>