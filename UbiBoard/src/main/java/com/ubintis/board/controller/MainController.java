package com.ubintis.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.BoardService;
import com.ubintis.board.vo.MainBoardVO;


@Controller
public class MainController {
	
	@Autowired
	private BoardService boardservice;
	
	@RequestMapping(value = "/default")
	public ModelAndView loginpage(Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//¿¹½Ã
		/* mav.addObject("userName", "creamsoda"); */
		

		
		mav.setViewName("layout/login-page");
		
		return mav;
	}

	@RequestMapping("/goMain")
	public ModelAndView goMain (MainBoardVO vo) {
		ModelAndView mav = new ModelAndView();
		List<MainBoardVO> list = boardservice.getClipList();
		
		mav.addObject("clipList", list);
		
		mav.setViewName("layout/default");
		return mav;
	}

}
