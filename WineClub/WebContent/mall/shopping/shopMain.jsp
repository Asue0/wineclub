<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*, java.text.*" %>
<%-- 쇼핑몰 메인 페이지 : 상품이 나열되는 페이지 --%>
<%-- 상품의 분류별 전체 보기 --%>
<style>
/* 상품 분류*/
.t_kind { margin-top: 30px; }
.d_kind1 { text-align: right; margin-bottom: 10px; margin-left: 20px; }
.d_kind1 .s_kind1 { display: inline-block; float: left; }
.d_kind1 .s_kind11 { font-size: 1.1em; color: navy; }
.d_kind1 .s_kind2 select { margin-right: 40px; width: 150px; height: 25px; }
.d_kind2 { margin-left: 20px; margin-bottom: 10px; clear: both; }
.d_kind2 .s_kind21 { color: #f1617d; }
/* 상품 분류별  노출 */
.d_kind3 { position: relative; float: left; text-align: center; font-size: 0.9em; margin-bottom: 0px; }
.d_kind3 a { text-decoration: none; color: #000;  }
.c_product { display: inline-block; width: 250px; height: 320px; 
	padding: 10px; margin: 10px; border: 1px solid gray; }
.c_product .c_p2, .c_product .c_p4 { font-weight: bold; }
.c_product .c_p3 { font-size: 0.9em; color: #868e96; }
.c_product .c_p2, .c_product .c_p3 { white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}
/* white-space: nowrap -> 줄을 바꾸지 않음 / overflow: hidden; -> 텍스트가 넘치는 부분은 숨김 / text-overflow: ellipsis ->  */
.c_product .c_p4 .s_p_discount { color: #f00; }
/* 상품 hover 효과 */
.c_product2 { display: none; }
.c_product2 .c_p5, .c_product2 .c_p6 { display: none; }
.d_kind3:hover .c_product2 { position: absolute; top:0; left:0; background: rgba(0, 0, 0, 0.8); text-align: center;
	display: inline-block; width: 250px; height: 320px; padding: 10px; margin: 10px; border: 1px solid gray; }
.d_kind3:hover .c_p5, .d_kind3:hover .c_p6 { display: inline-block; width: 70px; height: 70px; border: none; background: #c84557;
	border-radius: 50%; margin: 140px 5px 0 5px; text-align: center; line-height: 70px; font-size: 0.9em; font-weight: bold; color: #fff; }
/* 하단 - 페이징 영역 */
#paging { text-align: center; margin-top: 20px; clear: both; }
#paging a { color: #000; }
#pBox { display: inline-block; width: 22px; height: 22px; padding: 5px;
		margin: 5px;  }
#pBox:hover { background: #f1617d; color: white; font-weight: bold;
		  	  border-radius: 50%; }	
.pBox_c { background: #f1617d; color: white; font-weight: bold;
		  border-radius: 50%; }
.pBox_b { font-weight: bold; }  
.main_end { margin: 50px 0 20px 0; }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	let product_kind = document.getElementById("product_kind");
	
	// 상품 분류 선택에 대한 change 이벤트 처리
	product_kind.addEventListener("change", function(event) {
		// product_kind 값을 가지고 shopAll.jsp로 이동
		location = 'shopAll.jsp?product_kind=' + product_kind.value + "#t_kind";
	})
})
</script>
<%
request.setCharacterEncoding("utf-8");
String product_kind = request.getParameter("product_kind");
if(product_kind == null) product_kind = "110";

// 상품 분류별 상품명 설정
String product_kindName = "";
switch(product_kind) {
case "110": product_kindName = "내추럴 와인"; break;
case "120": product_kindName = "샴페인"; break;
case "130": product_kindName = "스파클링 와인"; break;
case "210": product_kindName = "레드 와인"; break;
case "220": product_kindName = "화이트 와인"; break;
case "310": product_kindName = "로제 와인"; break;
case "320": product_kindName = "주정강화 와인"; break;
case "410": product_kindName = "와인 글라스"; break;
case "420": product_kindName = "코르크 스크류"; break;
case "510": product_kindName = "와인 렉"; break;
case "520": product_kindName = "와인 셀러"; break;
}

DecimalFormat df = new DecimalFormat("#,###,###");  

//########페이징(paging) 처리###########
//페이징 처리를 위한 변수 선언
int pageSize = 8; // 1페이지에 8건의 게시글을 보여줌
String pageNum = request.getParameter("pageNum");// 페이지 번호
if(pageNum == null) pageNum = "1";				 // 페이지 번호가 없다면 1페이지로 설정

int currentPage = Integer.parseInt(pageNum); 	 // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지의 첫번째 행
int endRow = currentPage * pageSize;			 // 현재 페이지의 마지막 행
//###################

ProductDAO productDAO = ProductDAO.getInstance();

// 분류별 상품에 대한 페이징 처리
List<ProductDTO> productList = 
productDAO.getProductList(startRow, pageSize, product_kind);
int cnt = productDAO.getProductCount(product_kind);

/* 데이터가 잘 넘어오는지 검사 (디버깅)
for(ProductDTO product : productList) {
	System.out.println(product); // 매소드를 생략하면 자동으로 toString 매소드 실행
}
*/

%>
<%-- 분류별 상품을 4개씩 3단으로 처리 --%>
<div class="t_kind" id="t_kind">
	<div class="d_kind1">
		<span class="s_kind1"><b class="s_kind11"><%=product_kindName %></b> 분야 상품 목록</span>
		<span class="s_kind2">
			<select id="product_kind">
				<option value="110" <%if(product_kind.equals("110")) {%> selected <%} %>>내추럴 와인</option>
				<option value="120" <%if(product_kind.equals("120")) {%> selected <%} %>>샴페인</option>
				<option value="130" <%if(product_kind.equals("130")) {%> selected <%} %>>스파클링 와인</option>
				<option value="210" <%if(product_kind.equals("210")) {%> selected <%} %>>레드 와인</option>
				<option value="220" <%if(product_kind.equals("220")) {%> selected <%} %>>화이트 와인</option>
				<option value="310" <%if(product_kind.equals("310")) {%> selected <%} %>>로제 와인</option>
				<option value="320" <%if(product_kind.equals("320")) {%> selected <%} %>>주정강화 와인</option>
				<option value="410" <%if(product_kind.equals("410")) {%> selected <%} %>>와인 글라스</option>
				<option value="420" <%if(product_kind.equals("420")) {%> selected <%} %>>코르크 스크류</option>
				<option value="510" <%if(product_kind.equals("510")) {%> selected <%} %>>와인 렉</option>
				<option value="520" <%if(product_kind.equals("520")) {%> selected <%} %>>와인 셀러</option>
			</select>
		</span>
	</div>
	<div class="d_kind2">상품수: 총 <b class="s_kind21"><%=cnt %></b>건</div>
	<%for(ProductDTO product : productList) {%>
	<div class="d_kind3">
		<div class="c_product">
			<div class="c_p1"><img src="/images_wineclub/<%=product.getProduct_image()%>" width="200" height="260"></div>
			<div class="c_p2"><span title="<%=product.getProduct_name() %>"><%=product.getProduct_name() %></span></div>
			<div class="c_p3"><span title="<%=product.getOrigin() %>"><%=product.getOrigin() %></span>
			<%if(product.getWine_variety()!=null) out.print(" | <span>" + product.getWine_variety() + "</span>");  %></div>
			<div class="c_p4"><span title="<%= product.getProduct_price() %>"><%=df.format(product.getProduct_price()) %></span>원 (<span class="s_p_discount"><%=product.getDiscount_rate() %>% 할인</span>)</div>
		</div>
		<div class="c_product2">
			<a href="../buy/buyForm.jsp?product_id=<%=product.getProduct_id() %>&part=1"><div class="c_p5">구매</div></a>
			<a href="shopContent.jsp?product_id=<%= product.getProduct_id()%>"><div class="c_p6">상세</div></a>
		</div>
	</div>
	<%} %>
	<%-- 하단: 페이징 처리 --%>
	<div id="paging">
	<%
	if(cnt > 0) {
		int pageCount = 
		cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지 수
		int startPage = 1; // 시작 페이지 번호
		int pageBlock = 3; // 한 화면에 드러나는 페이지의 갯수 (3개)
		// 시작 페이지 설정
		if(currentPage % 3 != 0) startPage = (currentPage/3) * 3 + 1;
		else startPage = (currentPage/3-1)	* 3 + 1;
		// 끝 페이지 설정
		int endPage = startPage + pageBlock -1;
		if(endPage > pageCount) endPage = pageCount; 
	
		// 맨 처음 페이지 이동 처리
		if(startPage > 3) {
			out.print("<a href='shopAll.jsp?pageNum=1&product_kind=" + product_kind + "#t_kind'><div id='pBox' class='pBox_b' title='첫 페이지'>"+"〈〈"+"</div></a>");
		}
		
		// 이전 페이지 이동 처리
		if(startPage > 3) {
			out.print("<a href='shopAll.jsp?pageNum="+(currentPage-3)+"&product_kind=" + product_kind + "#t_kind'><div id='pBox' class='pBox_b' title='이전 페이지'>"+"〈"+"</div></a>");
		}
		
		// 페이징 블럭 출력 처리
		for(int i=startPage; i<=endPage; i++) {
			if(currentPage == i) { // 마우스로 선택된 페이지 번호가 현재 페이지 번호일 때
				out.print("<div id='pBox' class='pBox_c'>"+i+"</div>");
			} else { // 마우스로 선택된 페이지 번호가 다른 페이지 번호일 때 -> 이동에 대한 링크 설정
				out.print("<a href='shopAll.jsp?pageNum="+i+"&product_kind=" + product_kind + "#t_kind'><div id='pBox'>"+i+"</div></a>");
			}
		}
		// 다음 페이지 처리
		if(endPage < pageCount) {
			int movePage = currentPage + 3;
			if(movePage > pageCount) movePage = pageCount;
			out.print("<a href='shopAll.jsp?pageNum="+movePage+"&product_kind=" + product_kind + "#t_kind'><div id='pBox' class='pBox_b' title='다음 페이지'>"+"〉"+"</div></a>");
		}
		// 맨 끝 페이지 이동 처리
		if(endPage < pageCount) {
			out.print("<a href='shopAll.jsp?pageNum="+pageCount+"&product_kind=" + product_kind + "#t_kind'><div id='pBox' class='pBox_b' title='끝 페이지'>"+"〉〉"+"</div></a>");
		}
	}  
	%>
	</div>
</div>
<hr class="main_end">