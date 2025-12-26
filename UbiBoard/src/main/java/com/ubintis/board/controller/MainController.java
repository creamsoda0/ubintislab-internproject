package com.ubintis.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.AdminService;
import com.ubintis.board.service.BoardService;
import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.PageVO;
import com.ubintis.board.vo.PagingVO;
import com.ubintis.board.vo.SiteConfigVO;
import com.ubintis.board.vo.UserVO;


@Controller
public class MainController {
	
	@Autowired
	private BoardService boardservice;
	
	@Autowired MemberService memberService;
	
	@Autowired
    private AdminService adminService;
	
	@RequestMapping(value = "/default")
	public ModelAndView loginpage(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		boolean isExisted = loginUser != null;
		
		if (isExisted) {
			mav.setViewName("redirect:/goMain");
			return mav;
		}
		mav.setViewName("layout/login-page");
		
		return mav;
	}

	@RequestMapping("/goMain")
	public ModelAndView goMain (MainBoardVO vo, PagingVO paging) {
		ModelAndView mav = new ModelAndView();	
		
		SiteConfigVO config = adminService.getSiteConfig();
		
		int total = boardservice.getTotalCount(paging);
		paging.setAmount(config.getPostsPerPage());		// DB 환경세팅값대로 설정
		List<MainBoardVO> list = boardservice.getClipList(paging);
		
		mav.addObject("clipList", list);
	    mav.addObject("pageMaker", new PageVO(paging, total)); // 페이징 정보 전달
	    mav.addObject("totalCount", total); // 총 게시물 수 전달
		
		mav.setViewName("layout/default");
		return mav;
	}
	
	@RequestMapping("/goAdminGateway")
	public ModelAndView goAdminGateway (HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("layout/admin-gateway");
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		int count = memberService.selectAdminById(loginUser.getUserId());
		if (count == 0) {
			throw new Exception("관리자가 아닙니다.");
		}
		
		return mav;
	}

	
}
