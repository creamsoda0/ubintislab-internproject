package com.ubintis.board.exception;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

// 이 어노테이션이 있으면 모든 컨트롤러의 에러를 여기서 잡습니다.
@ControllerAdvice
public class GlobalExceptionHandler {

    // 1. DB 관련 모든 에러 처리 (SQL 오류, 제약조건 위반 등)
    @ExceptionHandler(DataAccessException.class)
    public Object handleDatabaseException(DataAccessException e, HttpServletRequest request) {
        System.err.println("🚨 DB 에러 발생: " + e.getMessage());
        return processException(request, e, "데이터베이스 처리 중 오류가 발생했습니다.");
    }

    // 2. 그 외 모든 에러 처리 (NullPointer 등 예상치 못한 에러)
    @ExceptionHandler(Exception.class)
    public Object handleAllException(Exception e, HttpServletRequest request) {
        System.err.println("🚨 알 수 없는 에러 발생: " + e.getMessage());
        e.printStackTrace(); // 콘솔에 로그 찍기
        return processException(request, e, "시스템 오류가 발생했습니다. 관리자에게 문의하세요.");
    }

    // ★ 핵심 로직: AJAX 요청인지 일반 요청인지 구분해서 응답
    private Object processException(HttpServletRequest request, Exception e, String userMessage) {
        
        // AJAX 요청인지 확인 (헤더 검사)
        String xRequestedWith = request.getHeader("X-Requested-With");
        
        if ("XMLHttpRequest".equals(xRequestedWith)) {
            // [CASE A] AJAX 요청이면 -> JSON 리턴 (@ResponseBody 효과)
            return getJsonError(userMessage, e.getMessage());
        } else {
            // [CASE B] 일반 요청이면 -> 에러 페이지(JSP)로 이동
            ModelAndView mav = new ModelAndView();
            mav.addObject("errorMessage", userMessage);
            mav.addObject("exception", e); // 개발 단계에서만 사용 (배포 시 제거 권장)
            mav.setViewName("error/common_error"); // error 폴더의 jsp로 이동
            return mav;
        }
    }
    
    // JSON 응답을 위한 헬퍼 메서드 (AJAX용)
    @ResponseBody
    private Map<String, Object> getJsonError(String message, String detail) {
        Map<String, Object> map = new HashMap<>();
        map.put("result", "error");
        map.put("message", message);
        map.put("detail", detail);
        return map;
    }
}