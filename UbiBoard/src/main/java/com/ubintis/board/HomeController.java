package com.ubintis.board;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/index"/* , method = RequestMethod.GET */)
	public ModelAndView home(Locale locale, Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//예시
		/* mav.addObject("userName", "creamsoda"); */
		
		model.addAttribute("pageTitle", "권한 신청 목록");
        model.addAttribute("lnbTitle", "시스템 접근 권한");
        model.addAttribute("menu2", "on"); // LNB 2차 메뉴 활성화
        model.addAttribute("subMenu2_1", "on"); // LNB 3차 메뉴 2-1 활성화
        
        model.addAttribute("content", "board/applyList :: applyListContent");
		
		mav.setViewName("layout/default");
		
		return mav;
	}
	
}
