<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>${not empty pageTitle ? pageTitle : '대한적십자'}</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, usrr-scalable=no">
    
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>

    <%-- [수정] /static/ 경로 추가 --%>
    <link rel="stylesheet" href="${contextPath}/static/main/css/base.css" type="text/css" />
    <link rel="stylesheet" href="${contextPath}/static/main/css/font.css" type="text/css" />
    <link rel="stylesheet" href="${contextPath}/static/main/css/layout.css" type="text/css" />
    
    <%-- [수정] JS 경로도 /static/main/으로 통일 --%>
    <script src="${contextPath}/static/main/js/jquery-1.11.3.min.js"></script>
</head>
<body>

    <jsp:include page="../fragments/header.jsp" flush="true"/>

    <div class="contents_wrap">
        
        <jsp:include page="../fragments/lnb.jsp" flush="true"/>
        
        <div class="sub_wrap">
            <c:import url="${content}" charEncoding="UTF-8" />
        </div>
    </div>  

    <jsp:include page="../fragments/footer.jsp" flush="true"/>

    <div id="dimmed"></div>
    <%-- [수정] /static/ 경로 추가 --%>
    <script src="${contextPath}/static/main/js/common.js"></script>
</body>
</html>