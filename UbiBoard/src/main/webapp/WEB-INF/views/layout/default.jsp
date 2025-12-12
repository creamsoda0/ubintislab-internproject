<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>${not empty pageTitle ? pageTitle : '공지사항'}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>

    <%-- 기존 Base CSS (필요한 경우 유지) --%>
    <link rel="stylesheet" href="${contextPath}/static/main/css/base.css">
    
    <%-- [NEW] 새로 분리한 게시판 전용 CSS --%>
    <link rel="stylesheet" href="${contextPath}/static/main/css/board.css">
    
    <script src="${contextPath}/static/main/js/jquery-1.11.3.min.js"></script>
</head>
<body>

    <jsp:include page="../fragments/header.jsp" flush="true"/>

    <%-- board-container: 새로 만든 CSS의 최상위 래퍼 --%>
    <div class="board-container">
        
        <header class="board-header">
            <h2>공지사항</h2>
            <p>유비앤티스랩의 주요 소식과 안내사항을 확인하세요.</p>
        </header>

        <div class="board-toolbar">
            <div class="board-total">
                총 <strong>${totalCount}</strong>건의 게시물이 있습니다.
            </div>
            <form action="${contextPath}/board/list" method="get" class="search-form">
                <select name="searchType" class="search-select">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력하세요">
                <button type="submit" class="btn-search">검색</button>
            </form>
        </div>

        <div class="board-table-wrap">
            <table class="board-table">
                <colgroup>
                    <col style="width: 80px;" class="mobile-hide"> <col style="width: auto;">  <col style="width: 100px;" class="mobile-hide"> <col style="width: 120px;"> <col style="width: 120px;" class="mobile-hide"> <col style="width: 80px;" class="mobile-hide">  </colgroup>
                <thead>
                    <tr>
                        <th class="mobile-hide">번호</th>
                        <th>제목</th>
                        <th class="mobile-hide">첨부</th>
                        <th>작성자</th>
                        <th class="mobile-hide">작성일</th>
                        <th class="mobile-hide">조회</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty boardList}">
                            <tr>
                                <td colspan="6" class="no-data">등록된 게시글이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${boardList}">
                                <tr>
                                    <td class="mobile-hide">${item.id}</td>
                                    <td class="td-subject">
                                        <a href="${contextPath}/board/view?id=${item.id}">
                                            ${item.title}
                                            <c:if test="${item.isNew}">
                                                <span class="ico-new">N</span>
                                            </c:if>
                                        </a>
                                    </td>
                                    <td class="mobile-hide">
                                        <c:if test="${item.hasFile}">
                                            <span class="ico-file">📎</span> 
                                            <%-- 이미지 경로가 있다면 아래 사용 --%>
                                            <%-- <img src="${contextPath}/static/images/icon_file.png" alt="첨부" class="ico-file"> --%>
                                        </c:if>
                                    </td>
                                    <td>${item.writer}</td>
                                    <td class="mobile-hide"><fmt:formatDate value="${item.regDate}" pattern="yyyy.MM.dd"/></td>
                                    <td class="mobile-hide">${item.hit}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="board-footer">
            <div class="pagination">
                <a href="#" class="page-link">&lt;</a>
                <a href="#" class="page-link active">1</a>
                <a href="#" class="page-link">2</a>
                <a href="#" class="page-link">3</a>
                <a href="#" class="page-link">4</a>
                <a href="#" class="page-link">5</a>
                <a href="#" class="page-link">&gt;</a>
            </div>
            
            <div class="btn-area">
                <a href="${contextPath}/clip/goWrite" class="btn-write">글쓰기</a>
            </div>
        </div>

    </div>
    
    <jsp:include page="../fragments/footer.jsp" flush="true"/>
    <script src="${contextPath}/static/main/js/common.js"></script>
</body>
</html>