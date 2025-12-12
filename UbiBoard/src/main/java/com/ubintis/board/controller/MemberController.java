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
	
	// 회원가입 컨트롤러입니다.예외처리 작업 아직 안함. 
	// 회원가입시 회원정보 DB 전송 컨트롤러
	@RequestMapping(value = "/joinProcess", method = RequestMethod.POST)
	public ModelAndView joinProcess (UserVO userVO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("layout/join-success");
		
		
		//email 나눠진거 합치는 로직
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
			mav.setViewName("/layout/default"); //메인페이지로 이동
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
	public String sendAuthCode(@RequestParam("name") String name, 
	                           @RequestParam("email") String email, 
	                           HttpSession session) {
	    
	    // 1. [유효성 검사] 입력값 누락 체크 (서버단 더블 체크)
	    if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
	        return "fail_input"; 
	    }

	    try {
	        // 2. [회원 조회] 이메일로 회원 정보 찾기
	        UserVO user = memberService.findUserByEmail(email);
	        
	        // 3. [회원 검증] 회원이 없거나, 입력한 '이름'과 DB의 '이름'이 다르면 실패 처리
	        // (기존 코드는 이메일만 있으면 이름을 아무거나 넣어도 통과되는 문제가 있었음)
	        if (user == null || !user.getName().equals(name)) {
	            return "fail_no_user"; 
	        }

	        // 4. [메일 발송] 인증코드 생성 및 발송
	        String authCode = memberService.sendAuthCode(email);
	        
	        if(authCode != null) {
	            // 5. [세션 저장]
	            session.setAttribute("authCode", authCode);
	            
	            // [주의] setMaxInactiveInterval은 세션 전체의 수명(로그인 유지 시간 등)을 바꿔버립니다.
	            // 단순히 인증번호 유효시간 체크용이라면, 차라리 '발송시간'을 세션에 같이 저장하는 것이 안전합니다.
	            // 여기서는 일단 기존 로직을 유지하되, 주석으로 남깁니다.
	            session.setMaxInactiveInterval(180); // 3분
	            
	            return "success";
	        } else {
	            return "fail_send";
	        }
	        
	    } catch (Exception e) {
	        // 메일 발송 중 SMTP 서버 에러 등이 발생했을 때 멈추지 않고 실패 메시지 리턴
	        e.printStackTrace();
	        return "error"; 
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

	@RequestMapping("/findIdProcess") 
    public ModelAndView findIdProcess(@RequestParam("email") String email, 
                                      @RequestParam("name") String name) {
        
        ModelAndView mv = new ModelAndView();
        
        // 이름과 이메일로 DB 조회
        UserVO resultUser = memberService.findId(name, email); // Service에 이 메서드 필요 (이전 답변 참조)
        
        if (resultUser != null) {
            mv.addObject("resultUser", resultUser);
            mv.setViewName("/layout/find-idResult"); // 결과 JSP로 이동
        } else {
            mv.addObject("msg", "일치하는 회원 정보가 없습니다.");
            mv.setViewName("redirect:/member/goFindId"); // 다시 입력창으로
        }
        
        return mv;
    }
	
	//비밀번호 찾기 시작
	@RequestMapping("/goFindPw")
	public ModelAndView FindIdProcess () {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/find-pw");
		return mav;
	}
	// 인증번호 확인은 아이디 찾기랑 똑같은 api를 활용함
	// 인증번호 확인은 /checkAuthCode를 확인
	@ResponseBody
	@RequestMapping("/sendAuthCodeForPw")
	public String sendAuthCodeForPw(@RequestParam("userId") String userId, 
									@RequestParam("email") String email, 
									@RequestParam("name") String name, 
									HttpSession session) {
	    
		// 어차피 이름 이메일 둘다 있으니까 이름과 이메일 둘 다 검색으로 넣어도 될듯
	    // (선택) 먼저 해당 이메일로 가입된 회원이 있는지 DB 체크 로직 추가 가능
	    UserVO user = memberService.findUserByIdEmail(userId, email);
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
	
	// 비밀번호 재설정 페이지로 이동
	 @RequestMapping("/resetPwPage") 
	 public ModelAndView resetPwPage(@RequestParam("userId") String userId) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("/layout/reset-pw");
		 mav.addObject("userId", userId);
		 return mav;
	 }
	 // 비밀번호 재설정로직입니다.
	 // 예외처리 필요함 데이터를 넣는 경우
	 @RequestMapping("/resetPwProcess")
	 public ModelAndView resetPwProcess (@RequestParam("userPw") String password, @RequestParam("userId") String userId) {
		 ModelAndView mav = new ModelAndView();
		 
		 int result = memberService.updateUserPw(userId, password);
		 if (result > 0) {
		        // 성공 (1개 이상의 행이 업데이트됨)
		        System.out.println("비밀번호 변경 성공!");
		        mav.setViewName("/layout/reset-pwsuccess");
		        
		    } else {
		        // 실패 (업데이트된 행이 없음 -> 아이디가 잘못되었거나 DB 오류)
		        System.out.println("비밀번호 변경 실패");
		        
		        // 실패 메시지를 담아서 다시 비밀번호 변경 페이지(또는 에러페이지)로 보냄
		        mav.addObject("msg", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
		        
		        // 다시 입력 페이지로 돌아가려면 userId가 필요하므로 다시 담아줌
		        mav.addObject("userId", userId); 
		        mav.setViewName("redirect:/resetPwPage");
		    } 
		 return mav;
	 }
	 
	 @RequestMapping("/goMemberDelete")
	 public ModelAndView goMemberDelete (HttpSession session) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("/layout/member-delete");
		 return mav;
	 }
	 
	 //회원탈퇴 프로세스
	 // 직접적인 트랜잭션 구현은 impl에 구현했음
	 @RequestMapping("/memberDeleteProcess")
	 public ModelAndView memberDeleteProcess(HttpSession session, UserVO userVO, @RequestParam("reason") String reason) {
	     ModelAndView mav = new ModelAndView();

	     try {
	         boolean isSuccess = memberService.withdrawProcess(userVO, reason);
	         
	         if (isSuccess) {
	             session.invalidate();
	             mav.addObject("msg", "탈퇴되었습니다.");
	             mav.addObject("url", "/main");
	             mav.setViewName("/layout/member-deletesuccess");
	         } else {
	             mav.addObject("msg", "비밀번호가 일치하지 않습니다.");
	             mav.setViewName("redirect:/member/goMemberDelete");
	         }
	     } catch (Exception e) {
	         e.printStackTrace();
	         mav.addObject("msg", "시스템 오류로 탈퇴에 실패했습니다.");
	         mav.setViewName("redirect:/member/goMemberDelete");
	     }
	     return mav;
	 }
	
}
