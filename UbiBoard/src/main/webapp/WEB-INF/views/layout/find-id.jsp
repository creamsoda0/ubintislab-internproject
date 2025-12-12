<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>아이디 찾기 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        /* =========================================
           아이디 찾기 페이지 스타일 (UBNTIS Style)
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

        /* 폼 테이블 스타일 */
        .form-box {
            max-width: 500px;
            margin: 0 auto;
        }
        
        .input-group {
            margin-bottom: 20px;
        }
        .input-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .input-row {
            display: flex;
            gap: 10px;
        }

        input[type="text"] {
            width: 100%;
            height: 44px;
            padding: 0 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.2s;
        }
        input:focus { border-color: #2c3e50; outline: none; }
        input[readonly] { background-color: #f5f5f5; cursor: default; }

        /* 소형 버튼 (인증번호 발송 등) */
        .btn-small {
            min-width: 100px;
            height: 44px;
            background-color: #555;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 13px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-small:hover { background-color: #333; }
        .btn-small.blue { background-color: #2c3e50; } /* 인증확인 버튼 */
        .btn-small.blue:hover { background-color: #1a252f; }

        /* 하단 메인 버튼 영역 */
        .btn-area {
            margin-top: 40px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-main {
            min-width: 140px;
            height: 50px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-submit { background-color: #2c3e50; color: #fff; }
        .btn-submit:hover { background-color: #1a252f; }
        .btn-cancel { background-color: #f1f3f5; color: #555; }
        .btn-cancel:hover { background-color: #e9ecef; }

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
            .input-row { flex-direction: column; }
            .btn-small { width: 100%; }
            .btn-area { flex-direction: column-reverse; }
            .btn-main { width: 100%; }
        }
    </style>

    <script>
        var isCertified = false; // 인증 완료 여부

        // 1. 인증번호 발송
        function sendAuthNum() {
            var name = $("#name").val();
            var email = $("#email").val();

            if(name.trim() == "") {
                alert("이름을 입력해주세요.");
                $("#name").focus();
                return;
            }
            if(email.trim() == "") {
                alert("이메일을 입력해주세요.");
                $("#email").focus();
                return;
            }

            // AJAX 요청
            $.ajax({
                url: "${contextPath}/member/sendAuthCode",
                type: "POST",
                data: { name: name, email: email },
                success: function(result) {
                    if(result === "success") {
                        alert("인증번호가 이메일로 발송되었습니다.\n메일함을 확인해주세요.");
                        $("#authnumber").focus();
                    } else if(result === "fail_no_user") {
                        alert("입력하신 정보와 일치하는 회원이 없습니다.");
                    } else {
                        alert("메일 발송 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                    }
                },
                error: function() {
                    alert("서버 통신 오류입니다.");
                }
            });
        }

        // 2. 인증번호 확인
        function checkAuthNum() {
            var inputCode = $("#authnumber").val();
            
            if(inputCode.trim() == "") {
                alert("인증번호를 입력해주세요.");
                $("#authnumber").focus();
                return;
            }

            $.ajax({
                url: "${contextPath}/member/checkAuthCode",
                type: "POST",
                data: { inputCode: inputCode },
                success: function(result) {
                    if(result === "success") {
                        alert("인증에 성공하였습니다.");
                        isCertified = true;
                        
                        // 입력창 잠금 (UX 개선)
                        $("#authnumber").prop("readonly", true).css("background-color", "#e8f5e9");
                        $("#email").prop("readonly", true);
                        $("#name").prop("readonly", true);
                        
                        // 버튼 비활성화
                        $(".btn-small").prop("disabled", true).css("opacity", "0.6");
                        
                    } else {
                        alert("인증번호가 일치하지 않습니다. 다시 확인해주세요.");
                        isCertified = false;
                    }
                },
                error: function() {
                    alert("서버 통신 오류입니다.");
                }
            });
        }

        // 3. 아이디 찾기 실행
        function findIdCheck() {
            if(!isCertified) {
                alert("이메일 인증을 먼저 완료해주세요.");
                return;
            }
            document.findIdForm.submit();
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
            <a href="${contextPath}/member/findPw">비밀번호 찾기</a>
        </div>
    </header>

    <div class="step-wrap">
        <ul class="step-list">
            <li class="active"><span>1</span>본인인증</li>
            <li><span>2</span>아이디 확인</li>
        </ul>
    </div>

    <div class="content">
        <h2 class="page-title">아이디 찾기</h2>
        <p class="page-desc">
            가입 시 등록한 <b>이름</b>과 <b>이메일</b>을 입력하여 본인인증을 진행해주세요.
        </p>

        <form action="${contextPath}/member/findIdProcess" method="post" name="findIdForm" class="form-box">
            
            <div class="input-group">
                <label for="name">이름</label>
                <input type="text" name="name" id="name" placeholder="이름을 입력하세요">
            </div>

            <div class="input-group">
                <label for="email">이메일</label>
                <div class="input-row">
                    <input type="text" name="email" id="email" placeholder="example@email.com">
                    <button type="button" class="btn-small" onclick="sendAuthNum()">인증번호 발송</button>
                </div>
            </div>

            <div class="input-group">
                <label for="authnumber">인증번호</label>
                <div class="input-row">
                    <input type="text" name="authnumber" id="authnumber" placeholder="인증번호 6자리">
                    <button type="button" class="btn-small blue" onclick="checkAuthNum()">인증확인</button>
                </div>
            </div>

            <div class="btn-area">
                <button type="button" class="btn-main btn-cancel" onclick="history.back()">취소</button>
                <button type="button" class="btn-main btn-submit" onclick="findIdCheck()">다음</button>
            </div>

        </form>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>