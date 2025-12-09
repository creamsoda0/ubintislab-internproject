package com.ubintis.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/join")
	public ModelAndView memberJoin (Model model) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("layout/terms-agree");
		
		return mav;
	}
	
	@RequestMapping (value = "/joinForm") 
	public ModelAndView joinForm (Model model) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("layout/join-form");
		
		return mav;
	}
	
	// 아이디 중복 체크
		@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
		@ResponseBody 
		public int idCheck(@RequestParam("userId") String userId) {
			
			// DB조회 후 몇 개인지(0 or 1) 아이디는 중복이 안되므로 0,1 둘 중 하나
			int cnt = memberService.idCheck(userId);
			
			return cnt; // 0이면 사용 가능, 1이면 중복
		}
	
	
}
