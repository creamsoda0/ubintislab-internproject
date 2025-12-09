<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 전체 조회</title>
</head>
<body>

	<h2>DB 연결 테스트: 회원 목록</h2>
	<table border="1">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>가입일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="user">
				<tr>
					<td>${user.userId}</td>
					<td>${user.name}</td>
					<td>${user.joinDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</body>
</html>