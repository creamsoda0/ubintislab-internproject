<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>회원정보 수정 완료 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* =========================================
           수정 완료 페이지 스타일 (UBNTIS Style)
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

        .header-util a {
            font-size: 13px;
            color: #888;
            text-decoration: none;
            margin-left: 15px;
        }
        .header-util a:hover { color: #2c3e50; font-weight: 500; }

        /* 단계 표시 (Step) - 2단계 구성 */
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
        
        /* 활성화된 단계 스타일 */
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

        /* 완료 컨텐츠 영역 */
        .content { 
            padding: 60px 20px 80px; 
            text-align: center; 
            flex: 1; 
        }

        /* 성공 아이콘 (SVG) */
        .success-icon {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 80px;
            height: 80px;
            background-color: #e8f5e9; /* 연한 초록색 배경 */
            border-radius: 50%;
            margin-bottom: 30px;
            color: #2e7d32; /* 진한 초록색 체크 */
        }
        .success-icon svg {
            width: 40px;
            height: 40px;
            fill: currentColor;
        }

        .complete-title {
            font-size: 28px;
            font-weight: 700;
            color: #111;
            margin-bottom: 15px;
        }
        
        .complete-desc {
            font-size: 16px;
            color: #666;
            margin-bottom: 50px;
        }

        /* 버튼 */
        .btn-area {
            display: flex;
            justify-content: center;
        }
        .btn-home {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 180px;
            height: 54px;
            background-color: #2c3e50; /* Navy Point */
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-home:hover { background-color: #1a252f; }

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
            .btn-home { width: 100%; }
            .success-icon { width: 60px; height: 60px; }
            .success-icon svg { width: 30px; height: 30px; }
            .complete-title { font-size: 22px; }
        }
    </style>
</head>
<body>

<div class="container">
    
    <header class="header">
        <h1><a href="${contextPath}/main">UBNTIS LAB</a></h1>
        <div class="header-util">
            <a href="${contextPath}/member/logout">로그아웃</a>
        </div>
    </header>

    <div class="step-wrap">
        <ul class="step-list">
            <li><span>1</span>회원정보수정</li>
            <li class="active"><span>2</span>수정완료</li>
        </ul>
    </div>

    <div class="content">
        <div class="success-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
            </svg>
        </div>

        <h2 class="complete-title">회원정보 수정 완료</h2>
        <p class="complete-desc">
            회원님의 정보가 성공적으로 수정되었습니다.<br>
            변경된 정보는 즉시 적용됩니다.
        </p>

        <div class="btn-area">
            <a href="${contextPath}/goMain" class="btn-home">메인으로</a>
        </div>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>