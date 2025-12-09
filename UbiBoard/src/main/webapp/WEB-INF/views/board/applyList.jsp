<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- [중요] 이 파일 안에서도 링크를 쓰려면 변수가 필요합니다 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<h2 class="title">권한 신청</h2>
<div class="sub_content_wrap">
    <p class="mb10">※ 권한 신청 목록을 확인할 수 있습니다.</p>
    
    <%-- 검색 폼 --%>
    <form>
        <div class="search_box_wrap clearfix">
            <div class="box01">
                <div class="select-box">
                    <select title="보기선택">
                        <option>10건</option>
                    </select>
                </div>
            </div>
            <div class="box02">
                <label class="hidden">신청구분</label>
                <div class="select-box">
                    <select title="신청구분 선택">
                        <option>전체</option>
                    </select>
                </div>

                <label class="hidden" for="lb_name">검색어 입력</label>
                <div class="select-box">
                    <input type="text" id="lb_name" name="lb_name" value="" placeholder="검색어 입력" title="검색어 입력">
                    <button type="button" class="button">검색</button>
                </div>
            </div>
        </div>
    </form>
    
    <h3 class="sub_s_title">권한 신청 목록</h3>
    <div class="table-wrap scroll">
        <table>
            <caption>권한 신청 리스트</caption>
            <colgroup>
                <col style="width:90px">
                <col style="width:13%">
                <col style="width:16%">
                <col style="width:auto">
                <col style="width:17%">
                <col style="width:17%">
                <col style="width:17%">
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">결재 번호</th>
                    <th scope="col">신청자 아이디</th>
                    <th scope="col">신청자 명</th>
                    <th scope="col">부서명</th>
                    <th scope="col">상태</th>
                    <th scope="col">신청일시</th>
                    <th scope="col">완료일시</th>
                </tr>
            </thead>
            <tbody>
                <%-- 데이터 반복 출력 구간 --%>
                <c:choose>
                    <c:when test="${not empty list}">
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td>${item.docId}</td>
                                <td>
                                    <a href="${contextPath}/sub02/auth/detail/${item.docId}">
                                        ${item.applicantId}
                                    </a>
                                </td>
                                <td>${item.applicantName}</td>
                                <td>${item.deptName}</td>
                                <td>${item.status}</td>
                                <td><p class="number">${item.applyDate}</p></td>
                                <td><p class="number">${item.completeDate}</p></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7">조회된 신청 목록이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>            
        </table>
        <span class="scroll_img">스크롤</span>
    </div>
    
    <%-- 페이징 --%>
    <div class="page con-mb-base" id="divPaging">
        <%-- pagination 객체가 있다고 가정 --%>
        <button type="button" class="btn-first" onclick="goList(1)">맨 처음</button>
        <button type="button" class="btn-prev" onclick="goList(${pagination.prevPage})">이전</button>
        
        <c:forEach var="page" begin="${pagination.startPage}" end="${pagination.endPage}">
            <a href="${contextPath}/sub02/auth/apply?page=${page}" 
               class="${page == pagination.currentPage ? 'this-page' : ''}">
               ${page}
            </a>
        </c:forEach>

        <button type="button" class="btn-next" onclick="goList(${pagination.nextPage})">다음</button>
        <button type="button" class="btn-last" onclick="goList(${pagination.totalPages})">맨 마지막</button>
    </div>
    
    <div class="fr">
        <button type="button" class="button02" onclick="location.href='${contextPath}/sub02/auth/new'">권한신청</button>
    </div>

    <%-- 페이지 전용 스크립트 (LNB 활성화 등) --%>
    <script>
    $(document).ready(function () {
        $(".sub_title").text("시스템 접근 권한");
        $(".sub_nav_inner > li:eq(1)").addClass("on"); 
        $(".sub_nav_inner > li:eq(1) > ul").css("display","block"); 
        $(".sub_nav_inner > li > ul > li:eq(0) > a").addClass("on"); 
    });
    
    function goList(page) {
        location.href = "${contextPath}/sub02/auth/apply?page=" + page;
    }
    </script>
</div>