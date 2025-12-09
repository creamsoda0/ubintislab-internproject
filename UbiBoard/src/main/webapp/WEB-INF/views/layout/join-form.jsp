<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Context Path 설정 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>

<title>서산시청 통합로그인 - 회원가입</title>

<%-- CSS 경로 수정 (/static/member/ 추가) --%>
<link rel="stylesheet" type="text/css" href="${contextPath}/static/member/css/import.css"/>

<%-- jQuery 로드 --%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<%-- 다음 우편번호 API (실제 기능 구현 시 사용) --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    // 회원가입 폼 전송 전 유효성 검사
    function checkForm() {
        var f = document.joinForm;

        // 아이디 검사
        if(f.userId.value == "") {
            alert("아이디를 입력해주세요.");
            f.userId.focus();
            return false;
        }
        
        // 비밀번호 검사
        if(f.userPw.value == "") {
            alert("비밀번호를 입력해주세요.");
            f.userPw.focus();
            return false;
        }
        
        if(f.userPw.value != f.userPwConfirm.value) {
            alert("비밀번호 확인이 일치하지 않습니다.");
            f.userPwConfirm.focus();
            return false;
        }

        // 이름 검사
        if(f.userName.value == "") {
            alert("이름을 입력해주세요.");
            f.userName.focus();
            return false;
        }
        
        // 필수항목 검사 통과 시 전송
        f.submit();
    }

    // 아이디 중복 체크 (껍데기)
    function checkId() {
        var userId = $("#userId").val();
        if(userId == "") {
            alert("아이디를 입력 후 중복체크 해주세요.");
            return;
        }
        alert("사용 가능한 아이디입니다. (임시 메시지)");
        // 실제로는 ajax로 서버에 중복 확인 요청을 보내야 함
    }

    // 우편번호 찾기 (껍데기 - 다음 API 연동 위치)
    function openZipSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                $("#zipCode").val(data.zonecode);
                $("#addr1").val(data.address);
                $("#addr2").focus();
            }
        }).open();
    }
    
    // 이메일 도메인 선택 시 자동 입력
    function changeEmailDomain() {
        var domain = $("#emailDomainSelect").val();
        if(domain == "direct") {
            $("#emailDomain").val("");
            $("#emailDomain").attr("readonly", false);
            $("#emailDomain").focus();
        } else {
            $("#emailDomain").val(domain);
            $("#emailDomain").attr("readonly", true);
        }
    }
</script>

<style>
    /* 버튼 스타일 (import.css 미적용 대비) */
    .btn_blue {
        background: #0054a6; color: #fff; border: none; padding: 15px 40px; cursor: pointer; font-weight: bold; font-size: 14px;
    }
    .btn_gray {
        background: #666; color: #fff; border: none; padding: 15px 40px; cursor: pointer; font-weight: bold; font-size: 14px;
    }
    .in_btn_gray {
        background: #eee; border: 1px solid #ccc; padding: 5px 10px; cursor: pointer; font-size: 12px;
    }
    /* 여백 유틸리티 */
    .mt50 { margin-top: 50px; } .mt20 { margin-top: 20px; } .mt10 { margin-top: 10px; } .mt5 { margin-top: 5px; } .mt3 { margin-top: 3px; }
    .ml10 { margin-left: 10px; } .ml20 { margin-left: 20px; }
    .txt_red { color: #e60021; }
    .t_center { text-align: center; }
</style>

</head>
<body>
		
	<div id="header">
		<h1><img src="${contextPath}/static/member/img/logo.png" alt="서산시 통합회원 상단로고" /></h1>
		<div>
			<ul>
				<li><a href="#">통합로그인</a></li>
				<li><a href="#">통합회원가입</a></li>
				<li><a href="#">아이디찾기</a></li>
				<li><a href="#">비밀번호찾기</a></li>
				<li><a href="#">회원정보수정</a></li>
				<li><a href="#">비밀번호변경</a></li>
				<li><a href="#">통합회원탈퇴</a></li>
			</ul>
		</div>
	</div>
	<div id="content">
		
		<div class="top_img">			
			<p>통합회원가입</p>
		</div>
		<div class="wrap">
			<div class="step">
				<table class="reg_step" cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="20%">
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<td><div class="step01"><span>STEP 01</span><br />
						<p>회원유형</p></div></td>
						<td><div class="step02"><span>STEP 02</span><br />
						<p>약관동의</p></div></td>
						<td><div class="step03"><span>STEP 03</span><br />
						<p>본인확인</p></div></td>
						<td class="step_select"><div class="step04"><span>STEP 04</span><br />
						<p>개인정보입력</p></div></td>
						<td><div class="step05"><span>STEP 05</span><br />
						<p>가입완료</p></div></td>
					</tr>
				</table>
			</div>
			<div class="mt50 text">
				
                <form name="joinForm" action="${contextPath}/member/joinProcess" method="post">
                
				<h3>아이디 정보</h3>
				<p class="bullet01 mt20">회원가입을 위하여 아래사항을 입력해 주시기 바랍니다.</p>
				<p class="bullet01 mt14"><span class="txt_red">*</span> 은 필수 입력 항목입니다. 회원가입을 위하여 반드시 가입해 주시기 바랍니다.</p>
				
				<table cellpadding="0" cellspacing="0" class="mt39">
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th><span class="txt_red">*</span> 아이디</th>
						<td>
                            <input type="text" name="userId" id="userId" style="width:280px;" placeholder="아이디 입력"> 
                            <button type="button" class="in_btn_gray ml10" onclick="checkId()">중복체크</button><br />
						    <span class="mt3">아이디는 5자 이상, 20자 이하.<br />
						    아이디에 영문 소문자 포함.</span>
                        </td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 비밀번호</th>
						<td>
                            <input type="password" name="userPw" id="userPw" style="width:280px;" placeholder="비밀번호 입력"><br />
							<span class="mt3">비밀번호는 9자 이상, 20자 이하.<br />
							비밀번호에 동일문자는 3회 이상 사용불가.&nbsp; 예&#41; aaa, 111<br />
							비밀번호에 연속문자는 3회 이상 사용불가.&nbsp; 예&#41; abc, 123<br />
							비밀번호에 영문 소문자, 숫자, 특수문자 포함.</span>
						</td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 비밀번호 확인</th>
						<td><input type="password" name="userPwConfirm" id="userPwConfirm" style="width:280px;" placeholder="비밀번호 재입력"></td>
					</tr>
				</table>
				<h3 class="mt50">개인 정보</h3>
				<table cellpadding="0" cellspacing="0" class="mt20">
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th><span class="txt_red">*</span> 이름</th>
						<td><input type="text" name="userName" style="width:280px;" value="홍길동"></td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 생년월일</th>
						<td><input type="text" name="birth" style="width:280px;" value="1973-08-23" placeholder="YYYY-MM-DD"></td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 휴대전화</th>
						<td><input type="text" name="phone" style="width:280px;" value="010-1234-5678"></td>
					</tr>
					<tr>
						<th>일반전화</th>
						<td>
                            <select name="tel1" style="width:100px;">
								<option value="">선택</option>
                                <option value="02">02</option>
                                <option value="031">031</option>
                                <option value="041">041</option>
							</select> -
							<input type="text" name="tel2" style="width:90px;"> -
							<input type="text" name="tel3" style="width:90px;">
                        </td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 주소</th>
						<td>
                            <input type="text" name="zipCode" id="zipCode" style="width:100px;" readonly> 
                            <button type="button" class="in_btn_gray ml10" onclick="openZipSearch()">우편번호 찾기</button><br />
						    <input type="text" name="addr1" id="addr1" style="width:360px;" class="mt5" readonly> 
                            <input type="text" name="addr2" id="addr2" style="width:200px;" class="mt5" placeholder="상세주소를 입력해 주세요.">
                        </td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 이메일</th>
						<td>
                            <input type="text" name="emailId" style="width:190px;"> @ 
                            <input type="text" name="emailDomain" id="emailDomain" style="width:190px;">
							<select id="emailDomainSelect" onchange="changeEmailDomain()" style="width:200px;">
								<option value="direct">직접입력</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="daum.net">daum.net</option>
							</select>
						</td>
					</tr>
				</table>
				<h3 class="mt50">부가 정보</h3>
				<table cellpadding="0" cellspacing="0" class="mt20">
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th><span class="txt_red">*</span> 메일 수신 여부</th>
						<td>
                            <input type="radio" name="emailAgreed" value="Y" checked> 수신
						    <input type="radio" name="emailAgreed" value="N" class="ml20"> 비수신
                        </td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> <span class="f14">SMS(카카오알림톡) 수신여부</span></th>
						<td>
                            <input type="radio" name="smsAgreed" value="Y" checked> 수신
						    <input type="radio" name="smsAgreed" value="N" class="ml20"> 비수신
                        </td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 비밀번호 힌트 질문</th>
						<td>
                            <select name="pwHint" style="width:300px;">
								<option value="">비밀번호 힌트 선택</option>
                                <option value="1">가장 기억에 남는 장소는?</option>
                                <option value="2">나의 보물 1호는?</option>
                                <option value="3">초등학교 짝꿍 이름은?</option>
							</select>
                        </td>
					</tr>
					<tr>
						<th><span class="txt_red">*</span> 비밀번호 힌트 답</th>
						<td><input type="text" name="pwHintAnswer" style="width:300px;"></td>
					</tr>
				</table>
				<div class="btn mt50 t_center">
					<button type="button" class="btn_blue" onclick="checkForm()">확인</button>
					<button type="button" class="btn_gray ml20" onclick="history.back()">취소</button>
				</div>
                
                </form>
                </div>
			</div>
		
	</div>
	<footer>
		<div id="footer">
			<div class="foot_bottom">
				<div class="foot_inner">
					<h2><img src="${contextPath}/static/member/img/foot_logo.png" alt="서산시 하단로고" /></h2>
					<div class="foot_info">
						<h3 class="hid" style="display:none">하단 메뉴</h3>
						<ul class="foot_menu">
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=2469" target="_blank" title="새창열림">개인정보처리방침</a></li>
							<li><a href="http://www.seosan.go.kr//www/sub.do?key=1383" target="_blank" title="새창열림">오시는길</a></li>
						</ul>
						<p class="copy notranslate">[31974] 충남 서산시 관아문길 1 (읍내동)  / TEL:041-660-2114 / FAX:041-660-2357
							<br /> COPYRIGHT 2016(C) THE CITY OF SEOSAN. ALL RIGHTS RESERVED.</p>
					</div>
				</div>
			</div>
		</div>
	</footer>
	</body>
</html>