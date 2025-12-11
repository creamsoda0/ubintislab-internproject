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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<title>서산시청 통합로그인 - 비밀번호 재설정</title>

<script>
    function changePwCheck() {
        var userPw = $("#userPw").val();
        var userPwConfirm = $("#userPwConfirm").val();

        // 1. 빈 값 체크
        if(userPw == "") {
            alert("새 비밀번호를 입력해주세요.");
            $("#userPw").focus();
            return;
        }
        
        // 2. 비밀번호 길이 체크 (9~20자)
        if(userPw.length < 9 || userPw.length > 20) {
            alert("비밀번호는 9자 이상, 20자 이하로 입력해주세요.");
            $("#userPw").focus();
            return;
        }

        // 3. 비밀번호 확인 체크
        if(userPwConfirm == "") {
            alert("비밀번호 확인을 입력해주세요.");
            $("#userPwConfirm").focus();
            return;
        }

        // 4. 일치 여부 체크
        if(userPw != userPwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            $("#userPwConfirm").val(""); // 값 비우기
            $("#userPwConfirm").focus();
            return;
        }

        // 유효성 검사 통과 시 전송
        document.resetPwForm.submit();
    }
    
    // 다시 입력 (초기화)
    function resetForm() {
    	$("#userPw").val("");
    	$("#userPwConfirm").val("");
    	$("#userPw").focus();
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
			<p>비밀번호찾기</p>
		</div>
		<div class="wrap">
			
			<div class="step">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="33%">
						<col width="33%">
						<col width="*">
					</colgroup>
					<tr>
						<td>본인인증</td>
						<td class="step_select">비밀번호 입력</td>
						<td>비밀번호 변경 완료</td>
					</tr>
				</table>
			</div>
			<div class="mt50 text">
				<h3>통합 비밀번호 입력</h3>
				<p class="bullet01 mt20">새로 사용할 비밀번호를 입력하세요.</p>
				
				<form action="${contextPath}/member/resetPwProcess" method="post" name="resetPwForm">
					
					<input type="hidden" name="userId" value="${userId}">

					<table cellpadding="0" cellspacing="0" class="mt30">
						<colgroup>
							<col width="20%">
							<col width="*">
						</colgroup>
						<tr>
							<th>새 비밀번호</th>
							<td>
								<input type="password" name="userPw" id="userPw" style="width:280px;" placeholder="새 비밀번호 입력"><br />
								<span class="mt3">비밀번호는 9자 이상, 20자 이하.<br />
								비밀번호에 동일문자는 3회 이상 사용불가.&nbsp; 예&#41; aaa, 111<br />
								비밀번호에 연속문자는 3회 이상 사용불가.&nbsp; 예&#41; abc, 123<br />
								비밀번호에 영문 소문자, 숫자, 특수문자 포함.</span>
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<input type="password" name="userPwConfirm" id="userPwConfirm" style="width:280px;" placeholder="비밀번호 재입력">
							</td>
						</tr>
					</table>
					
					<div class="btn mt50 t_center">
						<button type="button" class="btn_blue" onclick="changePwCheck()">확인</button>
						<button type="button" class="btn_gray ml20" onclick="resetForm()">다시 입력</button>
					</div>
				</form>
			</div>
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