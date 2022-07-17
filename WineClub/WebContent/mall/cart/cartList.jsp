<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*, mall.cart.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
<style>
.container { width: 1200px; margin: 0 auto; }
.cart_list { width: 100%; }
/* 상단 1 - d1 */
.d1 { width: 40%; padding: 15px; margin: 15px 45px; float: right; display: inline-block; }
.d1 .s1 { font-size: 1.1em; font-weight: bold; margin-right: 30px; }
.d1 .s2, .d1 .s3 { display: inline-block; width: 120px; text-align: center; font-size: 0.8em; font-weight: bold; padding: 6px 17px; border: 1px solid #333; border-radius: 15px; }
.d1 .s2 { background: #c84557; color: #fff; z-index: 10;  position: relative; border: 1px solid #c84557;}
.d1 .s3 { background: #fff; color: #333; margin-left: -30px; z-index: -10;  position: relative; }
/* 상단 2 - d2 */
.d2 { width: 40%; padding: 15px;  margin: 5px 45px; float: right; display: inline-block; text-align: left;}
.d_line { clear: both; width: 90%; border: 1px solid lightgray; }
/* 상당 3 - d3 */
.d3 { width: 90%; padding: 15px; margin: 0px 45px; float: left; }
.d3 input[type=checkbox] { zoom: 1.5; margin-right: 5px; float: left; }
.d3 label { font-size: 0.9em; margin-right: 20px; }
.d3 input[type=button]{ width: 80px; height: 30px;  border-radius: 3px; color: #fff; font-weight: bold; cursor: pointer;  }
.d3 #btn_buy_select { background: #32708d; border: 1px solid #32708d; margin-right: 5px; }
.d3 #btn_delete_select { background: #99424f; border: 1px solid #99424f; }
/* 중단 - 상품 정보 테이블  */
.t_cart_list { width: 90%; boarder: 1px solid gray; border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
border-left: none; border-right: none; clear: both; }
.t_cart_list tr { height: 40px; }
.t_cart_list td, .t_cart_list th { border-top: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6; border-left: none; border-right: none; }
.t_cart_list th { background: #f1f3f5; }
.t_cart_list td { }
.t_cart_list tr:last-child th { font-weight: normal; }
.left { text-align: left; padding-legt: 10px; }
.right { text-align: right; padding-right: 10px; }
.center { text-align: center;}
.td0 { text-align: center; font-weight: bold; font-size: 1.1em; padding: 30px 0; }
.td1 .ck_cart_one { zoom: 1.5; }
.td3 .s1 { font-weight: bold; }
.td3 .s1 a { font-size: 1.1em; text-decoration: none; color: #1e94be; }
.td3 .s2 { font-size: 0.9em; color: gray; }
.td3 .s3 { font-size: 0.9em; color: gray; text-decoration: line-through; }
.td3 .s4, .td3 .s5 { font-size: 0.9em; font-weight: bold; color: #c84557; }
.td4 input[type="number"] { width: 45px; margin-bottom: 5px; }
.td5 { font-size: 1.1em; font-weight: bold; color: #c84557; }
/* number 화살표 항상 보이는 효과 */
.td4 input[type="number"]::-webkit-inner-spin-button, 
.td4 input[type="number"]::-webkit-outer-spin-button { -webkit-appearance: "Always Show Up/Down Arrows"; opacity: 1; }
.td4 input[type="submit"] { width: 53px; height: 30px; border: 1px solid gray; background: #fff; border-radius: 2px; font-size: 0.8em; }
.td7 input[type="button"] { width: 80px; height: 30px;  border-radius: 3px; color: #fff; font-weight: bold; cursor: pointer; }
.td7 .btn_buy_one { background: #1e94be; border: 1px solid #1e94be; margin-bottom: 5px; }
.td7 .btn_delete_one { background: #c84557; border: 1px solid #c84557; }
/* 하단 - d4 */
.d4 { width: 90%; padding: 15px; margin: 0px 45px; }
.d4 span { font-size: 0.9em; font-weight: bold; color: gray; margin-right: 10px; margin-left: 25px; }
.d4 input[type=button]{ width: 80px; height: 30px;  border-radius: 3px; color: #fff; font-weight: bold; cursor: pointer;  }
.d4 #btn_buy_select2 { background: #32708d; border: 1px solid #32708d; margin-right: 5px; }
.d4 #btn_delete_select2 { background: #99424f; border: 1px solid #99424f; }

/* 하단 - 총상품금액 테이블 */
.t_cart_tot { width: 90%; border: 1px solid #ff953f;  border-collapse: collapse; margin: 0 auto; font-size: 0.9em; 
clear: both; background: #ffae6a; }
.t_cart_tot tr { height: 100px; }
.t_cart_tot td, .t_cart_tot th {  }
.t_cart_tot tr:first-child th:last-of-type { background: #ffc4a3; }
.t_cart_tot span { font-size: 1.5em; display: inline-block; margin-top: 5px; }
.t_cart_tot tr:first-child th:nth-of-type(5) { color: #196ab3; }
.t_cart_tot tr:first-child th:nth-of-type(7) { color: #a13b66; }

.t_cart_tot tr:nth-child(2) { font-size: 0.6em; }
.t_cart_tot tr:nth-child(2) span { font-wieght: normal; }
.t_cart_tot tr:nth-child(2) span b { color: #a13b66; }
.t_cart_tot tr:nth-child(2) th { border-top: 1px solid #ff953f; }

/* 하단 - 배송지 테이블 */
.t_cart_address { width: 90%; boarder: 1px solid gray; border-collapse: collapse; font-size: 0.9em;  clear: both; 
margin: 20px auto; }
.t_cart_address tr { height: 80px; }
.t_cart_address td, .t_cart_address th { border-top: 1px solid #dee2e6; }
.t_cart_address th { background: #f1f3f5; }
.t_cart_address th input { margin-top: 10px; }
.t_cart_address td { padding-left: 10px; }
.t_cart_address td input { margin-left: 20px; }
.t_cart_address input[type=button] { width: 80px; height: 30px; background: #fff; border: 1px solid lightgray; border-radius: 3px; 
padding: 5px; font-size: 0.9em; }

/* 하단 - 주문, 쇼핑계속하기 버튼 */
.d5 { width: 90%; padding: 15px; margin: 0 45px 30px; text-align: center; }
.d5 input[type=button] { width: 150px; height: 50px; font-size: 1.1em; font-weight: bold; color: #fff; cursor: pointer; border-radius: 5px; }
.d5 #btn_buy_select3 { background: #3a85c8; border: 1px solid #3a85c8; }
.d5 #btn_shopping { background: #2f9e77; border: 1px solid #2f9e77; }
.d_line2 { clear: both; width: 100%; border: 1px solid lightgray; margin-bottom: 20px; }

</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	let form = document.cartForm;
	let cart_ids = document.getElementsByName("cart_id"); // 카트 id의 배열
	// 주문, 삭제, 쇼핑 계속하기 버튼
	let btn_buy_select = document.getElementById("btn_buy_select");
	let btn_buy_select2 = document.getElementById("btn_buy_select2");
	let btn_buy_select3 = document.getElementById("btn_buy_select3");
	let btn_delete_select = document.getElementById("btn_delete_select");
	let btn_delete_select2 = document.getElementById("btn_delete_select2");
	let btn_shopping = document.getElementById("btn_shopping")
	
	// 구매 수량 제한 효과 (1~100) 
	let buy_counts = document.querySelectorAll(".buy_count");
	for(let buy_count of buy_counts) {
		buy_count.addEventListener("keyup", function() {
			if(buy_count.value < 1) {
				buy_count.value = 1;
			} else if(buy_count.value > 100) {
				buy_count.value = 100;
			}
		})
	}
	
	// 각 상품별 삭제 버튼 처리(1개 상품)

	let btn_delete_ones = document.querySelectorAll(".btn_delete_one");
	for(let i=0; i<btn_delete_ones.length; i++) {
		btn_delete_ones[i].addEventListener("click", function() {
			location = 'cartDeletePro.jsp?cart_id=' + cart_ids[i].value + "&part=3";
		})
	}
	
	// 각 상품별 주문 버튼 처리(1개 상품)
	let btn_buy_ones = document.querySelectorAll(".btn_buy_one");
	for(let i=0; i<btn_buy_ones.length; i++) {
		btn_buy_ones[i].addEventListener("click", function() {
			location = '../buy/buyForm.jsp?cart_id=' + cart_ids[i].value + "&part=3";
		})
	}
	
	
	//////////////////////////////////////
	// 판매가 계산 (원가에서 할인된 가격)
	let p_sums = document.getElementsByName("p_sum");
	let p_s1 = 0;
	let c1_s1 = document.querySelector(".c1_s1");
	let c2_s1 = document.querySelector(".c2_s1");
	let c3_s1 = document.querySelector(".c3_s1");
	
	// 원가 계산
	let p_sums2 = document.getElementsByName("p_sum2");
	let p_s2 = 0;
	let c1_s2 = document.querySelector(".c1_s2");
	
	// 할인 금액 계산
	let p_sums3 = document.getElementsByName("p_sum3");
	let p_s3 = 0;
	let c1_s3 = document.querySelector(".c1_s3");
	
	// 종, 개수 계산
	let k_count = 0;
	let p_count = 0;
	let c1_s4 = document.querySelector(".c1_s4");
	let c1_s5 = document.querySelector(".c1_s5");
	
	//////////////////////////////////////
	// 전체 선택 체크박스 처리
	let cart_ids_list = []; // 카트 아이디를 저장하는 배열
	let ck_count = 0; // 각 상품별 체크박스의 체크 개수
	let ck_cart_ones = document.querySelectorAll(".ck_cart_one");
	let ck_cart_all = document.getElementById("ck_cart_all");
	ck_cart_all.addEventListener("change", function() {
		p_s1 = 0;
		p_s2 = 0;
		p_s3 = 0;
		k_count = 0;
		p_count = 0;
		if(ck_cart_all.checked == true) { // 전체 선택을 체크했을 때 -> 각 상품별 모든 체크박스를 선택 
			ck_count = ck_cart_ones.length;
			for(let i=0; i<ck_cart_ones.length; i++) {
				ck_cart_ones[i].checked = true;
				cart_ids_list.push(cart_ids[i].value);
				p_s1 += parseInt(p_sums[i].value);
				p_s2 += parseInt(p_sums2[i].value);
				p_s3 += parseInt(p_sums3[i].value);
				++k_count;
				p_count += parseInt(buy_counts[i].value);
			}
		} else {				  		  // 전체 선택을 해제하였을 때 -> 각 상품별 모든 체크박스를 해제
			ck_count = 0;
			cart_ids_list = [];
			for(let i=0; i<ck_cart_ones.length; i++) {
				ck_cart_ones[i].checked = false;
			}
		} 
		cart_ids_list = [...new Set(cart_ids_list)]; // 전체 선택시 중복된 카드 아이디를 제거
		c1_s1.innerHTML = p_s1.toLocaleString() + '원';
		c2_s1.innerHTML = p_s1.toLocaleString() + '원';
		c3_s1.innerHTML = p_s1.toLocaleString() + '원';
		c1_s2.innerHTML = p_s2.toLocaleString() + '원';
		c1_s3.innerHTML = p_s3.toLocaleString() + '원';
		c1_s4.innerHTML = k_count + '종';
		c1_s5.innerHTML = p_count + '개';
		console.log(cart_ids_list);
	})
	 
	// 각 상품별 체크박스 처리
	// 각 상품별 체크박스 중에서 하나라도 선택 해제 된다면 전체 선택을 선택 해제
	// 각 상품별 체크박스가 모두 체크되었다면 전체 선택을 선택
	for(let i=0; i<ck_cart_ones.length; i++) {
		ck_cart_ones[i].addEventListener("change", function(event) {
			if(ck_cart_ones[i].checked == false) { // 체크 해제
				ck_cart_all.checked = false;
				--ck_count;
				cart_ids_list = cart_ids_list.filter((e) => e !== cart_ids[i].value); // 해제되지 않은 카트 아이디를 다시 저장
				p_s1 -= parseInt(p_sums[i].value);
				p_s2 -= parseInt(p_sums2[i].value);
				p_s3 -= parseInt(p_sums3[i].value);
				--k_count;
				p_count -= parseInt(buy_counts[i].value);
			} else {  // 체크 선택
				++ck_count;	
				cart_ids_list.push(cart_ids[i].value);
				p_s1 += parseInt(p_sums[i].value);
				p_s2 += parseInt(p_sums2[i].value);
				p_s3 += parseInt(p_sums3[i].value);
				++k_count;
				p_count += parseInt(buy_counts[i].value);
			}
			if(ck_count == ck_cart_ones.length) {
				ck_cart_all.checked = true;
			}
			c1_s1.innerHTML = p_s1.toLocaleString() + '원';
			c2_s1.innerHTML = p_s1.toLocaleString() + '원';
			c3_s1.innerHTML = p_s1.toLocaleString() + '원';
			c1_s2.innerHTML = p_s2.toLocaleString() + '원';
			c1_s3.innerHTML = p_s3.toLocaleString() + '원';
			c1_s4.innerHTML = k_count + '종';
			c1_s5.innerHTML = p_count + '개';
			console.log(cart_ids_list);
		})
	}
	
	// 삭제 버튼 처리
	btn_delete_select.addEventListener("click", function() {
		if(ck_count == 0) {
			alert('장바구니에 상품이 없습니다.');
			return;
		}
		location = 'cartDeletePro2.jsp?cart_id=' + cart_ids_list + "&part=3";
	})
	
	btn_delete_select2.addEventListener("click", function() {
		if(ck_count == 0) {
			alert('장바구니에 상품이 없습니다.');
			return;
		}
		location = 'cartDeletePro2.jsp?cart_id=' + cart_ids_list + "&part=3";
	})
	
	// 주문 버튼 처리
	btn_buy_select.addEventListener("click", function() {
		if(ck_count == 0) {
			alert('장바구니에 상품이 없습니다.');
			return;
		}
		location = '../buy/buyForm.jsp?cart_id=' + cart_ids_list + "&part=3";
	})
	btn_buy_select2.addEventListener("click", function() {
		if(ck_count == 0) {
			alert('장바구니에 상품이 없습니다.');
			return;
		}
		location = '../buy/buyForm.jsp?cart_id=' + cart_ids_list + "&part=3";
	})
	btn_buy_select3.addEventListener("click", function() {
		if(ck_count == 0) {
			alert('장바구니에 상품이 없습니다.');
			return;
		}
		location = '../buy/buyForm.jsp?cart_id=' + cart_ids_list + "&part=3";
	})
	
	// 쇼핑계속하기 버튼 처리
	btn_shopping.addEventListener("click", function() {
		location = '../shopping/shopAll.jsp';
	})

});
</script>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");

if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}

SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일");
DecimalFormat df = new DecimalFormat("#,###,###");

// 회원 DB 연결 질의 ->
MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO member = memberDAO.getMember(memberId);


String address = member.getAddress();
String local = address.substring(0, 2); // 주소에서  지역 2글자만 추출, ex) 서울, 경기, 대구, 제주 ...

/*
배송 날짜 계산 포맷 
규칙1. 서울: 다음날 배송, 경기: 2일 안에 배송, 지방: 3일 안에 배송, 제주도 지역: 10일 안에 배송
규칙2. 토요일, 일요일은 제외
현재날짜와 시간, 요일 판단, 주소 판단
*/
int n = 0; // 추가되는 날짜
Calendar c = Calendar.getInstance();
int w = c.get(Calendar.DAY_OF_WEEK); // 1~7로 표시 (1: 일요일, 2: 월요일...)

switch(local) {
case "서울":
	if(w >= 2 && w <= 5) ++n;
	else if(w == 6 || w == 7) n += 3;
	else if(w == 1) n += 2;
	break;
case "경기":
	if(w >= 2 && w <= 4) n += 2;
	else if(w >= 5 && w <= 7) n += 4;
	else if(w == 1) n += 3;
	break;
case "제주":
	n += 7;
	break;
default:
	if(w == 2 || w ==3) n += 3;
	else if(w >= 4 && w <= 7) n += 5;
	else if(w == 1) n += 4;
	break;
}
// 추가된 일수를 더한 날짜
c.add(Calendar.DATE, n);
int month = c.get(Calendar.MONTH) + 1; // 0~11로 표현, 1을 더해서 보정
int date = c.get(Calendar.DATE);
int week = c.get(Calendar.DAY_OF_WEEK);
String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"}; // 요일 명칭으로 변환하기 위한 배열 (week가 1~7까지로 표현하므로 0번은 비워둠)

//배송일 확인

String d_day = month + "월" + date + "일(" + weekday[week] + "요일)";
// System.out.println("배송일 : " + month + "월 " + date + "일 (" + weekday[week] + "요일)"); 



// 장바구니 DB 연결, 질의
CartDAO cartDAO = CartDAO.getInstance();
List<CartDTO> cartList = cartDAO.getCartList(memberId);
int cartListCount = cartDAO.getCartListCount(memberId);

// 상품가격(정가), 할인율, 할인가격(판매가)
int product_price = 0;
int buy_price = 0;
int discount_rate = 0;
int buy_count = 0;
int p_sum = 0;  // 각 상품의 합계(할인가격)
int p_tot = 0;  // 주문 상품의 총합계(할인가격)

int p_sum2 = 0; // 각 상품의 합계(원가)
int p_tot2 = 0; // 주문 상품의 총합계(원가)

int d_count = 0; // 실제 할인된 금액,  ex) 10000원(원가), 10%할인, 9000원(할인가) 
int p_sum3 = 0;  // 각 상품의 실제 할인된 금액의 합계
int p_tot3 = 0;  // 주문 상품의 실제 할인된 금액의 총합계

int k_count = 0; // 주문 상품의 종류
int p_count = 0; 	// 주문 상품 의총 개수

// 장바구니 목록 불러오기 매소드 확인
/*
for(CartDTO cart : cartList) {
	System.out.println(cart);
}
*/

%>
<div class="container">
	<jsp:include page="../common/shopTop.jsp"/>
	<div class="cart_list">
		<div class="d1">
			<span class="s1">WINECLUB 배송</span>
			<span class="s2">당일/하루/일반 배송</span>
			<span class="s3">아침배송</span>
		</div>
		<div class="d2">
			<img src="../../icons/progress01.png" width="450" height="70">
		</div>
		<hr class="d_line">
		<div class="d3">
			<input type="checkbox" name="ck_cart_all" id="ck_cart_all"><label for="ck_cart_all">전체 선택</label>
			<input type="button" value="주문" id="btn_buy_select">
			<input type="button" value="삭제" id="btn_delete_select">
		</div>
		<table class="t_cart_list">
			<tr>
				<th colspan="3">상품정보</th>
				<th>수량</th>
				<th>상품금액</th>
				<th>배송정보</th>
				<th>주문</th>
			</tr>
			<%if(cartListCount == 0) {%>
			<tr><td colspan="7" class="td0">장바구니에 상품이 없습니다.</td></tr>
			<%} else {%>
			<%for(CartDTO cart : cartList) {
				product_price = cart.getProduct_price();
				discount_rate = cart.getDiscount_rate();
				buy_price = cart.getBuy_price();
				buy_count = cart.getBuy_count();
				p_sum = buy_price * buy_count; 	// 각 상품의 합계 (할인가격)
				p_tot += p_sum;				   	// 총합계(할인가격)
			
				p_sum2 = product_price * buy_count; // 각 상품의 합계 (원가)
				p_tot2 += p_sum2;					// 총합계(원가)
				
				p_sum3 = product_price * discount_rate/100 * buy_count;  // 각 상품의 할인된 가격,  ex) 10000 * 10/100 * 구매수량
				p_tot3 += p_sum3;							 // 각 상품의 할인된 가격의 총합계
				
				++k_count;				// 주문 상품 종류
				p_count += buy_count;	// 주문 상품 총개수
			%>
			<form action="cartUpdatePro.jsp" method="post" name="cartForm">
				<input type="hidden" name="cart_id" value="<%=cart.getCart_id() %>">
				<input type="hidden" name="product_id" value="<%=cart.getProduct_id() %>">
				<input type="hidden" name="p_sum" value="<%=p_sum %>">
				<input type="hidden" name="p_sum2" value="<%=p_sum2 %>">
				<input type="hidden" name="p_sum3" value="<%=p_sum3 %>">
				<tr>
					<td class="center td1" width="3%"><input type="checkbox" name="ck_cart_one" class="ck_cart_one" ></td>
					<td class="cneter td2" width="8%">
						<a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id() %>"><img src="/images_wineclub/<%=cart.getProduct_image()%>" width="60" height="90"></a>
					</td>
					<td class="left td3" width="47">
						<span class="s1"><a href="../shopping/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><%=cart.getProduct_name() %></a></span><br>
						<span class="s2"><%=cart.getOrigin() %> | <%=cart.getProduct_kind() %></span><br>
						<span class="s3"><%=df.format(product_price) %>원</span> | <span class="s4"><%=df.format(buy_price) %>원</span> (<span class="s5"><%= discount_rate %>% 할인</span>)
					</td>
					<td class="center td4" width="8%">
						<input type="number" name="buy_count" value="<%=buy_count %>" class="buy_count" min="1" max="100"><br>
						<input type="submit" name="btn_count" value="변경" >
					</td>
					<td class="right td5" width="12%"><%=df.format(p_sum) %>원</td>
					<td class="center td6" width="12%"><%=d_day %><br>도착예정</td>
					<td class="center td7" width="12%">
						<input type="button" name="btn_buy_one" value="주문" class="btn_buy_one"><br>
						<input type="button" name="btn_delete_one" value="삭제" class="btn_delete_one">
					</td>
				</tr>
			</form>
			<%} }%>
			<tr>
				<th colspan="7">WINECLUB 배송 상품 총 금액: <b class="c1_s1"></b> (+배송비  <b>0원</b>)</th>
			</tr>
		</table>
		<div class="d4">
			<span>선택한 상품</span>
			<input type="button" value="주문" id="btn_buy_select2">
			<input type="button" value="삭제" id="btn_delete_select2">
		</div>
		<table class="t_cart_tot">
			<tr>
				<th>총 상품금액<br><span class="s1 c2_s1"></span>원</th>
				<th><img src="../../icons/plus.PNG" width="60"></th>
				<th>총 추가 금액<br><span class="s2"><%=0 %></span>원</th>
				<th><img src="../../icons/minus.PNG" width="60"></th>
				<th>총 할인 금액<br><span class="s3"><%=0 %></span>원</th>
				<th><img src="../../icons/equal.PNG" width="60"></th>
				<th>최종 결제금액<br><span class="s4 c3_s1"></span>원</th>
			</tr>
			<tr>
				<th colspan="7">
					<span>정가 <b class="c1_s2">0원</b>에서 <b class="c1_s3">0원</b> 할인</span><br>
					<span>총 주문수량: <b class="c1_s4">0종</b> (<b class="c1_s5">0개</b>)</span>
				</th>
			</tr>
		</table>
		<table class="t_cart_address">
			<tr>
				<th>배송일 안내<br><input type="button" value="배송안내"></th>
				<td>배송지 : <%=address %><input type="button" value="배송지 변경"></td>
			</tr>
		</table>
		<div class="d5">
			<input type="button" value="주문하기" id="btn_buy_select3">&ensp;&ensp;
			<input type="button" value="쇼핑 계속하기" id="btn_shopping">
		</div>
		<hr class="d_line2"> 
	</div>
	<jsp:include page="../common/shopBottom.jsp"/>
</div>

</body>
</html>