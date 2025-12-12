package com.ubintis.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MainController {
	
	@RequestMapping(value = "/default")
	public ModelAndView loginpage(Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//¿¹½Ã
		/* mav.addObject("userName", "creamsoda"); */
		

		
		mav.setViewName("layout/login-page");
		
		return mav;
	}

	@RequestMapping("/goMain")
	public ModelAndView goMain () {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("layout/default");
		return mav;
	}

}
