<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>

<link rel="stylesheet" type="text/css" href="${contextPath}/static/member/css/import.css"/>

<title>서산시청 통합로그인 - 아이디 찾기</title>

<script>
	function findIdCheck() {
		var name = document.getElementById("name");
		var email = document.getElementById("email");

		if(name.value == "") {
			alert("이름을 입력해주세요.");
			name.focus();
			return;
		}
		if(email.value == "") {
			alert("이메일을 입력해주세요.");
			email.focus();
			return;
		}

		// 폼 전송
		document.findIdForm.submit();
	}
</script>
</head>
<body>
		
	<div id="header">
		<h1><img src="${contextPath}/static/member/img/logo.png" alt="서산시 통합회원 상단로고" /></h1>
		<div>
			<ul>
				<li><a href="${contextPath}/member/login">통합로그인</a></li>
				<li><a href="${contextPath}/member/join">통합회원가입</a></li>
				<li><a href="${contextPath}/member/findId">아이디찾기</a></li>
				<li><a href="${contextPath}/member/findPw">비밀번호찾기</a></li>
				<li><a href="${contextPath}/member/myPage">회원정보수정</a></li>
				<li><a href="#">비밀번호변경</a></li>
				<li><a href="${contextPath}/member/delete">통합회원탈퇴</a></li>
			</ul>
		</div>
	</div>
	<div id="content">
		
		<div class="top_img">			
			<p>아이디찾기</p>
		</div>
		<div class="wrap">
			
			<div class="step">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="50%">
						<col width="*">
					</colgroup>
					<tr>
						<td class="step_select">본인인증</td>
						<td>통합회원 아이디찾기 완료</td>
					</tr>
				</table>
			</div>
				<div class="mt50 text">
				<h3>아이디 찾기</h3>
				<p class="bullet01 mt20">회원가입 시 등록한 <b>이름</b>과 <b>이메일</b>을 입력해 주세요.</p>
				
				<form action="${contextPath}/member/findIdProcess" method="post" name="findIdForm">
					<table cellpadding="0" cellspacing="0" class="mt30">
						<colgroup>
							<col width="20%">
							<col width="*">
						</colgroup>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="name" id="name" style="width:250px;" placeholder="가입하신 이름을 입력하세요">
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" name="email" id="email" style="width:250px;" placeholder="가입하신 이메일을 입력하세요">
							</td>
						</tr>
					</table>

					<div class="btn mt30 t_center">
						<button type="button" class="btn_blue" onclick="findIdCheck()">아이디 찾기</button>
						<button type="button" class="btn_gray ml10" onclick="history.back()">취소</button>
					</div>
				</form>
				</div>
		
	</div>
	<footer>
		<div id="footer">
			<div class="foot_bottom">
				<div class="foot_inner">
					<h2><img src="${contextPath}/static/member/img/foot_logo.png" alt="서산시 하단로고" /></h2>
					<div class="foot_info">
						<h3 class="hid" style="display:none">하단 메뉴</h3>
						<ul class="foot_menu">
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=2469" target="_blank" title="새창열림">개인정보처리방침</a></li>
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=1251" target="_blank" title="새창열림">이메일무단수집거부</a></li>
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=1350" target="_blank" title="새창열림">홈페이지 개선의견</a></li>
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=1253" target="_blank" title="새창열림">RSS 서비스</a></li>
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=2237" target="_blank" title="새창열림">뷰어다운로드</a></li>
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=1383" target="_blank" title="새창열림">오시는길</a></li>
						</ul>
						<p class="copy notranslate">[31974] 충남 서산시 관아문길 1 (읍내동)  / TEL:041-660-2114 / FAX:041-660-2357
							<br /> COPYRIGHT 2016(C) THE CITY OF SEOSAN. ALL RIGHTS RESERVED.</p>
					</div>
				</div>
			</div>
		</div>
	</footer>
	</body>
</html>