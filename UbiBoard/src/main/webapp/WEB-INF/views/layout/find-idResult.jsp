<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>아이디 찾기 결과 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* =========================================
           아이디 찾기 결과 스타일 (UBNTIS Style)
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

        /* 단계 표시 (Step) */
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
        
        /* 활성화된 단계 (Step 2) */
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

        /* 아이콘 박스 (사람 모양) */
        .icon-box {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 80px;
            height: 80px;
            background-color: #e3f2fd; /* 연한 파랑 배경 */
            border-radius: 50%;
            margin-bottom: 30px;
            color: #1565c0; /* 파랑 아이콘 */
        }
        .icon-box svg {
            width: 40px;
            height: 40px;
            fill: currentColor;
        }

        .result-title {
            font-size: 22px;
            font-weight: 700;
            color: #111;
            margin-bottom: 30px;
        }

        /* 아이디 표시 박스 */
        .id-box {
            background-color: #f8f9fa;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 40px;
        }
        .user-name {
            font-size: 15px;
            color: #666;
            margin-bottom: 10px;
        }
        .user-name strong { color: #333; font-weight: 600; }
        
        .user-id {
            font-size: 26px;
            font-weight: 800;
            color: #2c3e50; /* 브랜드 컬러 (Navy) */
            letter-spacing: 0.5px;
        }

        /* 버튼 영역 */
        .btn-area {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            min-width: 140px;
            height: 50px;
            font-size: 15px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .btn-login {
            background-color: #2c3e50;
            color: #fff;
        }
        .btn-login:hover { background-color: #1a252f; }

        .btn-pw {
            background-color: #fff;
            color: #555;
            border: 1px solid #ddd;
        }
        .btn-pw:hover { background-color: #f5f5f5; color: #333; }

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
            .user-id { font-size: 22px; }
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
            <li class="active"><span>2</span>아이디 확인</li>
        </ul>
    </div>

    <div class="content">
        <div class="result-card">
            
            <div class="icon-box">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                </svg>
            </div>

            <h2 class="result-title">아이디 찾기 결과</h2>

            <div class="id-box">
                <p class="user-name">
                    <strong>${resultUser.name}</strong> 님의 통합 아이디는
                </p>
                <p class="user-id">
                    ${resultUser.userId}
                </p>
            </div>

            <div class="btn-area">
                <button type="button" class="btn btn-login" onclick="location.href='${contextPath}/member/goLoginPage'">통합로그인</button>
                <button type="button" class="btn btn-pw" onclick="location.href='${contextPath}/member/goFindPw'">비밀번호 찾기</button>
            </div>
            
        </div>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>