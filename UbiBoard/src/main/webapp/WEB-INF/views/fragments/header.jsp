<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class='top_bg'>
    <div class="header_wrap">
        <h1><a href="${pageContext.request.contextPath}/">대한적십자</a></h1>
        <a class="menu" href="#none">menu</a>
        <ul class="utility">
            <li><strong>홍길동(test01)</strong> 님 반갑습니다.</li>
            <li><a href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
        </ul>
    </div>
</header>