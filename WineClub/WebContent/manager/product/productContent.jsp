<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lobster&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Lato:wght@100&family=Oswald:wght@200&family=Patua+One&display=swap');
#container { width: 550px; margin: 0 auto; }
a { text-decoration: none; color: black; font-weight: bold; }
/* 상단 - 메인, 서브 타이틀 */
.m_title { font-family: 'Lobster', cursive; font-size: 3em; text-align: center; }
.m_title a { color: #cd4d4d; }
.s_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em;
 		font-weight: bold; text-align: center; margin-bottom: 30px; }
/* 중단 - 상품 등록 테이블 */
table { width: 100%; border: 1px solid #705e7b; border-collapse: collapse; 
	border-top: 3px solid #705e7b; border-bottom: 3px solid #705e7b;
	border-left: hidden; border-right: hidden; }
tr { height: 35px; }
td, th { border: 1px solid #705e7b; }
th { background: #e6c9e1; }
td { padding-left: 5px; }
/* 중단 - 테이블 안의 입력상자  */
.c_p_id, .c_p_reg_date  { background: #e9ecef; }
.s_p_id, .s_p_reg_date { color: #f00; font-size: 0.9em; font-weight: bold; margin-left: 10px; }
.s_p_image { color: #00f; font-size: 0.8em; }
input[type="number"] { width: 100px; }
textarea { margin-top: 5px; }
/* 하단 - 버튼 */
select { height: 25px; }
input::file-selector-button { width: 90px; height: 28px; background: #705e7b; color: #fff;
	border: none; border-radius: 3px; font-weight: bold; cursor: pointer; }
.btns { text-align: center; margin-top: 10px; }
.btns input { width: 110px; height: 37px; border: none; background: #495057;
		color: #fff; font-weight: bold; margin: 5px; cursor: pointer; }
.btns input:nth-child(1), .btns input:nth-child(2) { background: #705e7b; }
.btns input:nth-child(1):hover, .btns input:nth-child(2):hover { border: 2px solid #2f9e77; background: #fff;
	color: #2f9e77; font-weight: bold; }
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.updateForm	;
	
		// 상품 분류가 선택되도록  설정 ex) 자기계발: 310
		let product_kind = form.product_kind; // select 절
		let p_kind = form.p_kind;			// ex) 자기계발: 310이 있는 input
		for(let i=0; i<product_kind.length; i++) {
			if(p_kind.value == product_kind[i].value) {
				product_kind[i].selected = true;
				break;
			}
		}
		// 상품 수정 처리 페이지 이동 버튼	
		let btn_update = document.getElementById("btn_update");
		btn_update.addEventListener("click", function() {
			if(!form.product_name.value) {
				alert('상품 제목을 입력하시오.');
				return;
			}
			if(!form.product_price.value) {
				alert('상품 가격을 입력하시오.');
				return;
			}
			if(!form.product_count.value) {
				alert('상품 수량을 입력하시오.');
				return;
			}
			if(!form.origin.value) {
				alert('원산지를 입력하시오.');
				return;
			}
			if(form.product_kind.value < 400) {
				if(!form.wine_variety.value) {
					alert('와인 품종을 입력하시오.');
					return;
				}
				if(!form.alcoholicity.value) {
					alert('알코올 도수를 입력하시오.');
					return;
				}
				if(!form.amount.value) {
					alert('와인 양을 입력하시오.');
					return;
				}
			}
			if(!form.discount_rate.value) {
				alert('할인율을 입력하시오.');
				return;
			}
			form.submit();
		});
		
		// 악세서리류 등록시 불필요한 필드 목록 입력 제한(와인 품종, 알코올 도수, 와인 양)
		if(form.product_kind.value > 400) {
			form.wine_variety.value = null;
			form.alcoholicity.value = null;
			form.amount.value = null;	
			form.wine_variety.setAttribute('disabled', true);
			form.alcoholicity.setAttribute('disabled', true);
			form.amount.setAttribute('disabled', true);
		}
		
		form.product_kind.addEventListener("change", function() {
			if(form.product_kind.value > 400) {
				form.wine_variety.setAttribute('disabled', true);
				form.alcoholicity.setAttribute('disabled', true);
				form.amount.setAttribute('disabled', true);
			} else {
				form.wine_variety.removeAttribute('disabled');
				form.alcoholicity.removeAttribute('disabled');
				form.amount.removeAttribute('disabled');
			}
		})
		
		
		// 상품 삭제 처리 페이지로 이동
		let product_id = form.product_id.value; // 겟 방식으로 아이디만 따로 넘겨주기 위해 변수 선언
		let pageNum = form.pageNum.value; // 겟 방식으로 pageNum을 넘기기 위해 변수 선언
		
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click", function() {
			location = 'productDeletePro.jsp?product_id=' + product_id + "&pageNum=" + pageNum;
		});
		
		// 상품 목록 이동 버튼
		let btn_list = document.getElementById("btn_list");
		btn_list.addEventListener("click", function() {
			location = 'productList.jsp?pageNum=' + pageNum;
		})
		// 관리자 페이지 이동 버튼
		let btn_main = document.getElementById("btn_main");
		btn_main.addEventListener("click", function() {
			location = '../managerMain.jsp';
		})
	});
</script>
</head>
<body>
<%

String managerId = (String) session.getAttribute("managerId");
if(managerId==null) out.print("<script>location = '../logon/managerLoginForm.jsp' </script>"); 


String pageNum = request.getParameter("pageNum");
int product_id = Integer.parseInt(request.getParameter("product_id"));

// DB 연결, 질의 처리
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);


SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

%>

<div id="container">
	<div class="m_title"><a href="../managerMain.jsp">WINE CLUB</a></div>
	<div class="s_title">상품 정보 확인</div>
	
	<form action="productUpdatePro.jsp" method="post" name="updateForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<table>
			<tr>
				<th>상품번호</th>
				<td>
					<input type="text" name="product_id" value="<%=product.getProduct_id() %>" size="10" readonly class="c_p_id">
					<span class="s_p_id">상품번호는 변경불가</span>
				</td>
			</tr>
			<tr>
				<th width="20%">상품 분류</th>
				<td width="80%">
					<input type="hidden" name="p_kind" value="<%=product.getProduct_kind() %>" >
					<select name="product_kind">
						<option value="110">내추럴 와인</option>
						<option value="120">샴페인</option>
						<option value="130">스파클링 와인</option>
						<option value="210">레드 와인</option>
						<option value="220">화이트 와인</option>
						<option value="310">로제 와인</option>
						<option value="320">주정강화 와인</option>
						<option value="410">와인 글라스</option>
						<option value="420">코르크 스크류</option>
						<option value="510">와인 렉</option>
						<option value="520">와인 셀러</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>상품 제목</th>
				<td><input type="text" name="product_name" size="56" value="<%=product.getProduct_name() %>"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="product_price" min="1000" max="1000000" value="<%=product.getProduct_price() %>">원</td>
			</tr>
			<tr>
				<th>상품 수량</th>
				<td><input type="number" name="product_count" min="0" max="100000" value="<%=product.getProduct_count() %>">개</td>
			</tr>
			<tr>
				<th>원산지</th>
				<td><input type="text" name="origin" size="10" value="<%=product.getOrigin() %>"></td>
			</tr>
			<tr>
				<th>와인 품종</th>
				<td><input type="text" name="wine_variety" size="40" value="<%if(product.getWine_variety()!=null) out.print(product.getWine_variety()); %>"></td>
			</tr>
			<tr>
				<th>알코올 도수</th>
				<td><input type="text" name="alcoholicity" size="10" value="<%if(product.getAlcoholicity()!=null) out.print(product.getAlcoholicity()); %>">%</td>
			</tr>
			<tr>
				<th>와인 양</th>
				<td><input type="number" name="amount" min="0" value="<%=product.getAmount() %>">ml</td>
			</tr>
			<tr>
				<th>상품 이미지</th>
				<td>
					<input type="file" name="product_image"><br>
					<span class="s_p_image">상품 이미지를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>상품 내용</th>
				<td>
					<input type="file" name="product_content"><br>
					<span class="s_p_image">상품 내용 이미지를 다시 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input type="number" name="discount_rate" min="0" max="90" value="<%=product.getDiscount_rate() %>">%</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>
					<input type="text" name="reg_date" value="<%=sdf.format(product.getReg_date()) %>" size="10" readonly class="c_p_reg_date">
					<span class=s_p_reg_date>등록일은 변경불가</span> 
				</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="상품 정보 수정" id="btn_update">
			<input type="reset" value="상품 정보 삭제" id="btn_delete">
			<input type="button" value="상품 목록" id="btn_list">
			<input type="button" value="관리자 페이지" id="btn_main">
		</div>
	</form>
</div>
</body>
</html>