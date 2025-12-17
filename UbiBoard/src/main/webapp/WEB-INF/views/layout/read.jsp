<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>${board.title}|상세보기</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="${contextPath}/static/main/js/jquery-1.11.3.min.js"></script>
<script src="${contextPath}/static/main/js/masking.js"></script>

<style>
/* ================= 1. 기본 레이아웃 ================= */
body {
	background-color: #f5f7fa;
	font-family: 'Noto Sans KR', sans-serif;
	color: #333;
}

.board-container {
	max-width: 1000px;
	margin: 50px auto;
	padding: 0 20px;
}

/* ================= 2. 게시글 본문 영역 (카드 형태) ================= */
.board-view-card {
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
	overflow: hidden;
	border: 1px solid #e1e4e8;
}

/* 헤더 (제목, 정보) */
.view-header {
	padding: 30px;
	border-bottom: 1px solid #eee;
	background-color: #fff;
}

.view-title {
	font-size: 26px;
	font-weight: 700;
	color: #111;
	margin-bottom: 15px;
	line-height: 1.4;
}

.view-meta {
	display: flex;
	font-size: 14px;
	color: #666;
	gap: 20px;
	align-items: center;
}

.view-meta span {
	display: flex;
	align-items: center;
	gap: 5px;
}

.mask-id {
	font-weight: 600;
	color: #333;
}

/* 첨부파일 영역 */
/* ================= 첨부파일 영역 디자인 개선 ================= */
.file-box {
	background: #f8f9fa;
	padding: 25px;
	border-bottom: 1px solid #eee;
}

.file-header-label {
	display: block;
	font-size: 14px;
	font-weight: 700;
	color: #555;
	margin-bottom: 12px;
}

/* 파일 목록을 세로로 배치 */
.file-list-wrapper {
	display: flex;
	flex-direction: column;
	gap: 8px; /* 파일 사이 간격 */
}

/* 개별 파일 카드 디자인 */
.file-download-card {
	display: flex;
	align-items: center;
	justify-content: space-between; /* 좌우 끝으로 배치 */
	background: #fff;
	border: 1px solid #e1e4e8;
	padding: 12px 20px;
	border-radius: 8px;
	text-decoration: none;
	transition: all 0.2s ease;
}

.file-download-card:hover {
	border-color: #4a90e2;
	box-shadow: 0 4px 12px rgba(74, 144, 226, 0.1);
	transform: translateY(-2px); /* 살짝 위로 떠오르는 효과 */
}

/* ================= 토글형 첨부파일 스타일 ================= */
/* ================= 토글 + 카드형 첨부파일 스타일 ================= */
.file-toggle-wrapper {
	margin-top: 20px;
	border: 1px solid #e1e4e8;
	border-radius: 8px;
	background: #fff;
	overflow: hidden;
}

/* 1. 토글 버튼 (헤더) */
.file-toggle-btn {
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 25px;
	background: #f8f9fa; /* 헤더 배경색 */
	border: none;
	cursor: pointer;
	text-align: left;
	transition: background 0.2s;
	outline: none;
}

.file-toggle-btn:hover {
	background: #f1f3f5;
}

.toggle-title {
	font-size: 15px;
	font-weight: 700;
	color: #333;
	display: flex;
	align-items: center;
	gap: 8px;
}

.toggle-icon {
	font-size: 12px;
	color: #888;
	transition: transform 0.3s ease;
}

/* 활성화(열림) 상태일 때 화살표 회전 */
.file-toggle-btn.active .toggle-icon {
	transform: rotate(180deg);
}

/* 2. 파일 리스트 영역 (숨김 영역) */
.file-list-content {
	display: none; /* 기본 숨김 */
	padding: 20px;
	background: #fff;
	border-top: 1px solid #eee;
	/* 내부 카드들 세로 정렬 */
	display: flex;
	flex-direction: column;
	gap: 10px;
}

/* 3. 개별 파일 카드 디자인 (호버 효과 포함) */
.file-download-card {
	display: flex;
	align-items: center;
	justify-content: space-between;
	background: #fff;
	border: 1px solid #e1e4e8;
	padding: 15px 20px;
	border-radius: 8px;
	text-decoration: none;
	transition: all 0.2s ease;
}

/* ★ 여기가 마우스 올렸을 때 효과 ★ */
.file-download-card:hover {
	border-color: #4a90e2;
	background-color: #fcfdfe;
	box-shadow: 0 4px 12px rgba(74, 144, 226, 0.15); /* 그림자 */
	transform: translateY(-2px); /* 살짝 위로 뜸 */
}

/* 아이콘+이름 */
.file-info-left {
	display: flex;
	align-items: center;
	gap: 12px;
}

.file-icon {
	width: 36px;
	height: 36px;
	background: #f1f3f5;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
}

.file-name {
	font-size: 14px;
	color: #333;
	font-weight: 500;
}

/* 용량+다운로드 버튼 */
.file-info-right {
	display: flex;
	align-items: center;
	gap: 15px;
}

.file-size-badge {
	font-size: 12px;
	color: #666;
	background: #f8f9fa;
	padding: 4px 10px;
	border-radius: 12px;
}

.download-icon {
	color: #ccc;
	font-size: 18px;
	transition: 0.2s;
}

.file-download-card:hover .download-icon {
	color: #4a90e2;
}

/* 초기에는 리스트 숨기기 위해 display:none 처리 (JS로 켬) */
.file-list-content {
	display: none;
}
/* 본문 내용 */
.view-content {
	padding: 40px 30px;
	min-height: 300px;
	font-size: 16px;
	line-height: 1.8;
	color: #222;
}

/* ================= 3. 좋아요 버튼 (본문 하단 중앙) ================= */
.like-section {
	text-align: center;
	padding: 30px 0 50px 0;
	border-top: 1px dashed #eee; /* 본문과 구분선 */
	margin: 0 30px; /* 좌우 여백 */
}

.btn-like {
	background: #fff;
	border: 1px solid #ddd;
	padding: 12px 30px;
	border-radius: 50px; /* 둥근 알약 모양 */
	font-size: 16px;
	cursor: pointer;
	transition: all 0.3s;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-like:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
	border-color: #ff6b6b;
}

.heart-icon {
	font-size: 20px;
}

.like-text {
	font-weight: 600;
	color: #555;
}

.like-count {
	font-weight: 800;
	color: #ff6b6b;
	font-size: 18px;
}

/* ================= 4. 댓글 영역 ================= */
.comment-wrap {
	margin-top: 30px;
}

.comment-header {
	font-size: 18px;
	font-weight: 700;
	margin-bottom: 15px;
	color: #333;
	display: flex;
	align-items: center;
	gap: 5px;
}

.comment-count-badge {
	background: #eee;
	font-size: 12px;
	padding: 2px 8px;
	border-radius: 10px;
	color: #555;
}

/* 댓글 입력창 */
.comment-form {
	display: flex;
	gap: 10px;
	background: #fff;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 8px;
	margin-bottom: 20px;
}

.comment-input {
	flex: 1;
	height: 60px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	resize: none;
	font-size: 14px;
	outline: none;
}

.comment-input:focus {
	border-color: #4a90e2;
}

.btn-comment-save {
	width: 90px;
	background: #4a90e2;
	color: #fff;
	border: none;
	border-radius: 4px;
	font-weight: bold;
	cursor: pointer;
	transition: 0.2s;
}

.btn-comment-save:hover {
	background: #357abd;
}

/* 댓글 리스트 */
.comment-list {
	list-style: none;
	padding: 0;
	margin: 0;
	background: #fff;
	border: 1px solid #eee;
	border-radius: 8px;
}

.comment-item {
	padding: 20px;
	border-bottom: 1px solid #f1f1f1;
}

.comment-item:last-child {
	border-bottom: none;
}

.comment-meta {
	display: flex;
	justify-content: space-between;
	margin-bottom: 8px;
	font-size: 13px;
}

.meta-left strong {
	color: #333;
	margin-right: 8px;
	font-size: 14px;
}

.meta-left .date {
	color: #999;
}

.meta-right button {
	background: none;
	border: none;
	font-size: 12px;
	color: #777;
	cursor: pointer;
	margin-left: 5px;
}

.meta-right button:hover {
	color: #333;
	text-decoration: underline;
}

.comment-text {
	font-size: 15px;
	line-height: 1.5;
	color: #444;
	white-space: pre-wrap;
}

/* 대댓글 스타일 */
.reply-item {
	margin-top: 15px;
	background: #f9fbfd;
	padding: 15px;
	border-radius: 8px;
	position: relative;
	margin-left: 20px;
	border-left: 3px solid #dee2e6;
}

.reply-form-wrap {
	display: none;
	margin-top: 15px;
	background: #f8f9fa;
	padding: 15px;
	border-radius: 8px;
}

/* ================= 5. 하단 버튼 영역 ================= */
.btn-area-between {
	display: flex;
	justify-content: space-between;
	margin-top: 30px;
}

.btn-common {
	padding: 10px 20px;
	border-radius: 4px;
	font-size: 14px;
	font-weight: 500;
	text-decoration: none;
	cursor: pointer;
	border: 1px solid transparent;
	transition: 0.2s;
	display: inline-block;
}

.btn-list {
	background: #fff;
	border-color: #ccc;
	color: #555;
}

.btn-list:hover {
	background: #f1f1f1;
}

.btn-modify {
	background: #6c757d;
	color: #fff;
}

.btn-modify:hover {
	background: #5a6268;
}

.btn-delete {
	background: #dc3545;
	color: #fff;
}

.btn-delete:hover {
	background: #c82333;
}
</style>
</head>
<body>

	<jsp:include page="../fragments/header.jsp" flush="true" />

	<div class="board-container">

		<div class="board-view-card">

			<div class="view-header">
				<h1 class="view-title">${board.title}</h1>
				<div class="view-meta">
					<span>👤 <strong class="mask-id">${board.userId}</strong></span> <span
						style="color: #ddd">|</span> <span>🕒 <fmt:formatDate
							value="${board.regDate}" pattern="yyyy.MM.dd HH:mm" /></span> <span
						style="color: #ddd">|</span> <span>👁️ ${board.views}</span>
				</div>
			</div>

			<c:if test="${not empty fileList}">
				<div class="file-toggle-wrapper">

					<button type="button" class="file-toggle-btn"
						onclick="toggleFileArea(this);">
						<span class="toggle-title"> 📂 첨부파일 <span
							style="color: #4a90e2; margin-left: 5px;">(${fn:length(fileList)})</span>
						</span> <span class="toggle-icon">▼</span>
					</button>

					<div class="file-list-content">
						<c:forEach var="file" items="${fileList}">
							<a href="${contextPath}/clip/download?filePath=${file.filePath}"
								class="file-download-card">

								<div class="file-info-left">
									<span class="file-icon">📄</span> <span class="file-name">${file.originalName}</span>
								</div>

								<div class="file-info-right">
									<span class="file-size-badge"> <fmt:formatNumber
											value="${file.fileSize / 1024.0}" pattern="#,##0.0" /> KB
									</span> <span class="download-icon">⬇️</span>
								</div>
							</a>
						</c:forEach>
					</div>

				</div>
			</c:if>

			<div class="view-content">
				<%-- 엔터키 처리 등을 위해 pre-wrap 사용 --%>
				<div style="white-space: pre-wrap;">${board.content}</div>
			</div>

			<div class="like-section">
				<button type="button" id="btnLike" class="btn-like"
					onclick="toggleLike();">
					<span id="heartIcon" class="heart-icon"> <c:choose>
							<c:when test="${isLiked}">❤️</c:when>
							<c:otherwise>🤍</c:otherwise>
						</c:choose>
					</span> <span class="like-text">좋아요</span> <span id="likeCount"
						class="like-count">${board.likeCount}</span>
				</button>
			</div>

		</div>
		<div class="comment-wrap">
			<div class="comment-header">
				💬 댓글 <span class="comment-count-badge">${commentList.size() + subCommentList.size()}</span>
			</div>

			<form action="${contextPath}/clip/writeComment" method="post"
				class="comment-form">
				<input type="hidden" name="boardId" value="${board.boardId}">
				<textarea name="content" class="comment-input"
					placeholder="댓글을 남겨보세요." required></textarea>
				<button type="submit" class="btn-comment-save">등록</button>
			</form>

			<ul class="comment-list">
				<c:if test="${empty commentList}">
					<li style="padding: 40px; text-align: center; color: #999;">첫
						번째 댓글을 남겨주세요!</li>
				</c:if>

				<c:forEach var="comment" items="${commentList}">
					<li class="comment-item">
						<div class="main-comment-box">
							<div class="comment-meta">
								<div class="meta-left">
									<strong class="mask-id">${comment.userId}</strong> <span
										class="date"><fmt:formatDate value="${comment.regDate}"
											pattern="MM.dd HH:mm" /></span>
								</div>
								<div class="meta-right">
									<button type="button"
										onclick="toggleReplyForm('${comment.commentId}')">답글</button>
									<c:if test="${sessionScope.loginUser.userId == comment.userId}">
										<button type="button"
											onclick="deleteComment('${comment.commentId}')">삭제</button>
									</c:if>
								</div>
							</div>
							<div class="comment-text">${comment.content}</div>
						</div>

						<div id="replyForm_${comment.commentId}" class="reply-form-wrap">
							<form action="${contextPath}/clip/writeSubComment" method="post"
								style="display: flex; gap: 10px;">
								<input type="hidden" name="boardId" value="${board.boardId}">
								<input type="hidden" name="commentId"
									value="${comment.commentId}">
								<textarea name="content" class="comment-input"
									style="height: 40px;" placeholder="답글을 입력하세요." required></textarea>
								<button type="submit" class="btn-comment-save"
									style="width: 70px;">등록</button>
							</form>
						</div> <c:forEach var="sub" items="${subCommentList}">
							<c:if test="${sub.commentId == comment.commentId}">
								<div class="reply-item">
									<div class="comment-meta">
										<div class="meta-left">
											<span style="color: #aaa; margin-right: 5px;">↳</span> <strong
												class="mask-id">${sub.userId}</strong> <span class="date"><fmt:formatDate
													value="${sub.regDate}" pattern="MM.dd HH:mm" /></span>
										</div>
										<div class="meta-right">
											<c:if test="${sessionScope.loginUser.userId == sub.userId}">
												<button type="button"
													onclick="deleteSubComment('${sub.subId}')">삭제</button>
											</c:if>
										</div>
									</div>
									<div class="comment-text">${sub.content}</div>
								</div>
							</c:if>
						</c:forEach>
					</li>
				</c:forEach>
			</ul>
		</div>


		<div class="btn-area-between">
			<div class="left">
				<a href="${contextPath}/goMain" class="btn-common btn-list">목록으로</a>
			</div>
			<div class="right">
				<c:if test="${sessionScope.loginUser.userId == board.userId}">
					<a href="${contextPath}/clip/goModify?boardId=${board.boardId}"
						class="btn-common btn-modify">수정</a>
					<button type="button" onclick="deleteClip(${board.boardId});"
						class="btn-common btn-delete">삭제</button>
				</c:if>
			</div>
		</div>

	</div>

	<jsp:include page="../fragments/footer.jsp" flush="true" />

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
                // 입력창에 포커스
                form.querySelector('textarea').focus();
            } else {
                form.style.display = "none"; // 숨기기
            }
        }

        // 댓글 삭제
        function deleteComment(commentId) {
            if(confirm("댓글을 삭제하시겠습니까?")) {
                location.href = "${contextPath}/clip/deleteComment?commentId=" + commentId + "&boardId=${board.boardId}";
            }
        }
        
        // 대댓글 삭제
        function deleteSubComment(subId) {
            if(confirm("답글을 삭제하시겠습니까?")) {
                location.href = "${contextPath}/clip/deleteSubComment?subId=" + subId + "&boardId=${board.boardId}";
            }
        }
        
        // 좋아요 토글 버튼 기능 (AJAX)
        function toggleLike() {
            var boardId = "${board.boardId}";
            
            $.ajax({
                url: "${contextPath}/clip/like/toggle",
                type: "POST",
                data: { boardId: boardId },
                success: function(response) {
                    if (response.result === "fail") {
                        alert(response.message); 
                        return;
                    }
                    if (response.result === "error") {
                        alert("에러가 발생했습니다.");
                        return;
                    }
                    
                    // 화면 갱신
                    $("#likeCount").text(response.count); 
                    
                    if (response.status === "liked") {
                        $("#heartIcon").text("❤️");
                    } else {
                        $("#heartIcon").text("🤍");
                    }
                },
                error: function(xhr, status, error) {
                    console.error(error);
                    alert("서버 통신 오류");
                }
            });
        }
        
     // 첨부파일 토글 기능
        function toggleFileArea(btn) {
            // 1. 버튼에 active 클래스 토글 (화살표 회전용)
            $(btn).toggleClass("active");
            
            // 2. 바로 다음 형제 요소(.file-list-content)를 슬라이드 토글
            $(btn).next(".file-list-content").slideToggle(300);
        }
    </script>
</body>
</html>