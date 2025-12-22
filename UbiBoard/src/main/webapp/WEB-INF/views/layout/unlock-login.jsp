<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>계정 잠금 해제 | 유비앤티스랩</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* =========================================
    유비앤티스랩 공통 스타일 유지
   ========================================= */
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Noto Sans KR', sans-serif; background-color: #f9f9f9; color: #333; line-height: 1.5; }
.container { max-width: 800px; margin: 0 auto; background-color: #fff; min-height: 100vh; box-shadow: 0 0 20px rgba(0, 0, 0, 0.03); display: flex; flex-direction: column; }

/* 헤더 */
.header { padding: 30px 40px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
.header h1 { font-size: 24px; font-weight: 700; color: #2c3e50; }
.header h1 a { text-decoration: none; color: inherit; }
.header-links a { font-size: 13px; color: #888; text-decoration: none; margin-left: 15px; }
.header-links a:hover { color: #2c3e50; font-weight: 500; }

/* 단계 표시 (2단계로 축소) */
.step-wrap { padding: 40px 0 20px; text-align: center; }
.step-list { display: inline-flex; gap: 10px; list-style: none; color: #ccc; font-weight: 500; font-size: 14px; }
.step-list li { display: flex; align-items: center; }
.step-list li::after { content: ">"; margin-left: 10px; font-size: 12px; color: #ddd; }
.step-list li:last-child::after { display: none; }
.step-list li.active { color: #2c3e50; font-weight: 700; }
.step-list li.active span { display: inline-block; width: 24px; height: 24px; background: #2c3e50; color: #fff; border-radius: 50%; text-align: center; line-height: 24px; margin-right: 6px; font-size: 12px; }

/* 컨텐츠 영역 */
.content { padding: 40px; flex: 1; }
.page-title { font-size: 24px; font-weight: 700; margin-bottom: 10px; color: #111; text-align: center; }
.page-desc { font-size: 14px; color: #666; margin-bottom: 40px; text-align: center; line-height: 1.6; }
.highlight { color: #e74c3c; font-weight: 600; }

/* 폼 박스 */
.form-box { max-width: 500px; margin: 0 auto; }
.input-group { margin-bottom: 20px; }
.input-group label { display: block; font-size: 14px; font-weight: 600; color: #333; margin-bottom: 8px; }
.input-row { display: flex; gap: 10px; }
input[type="text"], input[type="email"] { width: 100%; height: 44px; padding: 0 15px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; transition: border-color 0.2s; }
input:focus { border-color: #2c3e50; outline: none; }
input[readonly] { background-color: #f5f5f5; cursor: default; }

/* 버튼 */
.btn-small { min-width: 100px; height: 44px; background-color: #555; color: #fff; border: none; border-radius: 4px; font-size: 13px; cursor: pointer; transition: background 0.2s; }
.btn-small:hover { background-color: #333; }
.btn-small.blue { background-color: #2c3e50; }
.btn-area { margin-top: 40px; text-align: center; display: flex; justify-content: center; gap: 10px; }
.btn-main { min-width: 140px; height: 50px; font-size: 16px; font-weight: 700; border: none; border-radius: 6px; cursor: pointer; }
.btn-submit { background-color: #2c3e50; color: #fff; }
.btn-cancel { background-color: #f1f3f5; color: #555; }

/* 푸터 */
.footer { padding: 30px; border-top: 1px solid #eee; text-align: center; font-size: 12px; color: #999; }

@media screen and (max-width: 768px) {
    .content { padding: 20px; }
    .input-row { flex-direction: column; }
    .btn-small { width: 100%; }
    .btn-area { flex-direction: column-reverse; }
    .btn-main { width: 100%; }
}
</style>

<script>
    var isCertified = false;

    // 잠금 해제용 인증번호 발송
    function sendUnlockAuthNum() {
        var userId = $("#userId").val();
        var email = $("#email").val();

        if (userId.trim() == "") { alert("아이디를 입력해주세요."); return; }
        if (email.trim() == "") { alert("이메일을 입력해주세요."); return; }

        $.ajax({
            url : "${contextPath}/member/sendUnlockAuthCode", 
            type : "POST",
            data : { userId : userId, email : email },
            success : function(result) {
                alert("잠금 해제를 위한 인증번호가 발송되었습니다.");
                $("#authnumber").focus();
            },
            error : function(xhr) {
                if (xhr.status === 404) alert("해당 정보로 등록된 잠긴 계정이 없습니다.");
                else alert("메일 발송 중 오류가 발생했습니다.");
            }
        });
    }

    // 인증번호 확인
    function checkUnlockAuthNum() {
        var inputCode = $("#authnumber").val();
        var userId = $("#userId").val();

        if (inputCode.trim() == "") { alert("인증번호를 입력해주세요."); return; }

        $.ajax({
            url : "${contextPath}/member/checkAuthCode", // 기존 공통 인증번호 확인 로직 재사용 가능
            type : "POST",
            data : { userId : userId, inputCode : inputCode },
            success : function(result) {
                if (result === "success") {
                    alert("본인 인증에 성공하였습니다.\n이제 계정 잠금을 해제할 수 있습니다.");
                    isCertified = true;
                    $("#authnumber, #userId, #email").prop("readonly", true).css("background-color", "#e8f5e9");
                    $(".btn-small").prop("disabled", true).css("opacity", "0.6");
                } else {
                    alert("인증번호가 일치하지 않습니다.");
                }
            },
            error : function() { alert("서버 통신 오류입니다."); }
        });
    }

    // 3. 잠금 해제 처리
    function processUnlock() {
        if (!isCertified) {
            alert("먼저 이메일 인증을 완료해주세요.");
            return;
        }
        
        if(confirm("계정 잠금을 해제하시겠습니까?")) {
            document.unlockForm.submit();
        }
    }
</script>
</head>
<body>

<div class="container">
    <header class="header">
        <h1><a href="${contextPath}/goMain">UBNTIS LAB</a></h1>
        <div class="header-links">
            <a href="${contextPath}/default">로그인</a>
            <a href="${contextPath}/member/join">회원가입</a>
        </div>
    </header>

    <div class="step-wrap">
        <ul class="step-list">
            <li class="active"><span>1</span>본인인증</li>
            <li><span>2</span>잠금 해제 완료</li>
        </ul>
    </div>

    <div class="content">
        <h2 class="page-title">계정 잠금 해제</h2>
        <p class="page-desc">
            비밀번호 <span class="highlight">5회 오류</span>로 인해 계정이 일시적으로 제한되었습니다.<br>
            가입 시 등록한 이메일 인증을 통해 잠금을 해제해 주세요.
        </p>

        <form action="${contextPath}/member/unlockAccount" method="post" name="unlockForm" class="form-box">
            <div class="input-group">
                <label for="userId">아이디</label>
                <input type="text" name="userId" id="userId" placeholder="아이디를 입력하세요">
            </div>

            <div class="input-group">
                <label for="email">이메일 주소</label>
                <div class="input-row">
                    <input type="email" name="email" id="email" placeholder="example@ubntis.com">
                    <button type="button" class="btn-small" onclick="sendUnlockAuthNum()">인증번호 발송</button>
                </div>
            </div>

            <div class="input-group">
                <label for="authnumber">인증번호 확인</label>
                <div class="input-row">
                    <input type="text" name="authnumber" id="authnumber" placeholder="6자리 번호 입력">
                    <button type="button" class="btn-small blue" onclick="checkUnlockAuthNum()">인증확인</button>
                </div>
            </div>

            <div class="btn-area">
                <button type="button" class="btn-main btn-cancel" onclick="location.href='${contextPath}/member/login'">취소</button>
                <button type="button" class="btn-main btn-submit" onclick="processUnlock()">잠금 해제하기</button>
            </div>
        </form>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>
</div>

</body>
</html>