<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>

<%
    int currentYear = LocalDate.now().getYear();
%>

<footer style="background-color: #f8f9fa; padding: 40px 0; border-top: 1px solid #e9ecef; color: #6c757d; font-size: 13px;">
    <div class="container" style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">
        
        <div class="warning-box" style="background-color: #f0f7ff; color: #055160; padding: 15px; border-radius: 6px; margin-bottom: 20px; text-align: center; border: 1px solid #cff4fc;">
            <strong style="color: #d63384;">⚠️ 개인정보 보호 주의</strong> : 본 시스템의 모든 정보는 업무 목적으로만 이용해야 하며, 위반 시 관련법에 의해 처벌될 수 있습니다.
        </div>

        <div class="footer-bottom" style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #e9ecef; padding-top: 20px; flex-wrap: wrap; gap: 10px;">
            
            <div class="left-info">
                <span style="font-weight: bold; color: #333; font-size: 14px;">UBINTISLAB</span>
            </div>

            <div class="copyright">
                Copyright &copy; <%= currentYear %> UBINTISLAB. All rights reserved.
            </div>
        </div>
    </div>
</footer>