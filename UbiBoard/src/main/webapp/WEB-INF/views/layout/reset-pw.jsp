<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    <title>비밀번호 재설정 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${contextPath}/resources/static/member/css/reset-pw.css">

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