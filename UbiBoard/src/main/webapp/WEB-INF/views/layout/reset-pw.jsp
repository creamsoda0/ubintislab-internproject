<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>비밀번호 재설정 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        /* =========================================
           비밀번호 재설정 스타일 (UBNTIS Style)
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

        /* 단계 표시 (Step 2) */
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
            padding: 40px; 
            flex: 1; 
        }
        
        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #111;
            text-align: center;
        }
        .page-desc {
            font-size: 14px;
            color: #666;
            margin-bottom: 40px;
            text-align: center;
        }

        /* 폼 박스 스타일 */
        .form-box {
            max-width: 480px;
            margin: 0 auto;
        }
        
        .input-group {
            margin-bottom: 25px;
        }
        .input-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        input[type="password"] {
            width: 100%;
            height: 48px;
            padding: 0 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.2s;
        }
        input:focus { border-color: #2c3e50; outline: none; }

        /* 도움말 텍스트 */
        .help-text {
            display: block;
            margin-top: 8px;
            font-size: 12px;
            color: #888;
            line-height: 1.4;
        }
        .help-text.error { color: #d32f2f; }

        /* 버튼 영역 */
        .btn-area {
            margin-top: 40px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            min-width: 140px;
            height: 50px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit { background-color: #2c3e50; color: #fff; }
        .btn-submit:hover { background-color: #1a252f; }
        .btn-reset { background-color: #f1f3f5; color: #555; }
        .btn-reset:hover { background-color: #e9ecef; }

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
            .content { padding: 20px; }
            .btn-area { flex-direction: column-reverse; }
            .btn { width: 100%; }
        }
    </style>

    <script>
        function changePwCheck() {
            var userPw = $("#userPw").val();
            var userPwConfirm = $("#userPwConfirm").val();

            // 1. 빈 값 체크
            if(userPw == "") {
                alert("새 비밀번호를 입력해주세요.");
                $("#userPw").focus();
                return;
            }
            
            // 2. 비밀번호 길이 체크
            if(userPw.length < 9 || userPw.length > 20) {
                alert("비밀번호는 9자 이상, 20자 이하로 입력해주세요.");
                $("#userPw").focus();
                return;
            }

            // 3. 비밀번호 확인 체크
            if(userPwConfirm == "") {
                alert("비밀번호 확인란을 입력해주세요.");
                $("#userPwConfirm").focus();
                return;
            }

            // 4. 일치 여부 체크
            if(userPw != userPwConfirm) {
                alert("비밀번호가 일치하지 않습니다.");
                $("#userPwConfirm").val("");
                $("#userPwConfirm").focus();
                return;
            }

            // 전송
            if(confirm("비밀번호를 변경하시겠습니까?")) {
                document.resetPwForm.submit();
            }
        }
        
        // 다시 입력 (초기화)
        function resetForm() {
            $("#userPw").val("");
            $("#userPwConfirm").val("");
            $("#userPw").focus();
        }
    </script>
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
            <li class="active"><span>2</span>비밀번호 재설정</li>
            <li><span>3</span>완료</li>
        </ul>
    </div>

    <div class="content">
        <h2 class="page-title">새 비밀번호 입력</h2>
        <p class="page-desc">
            새로 사용하실 비밀번호를 입력해 주세요.
        </p>

        <form action="${contextPath}/member/resetPwProcess" method="post" name="resetPwForm" class="form-box">
            
            <input type="hidden" name="userId" value="${userId}">

            <div class="input-group">
                <label for="userPw">새 비밀번호</label>
                <input type="password" name="userPw" id="userPw" placeholder="새 비밀번호 입력">
                <span class="help-text">
                    ※ 9~20자 이내, 영문/숫자/특수문자 포함 필수<br>
                    ※ 연속된 문자나 아이디와 동일한 비밀번호는 사용 불가
                </span>
            </div>

            <div class="input-group">
                <label for="userPwConfirm">비밀번호 확인</label>
                <input type="password" name="userPwConfirm" id="userPwConfirm" placeholder="비밀번호 재입력">
            </div>

            <div class="btn-area">
                <button type="button" class="btn btn-reset" onclick="resetForm()">다시 입력</button>
                <button type="button" class="btn btn-submit" onclick="changePwCheck()">변경하기</button>
            </div>

        </form>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>