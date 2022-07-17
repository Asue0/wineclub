<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Lato:wght@100&family=Oswald:wght@200&family=Patua+One&display=swap');
#container { width: 1200px; margin: 0 auto; }
a { text-decoration: none; color: #59637f; font-weight: bold; }
/* 상단 - 메인, 서브 타이틀 */
.m_title { font-family: 'Lobster', cursive; font-size: 3em; text-align: center; }
.m_title a { color: #cd4d4d; }
.s_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em;
 		font-weight: bold; text-align: center; margin-bottom: 30px; }
.s_title a { color: black; }
/* 상단 - 전체 상품수, 아이디, 로그아웃 , 상품등록 */
.top_info { margin-bottom: 10px; text-align: right; }
.c_cnt { float: left; }
.c_cnt, .c_managerId { color: #59637f; font-size: 0.95em; font-weight: bold; }
.c_managerId { clear: both; }
.c_logout a { color: #99424f; }
/* 상단 - 검색  */
.top_search { margin-bottom: 10px; }
.c_select { width: 153px; height: 25px; }
.c_input { width: 200px; height: 19px; }
.c_submit { width: 82px; height: 27px; border: none; background: #000;
 	color: #fff; font-size: 0.8em; font-weight: bold; border-radius: 3px; }

/* 중단 - 상품 정보 테이블 */
table { width: 100%; border: 1px solid black; border-collapse: collapse; font-size: 0.9em; }
tr { height: 30px; }
tr:nth-child(2n+1) { background: #f8f9fa; }
th, td { border: 1px solid black; }
th { background: #dee2e6; }
.center { text-align: center; }
.left { text-align: left; padding-left: 3px; }
.right { text-align: right; padding-right: 3px; }
.img_update:hover { content: url('../../icons/update2.png'); }
.img_delete:hover { content: url('../../icons/delete2.png'); }
.f_row { text-align: center; font-weight: bold; color: #c84557; }
/* 하단 - 페이징 영역 */
#paging { text-align: center; margin-top: 20px; }
#pBox { display: inline-block; width: 22px; height: 22px; padding: 5px;
		margin: 5px;  }
#pBox:hover { background: #495057; color: white; font-weight: bold;
		  	  border-radius: 10px; }	
.pBox_c { background: #495057; color: white; font-weight: bold;
		  border-radius: 10px; }
.pBox_b { font-weight: bold; }  
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		
	})
</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String managerId = (String)session.getAttribute("managerId");
if(managerId == null) out.print("<script>location = '../logon/managerLoginForm.jsp';</script>");



SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
DecimalFormat df = new DecimalFormat("#,###,###");
String product_kindName = ""; // 상품 이름을 숫자에서 이름으로 바꿔주기 위한 변수


//########페이징(paging) 처리###########
//페이징 처리를 위한 변수 선언
int pageSize = 10; // 1페이지에 10건의 게시글을 보여줌
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1";				  // 페이지 번호가 없다면 1페이지로 설정

int currentPage = Integer.parseInt(pageNum); 	 // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지의 첫번째 행
int endRow = currentPage * pageSize;			 // 현재 페이지의 마지막 행

//###################

// 검색 처리  - 검색일때는 search가 1이고, 검색이 아닐 때는 search가 0

String search = request.getParameter("search");
String s_search = "";
String i_search = "";

if(search == null) { 
	search = "0";
} else {  // search가 "1"일 경우 (검색일 경우)
	s_search = request.getParameter("s_search");
	i_search = request.getParameter("i_search");
}


// DB 연결, 질의 처리
ProductDAO productDAO = ProductDAO.getInstance();
// 전체 상품수 조회
int cnt = 0;
// 전체 상품 조회 - 페이징 처리가 된 상품 목록, 검색 처리(search가 1이면 검색, search가 0이면 검색이 아님)
List<ProductDTO> productList = null;
if(search.equals("1")) {
	productList =  productDAO.getProductList(startRow, pageSize, s_search, i_search);
	cnt = productDAO.getProductCount(s_search, i_search);
}
else if(search.equals("0")){
	productList = productDAO.getProductList(startRow, pageSize);
	cnt = productDAO.getProductCount();
}

//매 페이지마다 전체 글수에 대한 역순 번호
int number = cnt - ((currentPage-1) * pageSize); 


%>
<div id="container">
	<%-- 상단: 타이틀  --%>
	<div class="m_title"><a href="../managerMain.jsp">WINE CLUB</a></div>
	<div class="s_title"><a href="productList.jsp">상품 목록</a></div>
	<%-- 싱단: 아이디, 로그아웃, 상품등록 --%>
	<div class="top_info">
		<span class="c_cnt">전체 상품수: <%=cnt %>개</span>
		<span class="c_managerId"><%=managerId %>님(관리자)</span>&emsp;|&emsp;
		<span class="c_logout"><a href="../logon/managerLogout.jsp">로그아웃</a></span>&emsp;|&emsp;
		<span class="c_register_product"><a href="productRegisterForm.jsp">상품등록</a></span>
	</div>
	<%-- 상단: 검색 --%>
	<div class="top_search">
		<form action="productList.jsp" method="post" name="searchForm">
			<input type="hidden" name="search" value="1">
			<span class="c_s1">
				<select name="s_search" class="c_select">
					<option selected>제목</option>
					<option>원산지</option>
					<option>와인 품종</option>
					<option>상품 종류</option>
				</select>
			</span>
			<span class="c_s2"><input type="text" name="i_search" class="c_input"></span>
			<span class="c_s3"><input type="submit" value="검색" class="c_submit"></span>
		</form>
	</div>
	<%-- 중단: 상품 테이블 --%>
	<table>
		<tr>
			<th width="4%">NO</th>
			<th width="9%">상품분류</th>
			<th width="5%">이미지</th>
			<th width="20%">제목</th>
			<th width="8%">상품가격</th>
			<th width="4%">수량</th>
			<th width="12%">원산지</th>
			<th width="12%">품종</th>
			<th width="7%">알콜 도수</th>
			<th width="4%">할인율</th>
			<th width="7%">등록일</th>
			<th width="8%">수정 | 삭제</th>
		</tr>
		<%if(cnt == 0) { // 등록된 글이 없을 때
			out.print("<tr><td colspan='13' class='f_row'>등록된 글이 없습니다.</td></tr>");
		} else { 		 // 등록된 글이 있을 때
			for(ProductDTO product : productList) {
				// 상품 분류를 숫자에서 이름으로 바꾸어주는 작업
				switch(product.getProduct_kind()) {
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
		%> 
		<tr>
			<td class="center"><%=number-- %></td>
			<td class="center"><%=product_kindName %></td>
			<td class="center">
				<a href="productContent.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum %>">
					<img src=<%="/images_wineclub/" + product.getProduct_image() %> width="35px" height="50px">
				</a>
			</td>
			<td class="left">
				<a href="productContent.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum %>"><%=product.getProduct_name() %></a>
			</td>
			<td class="right"><%=df.format(product.getProduct_price()) %>원</td>
			<td class="right"><%=df.format(product.getProduct_count()) %>개</td>
			<td class="center"><%=product.getOrigin() %></td>
			<td class="center"><%if(product.getWine_variety()!=null) out.print(product.getWine_variety()); %></td>
			<td class="center"><%if(product.getAlcoholicity()!=null) out.print(product.getAlcoholicity() + "%"); %></td>
			<td class="center"><%=product.getDiscount_rate() %>%</td>
			<td class="center"><%=sdf.format(product.getReg_date()) %></td>
			<td class="center">
				<a href="productContent.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum %>" title="상품수정폼 이동"><img src="../../icons/update1.png" width="25" class="img_update"></a>&nbsp;
				<a href="productDeletePro.jsp?product_id=<%=product.getProduct_id() %>&pageNum=<%=pageNum %>" title="상품삭제"><img src="../../icons/delete1.png" width="25" class="img_delete"></a>
			</td>
		</tr>
		<%} }%>
	</table>
	<%-- 하단: 페이징 처리 --%>
	<div id="paging">
	<%
	if(cnt > 0) {
		int pageCount = cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지 수
		int startPage = 1; // 시작 페이지 번호
		int pageBlock = 10; // 한 화면에 드러나는 페이지의 갯수 (10개)
		// 시작 페이지 설정
		if(currentPage % 10 != 0) startPage = (currentPage/10) * 10 + 1;
		else startPage = (currentPage/10-1)	* 10 + 1;
		// 끝 페이지 설정
		int endPage = startPage + pageBlock -1;
		if(endPage > pageCount) endPage = pageCount; 
		
		// 맨 처음 페이지 이동 처리
		if(startPage > 10) {
			out.print("<a href='productList.jsp?pageNum=1&search="+search+"&s_search="+s_search+"&i_search="+i_search+"'><div id='pBox' class='pBox_b' title='첫 페이지'>"+"〈〈"+"</div></a>");
		}
		// 이전 페이지 이동 처리
		if(startPage > 10) {
			out.print("<a href='productList.jsp?pageNum="+(currentPage-10)+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"'><div id='pBox' class='pBox_b' title='이전 페이지'>"+"〈"+"</div></a>");
		}
		
		// 페이징 블럭 출력 처리
		for(int i=startPage; i<=endPage; i++) {
			if(currentPage == i) { // 마우스로 선택된 페이지 번호가 현재 페이지 번호일 때
				out.print("<div id='pBox' class='pBox_c'>"+i+"</div>");
			} else { // 마우스로 선택된 페이지 번호가 다른 페이지 번호일 때 -> 이동에 대한 링크 설정
				out.print("<a href='productList.jsp?pageNum="+i+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"'><div id='pBox'>"+i+"</div></a>");
			}
		}
		// 다음 페이지 처리
		if(endPage < pageCount) {
			int movePage = currentPage + 10;
			if(movePage > pageCount) movePage = pageCount;
			out.print("<a href='productList.jsp?pageNum="+movePage+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"'><div id='pBox' class='pBox_b' title='다음 페이지'>"+"〉"+"</div></a>");
		}
		// 맨 끝 페이지 이동 처리
		if(endPage < pageCount) {
			out.print("<a href='productList.jsp?pageNum="+pageCount+"&search="+search+"&s_search="+s_search+"&i_search="+i_search+"'><div id='pBox' class='pBox_b' title='끝 페이지'>"+"〉〉"+"</div></a>");
		}
	}  
	%>
	</div>
</div>
</body>
</html>