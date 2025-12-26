<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>접속 모드 선택</title>
    <style>
        /* 기본 폰트 및 배경 */
        body {
            font-family: 'Malgun Gothic', sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .gateway-container {
            display: flex;
            gap: 30px;
            max-width: 800px;
        }

        /* 카드 스타일 */
        .mode-card {
            background: white;
            width: 320px;
            padding: 50px 30px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none; /* a 태그 밑줄 제거 */
            display: block;
        }

        .mode-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        /* 아이콘 및 텍스트 */
        .icon {
            font-size: 60px;
            margin-bottom: 20px;
            display: block;
        }

        .title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            display: block;
        }

        .description {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 25px;
            display: block;
        }

        /* 버튼 스타일 */
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 5px;
            font-weight: bold;
            color: white;
            transition: opacity 0.2s;
        }

        .btn-user { background-color: #007bff; }
        .btn-admin { background-color: #343a40; }
        
        .mode-card:hover .btn {
            opacity: 0.8;
        }
    </style>
</head>
<body>
	
    <div class="gateway-container">
        <a href="${pageContext.request.contextPath}/goMain" class="mode-card">
            <span class="icon">👥</span>
            <span class="title">사용자 모드</span>
            <span class="description">
                일반 게시판 화면으로 입장합니다.<br>
                게시글 열람 및 작성이 가능합니다.
            </span>
            <span class="btn btn-user">게시판 바로가기</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/goConfig" class="mode-card">
            <span class="icon">🛠️</span>
            <span class="title">관리자 모드</span>
            <span class="description">
                사이트 환경설정 화면으로 입장합니다.<br>
                게시판 옵션 및 유저 관리가 가능합니다.
            </span>
            <span class="btn btn-admin">환경설정 도구</span>
        </a>
    </div>

</body>
</html>