<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 발생</title>
<style>
    .error-container { text-align: center; padding: 50px; }
    .error-title { font-size: 24px; color: #e74c3c; font-weight: bold; }
    .error-msg { margin: 20px 0; font-size: 16px; color: #555; }
    .btn-home { padding: 10px 20px; background: #333; color: #fff; text-decoration: none; border-radius: 5px; }
</style>
</head>
<body>
    <div class="error-container">
        <div class="error-title">⚠️ 죄송합니다.</div>
        
        <div class="error-msg">
            ${errorMessage}<br>
            <span style="font-size: 12px; color: #999;">(잠시 후 다시 시도해주세요.)</span>
        </div>

        <div style="margin-bottom: 30px; color: #aaa; font-size: 11px;">
            DEBUG: ${exception.message}
        </div>

        <a href="${pageContext.request.contextPath}/goMain" class="btn-home">메인으로 가기</a>
    </div>
</body>
</html>