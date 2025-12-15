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

    <style>
        /* ================= 기존 스타일 유지 ================= */
        body { background-color: #f8f9fa; }
        .board-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; font-family: 'Noto Sans KR', sans-serif; }
        .board-header { text-align: center; margin-bottom: 40px; border-bottom: 2px solid #333; padding-bottom: 20px; }
        .board-header h2 { font-size: 28px; color: #333; margin: 0; font-weight: 700; }
        .board-view-wrap { border: 1px solid #ddd; border-top: 3px solid #4a90e2; background: #fff; margin-bottom: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .view-table { width: 100%; border-collapse: collapse; table-layout: fixed; }
        .view-table th, .view-table td { padding: 15px 20px; border-bottom: 1px solid #eee; font-size: 15px; text-align: left; }
        .view-table th { background-color: #f8f9fa; color: #555; font-weight: 600; width: 130px; border-right: 1px solid #eee; }
        .view-title { font-size: 22px; font-weight: bold; color: #111; padding: 20px; background-color: #fff; }
        .view-content { padding: 40px 30px; min-height: 300px; font-size: 16px; line-height: 1.8; color: #222; border-bottom: 1px solid #eee; white-space: pre-wrap; word-wrap: break-word; }
        .file-link { display: inline-block; padding: 6px 12px; background-color: #e9ecef; color: #495057; text-decoration: none; border-radius: 4px; font-size: 13px; transition: 0.2s; }
        .file-link:hover { background-color: #dee2e6; color: #212529; }
        .btn-area-between { display: flex; justify-content: space-between; align-items: center; margin-top: 30px; }
        .btn-common { display: inline-block; padding: 10px 25px; font-size: 15px; text-decoration: none; border-radius: 4px; cursor: pointer; transition: all 0.2s; font-weight: 500; border: none; }
        .btn-list { background-color: #fff; border: 1px solid #ccc; color: #555; }
        .btn-list:hover { background-color: #f8f9fa; }
        .btn-modify { background-color: #007bff; color: #fff; margin-right: 8px; }
        .btn-modify:hover { background-color: #0069d9; }
        .btn-delete { background-color: #dc3545; color: #fff; }
        .btn-delete:hover { background-color: #c82333; }

        /* ================= ★ NEW: 댓글/대댓글 스타일 추가 ★ ================= */
        
        .comment-wrap {
            margin-top: 40px;
            background: #fff;
            border: 1px solid #ddd;
            border-top: 2px solid #666; /* 댓글 섹션은 조금 다른 색상이나 두께로 구분 */
            padding: 20px;
        }

        .comment-count {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        /* 댓글 입력 폼 */
        .comment-form {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
        }
        .comment-input {
            flex: 1; /* 남은 공간 다 차지 */
            height: 50px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: none; /* 크기 조절 막기 */
        }
        .btn-comment-save {
            width: 80px;
            background: #4a90e2;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        /* 댓글 리스트 */
        .comment-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .comment-item {
            padding: 15px 0;
            border-bottom: 1px solid #f1f1f1;
        }
        
        /* 댓글 헤더 (작성자, 날짜, 버튼) */
        .comment-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .meta-left strong { margin-right: 10px; color: #333; }
        .meta-left span { color: #888; font-size: 13px; }
        
        .meta-right button {
            background: none;
            border: none;
            color: #666;
            font-size: 12px;
            cursor: pointer;
            padding: 2px 5px;
        }
        .meta-right button:hover { text-decoration: underline; color: #333; }

        .comment-text {
            font-size: 15px;
            color: #444;
            line-height: 1.5;
            white-space: pre-wrap;
        }

        /* 대댓글 (답글) 스타일 */
        .reply-item {
            margin-top: 10px;
            margin-left: 40px; /* 들여쓰기 */
            background-color: #f9f9f9; /* 배경색으로 구분 */
            padding: 15px;
            border-radius: 5px;
            position: relative;
        }
        .reply-icon {
            position: absolute;
            left: -25px;
            top: 15px;
            color: #aaa;
            font-size: 18px;
        }

        /* 답글 작성 폼 (숨김 상태) */
        .reply-form-wrap {
            display: none; /* 기본 숨김 */
            margin-top: 10px;
            margin-left: 40px;
            padding: 10px;
            background: #f1f3f5;
            border-radius: 5px;
        }
    </style>
</head>
<body>

    <jsp:include page="../fragments/header.jsp" flush="true"/>

    <div class="board-container">
        
        <header class="board-header">
            <h2>게시글 상세보기</h2>
        </header>

        <%-- 게시글 본문 영역 --%>
        <div class="board-view-wrap">
            <table class="view-table">
                <colgroup>
                    <col style="width: 120px;">
                    <col style="width: auto;">
                    <col style="width: 120px;">
                    <col style="width: auto;">
                </colgroup>
                <tbody>
                    <tr>
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
                                <a href="${contextPath}${board.filePath}" download class="file-link">💾 다운로드</a>
                            </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="view-content">${board.content}</div>
        </div>

        <%-- ★ 댓글 및 대댓글 영역 시작 ★ --%>
        <div class="comment-wrap">
            <div class="comment-count">
                댓글 <strong>${commentList.size() + subCommentList.size()}</strong>개
            </div>

            <%-- 1. 메인 댓글 작성 폼 --%>
            <form action="${contextPath}/comment/write" method="post" class="comment-form">
                <input type="hidden" name="boardId" value="${board.boardId}">
                <%-- 로그인한 경우만 작성 가능하도록 (필요시 readonly 처리) --%>
                <textarea name="content" class="comment-input" placeholder="댓글을 입력해주세요." required></textarea>
                <button type="submit" class="btn-comment-save">등록</button>
            </form>

            <%-- 2. 댓글 리스트 출력 --%>
            <ul class="comment-list">
                <c:forEach var="comment" items="${commentList}">
                    <li class="comment-item">
                        <%-- 부모 댓글 내용 --%>
                        <div class="main-comment-box">
                            <div class="comment-meta">
                                <div class="meta-left">
                                    <strong>${comment.userId}</strong>
                                    <span><fmt:formatDate value="${comment.regDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                                </div>
                                <div class="meta-right">
                                    <%-- 답글 버튼 (클릭 시 폼 토글) --%>
                                    <button type="button" onclick="toggleReplyForm('${comment.commentId}')">답글</button>
                                    
                                    <%-- 본인 댓글일 때만 삭제 --%>
                                    <c:if test="${sessionScope.loginUser.userId == comment.userId}">
                                        <button type="button" onclick="deleteComment('${comment.commentId}')">삭제</button>
                                    </c:if>
                                </div>
                            </div>
                            <div class="comment-text">${comment.content}</div>
                        </div>

                        <%-- 3. 대댓글(답글) 작성 폼 (기본 숨김) --%>
                        <div id="replyForm_${comment.commentId}" class="reply-form-wrap">
                            <form action="${contextPath}/comment/reply" method="post" style="display:flex; gap:10px;">
                                <input type="hidden" name="boardId" value="${board.boardId}">
                                <input type="hidden" name="commentId" value="${comment.commentId}"> <%-- 부모 댓글 ID --%>
                                <textarea name="content" class="comment-input" style="height:40px;" placeholder="답글 내용을 입력하세요." required></textarea>
                                <button type="submit" class="btn-comment-save" style="width:60px; font-size:13px;">등록</button>
                            </form>
                        </div>

                        <%-- 4. 대댓글(답글) 리스트 출력 --%>
                        <c:forEach var="sub" items="${subCommentList}">
                            <%-- 부모 ID가 일치하는 것만 출력 --%>
                            <c:if test="${sub.commentId == comment.commentId}">
                                <div class="reply-item">
                                    <span class="reply-icon">↳</span>
                                    <div class="comment-meta">
                                        <div class="meta-left">
                                            <strong>${sub.userId}</strong>
                                            <span><fmt:formatDate value="${sub.regDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                                        </div>
                                        <div class="meta-right">
                                            <c:if test="${sessionScope.loginUser.userId == sub.userId}">
                                                <button type="button" onclick="deleteSubComment('${sub.replyId}')">삭제</button>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="comment-text">${sub.content}</div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </li>
                </c:forEach>
                
                <%-- 댓글이 없을 경우 --%>
                <c:if test="${empty commentList}">
                    <li style="text-align:center; padding:30px; color:#999;">등록된 댓글이 없습니다.</li>
                </c:if>
            </ul>
        </div>
        <%-- ★ 댓글 영역 끝 ★ --%>


        <%-- 하단 버튼 영역 --%>
        <div class="btn-area-between">
            <div class="left">
                <a href="${contextPath}/goMain" class="btn-common btn-list">목록으로</a>
            </div>
            <div class="right">
                <c:if test="${sessionScope.loginUser.userId == board.userId}">
                    <a href="${contextPath}/clip/goModify?boardId=${board.boardId}" class="btn-common btn-modify">수정</a>
                    <button type="button" onclick="deleteClip(${board.boardId});" class="btn-common btn-delete">삭제</button>
                </c:if>
            </div>
        </div>

    </div>

    <jsp:include page="../fragments/footer.jsp" flush="true"/>
    
    <script>
        // 게시글 삭제
        function deleteClip(boardId) {
            if(confirm("정말로 이 게시글을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
                location.href = "${contextPath}/clip/deleteClip?boardId=" + boardId;
            }
        }

        // 답글(대댓글) 폼 토글 기능
        function toggleReplyForm(commentId) {
            var formId = "replyForm_" + commentId;
            var form = document.getElementById(formId);
            
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "block"; // 보이기
            } else {
                form.style.display = "none"; // 숨기기
            }
        }

        // 댓글 삭제
        function deleteComment(commentId) {
            if(confirm("댓글을 삭제하시겠습니까?")) {
                location.href = "${contextPath}/comment/delete?commentId=" + commentId + "&boardId=${board.boardId}";
            }
        }
        
        // 대댓글 삭제
        function deleteSubComment(replyId) {
            if(confirm("답글을 삭제하시겠습니까?")) {
                location.href = "${contextPath}/comment/deleteSub?replyId=" + replyId + "&boardId=${board.boardId}";
            }
        }
    </script>
</body>
</html>