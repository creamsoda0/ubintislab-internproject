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
    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/static/member/js/join-form.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/member/css/join-form.css">
		
</head>
<body>

<div class="container">
    
    <header class="header">
        <h1><a href="${contextPath}/default">UBNTIS LAB</a></h1>
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
                                <span id="pwMsg" class="error-msg"></span>
                                <span class="help-text">9자 이상, 영문/숫자/특수문자 조합</span>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>비밀번호 확인</th>
                            <td>
                                <input type="password" name="passwordConfirm" id="passwordConfirm" placeholder="비밀번호 재입력" style="width: 200px;">
                            	<span id="pwConfirmMsg" class="error-msg"></span>
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
                            <td><input type="text" name="name" style="width: 200px;" placeholder="이름을 입력하세요."></td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>생년월일</th>
                            <td><input type="text" name="birth" style="width: 200px;" value="1973-08-23" placeholder="YYYY-MM-DD" readonly></td>
                        </tr>
                        <tr>
                            <th><span class="req">*</span>휴대전화</th>
                            <td><input type="text" name="phone" maxlength="13" style="width: 200px;" value="010-1234-5678" placeholder="'-' 없이 입력"></td>
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
                                <input type="text" name="emailId" maxlength="30" style="width: 150px;"> @ 
                                <input type="text" name="emailDomain" maxlength="30" id="emailDomain" style="width: 150px;">
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
                                <input type="text" name="hintAnswer" style="width: 100%; max-width: 300px;" maxlength="50" placeholder="답변 입력">
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