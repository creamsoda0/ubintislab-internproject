<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>약관동의 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <style>
        /* =========================================
           약관동의 페이지 전용 스타일 (Modern Style)
           ========================================= */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.5;
        }

        /* 공통 레이아웃 컨테이너 */
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            min-height: 100vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.03);
        }

        /* 1. 심플 헤더 */
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
            color: #2c3e50; /* UBNTIS Navy */
        }
        .header h1 a { text-decoration: none; color: inherit; }

        /* 2. 단계 표시 (Step Process) */
        .step-wrap {
            padding: 40px 40px 20px;
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
        
        /* 현재 단계 활성화 스타일 */
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

        /* 3. 본문 영역 */
        .content { padding: 20px 40px 60px; }
        .page-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            color: #111;
        }

        /* 약관 박스 스타일 */
        .terms-section { margin-bottom: 30px; }
        .terms-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #444;
            display: block;
        }
        .terms-box {
            width: 100%;
            height: 200px;
            border: 1px solid #ddd;
            background-color: #f8f9fa;
            padding: 20px;
            overflow-y: auto;
            font-size: 13px;
            color: #666;
            line-height: 1.6;
            border-radius: 4px;
        }
        /* 스크롤바 디자인 (Webkit) */
        .terms-box::-webkit-scrollbar { width: 6px; }
        .terms-box::-webkit-scrollbar-thumb { background: #ccc; border-radius: 3px; }

        /* 체크박스 디자인 */
        .check-wrap {
            margin-top: 10px;
            text-align: right;
        }
        .custom-checkbox input { display: none; } /* 실제 체크박스 숨김 */
        .custom-checkbox label {
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            font-size: 15px;
            font-weight: 500;
            color: #333;
        }
        .custom-checkbox label::before {
            content: "";
            display: inline-block;
            width: 20px; height: 20px;
            border: 2px solid #ddd;
            border-radius: 4px;
            margin-right: 8px;
            transition: all 0.2s;
            background: #fff;
        }
        /* 체크되었을 때 스타일 */
        .custom-checkbox input:checked + label::before {
            border-color: #2c3e50;
            background-color: #2c3e50;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white' width='14px' height='14px'%3E%3Cpath d='M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: center;
        }

        /* 4. 버튼 영역 */
        .btn-area {
            margin-top: 50px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .btn {
            min-width: 140px;
            height: 50px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-cancel {
            background-color: #f1f3f5;
            color: #555;
        }
        .btn-cancel:hover { background-color: #e9ecef; }
        
        .btn-submit {
            background-color: #2c3e50; /* Navy Point */
            color: #fff;
        }
        .btn-submit:hover { background-color: #1a252f; }

        /* 푸터 */
        .footer {
            padding: 30px;
            border-top: 1px solid #eee;
            text-align: center;
            font-size: 12px;
            color: #999;
        }

        /* 모바일 대응 */
        @media screen and (max-width: 768px) {
            .container { width: 100%; box-shadow: none; }
            .header, .content { padding-left: 20px; padding-right: 20px; }
            .btn-area { flex-direction: column-reverse; }
            .btn { width: 100%; }
            .step-list span { display: none !important; } /* 모바일에선 숫자 숨김 */
        }
    </style>

    <script>
        function checkAgree() {
            // 체크 여부 확인
            if(!$("#ckok1").is(":checked")) {
                alert("서비스 이용약관에 동의해주세요.");
                $("#ckok1").focus();
                return;
            }
            // [추가 가능] 개인정보 처리방침 동의 체크
            /*
            if(!$("#ckok2").is(":checked")) {
                alert("개인정보 수집 및 이용안내에 동의해주세요.");
                $("#ckok2").focus();
                return;
            }
            */
            
            // 모든 확인 완료 후 이동
            // alert("약관에 동의하셨습니다. 정보 입력 페이지로 이동합니다.");
            location.href = "${contextPath}/member/joinForm"; 
        }

        // 전체 동의 기능 (필요 시 활성화)
        function checkAll() {
            var isChecked = $("#checkAll").is(":checked");
            $("input[type=checkbox]").prop("checked", isChecked);
        }
    </script>
</head>
<body>

<div class="container">
    
    <header class="header">
        <h1><a href="${contextPath}/main">UBNTIS LAB</a></h1>
    </header>

    <div class="step-wrap">
        <ul class="step-list">
            <li class="active"><span>1</span>약관동의</li>
            <li><span>2</span>정보입력</li>
            <li><span>3</span>가입완료</li>
        </ul>
    </div>

    <div class="content">
        <h2 class="page-title">약관동의</h2>
        <p style="margin-bottom: 20px; color: #666; font-size: 14px;">
            유비앤티스랩 서비스 이용을 위해 약관에 동의해 주세요.
        </p>

        <div class="terms-section">
            <span class="terms-title">서비스 이용약관 (필수)</span>
            <div class="terms-box">
                제 1 장 총칙<br><br>
                제 1 조 [목적]<br>
                본 약관은 유비앤티스랩(이하 '회사')이 제공하는 서비스의 이용조건 및 절차, 이용자와 회사의 권리, 의무, 책임사항을 규정함을 목적으로 합니다.<br><br>
                제 2 조 [약관의 효력]<br>
                1. 이 약관은 서비스를 통하여 이를 공지하거나 전자우편 기타의 방법으로 회원에게 통지함으로써 효력이 발생합니다.<br>
                2. 회사는 사정 변경의 경우와 영업상 중요 사유가 있을 때 약관을 변경할 수 있으며, 변경된 약관은 전항과 같은 방법으로 효력을 발생합니다.<br>
                (중략)...<br>
                서비스의 이용은 회원의 동의와 회사의 승낙으로 이루어집니다.
            </div>
            <div class="check-wrap custom-checkbox">
                <input type="checkbox" id="ckok1" name="agree1">
                <label for="ckok1">이용약관에 동의합니다.</label>
            </div>
        </div>

        <div class="btn-area">
            <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
            <button type="button" class="btn btn-submit" onclick="checkAgree()">다음</button>
        </div>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>