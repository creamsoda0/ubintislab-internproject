package com.ubintis.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.UserVO;

@Controller
@RequestMapping ("/clip")
public class ClipController {
	
	@Autowired
	private MemberService memberservice;
	
	@RequestMapping ("/write")
	public ModelAndView goWriteClip (HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		if (loginUser==null) {
			mav.setViewName("redirect:/member/goLoginPage");
			return mav;
		}
		UserVO userInfo = memberservice.getMember(loginUser.getUserId());
		mav.addObject("userInfo", userInfo);
		mav.setViewName("/layout/write");
		return mav;	
	}
}
