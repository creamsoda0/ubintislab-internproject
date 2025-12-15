<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>${board.title} | 상세보기</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    <script src="${contextPath}/static/main/js/jquery-1.11.3.min.js"></script>

    <%-- ★ 내부 CSS 스타일 (이 파일에서만 즉시 적용됨) ★ --%>
    <style>
        /* 1. 레이아웃 기본 */
        .board-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            font-family: 'Noto Sans KR', 'Malgun Gothic', sans-serif;
        }

        .board-header {
            text-align: center;
            margin-bottom: 40px;
            border-bottom: 2px solid #333;
            padding-bottom: 20px;
        }
        .board-header h2 {
            font-size: 28px;
            color: #333;
            margin: 0;
            font-weight: 700;
        }

        /* 2. 게시글 상세보기 영역 (카드 스타일) */
        .board-view-wrap {
            border: 1px solid #ddd;
            border-top: 3px solid #4a90e2; /* 포인트 컬러 (파란색) */
            background: #fff;
            margin-bottom: 30px;
        }

        /* 테이블 스타일 */
        .view-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed; /* 칸 너비 고정 */
        }
        
        .view-table th, .view-table td {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            font-size: 15px;
            text-align: left;
        }

        .view-table th {
            background-color: #f8f9fa;
            color: #555;
            font-weight: 600;
            width: 130px;
            border-right: 1px solid #eee;
        }

        .view-table td {
            color: #333;
        }

        /* 제목 강조 */
        .view-title {
            font-size: 22px;
            font-weight: bold;
            color: #111;
            padding: 20px;
            background-color: #fff;
        }

        /* 3. 본문 내용 */
        .view-content {
            padding: 40px 30px;
            min-height: 400px;
            font-size: 16px;
            line-height: 1.8;
            color: #222;
            border-bottom: 1px solid #eee;
            /* 줄바꿈 유지 */
            white-space: pre-wrap; 
            word-wrap: break-word;
        }

        /* 4. 첨부파일 링크 */
        .file-link {
            display: inline-block;
            padding: 6px 12px;
            background-color: #e9ecef;
            color: #495057;
            text-decoration: none;
            border-radius: 4px;
            font-size: 13px;
            transition: 0.2s;
        }
        .file-link:hover {
            background-color: #dee2e6;
            color: #212529;
        }

        /* 5. 버튼 영역 */
        .btn-area-between {
            display: flex;
            justify-content: space-between; /* 양쪽 끝으로 배치 */
            align-items: center;
            margin-top: 30px;
        }

        .btn-common {
            display: inline-block;
            padding: 10px 25px;
            font-size: 15px;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.2s;
            font-weight: 500;
            border: none; /* 버튼 테두리 제거 */
        }

        /* 목록 버튼 (흰색) */
        .btn-list {
            background-color: #fff;
            border: 1px solid #ccc;
            color: #555;
        }
        .btn-list:hover {
            background-color: #f8f9fa;
            border-color: #bbb;
        }

        /* 수정 버튼 (파란색) */
        .btn-modify {
            background-color: #007bff;
            color: #fff;
            margin-right: 8px;
        }
        .btn-modify:hover {
            background-color: #0069d9;
        }

        /* 삭제 버튼 (빨간색) */
        .btn-delete {
            background-color: #dc3545;
            color: #fff;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

    <jsp:include page="../fragments/header.jsp" flush="true"/>

    <div class="board-container">
        
        <header class="board-header">
            <h2>게시글 상세보기</h2>
        </header>

        <div class="board-view-wrap">
            <%-- 1. 게시글 헤더 정보 --%>
            <table class="view-table">
                <colgroup>
                    <col style="width: 120px;">
                    <col style="width: auto;">
                    <col style="width: 120px;">
                    <col style="width: auto;">
                </colgroup>
                <tbody>
                    <tr>
                        <%-- 제목은 전체 병합 --%>
                        <td colspan="4" class="view-title">${board.title}</td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>${board.userId}</td>
                        <th>작성일</th>
                        <td><fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    </tr>
                    <tr>
                        <th>조회수</th>
                        <td>${board.views}</td>
                        <th>첨부파일</th>
                        <td>
                            <c:if test="${not empty board.filePath}">
                                <a href="${contextPath}${board.filePath}" download class="file-link">
                                    💾 다운로드
                                </a>
                            </c:if>
                            <c:if test="${empty board.filePath}">
                                <span style="color:#999; font-size:13px;">-</span>
                            </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>

            <%-- 2. 게시글 본문 --%>
            <div class="view-content">
                ${board.content}
            </div>
        </div>

        <%-- 3. 버튼 영역 --%>
        <div class="btn-area-between">
            <div class="left">
                <a href="${contextPath}/goMain" class="btn-common btn-list">목록으로</a>
            </div>
            
            <div class="right">
                <%-- 작성자 본인일 때만 표시 --%>
                <c:if test="${sessionScope.loginUser.userId == board.userId}">
                    <a href="${contextPath}/clip/modify?id=${board.boardId}" class="btn-common btn-modify">수정</a>
                    <button type="button" onclick="deleteClip(${board.boardId});" class="btn-common btn-delete">삭제</button>
                </c:if>
            </div>
        </div>

    </div>

    <jsp:include page="../fragments/footer.jsp" flush="true"/>
    
    <script>
        function deleteClip(boardId) {
            if(confirm("정말로 이 게시글을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
                // 삭제 컨트롤러로 이동
                location.href = "${contextPath}/clip/deleteClip?boardId=" + boardId;
            }
        }
    </script>
</body>
</html>