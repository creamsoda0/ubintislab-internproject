<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>


<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UBNTIS | 휴면 계정 안내</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body { background-color: #f4f7f9; font-family: 'Malgun Gothic', 'dotum', sans-serif; }
        .dormant-container { max-width: 520px; margin: 120px auto; }
        .card { background: #fff; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); border-top: 5px solid #1a3d6a; padding: 40px 30px; }
        .logo-area { text-align: center; margin-bottom: 30px; }
        .logo-area h1 { color: #1a3d6a; font-size: 24px; font-weight: bold; margin: 0; }
        .icon-box { text-align: center; margin-bottom: 20px; color: #f0ad4e; font-size: 50px; }
        .content-title { text-align: center; font-size: 20px; font-weight: bold; color: #333; margin-bottom: 15px; }
        .content-desc { color: #666; line-height: 1.6; font-size: 14px; text-align: center; margin-bottom: 30px; }
        .info-box { background: #f9f9f9; border-radius: 4px; padding: 15px; margin-bottom: 25px; border-left: 4px solid #ddd; }
        .info-box p { margin: 5px 0; font-size: 13px; color: #555; }
        .btn-activate { background-color: #1a3d6a; color: white; padding: 12px; font-size: 16px; font-weight: bold; border-radius: 4px; transition: 0.3s; }
        .btn-activate:hover { background-color: #122b4a; color: #fff; text-decoration: none; }
        .footer-link { text-align: center; margin-top: 20px; font-size: 13px; }
        .footer-link a { color: #888; text-decoration: underline; }
    </style>
</head>
<body>

<div class="dormant-container">
    <div class="logo-area">
        <h1>UBNTIS BOARD</h1>
    </div>
    
    <div class="card">
        <div class="icon-box">
            <span class="glyphicon glyphicon-time"></span>
        </div>
        <h2 class="content-title">오랫동안 자리를 비우셨네요!</h2>
        <p class="content-desc">
        <strong><c:out value="${dormantUserId}"/></strong> 고객님은 현재 <storng>휴면 상태</storng>입니다.<br>
            고객님의 소중한 정보 보호를 위해<br>
            현재 계정이 <strong>휴면 상태</strong>로 전환되었습니다.
        </p>

        <div class="info-box">
            <p><strong>휴면 전환일:</strong> 
            <fmt:formatDate value="${dormantDate}" pattern="yyyy-MM-dd" /></p>
            <p><strong>사유:</strong> <c:out value="${not empty reason ? reason : '3개월 이상 미접속'}"/></p>
            <p><strong>보관 기간:</strong> 파기 시까지 별도 분리 저장</p>
        </div>

        <form action="${pageContext.request.contextPath}/member/goActivateUser" method="post">
            <input type="hidden" name="userId" id="userId" value="${dormantUserId}"> 
            <button type="submit" class="btn btn-block btn-activate">
                지금 바로 계정 활성화하기
            </button>
        </form>
    </div>

    <div class="footer-link">
        <p>문제가 발생하셨나요? <a href="/cs/qna">고객센터 문의하기</a></p>
    </div>
</div>

</body>
</html>