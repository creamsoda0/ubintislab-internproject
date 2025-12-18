package com.ubintis.board.exception;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionHandler {

    // 1. 404 에러 처리 (페이지 없음)
    @ExceptionHandler(NoHandlerFoundException.class)
    public Object handle404(NoHandlerFoundException e, HttpServletRequest request, HttpServletResponse response) {
        return processException(request, response, e, "요청하신 페이지를 찾을 수 없습니다.", HttpStatus.NOT_FOUND);
    }

    // 2. 405 에러 처리 (GET/POST 메서드 잘못된 요청)
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public Object handle405(HttpRequestMethodNotSupportedException e, HttpServletRequest request, HttpServletResponse response) {
        return processException(request, response, e, "지원하지 않는 요청 방식입니다.", HttpStatus.METHOD_NOT_ALLOWED);
    }

    // 3. DB 관련 에러 처리
    @ExceptionHandler(DataAccessException.class)
    public Object handleDatabaseException(DataAccessException e, HttpServletRequest request, HttpServletResponse response) {
        return processException(request, response, e, "데이터베이스 처리 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    // 4. 그 외 모든 예외 (500 에러 등)
    @ExceptionHandler(Exception.class)
    public Object handleAllException(Exception e, HttpServletRequest request, HttpServletResponse response) {
        e.printStackTrace(); 
        return processException(request, response, e, "시스템 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    // ★ 핵심 로직: 응답 코드 설정 및 AJAX 구분
    private Object processException(HttpServletRequest request, HttpServletResponse response, Exception e, String userMessage, HttpStatus status) {
        
        // HTTP 응답 상태 코드 설정 (브라우저/AJAX가 인식하게 함)
        response.setStatus(status.value());

        String xRequestedWith = request.getHeader("X-Requested-With");
        
        if ("XMLHttpRequest".equals(xRequestedWith)) {
            // [CASE A] AJAX 요청이면 JSON 반환
            return getJsonError(userMessage, e.getMessage(), status);
        } else {
            // [CASE B] 일반 요청이면 에러 페이지 이동
            ModelAndView mav = new ModelAndView();
            mav.addObject("status", status.value());
            mav.addObject("errorMessage", userMessage);
            mav.addObject("detailMessage", e.getMessage());
            mav.setViewName("error/common_error"); 
            return mav;
        }
    }
    
    @ResponseBody
    private Map<String, Object> getJsonError(String message, String detail, HttpStatus status) {
        Map<String, Object> map = new HashMap<>();
        map.put("result", "error");
        map.put("status", status.value());
        map.put("message", message);
        map.put("detail", detail);
        return map;
    }
}