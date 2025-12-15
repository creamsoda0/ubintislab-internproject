package com.ubintis.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.BoardService;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.PageVO;
import com.ubintis.board.vo.PagingVO;


@Controller
public class MainController {
	
	@Autowired
	private BoardService boardservice;
	
	@RequestMapping(value = "/default")
	public ModelAndView loginpage(Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//예시
		/* mav.addObject("userName", "creamsoda"); */
		

		
		mav.setViewName("layout/login-page");
		
		return mav;
	}

	@RequestMapping("/goMain")
	public ModelAndView goMain (MainBoardVO vo, PagingVO paging) {
		ModelAndView mav = new ModelAndView();				
		int total = boardservice.getTotalCount(paging);
				
		List<MainBoardVO> list = boardservice.getClipList(paging);
		
		mav.addObject("clipList", list);
	    mav.addObject("pageMaker", new PageVO(paging, total)); // 페이징 정보 전달
	    mav.addObject("totalCount", total); // 총 게시물 수 전달
		
		mav.setViewName("layout/default");
		return mav;
	}

}
