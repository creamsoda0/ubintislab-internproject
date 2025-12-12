<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <title>회원탈퇴 | 유비앤티스랩</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <style>
        /* =========================================
           기본 스타일 (정보수정 페이지와 동일)
           ========================================= */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.5;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            min-height: 100vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.03);
            padding-bottom: 60px;
        }

        /* 헤더 */
        .header {
            padding: 30px 40px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
        }
        .header h1 a { text-decoration: none; color: inherit; }
        
        .header-util a {
            font-size: 13px;
            color: #888;
            text-decoration: none;
            margin-left: 15px;
        }
        .header-util a:hover { color: #2c3e50; font-weight: 500; }

        /* 컨텐츠 */
        .content { padding: 40px; }
        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #111;
            padding-bottom: 20px;
            border-bottom: 2px solid #333;
        }

        /* 폼 공통 */
        .section-title {
            font-size: 18px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
            margin-top: 30px;
        }

        .form-table {
            width: 100%;
            border-collapse: collapse;
            border-top: 1px solid #ddd;
        }
        .form-table th {
            width: 160px;
            padding: 15px;
            text-align: left;
            background-color: #fbfbfb;
            border-bottom: 1px solid #eee;
            color: #333;
            font-weight: 600;
            vertical-align: middle;
        }
        .form-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            color: #666;
        }

        input[type="password"], select {
            height: 40px;
            padding: 0 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
            vertical-align: middle;
        }
        input:focus, select:focus { border-color: #2c3e50; outline: none; }

        /* 버튼 영역 */
        .btn-area {
            margin-top: 50px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .btn-cancel {
            min-width: 140px;
            height: 50px;
            background-color: #f1f3f5;
            color: #555;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-cancel:hover { background-color: #e9ecef; }

        /* 탈퇴 전용 스타일 */
        .caution-box {
            background-color: #fff5f5;
            border: 1px solid #ffc9c9;
            padding: 20px;
            border-radius: 6px;
            margin-bottom: 30px;
            color: #d32f2f;
        }
        .caution-box h4 { margin-bottom: 10px; font-size: 16px; font-weight: 700; display: flex; align-items: center;}
        .caution-box ul { padding-left: 20px; font-size: 13px; color: #555; }
        .caution-box li { margin-bottom: 5px; }

        .btn-delete {
            min-width: 140px;
            height: 50px;
            background-color: #d32f2f; /* 경고색(빨강) */
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-delete:hover { background-color: #b71c1c; }

        .agree-check {
            margin-top: 10px;
            font-size: 14px;
            color: #333;
            font-weight: 500;
            display: block;
        }
        .agree-check input { margin-right: 8px; vertical-align: middle; }

        /* 푸터 */
        .footer {
            margin-top: 40px;
            padding: 30px;
            border-top: 1px solid #eee;
            text-align: center;
            font-size: 12px;
            color: #999;
        }

        /* 반응형 */
        @media screen and (max-width: 768px) {
            .content { padding: 20px; }
            .form-table, .form-table tbody, .form-table tr, .form-table th, .form-table td {
                display: block; width: 100%;
            }
            .form-table th { padding-bottom: 5px; background: none; border: none; }
            .form-table td { padding-top: 5px; padding-bottom: 20px; }
            input[type="password"], select { width: 100%; }
        }
    </style>

    <script>
        function deleteCheck() {
            var form = document.deleteForm;
            var pw = form.password.value;
            var agree = document.getElementById("agreeCheck").checked;

            if(!pw) {
                alert("비밀번호를 입력해주세요.");
                form.password.focus();
                return;
            }

            if(!agree) {
                alert("탈퇴 유의사항을 확인하고 동의해주세요.");
                document.getElementById("agreeCheck").focus();
                return;
            }

            if(confirm("정말로 탈퇴하시겠습니까?")) {
                form.submit();
            }
        }
    </script>
</head>
<body>

<div class="container">
    
    <header class="header">
        <h1><a href="${contextPath}/main">UBNTIS LAB</a></h1>
        <div class="header-util">
            <a href="${contextPath}/member/logout">로그아웃</a>
            <a href="${contextPath}/member/updateMember" style="font-weight:bold; color:#2c3e50;">정보수정</a>
        </div>
    </header>

    <div class="content">
        <h2 class="page-title">회원탈퇴</h2>
        
        <div class="caution-box">
            <h4>⚠️ 탈퇴 시 유의사항</h4>
            <ul>
                <li>회원 탈퇴 시 고객님의 모든 개인정보는 즉시 파기되며 복구할 수 없습니다.</li>
                <li>작성하신 게시물, 댓글 등은 자동으로 삭제되지 않으므로 탈퇴 전 직접 삭제하셔야 합니다.</li>
                <li>탈퇴 후 동일한 아이디로 재가입이 불가능할 수 있습니다.</li>
            </ul>
        </div>

        <form name="deleteForm" action="${contextPath}/member/memberDeleteProcess" method="post">
            <input type="hidden" name="userId" value="${loginUser.userId}">

            <h3 class="section-title">탈퇴 확인</h3>
            <table class="form-table">
                <tbody>
                    <tr>
                        <th>아이디</th>
                        <td><strong>${loginUser.userId}</strong></td>
                    </tr>
                    <tr>
                        <th>탈퇴 사유</th>
                        <td>
                            <select name="reason" id="reason" style="width: 100%; max-width: 300px;">
                                <option value="">사유를 선택해주세요</option>
                                <option value="service">서비스 불만족</option>
                                <option value="privacy">개인정보 유출 우려</option>
                                <option value="change">아이디 변경 목적</option>
                                <option value="unused">자주 이용하지 않음</option>
                                <option value="etc">기타</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>비밀번호 확인</th>
                        <td>
                            <input type="password" name="password" placeholder="현재 비밀번호를 입력하세요" style="width: 100%; max-width: 300px;">
                        </td>
                    </tr>
                    <tr>
                        <th>동의 여부</th>
                        <td>
                            <label class="agree-check">
                                <input type="checkbox" id="agreeCheck">
                                위 탈퇴 유의사항을 모두 확인하였으며, 이에 동의합니다.
                            </label>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="btn-area">
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                <button type="button" class="btn-delete" onclick="deleteCheck()">탈퇴하기</button>
            </div>
        </form>
    </div>

    <footer class="footer">
        &copy; UBNTIS LAB Corp. All Rights Reserved.
    </footer>

</div>

</body>
</html>