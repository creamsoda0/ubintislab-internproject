<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Context Path 설정 (이미지, CSS 경로 깨짐 방지) --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>

<%-- [중요] CSS 경로 수정: ${contextPath} 추가 --%>
<link rel="stylesheet" type="text/css" href="${contextPath}/member/css/import.css"/>

<title>서산시청 통합로그인</title>

<%-- 간단한 스크립트 추가 (동의 체크 확인용) --%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	function checkAgree() {
		if(!$("#ckok1").is(":checked")) {
			alert("통합회원 이용약관에 동의해주세요.");
			$("#ckok1").focus();
			return;
		}
		if(!$("#ckok2").is(":checked")) {
			alert("개인정보 수집 및 이용안내에 동의해주세요.");
			$("#ckok2").focus();
			return;
		}
		if(!$("#ckok3").is(":checked")) {
			alert("수집한 개인정보의 제3자 제공에 동의해주세요.");
			$("#ckok3").focus();
			return;
		}
		
		// 모두 동의했을 경우 처리 (예: form submit)
		alert("모든 약관에 동의하셨습니다. 다음 단계로 이동합니다.");
		// location.href = "${contextPath}/member/updateProcess"; 
	}
</script>
</head>
<body>
		
	<div id="header">
		<%-- 이미지 경로 수정: ${contextPath} 추가 --%>
		<h1><img src="${contextPath}/member/img/logo.png" alt="서산시 통합회원 상단로고" /></h1>
		<div>
			<ul>
				<li><a href="#">통합로그인</a></li>
				<li><a href="#">통합회원가입</a></li>
				<li><a href="#">아이디찾기</a></li>
				<li><a href="#">비밀번호찾기</a></li>
				<li><a href="#">회원정보수정</a></li>
				<li><a href="#">비밀번호변경</a></li>
				<li><a href="#">통합회원탈퇴</a></li>
			</ul>
		</div>
	</div>
	<div id="content">
		
		<div class="top_img">			
			<p>이용약관 재동의</p>
		</div>
		<div class="wrap">

			<div class="mt50 text">
				<h3>회원정보 재동의에 따른 약관동의</h3>
				
				<form id="agreeForm" action="${contextPath}/member/agree" method="post">
					<p class="s_title mt50">이용약관</p>
					<div class="terms mt15">
						제 1 장 총칙<br /><br />
	
						제 1 조 [목적]<br />
						본 약관은 아산시청이 운영하는 가족사이트 <br />
						(중략)<br />
					</div>
					<p class="terms_form mt10"><input type="checkbox" name="agree1" title="통합회원 이용약관 체크" id="ckok1" />&nbsp;&nbsp;<label for="ckok1">통합회원 이용약관에 동의합니다.</label></p>
					
					<p class="s_title mt50">개인정보 수집 이용약관</p>
					<div class="terms mt15">
						제 1 장 총칙<br /><br />
	
						제 1 조 [목적]<br />
						본 약관은 아산시청이 운영하는 가족사이트 <br />
						(중략)<br />
					</div>
					<p class="terms_form mt10"><input type="checkbox" name="agree2" title="개인정보 수집 이용약관 체크" id="ckok2" />&nbsp;&nbsp;<label for="ckok2">개인정보 수집 및 이용안내를 숙지하였습니다.</label></p>
					
					<p class="s_title mt50">수집한 개인정보의 제3자 제공</p>
					<div class="terms mt15">
						제 1 장 총칙<br /><br />
	
						제 1 조 [목적]<br />
						본 약관은 아산시청이 운영하는 가족사이트 <br />
						(중략)<br />
					</div>
					<p class="terms_form mt10"><input type="checkbox" name="agree3" title="수집한 개인정보의 제3자 제공 체크" id="ckok3" />&nbsp;&nbsp;<label for="ckok3">수집한 개인정보의 제3자 제공을 숙지하였습니다.</label></p>
					
					<div class="btn mt50 t_center">
						<%-- 버튼 클릭 시 자바스크립트 호출 --%>
						<button type="button" class="btn_blue" onclick="checkAgree()">동의합니다</button>
						<button type="button" class="btn_gray ml20" onclick="history.back()">동의하지 않습니다</button>
					</div>				
				</form>
			</div>
			</div>
		
	</div>
	<footer>
		<div id="footer">
			<div class="foot_bottom">
				<div class="foot_inner">
					<%-- 이미지 경로 수정 --%>
					<h2><img src="${contextPath}/img/foot_logo.png" alt="서산시 하단로고" /></h2>
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