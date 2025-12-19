<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UBNTIS | 전환 완료</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body { background-color: #f4f7f9; font-family: 'Malgun Gothic', sans-serif; }
        .success-wrapper { max-width: 500px; margin: 100px auto; }
        .success-card { background: #fff; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); padding: 50px 30px; text-align: center; border-top: 6px solid #28a745; }
        .success-icon { font-size: 70px; color: #28a745; margin-bottom: 20px; }
        .success-title { color: #1a3d6a; font-size: 26px; font-weight: bold; margin-bottom: 10px; }
        .success-desc { color: #666; font-size: 15px; line-height: 1.6; margin-bottom: 30px; }
        .info-summary { background: #f8f9fa; border-radius: 8px; padding: 20px; margin-bottom: 30px; text-align: left; }
        .info-summary p { margin: 5px 0; font-size: 14px; color: #444; }
        .info-summary b { color: #1a3d6a; }
        .btn-go-login { background-color: #1a3d6a; color: white; padding: 15px; font-size: 16px; font-weight: bold; border-radius: 6px; transition: 0.3s; border: none; width: 100%; }
        .btn-go-login:hover { background-color: #0e2646; color: #fff; text-decoration: none; }
    </style>
</head>
<body>

<div class="success-wrapper">
    <div class="success-card">
        <div class="success-icon">
            <span class="glyphicon glyphicon-ok-circle"></span>
        </div>

        <h2 class="success-title">계정 활성화 완료</h2>
        <p class="success-desc">
            휴면 처리가 성공적으로 해제되었습니다.<br>
            이제 모든 서비스를 정상적으로 이용하실 수 있습니다.
        </p>

        <div class="info-summary">
            <p><b>아이디 :</b> <c:out value="${userId}"/></p>
            <p><b>전환 일시 :</b> <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss" /></p>
            <p><b>계정 상태 :</b> <span class="label label-success">정상(활동)</span></p>
        </div>

        <a href="${pageContext.request.contextPath}/default" class="btn btn-go-login">
            로그인 페이지로 이동
        </a>
    </div>
    
    <p style="text-align: center; margin-top: 20px; color: #999; font-size: 12px;">
        © UBNTIS Board System. All rights reserved.
    </p>
</div>

</body>
</html>