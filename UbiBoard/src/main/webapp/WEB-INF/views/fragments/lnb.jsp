<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sub_nav ani">
    <h2 class="sub_title"></h2> <ul class="sub_nav_inner">
        <li>
            <a href="${pageContext.request.contextPath}/sub02/password">비밀번호 변경</a>
        </li>
        <li>
            <a class="add" href="#none">시스템 접근 권한</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/sub02/auth/apply">권한 신청</a></li>
                <li><a href="${pageContext.request.contextPath}/sub02/auth/approve">권한 승인</a></li>
            </ul>
        </li>
        <li>
            <a class="add" href="#none">IT자료실</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/sub02/faq">자주하는 질문</a></li>
                <li><a href="${pageContext.request.contextPath}/sub02/manual">매뉴얼</a></li>
                <li><a href="#none">설치파일</a></li>
            </ul>
        </li>
    </ul>
</div>