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
    <script src="${contextPath}/static/main/js/masking.js"></script>
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
            <form action="${contextPath}/goMain" method="get" class="search-form">
                <select name="searchType" class="search-select">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <input type="text" name="keyword" class="search-input" placeholder="검색기능 미구현">
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
                        <!-- <th class="mobile-hide">첨부</th> -->
                        <th>작성자</th>
                        <th class="mobile-hide">작성일</th>
                        <th class="mobile-hide">조회</th>
                        <th class="mobile-hide">좋아요</th>
                    </tr>
                </thead>
                <tbody>
<c:choose>
            <c:when test="${empty clipList}">
                <tr>
                    <td colspan="5" style="text-align:center;">등록된 게시글이 없습니다.</td>
                </tr>
            </c:when>
            
            <c:otherwise>
                <c:forEach var="vo" items="${clipList}">
                    <tr>
                        <td>${vo.boardId}</td>
                        <td style="text-align:middle;">
                            <a href="${contextPath}/clip/read?boardId=${vo.boardId}">
                                ${vo.title}
                            </a>
                        </td>
                        <td><span class="mask-id">${vo.userId}</span></td>
                        <td>
                            <fmt:formatDate value="${vo.regDate}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>${vo.views}</td>
                        <td>${vo.likeCount}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
                </tbody>
            </table>
        </div>

<div class="board-footer">
    <div class="pagination">
        
        <%-- 이전 버튼 --%>
        <c:if test="${pageMaker.prev}">
            <a href="${contextPath}/goMain?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.paging.amount}" class="page-link">&lt;</a>
        </c:if>

        <%-- 페이지 번호 반복 --%>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <a href="${contextPath}/goMain?pageNum=${num}&amount=${pageMaker.paging.amount}" 
               class="page-link ${pageMaker.paging.pageNum == num ? 'active' : ''}">
               ${num}
            </a>
        </c:forEach>

        <%-- 다음 버튼 --%>
        <c:if test="${pageMaker.next}">
            <a href="${contextPath}/goMain?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.paging.amount}" class="page-link">&gt;</a>
        </c:if>

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