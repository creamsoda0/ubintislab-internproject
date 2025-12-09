<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>${not empty pageTitle ? pageTitle : '대한적십자'}</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, usrr-scalable=no">
    
    <%-- [중요] Context Path 변수 설정 --%>
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>

    <%-- CSS 절대 경로 설정 --%>
    <link rel="stylesheet" href="${contextPath}/main/css/base.css" type="text/css" />
    <link rel="stylesheet" href="${contextPath}/main/css/font.css" type="text/css" />
    <link rel="stylesheet" href="${contextPath}/main/css/layout.css" type="text/css" />
    
    <%-- jQuery --%>
    <script src="${contextPath}/js/jquery-1.11.3.min.js"></script>
</head>
<body>

    <%-- 1. 헤더 조각 포함 --%>
    <jsp:include page="../fragments/header.jsp" flush="true"/>

    <div class="contents_wrap">
        
        <%-- 2. 왼쪽 메뉴(LNB) 조각 포함 --%>
        <jsp:include page="../fragments/lnb.jsp" flush="true"/>
        
        <div class="sub_wrap">
            <%-- Controller에서 보낸 content 경로의 JSP를 로드 --%>
            <c:import url="${content}" charEncoding="UTF-8" />
        </div>
        </div>  
    <%-- 3. 푸터 조각 포함 --%>
    <jsp:include page="../fragments/footer.jsp" flush="true"/>

    <div id="dimmed"></div>
    <script src="${contextPath}/main/js/common.js"></script>
</body>
</html>