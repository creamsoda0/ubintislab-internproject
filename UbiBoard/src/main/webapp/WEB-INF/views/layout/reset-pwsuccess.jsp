<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>비밀번호 변경 완료 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* =========================================
           비밀번호 변경 완료 스타일 (UBNTIS Style)
           ========================================= */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.5;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            min-height: 100vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.03);
            display: flex;
            flex-direction: column;
        }

        /* 헤더 */
        .header {
            padding: 30px 40px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
        }
        .header h1 a { text-decoration: none; color: inherit; }

        .header-links a {
            font-size: 13px;
            color: #888;
            text-decoration: none;
            margin-left: 15px;
        }
        .header-links a:hover { color: #2c3e50; font-weight: 500; }

        /* 단계 표시 (Step 3: 완료) */
        .step-wrap {
            padding: 40px 0 20px;
            text-align: center;
        }
        .step-list {
            display: inline-flex;
            gap: 10px;
            list-style: none;
            color: #ccc;
            font-weight: 500;
            font-size: 14px;
        }
        .step-list li { display: flex; align-items: center; }
        .step-list li::after {
            content: ">";
            margin-left: 10px;
            font-size: 12px;
            color: #ddd;
        }
        .step-list li:last-child::after { display: none; }
        
        /* 활성화된 단계 */
        .step-list li.active { color: #2c3e50; font-weight: 700; }
        .step-list li.active span {
            display: inline-block;
            width: 24px; height: 24px;
            background: #2c3e50;
            color: #fff;
            border-radius: 50%;
            text-align: center;
            line-height: 24px;
            margin-right: 6px;
            font-size: 12px;
        }

        /* 컨텐츠 영역 */
        .content { 
            padding: 40px 20px 80px; 
            flex: 1; 
            text-align: center;
        }

        .result-card {
            max-width: 480px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
        }

        /* 성공 아이콘 (SVG) */
        .success-icon {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 80px;
            height: 80px;
            background-color: #e8f5e9; /* 연한 초록 배경 */
            border-radius: 50%;
            margin-bottom: 30px;
            color: #2e7d32; /* 진한 초록 아이콘 */
        }
        .success-icon svg {
            width: 40px;
            height: 40px;
            fill: currentColor;
        }

        .result-title {
            font-size: 22px;
            font-weight: 700;
            color: #111;
            margin-bottom: 20px;
        }

        .result-desc {
            font-size: 15px;
            color: #666;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        /* 문의 안내 박스 */
        .info-box {
            background-color: #f8f9fa;
            border: 1px solid #eee;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 40px;
            font-size: 13px;
            color: #555;
        }
        .info-box strong { color: #333; }

        /* 버튼 영역 */
        .btn-area {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            min-width: 160px;
            height: 50px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-login {
            background-color: #2c3e50; /* Navy Point */
            color: #fff;
        }
        .btn-login:hover { background-color: #1a252f; }

        /* 푸터 */
        .footer {
            padding: 30px;
            border-top: 1px solid #eee;
            text-align: center;
            font-size: 12px;
            color: #999;
        }

        /* 반응형 */
        @media screen and (max-width: 768px) {
            .btn-area { flex-direction: column; }
            .btn { width: 100%; }
            .success-icon { width: 60px; height: 60px; }
            .success-icon svg { width: 30px; height: 30px; }
        }
    </style>
</head>
<body>

<div class="container">
    
    <header class="header">
        <h1><a href="${contextPath}/member/login">UBNTIS LAB</a></h1>
        <div class="header-links">
            <a href="${contextPath}/member/login">로그인</a>
            <a href="${contextPath}/member/join">회원가입</a>
        </div>
    </header>

    <div class="step-wrap">
        <ul class="step-list">
            <li><span>1</span>본인인증</li>
            <li><span>2</span>비밀번호 재설정</li>
            <li class="active"><span>3</span>완료</li>
        </ul>
    </div>

    <div class="content">
        <div class="result-card">
            
            <div class="success-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
                </svg>
            </div>

            <h2 class="result-title">비밀번호 변경 완료</h2>
            <p class="result-desc">
                통합회원 비밀번호가 성공적으로 변경되었습니다.<br>
                새로운 비밀번호로 로그인해 주세요.
            </p>

            <div class="info-box">
                로그인에 문제가 있으신가요?<br>
                <strong>고객센터 : 041-000-0000</strong>
            </div>

            <div class="btn-area">
                <a href="${contextPath}/member/goLoginPage" class="btn btn-login">로그인 하러 가기</a>
            </div>
            
        </div>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>