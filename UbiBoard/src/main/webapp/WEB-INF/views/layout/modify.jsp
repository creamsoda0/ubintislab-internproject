<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        body { background-color: #f8f9fa; }
        .board-container { max-width: 1000px; margin: 50px auto; padding: 0 20px; font-family: 'Noto Sans KR', sans-serif; }
        .board-header { text-align: center; margin-bottom: 40px; }
        .board-header h2 { font-size: 32px; color: #333; margin: 0 0 10px 0; font-weight: 700; }
        .board-header p { font-size: 16px; color: #666; margin: 0; }

        /* 2. 수정 폼 카드 스타일 */
        .write-wrap { background: #fff; border: 1px solid #ddd; border-top: 3px solid #4a90e2; padding: 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.03); border-radius: 4px; }
        .form-group { margin-bottom: 25px; }
        .form-label { display: block; font-size: 15px; font-weight: 600; color: #333; margin-bottom: 10px; }
        .form-input, .form-textarea { width: 100%; padding: 12px 15px; border: 1px solid #ccc; border-radius: 4px; font-size: 15px; color: #333; box-sizing: border-box; transition: 0.2s; }
        .form-input:focus, .form-textarea:focus { border-color: #4a90e2; outline: none; box-shadow: 0 0 5px rgba(74, 144, 226, 0.2); }
        .form-textarea { height: 400px; resize: none; line-height: 1.6; }
        .input-readonly { background-color: #f1f3f5; color: #555; cursor: not-allowed; border-color: #ddd; }

        /* 파일 입력 영역 */
        .file-area { background-color: #fafafa; padding: 15px; border: 1px dashed #ccc; border-radius: 4px; }
        
        /* 파일 리스트 스타일 (공통) */
        .file-list-area { margin-top: 10px; }
        .file-item { display: flex; justify-content: space-between; align-items: center; padding: 8px 10px; background: #fff; border: 1px solid #eee; margin-bottom: 5px; border-radius: 4px; }
        .file-name { font-size: 14px; color: #555; }
        .file-size { font-size: 12px; color: #999; margin-left: 5px; }
        
        /* 삭제 버튼 */
        .btn-delete { background: #ff6b6b; color: white; border: none; padding: 4px 10px; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .btn-delete:hover { background: #fa5252; }
        
        /* 기존 파일 라벨 */
        .old-file-label { font-size: 13px; font-weight: bold; color: #4a90e2; margin-bottom: 5px; display: block; }

        /* 3. 버튼 영역 */
        .btn-area { margin-top: 40px; text-align: center; display: flex; justify-content: center; gap: 10px; }
        .btn-common { padding: 12px 40px; font-size: 16px; font-weight: 500; border-radius: 4px; cursor: pointer; border: none; transition: 0.2s; text-decoration: none; display: inline-block; }
        .btn-save { background-color: #007bff; color: #fff; }
        .btn-save:hover { background-color: #0056b3; }
        .btn-cancel { background-color: #6c757d; color: #fff; }
        .btn-cancel:hover { background-color: #545b62; }
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
            <%-- [변경] id 추가, onsubmit 수정 --%>
            <form id="updateForm" name="updateForm" method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validateForm();">
                
                <%-- 게시글 ID --%>
                <input type="hidden" name="boardId" value="${board.boardId}">
                
                <div class="form-group">
                    <label class="form-label">제목</label>
                    <input type="text" id="title" name="title" class="form-input" value="${board.title}" placeholder="제목을 입력하세요">
                </div>

                <div class="form-group">
                    <label class="form-label">작성자</label>
                    <input type="text" name="userId" class="form-input input-readonly" value="${board.userId}" readonly>
                </div>
                
                <div class="form-group">
                    <label class="form-label">내용</label>
                    <textarea id="content" name="content" class="form-textarea" placeholder="내용을 입력하세요">${board.content}</textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">첨부파일 관리</label>
                    <div class="file-area">
                        
                        <div style="margin-bottom: 15px;">
                            <span class="old-file-label">📂 기존 첨부파일</span>
                            <c:if test="${empty fileList}">
                                <div style="font-size:13px; color:#999;">기존 첨부파일이 없습니다.</div>
                            </c:if>
                            
                            <c:forEach var="file" items="${fileList}">
                                <div class="file-item" id="oldFile_${file.fileId}">
                                    <span class="file-name">
                                        ${file.originalName} 
                                        <span class="file-size">(<fmt:formatNumber value="${file.fileSize/1024}" pattern="0.0"/> KB)</span>
                                    </span>
                                    <button type="button" class="btn-delete" onclick="deleteExistingFile('${file.fileId}')">삭제</button>
                                </div>
                            </c:forEach>
                        </div>

                        <hr style="border:0; border-top:1px dashed #ddd; margin: 10px 0;">

                        <div>
                            <span class="old-file-label" style="color:#28a745;">➕ 새로운 파일 추가</span>
                            <input type="file" name="uploadFiles" id="uploadFiles" multiple class="form-control" style="border:none; padding-left:0;" onchange="addNewFiles(this);">
                            
                            <div id="new-file-list-area" class="file-list-area"></div>
                        </div>

                    </div>
                </div>

                <div class="btn-area">
                    <button type="submit" class="btn-common btn-save">수정 완료</button>
                    <a href="${contextPath}/clip/read?boardId=${board.boardId}" class="btn-common btn-cancel">취소</a>
                </div>
            </form>
        </div>
        <%-- 폼 영역 끝 --%>

    </div>

    <jsp:include page="../fragments/footer.jsp" flush="true"/>

    <script>
        // 1. [새 파일] 관리를 위한 배열
        var new_content_files = [];
        // 2. [기존 파일] 삭제할 파일 ID를 담을 배열
        var delete_file_ids = [];

        function validateForm() {
            var title = document.getElementById("title");
            var content = document.getElementById("content");

            if (title.value.trim() == "") {
                alert("제목을 입력해주세요.");
                title.focus();
                return false;
            }
            
            if (content.value.trim() == "") {
                alert("내용을 입력해주세요.");
                content.focus();
                return false;
            }
            
            if(!confirm("게시글을 수정하시겠습니까?")) {
                return false;
            }
            
            // 검증 통과 시 AJAX 전송
            submitUpdate();
        }

        // --- A. 새로운 파일 추가 로직 (Write 페이지와 동일) ---
        function addNewFiles(input) {
            var files = input.files;
            var filesArr = Array.prototype.slice.call(files);

            if (new_content_files.length + filesArr.length > 10) {
                alert("최대 10개까지만 업로드 가능합니다.");
                input.value = "";
                return;
            }

            filesArr.forEach(function(f) {
                new_content_files.push(f);
            });

            input.value = "";
            renderNewFileList();
        }

        function renderNewFileList() {
            var listArea = $("#new-file-list-area");
            listArea.empty();

            new_content_files.forEach(function(f, index) {
                var html = '';
                html += '<div class="file-item" id="newFile_' + index + '">';
                html += '   <span class="file-name">' + f.name + ' (New)</span>';
                html += '   <button type="button" class="btn-delete" onclick="deleteNewFile(' + index + ')">취소</button>';
                html += '</div>';
                listArea.append(html);
            });
        }

        function deleteNewFile(index) {
            new_content_files.splice(index, 1);
            renderNewFileList();
        }

        // --- B. 기존 파일 삭제 로직 ---
        function deleteExistingFile(fileId) {
            if(!confirm("정말 이 파일을 삭제하시겠습니까?\n(수정 완료 시 영구 삭제됩니다)")) {
                return;
            }
            
            // 1. 삭제할 ID 배열에 추가
            delete_file_ids.push(fileId);
            
            // 2. 화면에서 해당 파일 항목 숨기기 (또는 제거)
            $("#oldFile_" + fileId).remove();
        }

        // --- C. 서버 전송 (AJAX) ---
        function submitUpdate() {
            var form = $("#updateForm")[0];
            var formData = new FormData(form);

            // 1. 기존 input file 데이터 제거 (배열로 대체할 것이므로)
            formData.delete("uploadFiles");

            // 2. 새로 추가된 파일들 FormData에 담기
            for (var i = 0; i < new_content_files.length; i++) {
                formData.append("uploadFiles", new_content_files[i]);
            }

            // 3. 삭제할 기존 파일 ID들 담기
            // 배열을 콤마(,)로 구분된 문자열로 보내거나, 같은 이름으로 여러 번 보냄
            // 여기서는 Controller에서 List<Integer> deleteFileIds로 받을 수 있게 여러 번 append 합니다.
            for (var i = 0; i < delete_file_ids.length; i++) {
                formData.append("deleteFileIds", delete_file_ids[i]);
            }

            $.ajax({
                url: "${contextPath}/clip/updateClip",
                type: "POST",
                enctype: 'multipart/form-data',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert(response); // "수정되었습니다" 등의 메시지
                    if(response.indexOf("수정") > -1) {
                        // 수정 후 상세 페이지로 이동
                        location.href = "${contextPath}/clip/read?boardId=${board.boardId}";
                    }
                },
                error: function(xhr, status, error) {
                    alert("에러 발생: " + error);
                    console.log(xhr.responseText);
                }
            });
        }
    </script>
</body>
</html>