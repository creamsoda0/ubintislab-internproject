<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시글 작성 | 유비앤티스랩</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%-- CSS 연결 --%>
<link rel="stylesheet" href="${contextPath}/static/main/css/base.css">
<link rel="stylesheet" href="${contextPath}/static/main/css/header.css">
<link rel="stylesheet" href="${contextPath}/static/main/css/board.css">
<script src="${contextPath}/static/main/js/jquery-1.11.3.min.js"></script>

<style type="text/css">
.file-list-area {
	margin-top: 10px;
	border: 1px solid #ddd;
	padding: 10px;
	background: #f9f9f9;
	min-height: 50px;
	border-radius: 4px;
}

.file-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 5px 10px;
	background: #fff;
	border: 1px solid #eee;
	margin-bottom: 5px;
	border-radius: 4px;
}

.file-name {
	font-size: 14px;
	color: #555;
}

.btn-delete {
	background: #ff6b6b;
	color: white;
	border: none;
	padding: 2px 8px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 12px;
}

.btn-delete:hover {
	background: #fa5252;
}
</style>

</head>
<body>

	<jsp:include page="../fragments/header.jsp" flush="true" />

	<%-- 게시판 컨테이너 시작 --%>
	<div class="board-container">

		<header class="board-header">
			<h2>게시글 작성</h2>
			<p>새로운 소식을 등록해주세요.</p>
		</header>

		<form id="writeForm" name="writeForm"
			action="${contextPath}/clip/write" method="post"
			enctype="multipart/form-data"
			onsubmit="event.preventDefault(); validateForm();">

			<div class="board-write-wrap">
				<table class="write-table">
					<colgroup>
						<col style="width: 150px;">
						<col style="width: auto;">
					</colgroup>
					<tbody>
						<tr>
							<th><label for="title">제목</label></th>
							<td><input type="text" id="title" name="title"
								class="ipt-text" placeholder="제목을 입력하세요."></td>
						</tr>

						<tr>
							<th>작성자</th>
							<td><input type="text" name="writer" class="ipt-text"
								value="${sessionScope.loginUser.name}" readonly> <%-- 필요시 ID도 hidden으로 전송 --%>
								<input type="hidden" name="userId" id="userId"
								value="${sessionScope.loginUser.userId}"></td>
						</tr>

						<tr>
							<th><label for="content">내용</label></th>
							<td><textarea id="content" name="content" class="tx-area"
									placeholder="내용을 입력하세요."></textarea></td>
						</tr>

						<tr>
							<th>첨부파일</th>
							<td>
								<div class="file-box">
									<input type="file" name="uploadFiles" id="uploadFiles" multiple
										class="form-control" onchange="addFiles(this);">
								</div>

								<div id="file-list-area" class="file-list-area"></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="btn-area center">
				<a href="${contextPath}/clip/list" class="btn-cancel">취소</a>
				<button type="submit" class="btn-submit">등록하기</button>
			</div>

		</form>

	</div>

	<jsp:include page="../fragments/footer.jsp" flush="true" />
	<script src="${contextPath}/static/main/js/common.js"></script>

	<%-- 간단한 유효성 검사 스크립트 --%>
	<script>
	// 1. 선택된 파일들을 담아둘 전역 배열
    var content_files = [];

    function validateForm() {
        var title = document.getElementById("title").value;
        var content = document.getElementById("content").value;

        if (title.trim() == "") {
            alert("제목을 입력해주세요.");
            document.getElementById("title").focus();
            return false;
        }
        if (content.trim() == "") {
            alert("내용을 입력해주세요.");
            document.getElementById("content").focus();
            return false;
        }

        if (!confirm("게시글을 등록하시겠습니까?")) {
            return false;
        }

        submitWrite();
    }

    // 2. 파일 선택 시 호출되는 함수
    function addFiles(input) {
        var files = input.files;
        var filesArr = Array.prototype.slice.call(files);

        if (content_files.length + filesArr.length > 10) {
            alert("최대 10개까지만 업로드 가능합니다.");
            input.value = "";
            return;
        }

        filesArr.forEach(function(f) {
            content_files.push(f);
        });

        input.value = ""; // 초기화해야 같은 파일 다시 선택 가능
        renderFileList();
    }

    // 3. 화면에 파일 목록 그리기
    function renderFileList() {
        var listArea = $("#file-list-area");
        listArea.empty();

        content_files.forEach(function(f, index) {
            var html = '';
            html += '<div class="file-item" id="fileItem_' + index + '">';
            html += '   <span class="file-name">' + f.name + ' (' + (f.size / 1024).toFixed(1) + ' KB)</span>';
            html += '   <button type="button" class="btn-delete" onclick="deleteFile(' + index + ')">삭제</button>';
            html += '</div>';
            listArea.append(html);
        });
    }

    // 4. 파일 삭제
    function deleteFile(index) {
        content_files.splice(index, 1);
        renderFileList();
    }

    // 5. 서버 전송 (최종 버전 하나만 남김)
    function submitWrite() {
        // [중요] HTML 태그에 id="writeForm"이 있어야 동작함
        var form = $("#writeForm")[0]; 
        var formData = new FormData(form);

        // 기존 input(uploadFiles) 내용은 지우고, 배열(content_files)에 있는 걸로 교체
        formData.delete("uploadFiles"); 

        if (content_files.length > 0) {
            for (var i = 0; i < content_files.length; i++) {
                formData.append("uploadFiles", content_files[i]);
            }
        }

        $.ajax({
            url: "${contextPath}/clip/write",
            type: "POST",
            enctype: 'multipart/form-data',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert(response);
                if(response.indexOf("저장되었습니다") > -1) {
                    location.href = "${contextPath}/goMain";
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