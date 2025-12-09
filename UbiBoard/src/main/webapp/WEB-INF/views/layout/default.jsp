<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
<title th:text="${pageTitle} ?: '대한적십자'"></title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="format-detection" content="telephone=no, address=no, email=no" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, usrr-scalable=no">
<meta name="title" content="대한적십자">
<meta name="keywords" content="대한적십자">
<link rel="stylesheet" th:href="@{/css/base.css}" type="text/css" />
<link rel="stylesheet" th:href="@{/css/font.css}" type="text/css" />
<link rel="stylesheet" th:href="@{/css/layout.css}" type="text/css" />
<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>

<header th:replace="~{fragments/header :: headerFragment}"></header>

<div class="contents_wrap">
	<div th:replace="~{fragments/lnb :: lnbFragment}"></div>
	
	<div class="sub_wrap">
		<div th:replace="${content}"></div>
	</div>
	</div>	
<footer th:replace="~{fragments/footer :: footerFragment}"></footer>

<div id="dimmed"></div>
<script th:src="@{/js/common.js}"></script>
<script>
// 기존 jQuery 스크립트는 해당 페이지의 동적 요소에 맞게 Controller에서 처리하거나,
// LNB Fragment에 배치하는 것이 좋습니다.
// 예시: $(".sub_title").text("시스템 접근 권한"); 등

$(document).ready(function () {
	// LNB 활성화 로직 (Controller에서 현재 메뉴 정보를 받아와 처리하는 것이 이상적)
	// 임시로 기존 로직 유지
	$(".sub_title").text("시스템 접근 권한");
	$(".sub_nav_inner > li:eq(1)").addClass("on"); //왼쪽메뉴
	$(".sub_nav_inner > li:eq(1) > ul").css("display","block"); //왼쪽메뉴
	$(".sub_nav_inner > li > ul > li:eq(0) > a").addClass("on"); //왼쪽메뉴
});
</script>
</body>
</html>