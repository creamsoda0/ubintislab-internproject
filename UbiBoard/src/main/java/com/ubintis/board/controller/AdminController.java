package com.ubintis.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@RequestMapping("/goConfig")
	public ModelAndView goConfig () {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/admin-config");
		return mav;
	}

}
