<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Context Path 설정 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%-- 헤더 전용 CSS 연결 --%>
<link rel="stylesheet" href="${contextPath}/static/main/css/header.css">

<header class="rc-header">
    
    <div class="utility-bar">
        <div class="utility-inner">
            <ul class="utility-menu">
                
                    <%-- [CASE 1] 비로그인 상태 --%>
                    
                       <%-- 로그인 연장 타이머 (디자인 개선됨) --%>
                        <li class="no-line">
                            <div class="timer-wrap">
                                <span class="timer-text" id="sessionTimer">${sessionScope.siteConfig.sessionTimeOut}:00</span>
                                <button type="button" class="btn-extend" onclick="alert('로그인 시간이 연장되었습니다.');">연장</button>
                            </div>
                        </li>

                        <%-- 사용자 정보 --%>
                        <li>
                            <span class="user-info">
                                ${sessionScope.loginUser.name}
                                <span class="user-id">(${sessionScope.loginUser.userId})</span>
                            </span> 님
                        </li>
                        
                        <li><a href="${contextPath}/member/memberUpdate">정보수정</a></li>
                        <li class="no-line"><a href="${contextPath}/member/logout">로그아웃</a></li>
                        
                        
                <c:choose>
                	<c:when test="${sessionScope.admin}">        
                        <li><a href="${contextPath}/admin/goConfig">관리자 페이지</a></li>
                    </c:when>
					<c:otherwise>
					</c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>

    <div class="main-bar">
        <h1 class="logo">
            <a href="${contextPath}/goMain">UBINTISLAB</a>
            <%-- 로고 이미지가 있다면 아래 주석 해제 후 사용 --%>
            <%-- <a href="${contextPath}/main"><img src="${contextPath}/static/images/logo.png" alt="유비앤티스랩"></a> --%>
        </h1>

        <a class="btn-hamburger" href="#none">
            <span></span><span></span><span></span>
        </a>
    </div>

</header>

<script>
// 서버 설정값 가져오기 (초 단위)
const SESSION_TIMEOUT_SEC = ${sessionScope.siteConfig.sessionTimeOut * 60}; 
const SESSION_TIMEOUT_MS = SESSION_TIMEOUT_SEC * 1000;
const KEY_LAST_ACTIVE = 'ubintis_lastActiveTime'; // 프로젝트 고유 키값

var timerInterval;


const SessionManager = {
 // 현재 시간을 localStorage에 기록 
 updateLastActive: function() {
     localStorage.setItem(KEY_LAST_ACTIVE, Date.now().toString());
 },

 // 저장된 마지막 활동 시간을 가져옴 (없으면 현재 시간)
 getLastActive: function() {
     const stored = localStorage.getItem(KEY_LAST_ACTIVE);
     return stored ? parseInt(stored) : Date.now();
 }
};

// 타이머 및 화면 표시 함수
function startTimer() {
 // 기존 인터벌 제거
 if (timerInterval) clearInterval(timerInterval);

 timerInterval = setInterval(function() {
     const now = Date.now();
     const lastActive = SessionManager.getLastActive(); // 다른 탭에서 갱신된 시간도 가져옴
     
     // 경과 시간 = 현재시간 - 마지막활동시간
     const elapsed = now - lastActive;
     
     // 남은 시간 계산 = 전체시간 - 경과시간
     const remainingMS = SESSION_TIMEOUT_MS - elapsed;
     
     // 시간이 다 되었을 때
     if (remainingMS <= 0) {
         clearInterval(timerInterval);
         document.getElementById('sessionTimer').innerHTML = "0:00";
         
         // 여기서 최종 로그아웃 처리
         alert("세션이 만료되어 로그아웃됩니다.");
         location.href = '${pageContext.request.contextPath}/member/logout';
         return;
     }

     const remainingSec = Math.ceil(remainingMS / 1000);
     
     const minutes = Math.floor(remainingSec / 60);
     let seconds = remainingSec % 60;
     seconds = seconds < 10 ? '0' + seconds : seconds;

     // 화면에 표시
     const timerDisplay = document.getElementById('sessionTimer');
     if(timerDisplay) {
         timerDisplay.innerHTML = minutes + ":" + seconds;
     }

 }, 1000); // 1초마다 검사
}

// 버튼 클릭 시 실행될 함수
function extendLogin() {
 $.ajax({
     url: "${pageContext.request.contextPath}/admin/extendSession",
     type: "GET",
     success: function(data) {
         if(data === "success") {
             alert("로그인 시간이 연장되었습니다.");
             
             // [중요] localStorage에 현재 시간을 기록
             // 이렇게 하면 startTimer가 다음 1초 틱에 이걸 감지하고
             // 알아서 시간을 다시 30:00(설정시간)으로 계산해서 보여줍니다.
             SessionManager.updateLastActive(); 
         }
     },
     error: function() {
         alert("연장에 실패했습니다. 다시 시도해주세요.");
     }
 });
}

//[초기화] 페이지 로드 시 실행
$(document).ready(function() {
 // 페이지가 처음 열리면 '지금 활동함'으로 기록

 //  보통 새 창을 열면 세션이 갱신되므로 updateLastActive()를 호출하는 게 맞습니다.)
 SessionManager.updateLastActive();
 
 // 타이머 시작
 startTimer();
 
 $(document).ajaxComplete(function() {
     SessionManager.updateLastActive();
 });

});


</script>


<%-- 
    [참고] 타이머 스크립트는 common.js 등에 있거나 
    필요하다면 이 파일 하단에 <script>로 작성해야 작동합니다. 
    /* location.href = "${pageContext.request.contextPath}/member/logout"; */ // 로그아웃 처리
--%>