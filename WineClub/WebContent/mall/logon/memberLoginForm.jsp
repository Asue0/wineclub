<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
<style>
/* 웹폰트에서 폰트 경로 임폴트 */
@import url('https://fonts.googleapis.com/css2?family=Lato:wght@100&family=Oswald:wght@200&family=Patua+One&family=Ubuntu:wght@300&display=swap');
#container { width: 1200px; margin: 0 auto; }
/* 상단 메인, 서브 타이틀 */
.t_title { font-family: 'Ubuntu', sans-serif;  font-size: 2em;
 font-weight: bold; text-align: center; margin: 30px 0; }
a { text-decoration: none; color: black; }
/* 중단 - 입력창 */
.f_input { width: 450px; text-align: center; border: 1px solid #ccc; padding: 10px; margin: 0 auto; }
.f_input .c_id, .f_input .c_pwd { height: 45px; margin-top: 20px; padding-left: 5px; }
.f_input .f_chk { text-align: left; margin: 10px 0 0 10px; font-size 0.9em; color: gray; }
.f_input #btn_login { width: 425px;  height: 45px; margin-top: 25px; 
	background: black; color: white; font-size: 16px; font-weight: bold; 
	cursor: pointer; margin-top: 25px; margin-bottom: 10px; }
/* 하단 - 비밀번호 찾기, 아이디 찾기, 회원가입*/
.f_a { text-align: center; margin-top: 30px; font-size: 0.9em; }
.f_a a { color: gray; }
.t_line { border: 1px solid #e9ecef; margin: 30px 0; }
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.loginForm;
		// 로그인 버튼을 클릭했을 때 유효성 검사 (공백 유무)
		let btn_login = document.getElementById("btn_login");
		btn_login.addEventListener("click", function() {
			if(!form.id.value) {
				alert('아이디를 입력하세요');
				form.id.focus();
				return;
			}
			if(!form.pwd.value) {
				alert('비밀번호를 입력하세요');
				form.pwd.focus();
				return;
			}
			form.submit();
		})
		// 쿠키가 생성되어 있을 때 쿠키에 저장된 값인 아이디를 아이디 입력상자에 놓도록 하는 작업
		/*
		이미 쿠키를 생성했다는 가정 하에 쿠키는 지금 이런 형태가 되어 있다.
		**************cookieId=아이디이름;path=/;expires=
		이 상태에서 cookieId값만 찾는 법은 cookieId=를 indexOf를 통해 시작지점으로 찾아내고,
		indexOf(';' 시작지점)을 통해 cookieid가 끝나는 지점을 찾아낸다.
		그리고 substring(시작지점, 마지막지점)을 통해 완전한 cookieid값을 찾아내면 된다.
		*/
		if(document.cookie.length > 0) { // 쿠키의 값이 있다면 (쿠키 값의 길이가 0보다 크다면)
			let search = "cookieId=";
			let idx = document.cookie.indexOf(search); // 쿠키 중에서 cookieId=이 나오는 위치를 찾음
			if(idx != -1) { // 쿠키 값에 id값이 있다면
				idx += search.length;
				let end = document.cookie.indexOf(';', idx);
				if(end == -1) { 
					end = document.cookie.length;
				}
				form.id.value = document.cookie.substring(idx, end);
				form.chk.checked = true;
			}
		}
		// 로그인 상태 유지를 체크 했을 때의 기능 -> 쿠키를 이용
		// http 기본 속성: 연결 상태를 유지하지 않음
		// -> cookie, session을 이용해 연결 상태를 유지할 수 있음
		// 주의) 쿠키 생성시는 escape() 함수를 사용해 value를 받아야 한다.
		// escape() 함수: *, -, _, +, ., /를 제외한 모든 문자를 16진수로 변환하는 함수
		// -> 쉼표, 세미콜론 등과 같은 문자가 쿠키에서 사용되는 문자열과 충돌을 방지하기 위해서 사용
		let chk = document.getElementById("chk");
		chk.addEventListener("click", function() {
			let now = new Date(); 		// 오늘 날짜
			let name = "cookieId";		// 쿠키 이름
			let value = form.id.value;	// 쿠키 값
			if(form.chk.checked) {   // 체크 박스를 선택했을 때 (chk.checked가 값을 가질 때) -> 쿠키 생성
				// 쿠키 만료 시간을 설정
				now.setDate(now.getDate() + 7) // 만료시간: 지금 날짜로부터 일주일 후에 만료
		
			} else { // 체크 박스를 해제했을 때 -> 체크박스를 해제했을 때 -> 쿠키 삭제
				// 쿠키 만료 시간을 설정
				now.setDate(now.getDate() + 0); // 만료시간: 지금 시간으로 설정
			}
			// 쿠키 생성시에 필요한 정보: 쿠키의 이름과 값, 위치, 만료시간 
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";";
		});
	})
</script>
</head>
<body>
<div id="container">
	<jsp:include page="../common/shopTop.jsp" />
	<div class="t_title">WineClub LogIn</div>
	<form action="memberLoginPro.jsp" method="post" name="loginForm">
		<div class="f_input">
			<div class="f_id"><input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="55"></div>
			<div class="f_pwd"><input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="55"></div>
			<div class="f_chk">
				<input type="checkbox" id="chk" class="c_chk" size="55">&nbsp;
				<label for="chk">아이디 저장</label>
			</div>
			<div class="f_submit"><input type="button" value="로그인" id="btn_login" ></div>
		</div>
		<div class="f_a">
			<a href="#">비밀번호 찾기</a>&emsp;|&emsp;
			<a href="#">아이디 찾기</a>&emsp;|&emsp;
			<a href="../member/memberJoinForm.jsp">회원가입</a>
		</div>
	</form>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp" />
</div>
</body>
</html>