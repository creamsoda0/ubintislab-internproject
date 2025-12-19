<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UBNTIS | 이메일 본인인증</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body { background-color: #f4f7f9; font-family: 'Malgun Gothic', sans-serif; }
        .auth-container { max-width: 450px; margin: 100px auto; }
        .auth-card { background: #fff; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 40px; border-top: 4px solid #1a3d6a; }
        .auth-title { color: #1a3d6a; font-size: 20px; font-weight: bold; text-align: center; margin-bottom: 25px; }
        .email-display { background: #f8f9fa; padding: 10px; border-radius: 4px; text-align: center; font-weight: bold; color: #555; margin-bottom: 20px; }
        .auth-input { height: 50px; font-size: 18px; text-align: center; letter-spacing: 5px; font-weight: bold; border: 2px solid #ddd; }
        .auth-input:focus { border-color: #1a3d6a; box-shadow: none; }
        .timer-text { color: #d9534f; font-size: 13px; margin-top: 10px; text-align: right; }
        .btn-verify { background: #1a3d6a; color: white; height: 50px; font-size: 16px; font-weight: bold; margin-top: 20px; }
        .btn-resend { background: #fff; color: #666; border: 1px solid #ccc; margin-top: 10px; }
    </style>
</head>
<body>

<div class="auth-container">
    <div class="auth-card">
        <h2 class="auth-title">이메일 본인인증</h2>
        
        <p class="text-center" style="font-size: 14px; color: #666; margin-bottom: 20px;">
            보안을 위해 등록된 이메일로<br>인증번호 6자리를 발송하였습니다.
        </p>

        <div class="email-display">
            <c:out value="${maskedEmail}"/>
        </div>

        <form action="${pageContext.request.contextPath}/login/verifyCode.do" method="post">
            <input type="hidden" name="userId" value="${dormantUserId}">
            <div class="form-group">
                <input type="text" name="authCode" class="form-control auth-input" placeholder="000000" maxlength="6" required>
                <div class="timer-text" id="timer">유효시간 03:00</div>
            </div>
            
            <button type="submit" class="btn btn-block btn-verify">인증 확인</button>
        </form>
        
        <form action="${pageContext.request.contextPath}/member/resendCode.do" method="post">
            <input type="hidden" name="userId" value="${dormantUserId}">
            <button type="submit" class="btn btn-block btn-resend btn-sm">인증번호 재발송</button>
        </form>
    </div>
</div>

<script>
    // 단순 타이머 스크립트 (3분)
    var timeLeft = 180;
    var timerElement = document.getElementById('timer');
    var countdown = setInterval(function(){
        var minutes = Math.floor(timeLeft / 60);
        var seconds = timeLeft % 60;
        seconds = seconds < 10 ? '0' + seconds : seconds;
        timerElement.innerHTML = "유효시간 " + minutes + ":" + seconds;
        if(timeLeft <= 0) clearInterval(countdown);
        timeLeft--;
    }, 1000);
</script>

</body>
</html>