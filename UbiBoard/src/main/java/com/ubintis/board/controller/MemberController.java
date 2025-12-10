package com.ubintis.board.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.UserVO;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/join")
	public ModelAndView memberJoin(Model model) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("layout/terms-agree");

		return mav;
	}

	@RequestMapping(value = "/joinForm")
	public ModelAndView joinForm(Model model) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("layout/join-form");

		return mav;
	}

	@RequestMapping("/list")
	public String userList(Model model) {
		// 1. 서비스한테 명단 가져오라고 시킴
		List<UserVO> list = memberService.getUserList();

		// 2. 가져온 명단을 'list'라는 이름으로 화면에 던져줌
		model.addAttribute("list", list);

		// 3. userList.jsp로 이동
		return "userList";
	}

	// 아이디 중복 체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(@RequestParam("userId") String userId) {

		// DB조회 후 몇 개인지(0 or 1) 아이디는 중복이 안되므로 0,1 둘 중 하나
		int cnt = memberService.idCheck(userId);

		return cnt; // 0이면 사용 가능, 1이면 중복
	}

	// 회원 가입시 회원정보 DB 전송 컨트롤러
	@RequestMapping(value = "/joinProcess", method = RequestMethod.POST)
	public ModelAndView joinProcess (UserVO userVO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("layout/join-success");
		if (userVO.getEmailId() != null && !userVO.getEmailId().isEmpty() &&
		        userVO.getEmailDomain() != null && !userVO.getEmailDomain().isEmpty()) {
		        
		        String fullEmail = userVO.getEmailId() + "@" + userVO.getEmailDomain();
		        userVO.setEmail(fullEmail); // 합친 값을 VO의 email 변수에 저장
		    }
		
	    String fullAddress = "";
	    
	    // 우편번호가 있는 경우에만 괄호와 함께 추가
	    if (userVO.getZipCode() != null && !userVO.getZipCode().isEmpty()) {
	        fullAddress += "(" + userVO.getZipCode() + ") ";
	    }
	    
	    if (userVO.getAddr1() != null) {
	        fullAddress += userVO.getAddr1();
	    }
	    
	    if (userVO.getAddr2() != null && !userVO.getAddr2().isEmpty()) {
	        fullAddress += " " + userVO.getAddr2();
	    }
	    
	    // 합친 주소를 VO의 address 변수에 저장
	    userVO.setAddress(fullAddress);
	    // 현재 시간 반영
	    userVO.setJoinDate(new Date());
		
		memberService.insertMember(userVO);
		
		return mav;
	}
	
	@RequestMapping(value = "/goLoginPage") 
	public ModelAndView goLoginPage () {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/login-page");
		
		return mav;
	}
	
	@RequestMapping(value = "/loginProcess") 
	public ModelAndView loginProcess (UserVO userVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		// 서비스에서 로그인 체크 (UserVO 리턴 혹은 null)
		UserVO loginUser = memberService.login(userVO);
		
		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			mav.setViewName("/layout/defaults"); //메인페이지로 이동
		} else {
			mav.addObject("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		return mav;
	}
	
	// 로그아웃 (세션 삭제)
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
	    // 세션에 저장된 모든 정보 삭제 (로그아웃 처리)
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/defaults");
	    session.invalidate();
	    return mav; // 메인으로 이동
	}

}
