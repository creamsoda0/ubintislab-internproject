package com.ubintis.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MainController {
	
	@RequestMapping(value = "/default")
	public ModelAndView home(Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//예시
		/* mav.addObject("userName", "creamsoda"); */
		
		model.addAttribute("pageTitle", "권한 신청 목록");        
        model.addAttribute("content", "../board/applyList.jsp");
		
		mav.setViewName("layout/default");
		
		return mav;
	}
	
	
	

}
