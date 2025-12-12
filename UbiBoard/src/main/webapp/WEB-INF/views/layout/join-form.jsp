<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>회원가입 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        /* =========================================
           회원가입 페이지 전용 스타일 (Modern Style)
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
            padding-bottom: 60px;
        }

        /* 헤더 */
        .header {
            padding: 30px 40px;
            border-bottom: 1px solid #eee;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
        }
        .header h1 a { text-decoration: none; color: inherit; }

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

        /* 폼 영역 */
        .content { padding: 0 40px; }
        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #111;
        }
        .page-desc {
            font-size: 14px;
            color: #666;
            margin-bottom: 40px;
        }

        /* 섹션 스타일 */
        .form-section { margin-bottom: 40px; }
        .section-title {
            font-size: 18px;
            font-weight: 700;
            color: #2c3e50;
            padding-bottom: 15px;
            border-bottom: 2px solid #333;
            margin-bottom: 20px;
        }

        /* 테이블 스타일 폼 */
        .form-table {
            width: 100%;
            border-collapse: collapse;
            border-top: 1px solid #ddd;
        }
        .form-table th {
            width: 160px;
            padding: 15px;
            text-align: left;
            background-color: #fbfbfb;
            border-bottom: 1px solid #eee;
            color: #333;
            font-weight: 600;
            vertical-align: middle;
        }
        .form-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            color: #666;
        }

        /* 입력 필드 공통 */
        input[type="text"], input[type="password"], select {
            height: 40px;
            padding: 0 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
            vertical-align: middle;
        }
        input[type="text"]:focus, input[type="password"]:focus, select:focus {
            border-color: #2c3e50;
            outline: none;
        }
        input[readonly] { background-color: #f5f5f5; cursor: default; }

        /* 버튼 스타일 */
        .btn-check {
            height: 40px;
            padding: 0 15px;
            background-color: #555;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            vertical-align: middle;
            margin-left: 5px;
        }
        .btn-check:hover { background-color: #333; }

        .btn-area {
            margin-top: 50px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .btn-submit, .btn-cancel {
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

        /* 라디오 버튼 그룹 */
        .radio-group label { margin-right: 20px; cursor: pointer; }
        .radio-group input { margin-right: 5px; vertical-align: middle; }

        /* 도움말 텍스트 */
        .help-text {
            display: block;
            margin-top: 8px;
            font-size: 12px;
            color: #888;
            line-height: 1.4;
        }
        .req { color: #d32f2f; margin-right: 3px; } /* 필수 표시 */

        /* 푸터 */
        .footer {
            margin-top: 60px;
            padding: 30px;
            border-top: 1px solid #eee;
            text-align: center;
            font-size: 12px;
            color: #999;
        }

        /* 반응형 */
        @media screen and (max-width: 768px) {
            .content { padding: 0 20px; }
            .form-table, .form-table tbody, .form-table tr, .form-table th, .form-table td {
                display: block; width: 100%;
            }
            .form-table th { padding-bottom: 5px; background: none; border: none; }
            .form-table td { padding-top: 5px; padding-bottom: 20px; }
            input[type="text"], input[type="password"], select { width: 100%; margin-bottom: 5px; }
            .btn-check { width: 100%; margin: 5px 0 0 0; }
            /* 이메일 등 인라인 요소들 줄바꿈 처리 */
            .email-box { display: flex; flex-direction: column; gap: 5px; }
            .addr-box input { margin-bottom: 5px; }
        }
    </style>

    <script>
        var isIdChecked = false; // 아이디 중복 확인 여부

        $(document).ready(function(){
            // 아이디 입력값 변경 시 중복 확인 초기화
            $("#userId").on("input", function(){
                isIdChecked = false;
            });
        });

        // 회원가입 폼 유효성 검사
        function checkForm() {
            var f = document.joinForm;

            if(f.userId.value.trim() == "") {
                alert("아이디를 입력해주세요.");
                f.userId.focus();
                return false;
            }
            
            if(!isIdChecked) {
                alert("아이디 중복 확인을 해주세요.");
                return false;
            }

            if(f.password.value == "") {
                alert("비밀번호를 입력해주세요.");
                f.password.focus();
                return false;
            }

            if(f.password.value != f.passwordConfirm.value) {
                alert("비밀번호가 일치하지 않습니다.");
                f.passwordConfirm.focus();
                return false;
            }

            if(f.name.value.trim() == "") {
                alert("이름을 입력해주세요.");
                f.name.focus();
                return false;
            }

            if(f.phone.value.trim() == "") {
                alert("휴대전화 번호를 입력해주세요.");
                f.phone.focus();
                return false;
            }

            // 이메일 합치기 (hidden 필드에 저장하거나 서버에서 처리)
            // 여기서는 폼 전송 시 각각 가도록 둠
            
            f.submit();
        }

        // 아이디 중복 체크
        function checkId() {
            var userId = $("#userId").val();

            if(userId.trim() == "") {
                alert("아이디를 입력해주세요.");
                $("#userId").focus();
                return;
            }

            $.ajax({
                url: "${contextPath}/member/idCheck",
                type: "post",
                data: { "userId" : userId },
                dataType: 'json',
                success: function(result) {
                    if(result == 1) {
                        alert("이미 사용 중인 아이디입니다.");
                        $("#userId").val("").focus();
                        isIdChecked = false;
                    } else {
                        alert("사용 가능한 아이디입니다.");
                        isIdChecked = true;
                    }
                },
                error: function() {
                    alert("서버 통신 오류입니다. 잠시 후 다시 시도해주세요.");
                }
            });
        }

        // 주소 찾기 (Daum API)
        function openZipSearch() {
            new daum.Postcode({
                oncomplete: function(data) {
                    $("#zipCode").val(data.zonecode);
                    $("#addr1").val(data.address);
                    $("#addr2").focus();
                }
            }).open();
        }

        // 이메일 도메인 선택
        function changeEmailDomain() {
            var domain = $("#emailDomainSelect").val();
            if(domain == "direct") {
                $("#emailDomain").val("").attr("readonly", false).focus();
            } else {
                $("#emailDomain").val(domain).attr("readonly", true);
            }
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
            <li><span>1</span>약관동의</li>
            <li class="active"><span>2</span>정보입력</li>
            <li><span>3</span>가입완료</li>
        </ul>
    </div>

    <div class="content">
        <h2 class="page-title">회원가입</h2>
        <p class="page-desc">
            <span class="req">*</span> 표시된 항목은 필수 입력 사항입니다.
        </p>

        <form name="joinForm" action="${contextPath}/member/joinProcess" method="post">
            
            <div class="form-section">
                <h3 class="section-title">기본 정보</h3>
                <table class="form-table">
                    <tbody>
                        <tr>
                            <th><span class="req">*</span>아이디</th>
                            <td>
                                <input type="text" name="userId" id="userId" placeholder="아이디 입력" style="width: 200px;">
                                <button type="button" class="btn-check" onclick="checkId()">중복확인</button>
                                <span class="help-text">영문 소문자, 숫자 포함 5~20자</span>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>비밀번호</th>
                            <td>
                                <input type="password" name="password" id="password" placeholder="비밀번호" style="width: 200px;">
                                <span class="help-text">9자 이상, 영문/숫자/특수문자 조합</span>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>비밀번호 확인</th>
                            <td>
                                <input type="password" name="passwordConfirm" id="passwordConfirm" placeholder="비밀번호 재입력" style="width: 200px;">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="form-section">
                <h3 class="section-title">개인 정보</h3>
                <table class="form-table">
                    <tbody>
                        <tr>
                            <th><span class="req">*</span>이름</th>
                            <td><input type="text" name="name" style="width: 200px;" value="홍길동"></td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>생년월일</th>
                            <td><input type="text" name="birth" style="width: 200px;" value="1973-08-23" placeholder="YYYY-MM-DD"></td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>휴대전화</th>
                            <td><input type="text" name="phone" style="width: 200px;" value="010-1234-5678" placeholder="'-' 없이 입력"></td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>주소</th>
                            <td class="addr-box">
                                <input type="text" name="zipCode" id="zipCode" style="width: 100px;" readonly>
                                <button type="button" class="btn-check" onclick="openZipSearch()">우편번호 찾기</button>
                                <div style="margin-top: 5px;">
                                    <input type="text" name="addr1" id="addr1" style="width: 100%; max-width: 400px;" readonly placeholder="기본주소">
                                </div>
                                <div style="margin-top: 5px;">
                                    <input type="text" name="addr2" id="addr2" style="width: 100%; max-width: 400px;" placeholder="상세주소를 입력하세요">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>이메일</th>
                            <td class="email-box">
                                <input type="text" name="emailId" style="width: 150px;"> @ 
                                <input type="text" name="emailDomain" id="emailDomain" style="width: 150px;">
                                <select id="emailDomainSelect" onchange="changeEmailDomain()" style="width: 150px;">
                                    <option value="direct">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="daum.net">daum.net</option>
                                </select>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="form-section">
                <h3 class="section-title">부가 정보</h3>
                <table class="form-table">
                    <tbody>
                        <tr>
                            <th><span class="req">*</span>메일 수신</th>
                            <td class="radio-group">
                                <label><input type="radio" name="emailAgreed" value="1" checked> 수신</label>
                                <label><input type="radio" name="emailAgreed" value="0"> 비수신</label>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>SMS 수신</th>
                            <td class="radio-group">
                                <label><input type="radio" name="smsAgreed" value="1" checked> 수신</label>
                                <label><input type="radio" name="smsAgreed" value="0"> 비수신</label>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>비밀번호 힌트</th>
                            <td>
                                <select name="hintId" style="width: 100%; max-width: 300px; margin-bottom: 5px;">
                                    <option value="">질문 선택</option>
                                    <option value="1">가장 기억에 남는 장소는?</option>
                                    <option value="2">나의 보물 1호는?</option>
                                    <option value="3">초등학교 짝꿍 이름은?</option>
                                </select>
                                <input type="text" name="hintAnswer" style="width: 100%; max-width: 300px;" placeholder="답변 입력">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="btn-area">
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                <button type="button" class="btn-submit" onclick="checkForm()">가입하기</button>
            </div>

        </form>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>