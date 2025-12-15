<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>게시글 수정 | 유비앤티스랩</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    <script src="${contextPath}/static/main/js/jquery-1.11.3.min.js"></script>

   
    <style>
        /* 1. 레이아웃 기본 */
        body {
            background-color: #f8f9fa; /* 전체 배경을 아주 연한 회색으로 */
        }
        .board-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 0 20px;
            font-family: 'Noto Sans KR', 'Malgun Gothic', sans-serif;
        }

        .board-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .board-header h2 {
            font-size: 32px;
            color: #333;
            margin: 0 0 10px 0;
            font-weight: 700;
        }
        .board-header p {
            font-size: 16px;
            color: #666;
            margin: 0;
        }

        /* 2. 수정 폼 카드 스타일 */
        .write-wrap {
            background: #fff;
            border: 1px solid #ddd;
            border-top: 3px solid #4a90e2; /* 포인트 컬러 (파란색) */
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03); /* 살짝 떠있는 효과 */
            border-radius: 4px;
        }

        /* 입력 폼 스타일 */
        .form-group {
            margin-bottom: 25px;
        }
        .form-label {
            display: block;
            font-size: 15px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        
        .form-input, .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
            color: #333;
            box-sizing: border-box; /* padding 포함 크기 계산 */
            transition: 0.2s;
        }
        
        /* 입력창 포커스 효과 */
        .form-input:focus, .form-textarea:focus {
            border-color: #4a90e2;
            outline: none;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.2);
        }

        .form-textarea {
            height: 400px; /* 내용 입력창 높게 */
            resize: none; /* 크기 조절 막기 */
            line-height: 1.6;
        }

        /* 읽기 전용 필드 스타일 */
        .input-readonly {
            background-color: #f1f3f5;
            color: #555;
            cursor: not-allowed;
            border-color: #ddd;
        }

        /* 파일 입력 영역 */
        .file-area {
            background-color: #fafafa;
            padding: 15px;
            border: 1px dashed #ccc;
            border-radius: 4px;
        }
        .current-file {
            font-size: 14px;
            color: #007bff;
            margin-bottom: 8px;
            font-weight: 500;
        }

        /* 3. 버튼 영역 */
        .btn-area {
            margin-top: 40px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 10px; /* 버튼 사이 간격 */
        }

        .btn-common {
            padding: 12px 40px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 4px;
            cursor: pointer;
            border: none;
            transition: 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        /* 저장 버튼 (파란색) */
        .btn-save {
            background-color: #007bff;
            color: #fff;
        }
        .btn-save:hover {
            background-color: #0056b3;
        }

        /* 취소 버튼 (회색) */
        .btn-cancel {
            background-color: #6c757d;
            color: #fff;
        }
        .btn-cancel:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>

    <jsp:include page="../fragments/header.jsp" flush="true"/>

    <div class="board-container">
        
        <header class="board-header">
            <h2>게시글 수정</h2>
            <p>작성된 내용을 수정할 수 있습니다.</p>
        </header>

        <%-- 폼 영역 시작 --%>
        <div class="write-wrap">
            <form action="${contextPath}/clip/updateClip" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                
                <%-- 수정 대상 게시글 ID (숨김 필드) --%>
                <input type="hidden" name="boardId" value="${board.boardId}">
                
                <div class="form-group">
                    <label class="form-label">제목</label>
                    <input type="text" id="title" name="title" class="form-input" value="${board.title}" placeholder="제목을 입력하세요">
                </div>

                <div class="form-group">
                    <label class="form-label">작성자</label>
                    <%-- readonly 클래스 추가 --%>
                    <input type="text" name="userId" class="form-input input-readonly" value="${board.userId}" readonly>
                </div>
                
                <div class="form-group">
                    <label class="form-label">내용</label>
                    <textarea id="content" name="content" class="form-textarea" placeholder="내용을 입력하세요">${board.content}</textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">첨부파일</label>
                    <div class="file-area">
                        <c:if test="${not empty board.filePath}">
                            <div class="current-file">
                                📂 현재 파일: ${board.filePath}
                            </div>
                            <p style="font-size:12px; color:#888; margin:5px 0 0 0;">
                                ※ 새로운 파일을 선택하면 기존 파일은 삭제되고 덮어씌워집니다.
                            </p>
                        </c:if>
                        <input type="file" name="uploadFile" class="form-input" style="margin-top:10px; border:none; padding-left:0;">
                    </div>
                </div>

                <div class="btn-area">
                    <button type="submit" class="btn-common btn-save">수정 완료</button>
                    <a href="${contextPath}/clip/read?id=${board.boardId}" class="btn-common btn-cancel">취소</a>
                </div>
            </form>
        </div>
        <%-- 폼 영역 끝 --%>

    </div>

    <jsp:include page="../fragments/footer.jsp" flush="true"/>

    <script>
        function validateForm() {
            var title = document.getElementById("title");
            var content = document.getElementById("content");

            if (title.value.trim() == "") {
                alert("제목을 입력해주세요.");
                title.focus();
                return false; // 전송 중단
            }
            
            if (content.value.trim() == "") {
                alert("내용을 입력해주세요.");
                content.focus();
                return false; // 전송 중단
            }
            
            if(!confirm("게시글을 수정하시겠습니까?")) {
                return false; // 전송 중단
            }
            
            // true를 리턴하면 form action 주소(/clip/update)로 데이터가 전송됨
            return true;
        }
    </script>
</body>
</html>