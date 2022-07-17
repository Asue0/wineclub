<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 쇼핑몰 상단 페이지 : 쇼핑몰의 모든 페이지 상단에 포함되는 페이지 --%>

<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
/* 전체레이아웃 */
.top a { text-decoration: none; color: #000; }
.t_box1, .t_box2, .t_box3, .t_box4 { display: inline-block; padding: 2%; }
.t_box1, .t_box3 { width: 60%; }
.t_box2, .t_box4 { width: 30%; } 
/* 구역 1(상단 좌측): 타이틀, 검색 */
.t_box1 .m_title { font-family: 'Lobster', cursive; font-size: 60px; text-align: center; }
.t_box1 .m_title a {color: #cd4d4d; }
.t_box1 .s_title { font-family: 'Nanum Pen Script', cursive; font-size: 20px; text-align: center; }
.t_box1 .t_search { width: 400px; text-align: center; margin-top: 15px; margin-left: 150px;
border: 1px solid #000; border-radius: 35px; padding: 5px; }
.t_box1 .t_search #keyword { height: 38px; width: 300px; border: none; font-size: 1.1em; font-size: 0.9em; }
.t_box1 .t_search #keyword:focus { outline: none; }
.t_box1 .t_search button { border: none; background: #fff; cursor: pointer; }
/* 구역 2(상단 우측): 회원정보, 구매정보, 장바구니 정보 */
.t_box2 { float: right; text-align: right; line-height: 100px; }
.t_box2 .t_b2_img1:hover { content: url('../../icons/user2.png'); }
.t_box2 .t_b2_img2:hover { content: url('../../icons/buy2.png'); }
.t_box2 .t_b2_img3:hover { content: url('../../icons/cart2.png'); }
/* 구역 3(하단 좌측): 메인메뉴(하위 메뉴) */
.t_box3 { float: left; position: relative; }
.m_menu0 { display: inline-block; width: 30px; }
.m_menu_img:hover { content: url('../../icons/menu2.png'); }
.m_menu { display: inline-block; }
.m_menu a { font-family: 'Jua', sans-serif; font-size: 20px; color: #a6615a; width: 100px; padding: 5px; margin: 5px; }
.s_menu { display: none; position: absolute; top: 55px; width: 130px; z-index:10; background:#e9e1f4; }
.sm1 { left: 85px; }
.sm2 { left: 230px; }
.sm3 { left: 345px; }
.sm4 { left: 490px; }
.sm5 { left: 580px; }
.m_menu a:hover  { color: purple; text-shadow: 1px 1px 1px lightgray; }
.m_menu:hover .s_menu { display: block; }
.s_menu div { padding: 10px 0; }
.s_menu div a { font-family: '고딕'; font-size: 0.9em; color: #000; }
.s_menu div a:hover { font-weight: bold; font-size: 1.0em; text-shadow: 2px 2px 2px gray;}
/* 구역 4(하단 우측): 로그인, 회원가입, 고객센터... */
.t_box4 { float: right; text-align: right; }
.t_box4 a { color: gray; font-size: 15px; font-weight: bold; }
.top_end { clear: both; }
</style>
<%
String memberId = (String)session.getAttribute("memberId");
%>
<div class="top">
	<div class="t_box1"> <%-- 구역1(상단 좌측): 타이틀, 검색 --%>
		<div class="m_title"><a href="/WineClub/mall/shopping/shopAll.jsp">WINE CLUB</a></div>
		<div class="s_title">와인과 함께 풍미 깊은 인생을...</div>
		<div class="t_search">
			<form action="" method="post" name="searchForm">
				<input type="search" name="keyword" id="keyword" placeholder="상품을 입력해주세요.">
				<button type="submit"><img src="/WineClub/icons/search.png" width="25" height="25"></button>
			</form>
		</div>
	</div>
	<div class="t_box2"> <%-- 구역2(상단 우측): 회원정보, 구매정보, 장바구니 정보 --%>
		<a href="/WineClub/mall/member/memberInfoForm.jsp"><img src="/WineClub/icons/user1.png" width="40" title="회원정보" class="t_b2_img1"></a>&emsp;&emsp;
		<a href="/WineClub/mall/buy/buyList.jsp"><img src="/WineClub/icons/buy1.png" width="40" title="구매정보" class="t_b2_img2"></a>&emsp;&emsp;
		<a href="/WineClub/mall/cart/cartList.jsp"><img src="/WineClub/icons/cart1.png" width="40" title="장바구니정보" class="t_b2_img3"></a>
	</div>
	<div class="t_box3"> <%-- 구역3(하단 좌측): 메인메뉴(하위 메뉴) --%>
		<div class=".m_menu">
			<div class="m_menu"><a href="#"><img src="../../icons/menu1.png" width="25" class="m_menu_img"></a></div>
			<div class="m_menu mm1">
				<a href="#">Aperitif Wine</a>
				<div class="s_menu sm1">
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=110#t_kind">내추럴 와인</a></div>
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=120#t_kind">샴페인</a></div>
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=130#t_kind">스파클링 와인</a></div>
				</div>
			</div>
			<div class="m_menu mm2">
				<a href="#">Table Wine</a>
				<div class="s_menu sm2">
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=210#t_kind">레드 와인</a></div> <%-- #t_kind는 이동시 id값이 t_kind인 구역으로 자동으로 포커싱한다. --%>
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=220#t_kind">화이트 와인</a></div>
				</div>
			</div>
			<div class="m_menu mm3">
				<a href="#">Dessert Wine</a>
				<div class="s_menu sm3">
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=310#t_kind">로제 와인</a></div>
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=320#t_kind">주정강화 와인</a></div>
				</div>
			</div>
			<div class="m_menu mm4">
				<a href="#">악세사리</a>
				<div class="s_menu sm4">
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=410#t_kind">와인 글라스</a></div>
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=420#t_kind">코르크 스크류</a></div>
				</div>
			</div>
			<div class="m_menu mm5">
				<a href="#">보관용구</a>
				<div class="s_menu sm5">
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=510#t_kind">와인 렉</a></div>
					<div><a href="/WineClub/mall/shopping/shopAll.jsp?product_kind=520#t_kind">와인 셀러</a></div>
				</div>
			</div>
		</div>
	</div>
	<div class="t_box4"> <%-- 구역4(하단 우측): 로그인, 회원가입, 고객센터...  --%>
		<%if(memberId == null) {%>
		<a href="/WineClub/mall/logon/memberLoginForm.jsp"><span>로그인</span></a>&ensp;|&ensp;
		<a href="/WineClub/mall/member/memberJoinForm.jsp"><span>회원가입</span></a>&ensp;|&ensp;
		<%} else {%>
		<a href="/WineClub/mall/member/memberInfoForm.jsp"><%=memberId %>님</a>&ensp;|&ensp;<a href="/WineClub/mall/logon/memberLogout.jsp">로그아웃</a>&ensp;|&ensp;
		<%}%>
		<a href=""><span>고객센터</span></a> 
	</div>
</div>
<div class="top_end"></div>
<hr>
