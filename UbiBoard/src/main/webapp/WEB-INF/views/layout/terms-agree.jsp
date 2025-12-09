<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>

<%-- [수정] /static/ 추가 --%>
<link rel="stylesheet" type="text/css" href="${contextPath}/static/member/css/import.css"/>

<title>서산시청 통합로그인</title>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    function checkAgree() {
        if(!$("#ckok1").is(":checked")) {
            alert("통합회원 이용약관에 동의해주세요.");
            $("#ckok1").focus();
            return;
        }
/*         if(!$("#ckok2").is(":checked")) {
            alert("개인정보 수집 및 이용안내에 동의해주세요.");
            $("#ckok2").focus();
            return;
        }
        if(!$("#ckok3").is(":checked")) {
            alert("수집한 개인정보의 제3자 제공에 동의해주세요.");
            $("#ckok3").focus();
            return;
        } */
        
        alert("모든 약관에 동의하셨습니다. 다음 단계로 이동합니다.");
        location.href = "${contextPath}/member/joinForm"; 
    }
</script>
</head>
<body>
        
    <div id="header">
        <%-- [수정] /static/ 추가 --%>
        <h1><img src="${contextPath}/static/member/img/logo.png" alt="서산시 통합회원 상단로고" /></h1>
        <div>
            <ul>
                <li><a href="#">통합로그인</a></li>
                <li><a href="#">통합회원탈퇴</a></li>
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
            <p>이용약관 재동의</p>
        </div>
        <div class="wrap">
            <div class="mt50 text">
                <h3>회원정보 재동의에 따른 약관동의</h3>

				<p class="s_title mt50">이용약관</p>
				<div class="terms mt15">
					제 1 장 총칙<br /><br />

					제 1 조 [목적]<br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
					본 약관은 아산시청이 운영하는 가족사이트 <br />
				</div>
               	<p class="terms_form mt10"><input type="checkbox" title="통합회원 이용약관 체크" id="ckok1" />&nbsp;&nbsp;<label for="ckok1">통합회원 이용약관에 동의합니다.</label></p>
                <form id="agreeForm" action="${contextPath}/member/agree" method="post">
                    <div class="btn mt50 t_center">
                        <button type="button" class="btn_blue" onclick="checkAgree()">동의합니다</button>
                        <button type="button" class="btn_gray ml20" onclick="history.back()">동의하지 않습니다</button>
                    </div>              
                </form>
            </div>
        </div>
    </div>

    <footer>
        <div id="footer">
            <div class="foot_bottom">
                <div class="foot_inner">
                    <%-- [수정] /static/member/img/ 경로로 완벽하게 수정 --%>
                    <h2><img src="${contextPath}/static/member/img/foot_logo.png" alt="서산시 하단로고" /></h2>
                    <div class="foot_info">
                         <p class="copy notranslate">COPYRIGHT 2016(C) THE CITY OF SEOSAN. ALL RIGHTS RESERVED.</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>