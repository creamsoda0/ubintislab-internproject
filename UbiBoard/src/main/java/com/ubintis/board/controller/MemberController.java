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
			mav.setViewName("redirect:/default"); //메인페이지로 이동
		} else {
			mav.addObject("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			mav.setViewName("/layout/login-page");
		}
		
		return mav;
	}
	
	// 로그아웃 (세션 삭제)
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
	    // 세션에 저장된 모든 정보 삭제 (로그아웃 처리)
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/default");
	    session.invalidate();
	    return mav; // 메인으로 이동
	}
	
	// 회원정보 수정 페이지 이동
	@RequestMapping("/memberUpdate")
	public ModelAndView memberUpdate(HttpSession session) {		
		ModelAndView mav = new ModelAndView();
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		UserVO userInfo = memberService.getMember(loginUser.getUserId());
		
		//주소 분리해서 넣기
		String dbAddress = userInfo.getAddress();
		
		String zip ="";
		String addr = "";
		
		if (dbAddress != null && dbAddress.contains("(") && dbAddress.contains(")")) {
			int start = dbAddress.indexOf("(");
			int end = dbAddress.indexOf(")");
			
			// 우편번호 추출; 괄호 사이의 값
			zip = dbAddress.substring(start + 1, end);
			// 주소 추출
			addr = dbAddress.substring(end + 1).trim();
		}
		// 분리한 값을 jsp로 전달
		mav.addObject("zip",zip);
		mav.addObject("addr", addr);
		
		
		mav.addObject("user", userInfo);
		mav.setViewName("/layout/member-update");
		
		return mav;
	}
	
	// 회원정보 수정 쿼리 password, id 변경은 다른 곳에서 처리할 것임
	// birth는 수정이 안됨
	@RequestMapping ("/updateProcess")
	public ModelAndView updateProcess (UserVO userVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
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
	    
	    userVO.setAddress(fullAddress);
		memberService.updateMember(userVO);
		
		mav.setViewName("/layout/member-updatesuccess");
		
		return mav;
	}
	
	//아이디 찾기 구현
	@RequestMapping ("goFindId")
	public ModelAndView goFindId() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/find-id");
		return mav;
	}

	
	@ResponseBody
	@RequestMapping("/sendAuthCode")
	public String sendAuthCode(@RequestParam("email") String email, HttpSession session) {
	    
		// 어차피 이름 이메일 둘다 있으니까 이름과 이메일 둘 다 검색으로 넣어도 될듯
	    // (선택) 먼저 해당 이메일로 가입된 회원이 있는지 DB 체크 로직 추가 가능
	    UserVO user = memberService.findUserByEmail(email);
	    if(user == null) {
	        return "fail_no_user"; // 회원이 아님
	    }

	    // 메일 발송하고 인증코드 받아옴
	    String authCode = memberService.sendAuthCode(email);
	    
	    if(authCode != null) {
	        // 세션에 인증코드를 저장해둠 (나중에 비교용)
	        session.setAttribute("authCode", authCode);
	        // 세션 유효시간 설정 (예: 3분 = 180초)
	        session.setMaxInactiveInterval(180); 
	        
	        return "success";
	    } else {
	        return "fail_send";
	    }
	}
	
	@ResponseBody // 문자열만 반환
    @RequestMapping("/checkAuthCode") 
    public String checkAuthCode(@RequestParam("inputCode") String inputCode, HttpSession session) {
        
        String realCode = (String) session.getAttribute("authCode");
        
        if (realCode != null && realCode.equals(inputCode)) {
            return "success"; // 일치함
        } else {
            return "fail";    // 불일치
        }
    }

	@RequestMapping("/findIdProcess") // @ResponseBody 없음 (페이지 이동)
    public ModelAndView findIdProcess(@RequestParam("email") String email, 
                                      @RequestParam("name") String name) {
        
        ModelAndView mv = new ModelAndView();
        
        // 이름과 이메일로 DB 조회
        UserVO resultUser = memberService.findId(name, email); // Service에 이 메서드 필요 (이전 답변 참조)
        
        if (resultUser != null) {
            mv.addObject("resultUser", resultUser);
            mv.setViewName("member/findIdResult"); // 결과 JSP로 이동
        } else {
            mv.addObject("msg", "일치하는 회원 정보가 없습니다.");
            mv.setViewName("member/findId"); // 다시 입력창으로
        }
        
        return mv;
    }
	
}
