<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>회원탈퇴 완료 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <style>
        /* =========================================
           공통 스타일 (기존 페이지들과 동일)
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
        
        /* 로그인 전 상태이므로 헤더 유틸 메뉴는 제거하거나 로그인 버튼으로 대체 */
        .header-util a {
            font-size: 13px;
            color: #888;
            text-decoration: none;
        }

        /* 컨텐츠 영역 (중앙 정렬) */
        .content { 
            padding: 80px 40px; 
            flex: 1; /* 푸터를 하단으로 밀어내기 위함 */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        /* 완료 메시지 스타일 */
        .success-icon {
            font-size: 60px;
            color: #ccc;
            margin-bottom: 30px;
            display: inline-block;
            width: 80px;
            height: 80px;
            line-height: 80px;
            border: 2px solid #eee;
            border-radius: 50%;
            background-color: #fcfcfc;
        }
        
        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .desc-text {
            font-size: 16px;
            color: #666;
            margin-bottom: 50px;
            line-height: 1.8;
        }
        .desc-text span {
            color: #2c3e50;
            font-weight: 500;
        }

        /* 버튼 */
        .btn-home {
            display: inline-block;
            min-width: 160px;
            height: 50px;
            line-height: 50px;
            background-color: #2c3e50;
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s;
        }
        .btn-home:hover {
            background-color: #1a252f;
        }

        /* 푸터 */
        .footer {
            padding: 30px;
            border-top: 1px solid #eee;
            text-align: center;
            font-size: 12px;
            color: #999;
        }
    </style>
</head>
<body>

<div class="container">
    
    <header class="header">
        <h1><a href="${contextPath}/default">UBNTIS LAB</a></h1>
        <div class="header-util">
            <a href="${contextPath}/default">홈으로</a>
        </div>
    </header>

    <div class="content">
        <div class="success-icon">✔</div>

        <h2 class="page-title">회원탈퇴가 완료되었습니다.</h2>
        
        <p class="desc-text">
            그동안 <span>UBNTIS LAB</span> 서비스를 이용해 주셔서 감사합니다.<br>
            회원님의 소중한 의견을 반영하여 더 나은 서비스로<br>
            다시 만나 뵙기를 기대하겠습니다.
        </p>

        <a href="${contextPath}/default" class="btn-home">메인페이지로 이동</a>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>