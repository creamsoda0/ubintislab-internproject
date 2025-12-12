<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>게시글 작성 | 유비앤티스랩</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/>

    <%-- CSS 연결 --%>
    <link rel="stylesheet" href="${contextPath}/static/main/css/base.css">
    <link rel="stylesheet" href="${contextPath}/static/main/css/header.css"> <link rel="stylesheet" href="${contextPath}/static/main/css/board.css">  <script src="${contextPath}/static/main/js/jquery-1.11.3.min.js"></script>
</head>
<body>

    <jsp:include page="../fragments/header.jsp" flush="true"/>

    <%-- 게시판 컨테이너 시작 --%>
    <div class="board-container">
        
        <header class="board-header">
            <h2>게시글 작성</h2>
            <p>새로운 소식을 등록해주세요.</p>
        </header>

        <form name="writeForm" action="${contextPath}/clip/write" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
            
            <div class="board-write-wrap">
                <table class="write-table">
                    <colgroup>
                        <col style="width: 150px;">
                        <col style="width: auto;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><label for="title">제목</label></th>
                            <td>
                                <input type="text" id="title" name="title" class="ipt-text" placeholder="제목을 입력하세요.">
                            </td>
                        </tr>

                        <tr>
                            <th>작성자</th>
                            <td>
                                <input type="text" name="writer" class="ipt-text" 
                                       value="${sessionScope.loginUser.name}" 
                                       readonly>
                                       
                                <%-- 필요시 ID도 hidden으로 전송 --%>
                                <%-- <input type="hidden" name="writerId" value="${sessionScope.loginUser.userId}"> --%>
                            </td>
                        </tr>
                        
                        <tr>
                            <th><label for="content">내용</label></th>
                            <td>
                                <textarea id="content" name="content" class="tx-area" placeholder="내용을 입력하세요."></textarea>
                            </td>
                        </tr>

                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <div class="file-box">
                                    <input type="file" name="uploadFile" class="ipt-file">
                                </div>
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
    
    <jsp:include page="../fragments/footer.jsp" flush="true"/>
    <script src="${contextPath}/static/main/js/common.js"></script>

    <%-- 간단한 유효성 검사 스크립트 --%>
    <script>
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
            
            if(!confirm("게시글을 등록하시겠습니까?")) {
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>