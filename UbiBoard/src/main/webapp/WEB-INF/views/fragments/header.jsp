<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Context Path 설정 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%-- 헤더 전용 CSS 연결 --%>
<link rel="stylesheet" href="${contextPath}/static/main/css/header.css">

<header class="rc-header">
    
    <div class="utility-bar">
        <div class="utility-inner">
            <ul class="utility-menu">
                <c:choose>
                    <%-- [CASE 1] 비로그인 상태 --%>
                    <c:when test="${empty sessionScope.loginUser}">
                        <li><a href="${contextPath}/member/goLoginPage">로그인</a></li>
                        <li><a href="${contextPath}/member/join">회원가입</a></li>
                        <li><a href="${contextPath}/member/goFindId">아이디 찾기</a></li>
                        <li class="no-line"><a href="${contextPath}/member/goFindPw">패스워드 찾기</a></li>
                    </c:when>

                    <%-- [CASE 2] 로그인 상태 --%>
                    <c:otherwise>
                        <%-- 로그인 연장 타이머 (디자인 개선됨) --%>
                        <li class="no-line">
                            <div class="timer-wrap">
                                <span class="timer-text" id="sessionTimer">30:00</span>
                                <button type="button" class="btn-extend" onclick="alert('로그인 시간이 연장되었습니다.');">연장</button>
                            </div>
                        </li>

                        <%-- 사용자 정보 --%>
                        <li>
                            <span class="user-info">
                                ${sessionScope.loginUser.name}
                                <span class="user-id">(${sessionScope.loginUser.userId})</span>
                            </span> 님
                        </li>
                        
                        <li><a href="${contextPath}/member/memberUpdate">정보수정</a></li>
                        <li class="no-line"><a href="${contextPath}/member/logout">로그아웃</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>

    <div class="main-bar">
        <h1 class="logo">
            <a href="${contextPath}/default">UBINTISLAB</a>
            <%-- 로고 이미지가 있다면 아래 주석 해제 후 사용 --%>
            <%-- <a href="${contextPath}/main"><img src="${contextPath}/static/images/logo.png" alt="유비앤티스랩"></a> --%>
        </h1>

        <a class="btn-hamburger" href="#none">
            <span></span><span></span><span></span>
        </a>
    </div>

</header>

<%-- 
    [참고] 타이머 스크립트는 common.js 등에 있거나 
    필요하다면 이 파일 하단에 <script>로 작성해야 작동합니다. 
--%>