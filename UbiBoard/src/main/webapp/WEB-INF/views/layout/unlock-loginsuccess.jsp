<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>잠금 해제 완료 | 유비앤티스랩</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* 기존 유비앤티스랩 공통 스타일 */
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Noto Sans KR', sans-serif; background-color: #f9f9f9; color: #333; line-height: 1.5; }
.container { max-width: 800px; margin: 0 auto; background-color: #fff; min-height: 100vh; box-shadow: 0 0 20px rgba(0, 0, 0, 0.03); display: flex; flex-direction: column; }

/* 헤더 */
.header { padding: 30px 40px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
.header h1 { font-size: 24px; font-weight: 700; color: #2c3e50; }
.header h1 a { text-decoration: none; color: inherit; }

/* 단계 표시 (완료 단계 활성화) */
.step-wrap { padding: 40px 0 20px; text-align: center; }
.step-list { display: inline-flex; gap: 10px; list-style: none; color: #ccc; font-weight: 500; font-size: 14px; }
.step-list li { display: flex; align-items: center; }
.step-list li::after { content: ">"; margin-left: 10px; font-size: 12px; color: #ddd; }
.step-list li:last-child::after { display: none; }
.step-list li.active { color: #2c3e50; font-weight: 700; }
.step-list li.active span { display: inline-block; width: 24px; height: 24px; background: #2c3e50; color: #fff; border-radius: 50%; text-align: center; line-height: 24px; margin-right: 6px; font-size: 12px; }

/* 컨텐츠 영역 */
.content { padding: 60px 40px; flex: 1; text-align: center; }
.success-icon { font-size: 60px; color: #2ecc71; margin-bottom: 20px; }
.page-title { font-size: 26px; font-weight: 700; margin-bottom: 15px; color: #111; }
.page-desc { font-size: 15px; color: #666; margin-bottom: 40px; line-height: 1.6; }

/* 결과 박스 */
.result-box { background-color: #f8f9fa; padding: 30px; border-radius: 8px; max-width: 500px; margin: 0 auto 40px; border: 1px solid #eee; }
.result-box p { font-size: 14px; color: #555; }
.userId-display { font-size: 18px; font-weight: 700; color: #2c3e50; margin-top: 5px; }

/* 버튼 영역 */
.btn-area { display: flex; flex-direction: column; align-items: center; gap: 12px; }
.btn-main { width: 100%; max-width: 300px; height: 50px; font-size: 16px; font-weight: 700; border: none; border-radius: 6px; cursor: pointer; transition: 0.2s; text-decoration: none; display: flex; align-items: center; justify-content: center; }

.btn-login { background-color: #2c3e50; color: #fff; }
.btn-login:hover { background-color: #1a252f; }

.sub-btn-group { display: flex; gap: 10px; width: 100%; max-width: 300px; }
.btn-sub { flex: 1; height: 44px; background-color: #fff; color: #666; border: 1px solid #ddd; font-size: 13px; font-weight: 500; border-radius: 4px; text-decoration: none; display: flex; align-items: center; justify-content: center; }
.btn-sub:hover { background-color: #f1f3f5; color: #333; }

/* 푸터 */
.footer { padding: 30px; border-top: 1px solid #eee; text-align: center; font-size: 12px; color: #999; }
</style>
</head>
<body>

<div class="container">
    <header class="header">
        <h1><a href="${contextPath}/goMain">UBNTIS LAB</a></h1>
    </header>

    <div class="step-wrap">
        <ul class="step-list">
            <li><span>1</span>본인인증</li>
            <li class="active"><span>2</span>잠금 해제 완료</li>
        </ul>
    </div>

    <div class="content">
        <div class="success-icon">✔</div>
        <h2 class="page-title">계정 잠금 해제 완료</h2>
        <p class="page-desc">
            계정 잠금이 정상적으로 해제되었습니다.<br>
            이제 다시 유비앤티스랩의 모든 서비스를 이용하실 수 있습니다.
        </p>

        <div class="result-box">
            <p>대상 아이디</p>
            <div class="userId-display">${userId}</div>
        </div>

        <div class="btn-area">
            <a href="${contextPath}/default" class="btn-main btn-login">로그인 하러가기</a>
            
            <div class="sub-btn-group">
                <a href="${contextPath}/member/goFindId" class="btn-sub">아이디 찾기</a>
                <a href="${contextPath}/member/goFindPw" class="btn-sub">비밀번호 찾기</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>
</div>

</body>
</html>