package com.ubintis.board.interceptor; // 패키지명은 본인 프로젝트에 맞게 수정

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ubintis.board.service.AdminService;
import com.ubintis.board.vo.SiteConfigVO;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private AdminService adminService;
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
        // 1. 세션 가져오기
        HttpSession session = request.getSession();
        
        // 2. 세션에 'loginUser' 정보가 있는지 확인
        // (Controller에서 로그인 성공 시 session.setAttribute("loginUser", vo); 했다고 가정)
        Object loginUser = session.getAttribute("loginUser");
        
        if (loginUser == null) {
            // 3. 로그인이 안 되어 있다면 로그인 페이지로 튕겨내기
            // [중요] 경로는 본인의 로그인 페이지 URL로 수정하세요
            response.sendRedirect(request.getContextPath() + "/member/goLoginPage");
            
            response.setContentType("text/html; charset=UTF-8");
                      
            // 더 이상 컨트롤러로 진입하지 못하게 false 리턴
            return false;
        }
        
        Boolean reAgreeRequired = (Boolean) session.getAttribute("RE_AGREE_REQUIRED");
        
        if (reAgreeRequired != null && reAgreeRequired) {
            String uri = request.getRequestURI();
            
            // 재동의 페이지 뿐만 아니라, 동의 처리를 하는 URL(/updateReAgree)도 허용해야 합니다.
            if (uri.contains("/member/goReAgreePage") || 
                uri.contains("/member/updateReAgree") || // 이 부분이 핵심!
                uri.contains("/member/logout")) {
                return true;
            }
            
            // 재동의가 필요한데 다른 곳으로 가려 한다면 재동의 페이지로 강제 이동!
            response.sendRedirect(request.getContextPath() + "/member/goReAgreePage");
            return false;
        }
        
     // 1. DB에서 관리자가 설정한 최신 세션 타임아웃 값을 가져옵니다.
        SiteConfigVO config = adminService.getSiteConfig();
        int timeoutMinutes = config.getSessionTimeOut();

        // 2. 서버의 세션 만료 시간을 초 단위로 동적 설정합니다.
        // web.xml의 설정보다 이 코드가 우선순위가 높습니다.
        session.setMaxInactiveInterval(timeoutMinutes * 60);
        
        // 4. 로그인이 되어 있다면 통과(true)
        return true;
    }
}
