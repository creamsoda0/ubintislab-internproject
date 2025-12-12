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
                                <input type="hidden" name="writerId" value="${sessionScope.loginUser.userId}"> 
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
        function submitWrite() {

            //  폼 데이터 객체 생성 (파일 포함 시 필수)
            var form = $("form[name='writeForm']")[0]; // 폼 엘리먼트 선택
            var formData = new FormData(form);

            //  AJAX 전송
            $.ajax({
                url: "${contextPath}/clip/write", // Controller 매핑 주소
                type: "POST",
                enctype: 'multipart/form-data',   // 필수
                data: formData,                   // FormData 객체 전송
                processData: false,               // 필수: 데이터를 쿼리스트링으로 변환 금지
                contentType: false,               // 필수: 헤더 자동 설정
                cache: false,
                success: function(response) {
                    // Controller에서 리턴한 메시지(msg)를 받음
                    alert(response); 
                    
                    // 성공 시 리스트로 이동 (메시지에 '성공'이나 '저장'이 포함된 경우)
                    if(response.indexOf("저장되었습니다") > -1) {
                        location.href = "${contextPath}/clip/list";
                    }
                },
                error: function(xhr, status, error) {
                    alert("에러가 발생했습니다: " + error);
                    console.log(xhr.responseText);
                }
            });
        }
    </script>
</body>
</html>