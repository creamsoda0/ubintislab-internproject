<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>로그인 | 유비앤티스랩</title>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/member/css/login-page.css">

<script>

$(document).ready(function() {
    // 엔터키 입력 시 로그인 실행
    $("#password, #userId").on("keypress", function(e) {
        if (e.key === "Enter") {
            e.preventDefault();
            loginCheck();
        }
    });
});

/**
 * 상태 메시지 표시 함수
 * @param type: 'error', 'warning', 'lock' (CSS 클래스와 매칭)
 * @param message: 표시할 텍스트
 */
function showStatus(type, message) {
    var $msgBox = $('#statusMsg');
    var $msgText = $msgBox.find('.msg-text');
    
    // 기존 클래스 제거 후 새 타입 추가
    $msgBox.removeClass('error warning lock').addClass(type);
    $msgText.html(message); // HTML로 삽입하여 링크 태그 동작 허용
    
    $msgBox.stop().hide().fadeIn(300); // 부드러운 애니메이션 효과
}

function loginCheck() {
    var userId = $("#userId").val().trim();
    var password = $("#password").val().trim();
    var $msgBox = $('#statusMsg');

    // 미입력 체크
    if (userId == "" || password == "") {
        showStatus('warning', '아이디와 비밀번호를 모두 입력해주세요.');
        if(userId == "") $("#userId").focus();
        else $("#password").focus();
        return false;
    }

    // 로그인 버튼 비활성화 (중복 클릭 방지)
    var $btn = $(".btn-login");
    $btn.prop("disabled", true).text("로그인 중...");

    // AJAX 로그인 요청
    $.ajax({
        url: "${pageContext.request.contextPath}/member/loginProcess",
        type: "POST",
        data: {
            userId: userId,
            password: password
        },
        dataType: "json", // 서버에서 JSON 응답을 기대함
        success: function(response) {
            // 로그인 성공 시 메인 페이지로 이동
            location.href = "${pageContext.request.contextPath}/goMain";
        },
        error: function(xhr) {
            $btn.prop("disabled", false).text("로그인"); // 버튼 복구
            
            var status = xhr.status;
            var response = xhr.responseJSON;
            var message = (response && response.message) ? response.message : "로그인 중 오류가 발생했습니다.";

            if (status === 404) {
                // 케이스: 등록되지 않은 계정
                showStatus('error', '⚠️ ' + message);
                $("#userId").focus();
            } 
            else if (status === 401) {
                // 케이스: 아이디/비번 불일치 (실패 횟수 포함)
                showStatus('error', '❌ ' + message);
                $("#password").val("").focus();
            } 
            else if (status === 403) {
                // 케이스: 계정 잠김 (잠금 해제 링크 포함)
                var unlockLink = '<a href="${pageContext.request.contextPath}/member/goUnlockAuth" class="unlock-link">잠금해제(이메일 인증)</a>';
                showStatus('lock', '🔒 ' + message + unlockLink);
            } 
            else {
                showStatus('error', '🚫 서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
            }
        }
    });
}
</script>

</head>
<body>

	<div class="login-wrapper">
		<div class="login-card">

			<div class="logo-area">
				<h1>UBNTIS LAB</h1>
				<p>유비앤티스랩 서비스 이용을 환영합니다.</p>
			</div>

			<form id="loginForm" name="loginForm" onsubmit="return false;"
				class="login-form">

				<div id="statusMsg" class="status-msg-box" style="display: none;">
					<span class="msg-icon"></span> <span class="msg-text"></span>
				</div>

				<div class="input-group">
					<label for="userId">아이디</label>
					<div class="input-wrapper">
						<i class="icon-user"></i> <input type="text" id="userId"
							name="userId" placeholder="아이디를 입력하세요" autocomplete="off" />
					</div>
				</div>

				<div class="input-group">
					<label for="password">비밀번호</label>
					<div class="input-wrapper">
						<i class="icon-lock"></i> <input type="password" id="password"
							name="password" placeholder="비밀번호를 입력하세요" />
					</div>
				</div>

				<button type="button" class="btn-login" onclick="loginCheck()">로그인</button>
			</form>

			<div class="login-links">
				<a href="${contextPath}/member/join">회원가입</a> <span class="divider">|</span>
				<a href="${contextPath}/member/goFindId">아이디 찾기</a> <span
					class="divider">|</span> <a href="${contextPath}/member/goFindPw">비밀번호
					재발급</a>
			</div>

		</div>

		<div class="footer-copy">&copy; 2025 UBNTIS LAB Corp. All Rights
			Reserved.</div>
	</div>

</body>
</html>