<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>회원정보 수정 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        /* =========================================
           회원정보수정 페이지 스타일 (UBNTIS Style)
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

        /* 컨텐츠 */
        .content { padding: 40px; }
        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #111;
            padding-bottom: 20px;
            border-bottom: 2px solid #333;
        }

        /* 폼 섹션 */
        .form-section { margin-bottom: 40px; }
        .section-title {
            font-size: 18px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
            margin-top: 30px;
        }

        /* 테이블 스타일 */
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

        /* 입력 필드 */
        input[type="text"], input[type="password"], select {
            height: 40px;
            padding: 0 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
            vertical-align: middle;
        }
        input:focus, select:focus { border-color: #2c3e50; outline: none; }
        input[readonly] { background-color: #f5f5f5; cursor: default; }

        /* 버튼 */
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
        .btn-submit {
            min-width: 140px;
            height: 50px;
            background-color: #2c3e50;
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-submit:hover { background-color: #1a252f; }
        
        .btn-cancel {
            min-width: 140px;
            height: 50px;
            background-color: #f1f3f5;
            color: #555;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-cancel:hover { background-color: #e9ecef; }
        
        .help-text { font-size: 12px; color: #999; margin-left: 10px; }
        .req { color: #d32f2f; margin-right: 3px; }

        /* 라디오 그룹 */
        .radio-group label { margin-right: 20px; cursor: pointer; }
        .radio-group input { margin-right: 5px; vertical-align: middle; }

        /* 푸터 */
        .footer {
            margin-top: 40px;
            padding: 30px;
            border-top: 1px solid #eee;
            text-align: center;
            font-size: 12px;
            color: #999;
        }

        /* 반응형 */
        @media screen and (max-width: 768px) {
            .content { padding: 20px; }
            .form-table, .form-table tbody, .form-table tr, .form-table th, .form-table td {
                display: block; width: 100%;
            }
            .form-table th { padding-bottom: 5px; background: none; border: none; }
            .form-table td { padding-top: 5px; padding-bottom: 20px; }
            input[type="text"], select { width: 100%; margin-bottom: 5px; }
            .email-box, .phone-box { display: flex; flex-direction: column; gap: 5px; }
            .btn-check { width: 100%; margin: 5px 0 0 0; }
        }
    </style>

    <script>
        // 정보 수정 유효성 검사 및 데이터 병합
        function updateCheck() {
            var form = document.updateForm;
            
            // 1. 전화번호 합치기
            var p1 = document.getElementById("phone1").value;
            var p2 = document.getElementById("phone2").value;
            var p3 = document.getElementById("phone3").value;
            
            if(p1 && p2 && p3) {
                form.phone.value = p1 + "-" + p2 + "-" + p3;
            } else {
                alert("휴대전화 번호를 모두 입력해주세요.");
                document.getElementById("phone2").focus();
                return;
            }

            // 2. 이메일 합치기
            var eId = document.getElementById("emailId").value;
            var eDomain = document.getElementById("emailDomain").value;
            
            if(eId && eDomain) {
                form.email.value = eId + "@" + eDomain;
            } else {
                alert("이메일을 모두 입력해주세요.");
                document.getElementById("emailId").focus();
                return;
            }

            // 3. 힌트 답 확인
            if(!form.hintAnswer.value.trim()) {
                alert("비밀번호 힌트 정답을 입력해주세요.");
                form.hintAnswer.focus();
                return;
            }

            if(confirm("회원정보를 수정하시겠습니까?")) {
                form.submit();
            }
        }

        // 이메일 도메인 변경
        function changeEmailDomain() {
            var select = document.getElementById("emailDomainSelect");
            var domain = document.getElementById("emailDomain");
            
            if(select.value === "direct") {
                domain.value = "";
                domain.readOnly = false;
                domain.focus();
            } else {
                domain.value = select.value;
                domain.readOnly = true;
            }
        }

        // 주소 찾기 (Daum API)
        function openZipSearch() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = '';
                    if (data.userSelectedType === 'R') {
                        addr = data.roadAddress;
                    } else {
                        addr = data.jibunAddress;
                    }
                    document.getElementById('zipCode').value = data.zonecode;
                    document.getElementById("addr1").value = addr;
                    document.getElementById("addr2").focus();
                }
            }).open();
        }
    </script>
</head>
<body>

<div class="container">
    
    <header class="header">
        <h1><a href="${contextPath}/main">UBNTIS LAB</a></h1>
        <div class="header-util">
            <a href="${contextPath}/member/logout">로그아웃</a>
            <a href="${contextPath}/member/delete">회원탈퇴</a>
        </div>
    </header>

    <div class="content">
        <h2 class="page-title">회원정보 수정</h2>
        <p style="font-size: 14px; color: #666; margin-bottom: 20px;">
            <span class="req">*</span> 항목은 필수 입력값입니다.
        </p>

        <form name="updateForm" action="${contextPath}/member/updateProcess" method="post">
            <input type="hidden" name="phone" value="">
            <input type="hidden" name="email" value="">
            <input type="hidden" name="userId" value="${loginUser.userId}">

            <h3 class="section-title">계정 정보</h3>
            <table class="form-table">
                <tbody>
                    <tr>
                        <th>아이디</th>
                        <td><strong>${loginUser.userId}</strong></td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>
                            ${loginUser.name}
                            <span class="help-text">※ 개명 시 별도 문의</span>
                        </td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td>${loginUser.birth}</td>
                    </tr>
                </tbody>
            </table>

            <h3 class="section-title">연락처 정보</h3>
            <table class="form-table">
                <tbody>
                    <tr>
                        <th><span class="req">*</span>휴대전화</th>
                        <td>
                            <c:set var="phones" value="${fn:split(loginUser.phone, '-')}" />
                            
                            <div class="phone-box">
                                <select id="phone1" style="width: 80px;">
                                    <option value="010" <c:if test="${phones[0] == '010'}">selected</c:if>>010</option>
                                    <option value="011" <c:if test="${phones[0] == '011'}">selected</c:if>>011</option>
                                    <option value="016" <c:if test="${phones[0] == '016'}">selected</c:if>>016</option>
                                </select> - 
                                <input type="text" id="phone2" value="${phones[1]}" maxlength="4" style="width: 80px;"> - 
                                <input type="text" id="phone3" value="${phones[2]}" maxlength="4" style="width: 80px;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="req">*</span>주소</th>
                        <td>
                            <div style="margin-bottom: 5px;">
                                <input type="text" name="zipCode" id="zipCode" value="${zip}" style="width: 100px;" readonly>
                                <button type="button" class="btn-check" onclick="openZipSearch()">우편번호 찾기</button>
                            </div>
                            <div style="margin-bottom: 5px;">
                                <input type="text" name="addr1" id="addr1" value="${addr}" style="width: 100%; max-width: 400px;" readonly>
                            </div>
                            <div>
                                <input type="text" name="addr2" id="addr2" value="" placeholder="상세주소를 입력하세요" style="width: 100%; max-width: 400px;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><span class="req">*</span>이메일</th>
                        <td>
                            <c:set var="emails" value="${fn:split(loginUser.email, '@')}" />
                            
                            <div class="email-box">
                                <input type="text" id="emailId" value="${emails[0]}" style="width: 140px;"> @ 
                                <input type="text" id="emailDomain" value="${emails[1]}" style="width: 140px;">
                                <select id="emailDomainSelect" onchange="changeEmailDomain()" style="width: 140px;">
                                    <option value="direct">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="daum.net">daum.net</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

            <h3 class="section-title">부가 정보</h3>
            <table class="form-table">
                <tbody>
                    <tr>
                        <th>메일 수신</th>
                        <td class="radio-group">
                            <label><input type="radio" name="emailAgreed" value="1" <c:if test="${loginUser.emailAgreed == 1}">checked</c:if>> 수신</label>
                            <label><input type="radio" name="emailAgreed" value="0" <c:if test="${loginUser.emailAgreed == 0}">checked</c:if>> 비수신</label>
                        </td>
                    </tr>
                    <tr>
                        <th>SMS 수신</th>
                        <td class="radio-group">
                            <label><input type="radio" name="smsAgreed" value="1" <c:if test="${loginUser.smsAgreed == 1}">checked</c:if>> 수신</label>
                            <label><input type="radio" name="smsAgreed" value="0" <c:if test="${loginUser.smsAgreed == 0}">checked</c:if>> 비수신</label>
                        </td>
                    </tr>
                    <tr>
                        <th>비밀번호 힌트</th>
                        <td>
                            <select name="hintId" style="width: 100%; max-width: 300px; margin-bottom: 5px;">
                                <option value="1" <c:if test="${loginUser.hintId == 1}">selected</c:if>>가장 기억에 남는 장소는?</option>
                                <option value="2" <c:if test="${loginUser.hintId == 2}">selected</c:if>>나의 보물 1호는?</option>
                                <option value="3" <c:if test="${loginUser.hintId == 3}">selected</c:if>>초등학교 짝꿍 이름은?</option>
                            </select>
                            <br>
                            <input type="text" name="hintAnswer" value="${loginUser.hintAnswer}" style="width: 100%; max-width: 300px; margin-top: 5px;">
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="btn-area">
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                <button type="button" class="btn-submit" onclick="updateCheck()">수정하기</button>
            </div>
        </form>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>