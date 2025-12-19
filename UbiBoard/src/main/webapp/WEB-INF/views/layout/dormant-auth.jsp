<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UBNTIS | 이메일 본인인증</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* ... (기존 스타일 동일) ... */
        body { background-color: #f4f7f9; font-family: 'Malgun Gothic', sans-serif; }
        .auth-container { max-width: 450px; margin: 100px auto; }
        .auth-card { background: #fff; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 40px; border-top: 4px solid #1a3d6a; }
        .auth-title { color: #1a3d6a; font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 25px; }
        .email-display { background: #f8f9fa; padding: 10px; border-radius: 4px; text-align: center; font-weight: bold; color: #555; margin-bottom: 20px; }
        .auth-input { height: 50px; font-size: 18px; text-align: center; letter-spacing: 5px; font-weight: bold; border: 2px solid #ddd; }
        .timer-text { color: #d9534f; font-size: 13px; margin-top: 10px; text-align: right; }
        .btn-verify { background: #1a3d6a; color: white; height: 50px; font-size: 16px; font-weight: bold; margin-top: 20px; }
        .btn-resend { background: #fff; color: #666; border: 1px solid #ccc; margin-top: 10px; }
    </style>
</head>
<body>

<div class="auth-container">
    <div class="auth-card">
        <h2 class="auth-title">이메일 본인인증</h2>
        <div class="email-display"><c:out value="${maskedEmail}"/></div>

        <form action="${pageContext.request.contextPath}/member/verifyCode" method="post">
            <input type="hidden" name="userId" id="userId" value="${userId}">
            <div class="form-group">
                <input type="text" name="authCode" class="form-control auth-input" placeholder="000000" maxlength="6" required>
                <div class="timer-text" id="timer">유효시간 03:00</div>
            </div>
            <button type="submit" class="btn btn-block btn-verify">인증 확인</button>
        </form>
        
        <button type="button" id="btnResend" class="btn btn-block btn-resend btn-sm">인증번호 재발송</button>
    </div>
</div>

<script>
var countdown;

function startTimer() {
    var timeLeft = 180;
    var timerElement = document.getElementById('timer');

    if (countdown) clearInterval(countdown);
    timerElement.style.color = "#d9534f";

    countdown = setInterval(function() {
        var minutes = Math.floor(timeLeft / 60);
        var seconds = timeLeft % 60;
        seconds = seconds < 10 ? '0' + seconds : seconds;
        timerElement.innerHTML = "유효시간 " + minutes + ":" + seconds;

        if (timeLeft <= 0) {
            clearInterval(countdown);
            timerElement.innerHTML = "인증 시간이 만료되었습니다.";
            timerElement.style.color = "red";
        }
        timeLeft--;
    }, 1000);
}

$(document).ready(function() {
    startTimer();

    $('#btnResend').click(function() {
        var userId = "${userId}";
        var $btn = $(this);
        
        $btn.prop('disabled', true).text('발송 중...');

        $.ajax({
            url: "${pageContext.request.contextPath}/member/resendAuthCode",
            type: "POST",
            data: { userId: userId },
            success: function(response) {
                // ResponseEntity HttpStatus.OK 일 때 실행
                alert(response.message || "인증번호가 재발송되었습니다.");
                startTimer();
            },
            error: function(xhr) {
                // ResponseEntity 에러 코드(400, 500 등) 일 때 실행
                var msg = "오류가 발생했습니다.";
                if(xhr.responseJSON && xhr.responseJSON.message) msg = xhr.responseJSON.message;
                alert(msg);
            },
            complete: function() {
                $btn.prop('disabled', false).text('인증번호 재발송');
            }
        });
    });
});
</script>
</body>
</html>