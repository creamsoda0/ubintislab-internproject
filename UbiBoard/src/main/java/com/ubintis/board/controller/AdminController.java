package com.ubintis.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.AdminService;
import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.SiteConfigVO;
import com.ubintis.board.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("/goConfig")
	public ModelAndView goConfig (HttpSession session, SiteConfigVO configVO) throws Exception {
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		int count = memberService.selectAdminById(loginUser.getUserId());
		if (count == 0) {
			throw new Exception("관리자가 아닙니다.");
		}
		
		configVO = adminService.getSiteConfig();
		mav.addObject("config", configVO);
		mav.setViewName("/layout/admin-config");
		
		return mav;
	}

	@RequestMapping("/updateConfig")
	public ModelAndView updateConfig(SiteConfigVO configVO, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		int count = memberService.selectAdminById(loginUser.getUserId());
		if (count == 0) {
			throw new Exception("관리자가 아닙니다.");
		}
		
		System.out.println("페이지 수: " + configVO.getPostsPerPage());
	    System.out.println("임시잠금 여부: " + configVO.getTempLockEnabled());
	    System.out.println("로그인 유지시간: " + configVO.getSessionTimeOut());
		
		adminService.updateSiteConfig(configVO);
		
		mav.setViewName("redirect:/admin/goConfig");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/extendSession", method = RequestMethod.GET)
	@ResponseBody
	public String extendSession(HttpSession session) {
		SiteConfigVO config = adminService.getSiteConfig();
	    int timeoutMinutes = config.getSessionTimeOut();

		session.setMaxInactiveInterval(timeoutMinutes * 60);
	    return "success";
	}

	
}
