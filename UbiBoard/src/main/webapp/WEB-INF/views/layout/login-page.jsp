<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>로그인 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* =========================================
           로그인 페이지 전용 스타일 (UBNTIS Style)
           ========================================= */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f4f6f9; /* 차분한 배경색 */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }

        /* 로그인 컨테이너 (카드) */
        .login-wrapper {
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }

        .login-card {
            background: #fff;
            padding: 50px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05); /* 부드러운 그림자 */
            text-align: center;
        }

        /* 로고 영역 */
        .logo-area { margin-bottom: 40px; }
        .logo-area h1 {
            font-size: 28px;
            font-weight: 700;
            color: #2c3e50; /* 다크 네이비 */
            letter-spacing: -0.5px;
        }
        .logo-area p {
            margin-top: 10px;
            font-size: 14px;
            color: #888;
        }
        /* 로고 이미지가 있을 경우 아래 주석 해제하여 사용 */
        /* .logo-img { max-width: 180px; height: auto; } */

        /* 폼 영역 */
        .login-form .input-group { margin-bottom: 15px; text-align: left; }
        .login-form label {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 600;
            color: #555;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            height: 48px;
            padding: 0 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.2s;
            background-color: #fafafa;
        }
        .login-form input:focus {
            border-color: #2c3e50;
            background-color: #fff;
            outline: none;
            box-shadow: 0 0 0 3px rgba(44, 62, 80, 0.1);
        }

        /* 에러 메시지 */
        .error-msg {
            background-color: #ffebee;
            color: #d32f2f;
            font-size: 13px;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 500;
        }

        /* 로그인 버튼 */
        .btn-login {
            width: 100%;
            height: 50px;
            margin-top: 10px;
            background-color: #2c3e50; /* 회사 테마 컬러 (Navy) */
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-login:hover { background-color: #1a252f; }

        /* 하단 링크 (회원가입/찾기) */
        .login-links {
            margin-top: 25px;
            display: flex;
            justify-content: center;
            gap: 15px; /* 간격 */
            font-size: 13px;
            color: #888;
        }
        .login-links a {
            text-decoration: none;
            color: #666;
            transition: color 0.2s;
        }
        .login-links a:hover { color: #2c3e50; text-decoration: underline; }
        .login-links span { color: #ddd; } /* 구분선 */

        /* 하단 카피라이트 */
        .footer-copy {
            margin-top: 40px;
            font-size: 12px;
            color: #aaa;
            text-align: center;
        }
    </style>

    <script>
        function loginCheck() {
            var id = document.getElementById("userId");
            var pw = document.getElementById("password");

            if (id.value.trim() == "") {
                alert("아이디를 입력해주세요.");
                id.focus();
                return false;
            }
            if (pw.value.trim() == "") {
                alert("비밀번호를 입력해주세요.");
                pw.focus();
                return false;
            }
            
            // 폼 전송
            document.getElementById("loginForm").submit();
        }

        // 엔터키 입력 시 로그인 실행
        document.addEventListener("DOMContentLoaded", function() {
            var inputPw = document.getElementById("password");
            inputPw.addEventListener("keypress", function(event) {
                if (event.key === "Enter") {
                    event.preventDefault();
                    loginCheck();
                }
            });
        });
    </script>
</head>
<body>

    <div class="login-wrapper">
        <div class="login-card">
            
            <div class="logo-area">
                <%-- <img src="${contextPath}/static/member/img/logo_ubntis.png" alt="UBNTIS LAB" class="logo-img"> --%>
                
                <h1>UBNTIS LAB</h1>
                <p>유비앤티스랩 서비스 이용을 환영합니다.</p>
            </div>

            <form id="loginForm" name="loginForm" action="${contextPath}/member/loginProcess" method="post" class="login-form">
                
                <c:if test="${not empty msg}">
                    <div class="error-msg">
                        ⚠️ ${msg}
                    </div>
                </c:if>

                <div class="input-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" autocomplete="off" />
                </div>

                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" />
                </div>

                <button type="button" class="btn-login" onclick="loginCheck()">로그인</button>
            </form>

            <div class="login-links">
                <a href="${contextPath}/member/join">회원가입</a>
                <span>|</span>
                <a href="${contextPath}/member/goFindId">아이디 찾기</a>
                <span>|</span>
                <a href="${contextPath}/member/goFindPw">비밀번호 재발급</a>
            </div>

        </div>

        <div class="footer-copy">
            &copy; UBNTIS LAB Corp. All Rights Reserved.
        </div>
    </div>

</body>
</html>