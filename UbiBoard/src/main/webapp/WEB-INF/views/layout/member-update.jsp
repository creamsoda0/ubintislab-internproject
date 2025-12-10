<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>

<link rel="stylesheet" type="text/css" href="${contextPath}/static/member/css/import.css"/>

<%-- 다음 우편번호 API (실제 기능 구현 시 사용) --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<title>서산시청 회원정보수정</title>

<script>
    // 폼 전송 전 유효성 검사 및 데이터 합치기
    function updateCheck() {
        var form = document.updateForm;
        
        // 1. 전화번호 합치기 (화면엔 3개지만 DB엔 1개로 저장)
        var phone1 = document.getElementById("phone1").value;
        var phone2 = document.getElementById("phone2").value;
        var phone3 = document.getElementById("phone3").value;
        
        if(phone1 && phone2 && phone3) {
            form.phone.value = phone1 + "-" + phone2 + "-" + phone3;
        } else {
            alert("전화번호를 모두 입력해주세요.");
            return;
        }

        // 2. 이메일 합치기
        var emailId = document.getElementById("emailId").value;
        var emailDomain = document.getElementById("emailDomain").value;
        
        if(emailId && emailDomain) {
            form.email.value = emailId + "@" + emailDomain;
        } else {
            alert("이메일을 입력해주세요.");
            return;
        }

        // 비밀번호 힌트 답 확인
        if(!form.hintAnswer.value) {
            alert("비밀번호 힌트 정답을 입력해주세요.");
            return;
        }

        // 전송
        form.submit();
    }

    // 이메일 도메인 선택 시 자동 입력
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
</script>
</head>
<body>
    
    <div id="header">
        <h1><img src="${contextPath}/static/member/img/logo.png" alt="서산시 통합회원 상단로고" /></h1>
        <div>
            <ul>
                <li><a href="${contextPath}/member/login">통합로그인</a></li>
                <li><a href="${contextPath}/member/join">통합회원가입</a></li>
                <li><a href="#">아이디찾기</a></li>
                <li><a href="#">비밀번호찾기</a></li>
                <li><a href="${contextPath}/member/myPage">회원정보수정</a></li>
                <li><a href="#">비밀번호변경</a></li>
                <li><a href="${contextPath}/member/delete">통합회원탈퇴</a></li>
            </ul>
        </div>
    </div>
    <div id="content">
        
        <div class="top_img">            
            <p>회원정보수정</p>
        </div>
        <div class="wrap">
            
            <div class="step">
                <table cellpadding="0" cellspacing="0">
                    <colgroup>
                        <col width="50%">
                        <col width="*">
                    </colgroup>
                    <tr>
                        <td class="step_select">회원정보수정</td>
                        <td>회원정보수정 완료</td>
                    </tr>
                </table>
            </div>
            <div class="mt50 text">
                
                <form name="updateForm" action="${contextPath}/member/updateProcess" method="post">
                    
                    <input type="hidden" name="phone" value="">
                    <input type="hidden" name="email" value="">
                    <input type="hidden" name="userId" value="${loginUser.userId}">
    
                    <h3>아이디 정보</h3>
                    <p class="bullet01 mt20">정보수정을 위하여 아래사항을 입력해 주시기 바랍니다.</p>
                    <p class="bullet01 mt14"><span class="txt_red">*</span> 은 필수 입력 항목입니다.</p>
                    
                    <table cellpadding="0" cellspacing="0" class="mt39">
                        <colgroup>
                            <col width="20%">
                            <col width="*">
                        </colgroup>
                        <tr>
                            <th><span class="txt_red">*</span> 아이디</th>
                            <td><strong>${loginUser.userId}</strong></td>
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
                            <td>
                                ${loginUser.name} 
                                <button type="button" class="in_btn_gray ml20" onclick="alert('준비 중입니다.')">이름변경</button> 
                                <span class="txt_red in_block">* 개명으로 이름이 변경된 경우에 한하여 변경이 가능합니다.</span>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="txt_red">*</span> 생년월일</th>
                            <td>${loginUser.birth}</td>
                        </tr>
                        <tr>
                            <th><span class="txt_red">*</span> 휴대전화</th>
                            <td>
                                <c:set var="phones" value="${fn:split(loginUser.phone, '-')}" />
                                
                                <select id="phone1" style="width:100px;">
                                    <option value="010" <c:if test="${phones[0] == '010'}">selected</c:if>>010</option>
                                    <option value="011" <c:if test="${phones[0] == '011'}">selected</c:if>>011</option>
                                    <option value="016" <c:if test="${phones[0] == '016'}">selected</c:if>>016</option>
                                </select> -
                                <input type="text" id="phone2" style="width:90px;" value="${phones[1]}" maxlength="4"> -
                                <input type="text" id="phone3" style="width:90px;" value="${phones[2]}" maxlength="4">
                            </td>
                        </tr>
					<tr>
						<th><span class="txt_red">*</span> 주소</th>
						<td>
                            <input type="text" name="zipCode" id="zipCode" style="width:100px;" value="${zip}" readonly> 
                            <button type="button" class="in_btn_gray ml10" onclick="openZipSearch()">우편번호 찾기</button><br />
						    <input type="text" name="addr1" id="addr1" style="width:360px;" value="${addr}" class="mt5" readonly> 
                            <input type="text" name="addr2" id="addr2" style="width:200px;" class="mt5" placeholder="상세주소를 입력해 주세요.">
                        </td>
					</tr>
                        <tr>
                            <th><span class="txt_red">*</span> 이메일</th>
                            <td>
                                <c:set var="emails" value="${fn:split(loginUser.email, '@')}" />
                                
                                <input type="text" id="emailId" style="width:190px;" value="${emails[0]}"> @ 
                                <input type="text" id="emailDomain" style="width:190px;" value="${emails[1]}">
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
                                <input type="radio" name="emailAgreed" value="1" <c:if test="${loginUser.emailAgreed == 1}">checked</c:if>> 수신
                                <input type="radio" name="emailAgreed" value="0" <c:if test="${loginUser.emailAgreed == 0}">checked</c:if> class="ml20"> 비수신
                            </td>
                        </tr>
                        <tr>
                            <th><span class="txt_red">*</span> <span class="f14">SMS(카카오알림톡) 수신여부</span></th>
                            <td>
                                <input type="radio" name="smsAgreed" value="1" <c:if test="${loginUser.smsAgreed == 1}">checked</c:if>> 수신
                                <input type="radio" name="smsAgreed" value="0" <c:if test="${loginUser.smsAgreed == 0}">checked</c:if> class="ml20"> 비수신
                            </td>
                        </tr>
                        <tr>
                            <th><span class="txt_red">*</span> 비밀번호 힌트 질문</th>
                            <td>
                                <select name="hintId" style="width:300px;">
                                    <option value="">비밀번호 힌트 선택</option>
                                    <option value="1" <c:if test="${loginUser.hintId == 1}">selected</c:if>>가장 기억에 남는 장소는?</option>
                                    <option value="2" <c:if test="${loginUser.hintId == 2}">selected</c:if>>나의 보물 1호는?</option>
                                    <option value="3" <c:if test="${loginUser.hintId == 3}">selected</c:if>>초등학교 짝꿍 이름은?</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="txt_red">*</span> 비밀번호 힌트 답</th>
                            <td><input type="text" name="hintAnswer" style="width:300px;" value="${loginUser.hintAnswer}"></td>
                        </tr>
                    </table>
                    <div class="btn mt50 t_center">
                        <button type="button" class="btn_blue" onclick="updateCheck()">확인</button>
                        <button type="button" class="btn_gray ml20" onclick="history.back()">취소</button>
                    </div>
                </form> </div>
            </div>
        
    </div>
    <footer>
        <div id="footer">
            <div class="foot_bottom">
                <div class="foot_inner">
                    <h2><img src="${contextPath}/member/img/foot_logo.png" alt="서산시 하단로고" /></h2>
                    <div class="foot_info">
                        <p class="copy notranslate">[31974] 충남 서산시 관아문길 1 (읍내동) / TEL:041-660-2114 / FAX:041-660-2357
                            <br /> COPYRIGHT 2016(C) THE CITY OF SEOSAN. ALL RIGHTS RESERVED.</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    </body>
    <script>
 // 카카오(다음) 주소 API 연동
    function openZipSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // HTML에 있는 id="zipCode", id="addr1" 과 일치해야 함
                document.getElementById('zipCode').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
    </script>
    
</html>