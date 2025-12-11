<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Context Path 설정 (링크 경로 깨짐 방지) --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<header class='top_bg'>
    <div class="header_wrap">
        <a class="menu" href="#none">menu</a>
        
        <ul class="utility">
            <%-- 로그인 상태 체크 --%>
            <%-- Controller에서 로그인 성공 시 session에 'loginUser'라는 이름으로 사용자 객체를 담았다고 가정합니다. --%>
            <c:choose>
                <%-- 1. 로그인을 하지 않은 경우 (loginUser가 비어있음) --%>
                <c:when test="${empty sessionScope.loginUser}">
                    <li><a href="${contextPath}/member/goLoginPage">로그인</a></li>
                    <li> | </li>
                    <li><a href="${contextPath}/member/join">회원가입</a></li>
                    <li> | </li>
                    <li><a href="${contextPath}/member/goFindId">아이디 찾기</a></li>
                    <li> | </li>
                    <li><a href="${contextPath}/member/goFindPw">패스워드 찾기</a></li>
                    <li> | </li>
                </c:when>

                <%-- 2. 로그인을 한 경우 --%>
                <c:otherwise>
                    <%-- [나중에 구현] 로그인 연장 및 남은 시간 표시 (껍데기) --%>
                    <li class="login-timer-wrap" style="margin-right: 20px; font-size: 13px;">
                        <span class="timer-text">남은 시간 : <strong id="sessionTimer" style="color: #ffff00;">30:00</strong></span>
                        <button type="button" class="btn-extend" onclick="alert('로그인 연장 기능은 추후 구현 예정입니다.')" style="margin-left: 5px; cursor: pointer; border: 1px solid #fff; background: none; color: #fff; padding: 2px 5px; font-size: 11px;">연장</button>
                    </li>

                    <%-- 사용자 이름 출력 (DB에서 가져온 정보) --%>
                    <%-- loginUser 객체 안에 name, userId 필드가 있다고 가정 --%>
                    <li>
                        <strong>${sessionScope.loginUser.name} (${sessionScope.loginUser.userId})</strong> 님 반갑습니다.
                    </li>
                    <li><a href="${contextPath}/member/logout">로그아웃</a></li>
                    <li><a href="${contextPath}/member/memberUpdate">정보수정</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</header>