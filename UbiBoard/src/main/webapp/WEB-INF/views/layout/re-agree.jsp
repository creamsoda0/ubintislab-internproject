<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>개인정보 재동의 | 유비앤티스랩</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* 기존 유비앤티스랩 스타일 유지 */
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Noto Sans KR', sans-serif; background-color: #f9f9f9; color: #333; line-height: 1.5; }
.container { max-width: 800px; margin: 0 auto; background-color: #fff; min-height: 100vh; box-shadow: 0 0 20px rgba(0, 0, 0, 0.03); display: flex; flex-direction: column; }

/* 헤더 */
.header { padding: 30px 40px; border-bottom: 1px solid #eee; }
.header h1 { font-size: 24px; font-weight: 700; color: #2c3e50; text-align: center; }
.header h1 a { text-decoration: none; color: inherit; }

/* 컨텐츠 영역 */
.content { padding: 40px; flex: 1; }
.page-title { font-size: 24px; font-weight: 700; margin-bottom: 10px; color: #111; text-align: center; }
.page-desc { font-size: 14px; color: #666; margin-bottom: 40px; text-align: center; line-height: 1.6; }
.highlight-box { background-color: #f0f4f8; padding: 15px; border-radius: 6px; margin-bottom: 30px; font-size: 13px; color: #444; border-left: 4px solid #2c3e50; }

/* 약관 영역 */
.terms-wrapper { max-width: 600px; margin: 0 auto; }
.terms-item { margin-bottom: 25px; }
.terms-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.terms-header label { font-size: 14px; font-weight: 600; color: #333; display: flex; align-items: center; cursor: pointer; }
.terms-header input[type="checkbox"] { margin-right: 8px; width: 16px; height: 16px; accent-color: #2c3e50; }
.terms-view { width: 100%; height: 120px; padding: 12px; border: 1px solid #ddd; border-radius: 4px; background-color: #fafafa; font-size: 12px; color: #777; overflow-y: scroll; line-height: 1.6; }

/* 전체 동의 영역 */
.all-agree-wrap { background-color: #f8f9fa; padding: 20px; border-radius: 6px; margin-bottom: 30px; border: 1px solid #eee; }
.all-agree-wrap label { font-size: 16px; font-weight: 700; color: #2c3e50; display: flex; align-items: center; cursor: pointer; }
.all-agree-wrap input[type="checkbox"] { width: 20px; height: 20px; margin-right: 12px; accent-color: #2c3e50; }

/* 버튼 영역 */
.btn-area { margin-top: 40px; text-align: center; display: flex; justify-content: center; gap: 10px; }
.btn-main { min-width: 140px; height: 50px; font-size: 16px; font-weight: 700; border: none; border-radius: 6px; cursor: pointer; }
.btn-submit { background-color: #2c3e50; color: #fff; }
.btn-submit:hover { background-color: #1a252f; }
.btn-logout { background-color: #f1f3f5; color: #555; }

/* 푸터 */
.footer { padding: 30px; border-top: 1px solid #eee; text-align: center; font-size: 12px; color: #999; }

@media screen and (max-width: 768px) {
    .content { padding: 20px; }
    .btn-area { flex-direction: column-reverse; }
    .btn-main { width: 100%; }
}
</style>

<script>
    $(document).ready(function() {
        // 전체 동의 체크박스 로직
        $("#checkAll").click(function() {
            $(".single-check").prop('checked', $(this).prop('checked'));
        });

        $(".single-check").click(function() {
            var total = $(".single-check").length;
            var checked = $(".single-check:checked").length;
            $("#checkAll").prop('checked', total === checked);
        });
    });

    function submitAgreement() {
        if (!$("#agreeService").is(":checked") || !$("#agreePrivacy").is(":checked")) {
            alert("필수 약관에 모두 동의하셔야 서비스 이용이 가능합니다.");
            return;
        }
        
        if(confirm("입력하신 내용으로 재동의를 진행하시겠습니까?")) {
            document.agreeForm.submit();
        }
    }
</script>
</head>
<body>

<div class="container">
    <header class="header">
        <h1><a href="${contextPath}/">UBNTIS LAB</a></h1>
    </header>

    <div class="content">
        <h2 class="page-title">서비스 이용 재동의</h2>
        <p class="page-desc">
            유비앤티스랩을 이용해 주셔서 감사합니다.<br>
            관련 법령에 따라 <b>1년마다</b> 개인정보 수집 및 이용에 대한 재동의를 진행하고 있습니다.
        </p>

        <div class="highlight-box">
            회원님은 <b><c:out value="${lastAgreedDate}" default="2023-12-22" /></b>에 마지막으로 동의하셨습니다.<br>
            원활한 서비스 이용을 위해 아래 약관을 확인하신 후 다시 한번 동의해 주시기 바랍니다.
        </div>

        <form action="${contextPath}/member/updateReAgree" method="post" name="agreeForm" class="terms-wrapper">
            
            <div class="all-agree-wrap">
                <label>
                    <input type="checkbox" id="checkAll"> 이용약관 및 개인정보 수집·이용에 전체 동의
                </label>
            </div>

            <div class="terms-item">
                <div class="terms-header">
                    <label>
                        <input type="checkbox" id="agreeService" class="single-check" name="serviceAgree">
                        서비스 이용약관 동의 (필수)
                    </label>
                </div>
                <div class="terms-view">
                    제 1 조 (목적)
                    본 약관은 유비앤티스랩(이하 "회사")이 제공하는 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
                    ... (중략) ...
                    제 2 조 (기간)
                    재동의는 1년 주기로 진행되며 동의 시점으로부터 다시 1년간 유효합니다.
                </div>
            </div>

            <div class="terms-item">
                <div class="terms-header">
                    <label>
                        <input type="checkbox" id="agreePrivacy" class="single-check" name="privacyAgree">
                        개인정보 수집 및 이용 동의 (필수)
                    </label>
                </div>
                <div class="terms-view">
                    1. 수집하는 개인정보 항목: 아이디, 이름, 이메일, 접속 로그
                    2. 수집 및 이용 목적: 서비스 제공 및 사용자 식별, 보안 강화
                    3. 보유 및 이용 기간: 회원 탈퇴 시 혹은 재동의 거부 시 즉시 파기
                </div>
            </div>

<!--             <div class="terms-item">
                <div class="terms-header">
                    <label>
                        <input type="checkbox" id="agreeMarketing" class="single-check" name="marketingAgree">
                        마케팅 정보 수신 동의 (선택)
                    </label>
                </div>
                <div class="terms-view">
                    유비앤티스랩의 새로운 기술 소식 및 이벤트 정보를 이메일로 받아보실 수 있습니다.
                </div>
            </div>
 -->
            <div class="btn-area">
                <button type="button" class="btn-main btn-logout" onclick="location.href='${contextPath}/member/logout'">다음에 하기(로그아웃)</button>
                <button type="button" class="btn-main btn-submit" onclick="submitAgreement()">동의하고 계속하기</button>
            </div>
        </form>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>
</div>

</body>
</html>