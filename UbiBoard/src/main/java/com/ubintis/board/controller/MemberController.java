package com.ubintis.board.controller;

import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.LogService;
import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.UserVO;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private LogService logService;

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
		// 1. ¼­ºñ½ºÇÑÅ× ¸í´Ü °¡Á®¿À¶ó°í ½ÃÅ´
		List<UserVO> list = memberService.getUserList();

		// 2. °¡Á®¿Â ¸í´ÜÀ» 'list'¶ó´Â ÀÌ¸§À¸·Î È­¸é¿¡ ´øÁ®ÁÜ
		model.addAttribute("list", list);

		// 3. userList.jsp·Î ÀÌµ¿
		return "userList";
	}

	// ¾ÆÀÌµğ Áßº¹ Ã¼Å©
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(@RequestParam("userId") String userId) {

		// DBÁ¶È¸ ÈÄ ¸î °³ÀÎÁö(0 or 1) ¾ÆÀÌµğ´Â Áßº¹ÀÌ ¾ÈµÇ¹Ç·Î 0,1 µÑ Áß ÇÏ³ª
		int cnt = memberService.idCheck(userId);

		return cnt; // 0ÀÌ¸é »ç¿ë °¡´É, 1ÀÌ¸é Áßº¹
	}

	// È¸¿ø°¡ÀÔ½Ã È¸¿øÁ¤º¸ DB Àü¼Û ÄÁÆ®·Ñ·¯
	@RequestMapping(value = "/joinProcess", method = RequestMethod.POST)
	public ModelAndView joinProcess(UserVO userVO, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("layout/join-success");

		mav.setViewName("redirect:/member/joinForm");
		// ¾ÆÀÌµğ Á¤±Ô½Ä Ã¼Å© (¿µ¹® ¼Ò¹®ÀÚ/¼ıÀÚ, 5~20ÀÚ)
		String idRegex = "^[a-z0-9]{5,20}$";
		if (!Pattern.matches(idRegex, userVO.getUserId())) {
			// °Ë»ç ½ÇÆĞ ½Ã: ´Ù½Ã È¸¿ø°¡ÀÔ ÆäÀÌÁö·Î µ¹·Áº¸³¿
			mav.addObject("msg", "Àß¸øµÈ Á¢±ÙÀÔ´Ï´Ù. ¾ÆÀÌµğ´Â ¿µ¹® ¼Ò¹®ÀÚ¿Í ¼ıÀÚ¸¸ °¡´ÉÇÕ´Ï´Ù.");
			mav.setViewName("redirect:/member/joinForm");
			return mav; // È¸¿ø°¡ÀÔ jsp °æ·Î (forward)
		}

		// ºñ¹Ğ¹øÈ£ Á¤±Ô½Ä Ã¼Å© (9~25ÀÚ, ¿µ¹®+¼ıÀÚ+Æ¯¼ö¹®ÀÚ)
		String pwRegex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,25}$";
		if (!Pattern.matches(pwRegex, userVO.getPassword())) {
			mav.addObject("msg", "Àß¸øµÈ Á¢±ÙÀÔ´Ï´Ù. ºñ¹Ğ¹øÈ£ º¸¾È ±ÔÄ¢À» ÁöÄÑÁÖ¼¼¿ä.");
			mav.setViewName("redirect:/member/joinForm");
			return mav;
		}

		// ÀÌ¸§ÀÌ³ª ÀÌ¸ŞÀÏµµ ÇÊ¿äÇÏ´Ù¸é ¿©±â¼­ °Ë»ç
		String nameRegex = "^[°¡-ÆRa-zA-Z]{2,20}$";

		if (!Pattern.matches(nameRegex, userVO.getName())) {
			mav.addObject("msg", "ÀÌ¸§Àº ÇÑ±Û ¶Ç´Â ¿µ¹®À¸·Î 2~20ÀÚ ÀÌ³»¿©¾ß ÇÕ´Ï´Ù. (Æ¯¼ö¹®ÀÚ, ¼ıÀÚ, °ø¹é ºÒ°¡)");
			mav.setViewName("member/joinPage"); // redirect°¡ ¾Æ´Ï¶ó forward·Î º¸³»¾ß msg°¡ ¶å´Ï´Ù
			return mav;
		}
		// ÀÌ¸ŞÀÏ Á¤±Ô½Ä°Ë»ç
		if (!Pattern.matches(nameRegex, userVO.getEmailId())) {
			mav.addObject("msg", "ÀÌ¸ŞÀÏ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. (Æ¯¼ö¹®ÀÚ, ¼ıÀÚ, °ø¹é ºÒ°¡)");
			mav.setViewName("member/joinPage"); // redirect°¡ ¾Æ´Ï¶ó forward·Î º¸³»¾ß msg°¡ ¶å´Ï´Ù
			return mav;
		}
		if (!Pattern.matches(nameRegex, userVO.getEmailDomain())) {
			mav.addObject("msg", "ÀÌ¸ŞÀÏ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. (Æ¯¼ö¹®ÀÚ, ¼ıÀÚ, °ø¹é ºÒ°¡)");
			mav.setViewName("member/joinPage"); // redirect°¡ ¾Æ´Ï¶ó forward·Î º¸³»¾ß msg°¡ ¶å´Ï´Ù
			return mav;
		}

		// email ³ª´²Áø°Å ÇÕÄ¡´Â ·ÎÁ÷
		if (userVO.getEmailId() != null && !userVO.getEmailId().isEmpty() && userVO.getEmailDomain() != null
				&& !userVO.getEmailDomain().isEmpty()) {
			String fullEmail = userVO.getEmailId() + "@" + userVO.getEmailDomain();
			userVO.setEmail(fullEmail); // ÇÕÄ£ °ªÀ» VOÀÇ email º¯¼ö¿¡ ÀúÀå
		}

		String fullAddress = "";

		// ¿ìÆí¹øÈ£°¡ ÀÖ´Â °æ¿ì¿¡¸¸ °ıÈ£¿Í ÇÔ²² Ãß°¡
		if (userVO.getZipCode() != null && !userVO.getZipCode().isEmpty()) {
			fullAddress += "(" + userVO.getZipCode() + ") ";
		}
		if (userVO.getAddr1() != null) {
			fullAddress += userVO.getAddr1();
		}
		if (userVO.getAddr2() != null && !userVO.getAddr2().isEmpty()) {
			fullAddress += " " + userVO.getAddr2();
		}
		// ÇÕÄ£ ÁÖ¼Ò¸¦ VOÀÇ address º¯¼ö¿¡ ÀúÀå
		userVO.setAddress(fullAddress);
		// ÇöÀç ½Ã°£ ¹İ¿µ
		userVO.setJoinDate(new Date());

		memberService.insertMember(userVO);

		logService.saveLog(userVO.getUserId(), "JOIN", "È¸¿ø°¡ÀÔ ¼º°ø", request);

		return mav;
	}

	@RequestMapping(value = "/goLoginPage")
	public ModelAndView goLoginPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/login-page");

		return mav;
	}

	@RequestMapping(value = "/loginProcess")
	public ModelAndView loginProcess(UserVO userVO, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		// ¼­ºñ½º¿¡¼­ ·Î±×ÀÎ Ã¼Å© (UserVO ¸®ÅÏ È¤Àº null)
		UserVO loginUser = memberService.login(userVO);

		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			logService.saveLog(loginUser.getUserId(), "LOGIN", "·Î±×ÀÎ ¼º°ø", request);
			mav.setViewName("redirect:/goMain"); // ¸ŞÀÎÆäÀÌÁö·Î ÀÌµ¿
		} else {
			logService.saveLog(userVO.getUserId(), "LOGIN", "·Î±×ÀÎ ½ÇÆĞ ¾ÆÀÌµğ,ÆĞ½º¿öµå ºÒÀÏÄ¡", request);
			mav.addObject("msg", "¾ÆÀÌµğ ¶Ç´Â ºñ¹Ğ¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù.");
			mav.setViewName("/layout/login-page");
		}

		return mav;
	}

	// ·Î±×¾Æ¿ô (¼¼¼Ç »èÁ¦)
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session, HttpServletRequest request) {
		// ¼¼¼Ç¿¡ ÀúÀåµÈ ¸ğµç Á¤º¸ »èÁ¦ (·Î±×¾Æ¿ô Ã³¸®)
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser != null) {
			logService.saveLog(loginUser.getUserId(), "LOGOUT", "·Î±×¾Æ¿ô ¼º°ø", request);
		}
		mav.setViewName("redirect:/default");
		session.invalidate();
		return mav; // ¸ŞÀÎÀ¸·Î ÀÌµ¿
	}

	// È¸¿øÁ¤º¸ ¼öÁ¤ ÆäÀÌÁö ÀÌµ¿
	@RequestMapping("/memberUpdate")
	public ModelAndView memberUpdate(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		UserVO userInfo = memberService.getMember(loginUser.getUserId());

		// ÁÖ¼Ò ºĞ¸®ÇØ¼­ ³Ö±â
		String dbAddress = userInfo.getAddress();

		String zip = "";
		String addr = "";

		if (dbAddress != null && dbAddress.contains("(") && dbAddress.contains(")")) {
			int start = dbAddress.indexOf("(");
			int end = dbAddress.indexOf(")");

			// ¿ìÆí¹øÈ£ ÃßÃâ; °ıÈ£ »çÀÌÀÇ °ª
			zip = dbAddress.substring(start + 1, end);
			// ÁÖ¼Ò ÃßÃâ
			addr = dbAddress.substring(end + 1).trim();
		}
		// ºĞ¸®ÇÑ °ªÀ» jsp·Î Àü´Ş
		mav.addObject("zip", zip);
		mav.addObject("addr", addr);

		mav.addObject("user", userInfo);
		mav.setViewName("/layout/member-update");

		return mav;
	}

	// È¸¿øÁ¤º¸ ¼öÁ¤ Äõ¸® password, id º¯°æÀº ´Ù¸¥ °÷¿¡¼­ Ã³¸®ÇÒ °ÍÀÓ
	// birth´Â ¼öÁ¤ÀÌ ¾ÈµÊ
	@RequestMapping("/updateProcess")
	public ModelAndView updateProcess(UserVO userVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (userVO.getEmailId() != null && !userVO.getEmailId().isEmpty() && userVO.getEmailDomain() != null
				&& !userVO.getEmailDomain().isEmpty()) {

			String fullEmail = userVO.getEmailId() + "@" + userVO.getEmailDomain();
			userVO.setEmail(fullEmail); // ÇÕÄ£ °ªÀ» VOÀÇ email º¯¼ö¿¡ ÀúÀå
		}

		String fullAddress = "";

		// ¿ìÆí¹øÈ£°¡ ÀÖ´Â °æ¿ì¿¡¸¸ °ıÈ£¿Í ÇÔ²² Ãß°¡
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

	// ¾ÆÀÌµğ Ã£±â ±¸Çö
	@RequestMapping("/goFindId")
	public ModelAndView goFindId() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/find-id");
		return mav;
	}

	@ResponseBody
	@RequestMapping("/sendAuthCode")
	public ResponseEntity<String> sendAuthCode(@RequestParam("name") String name, @RequestParam("email") String email,
			HttpSession session) {

		// 1. [À¯È¿¼º °Ë»ç] ÀÔ·Â°ª ´©¶ô Ã¼Å© (¼­¹ö´Ü ´õºí Ã¼Å©)
		if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
			return new ResponseEntity<>("ÀÌ¸§°ú ÀÌ¸ŞÀÏÀ» ÀÔ·ÂÇØÁÖ¼¼¿ä.", HttpStatus.BAD_REQUEST); // 400
		}

		try {
			// 2. [È¸¿ø Á¶È¸] ÀÌ¸ŞÀÏ·Î È¸¿ø Á¤º¸ Ã£±â
			UserVO user = memberService.findUserByEmail(email);

			// 3. [È¸¿ø °ËÁõ] È¸¿øÀÌ ¾ø°Å³ª, ÀÔ·ÂÇÑ 'ÀÌ¸§'°ú DBÀÇ 'ÀÌ¸§'ÀÌ ´Ù¸£¸é ½ÇÆĞ Ã³¸®
			// (±âÁ¸ ÄÚµå´Â ÀÌ¸ŞÀÏ¸¸ ÀÖÀ¸¸é ÀÌ¸§À» ¾Æ¹«°Å³ª ³Ö¾îµµ Åë°úµÇ´Â ¹®Á¦°¡ ÀÖ¾úÀ½)
			if (user == null || !user.getName().equals(name)) {
				return new ResponseEntity<>("ÀÏÄ¡ÇÏ´Â È¸¿øÀÌ ¾ø½À´Ï´Ù.", HttpStatus.NOT_FOUND); // 404
			}

			// 4. [¸ŞÀÏ ¹ß¼Û] ÀÎÁõÄÚµå »ı¼º ¹× ¹ß¼Û
			String authCode = memberService.sendAuthCode(email);

			if (authCode != null) {
				// 5. [¼¼¼Ç ÀúÀå]
				session.setAttribute("authCode", authCode);

				// [ÁÖÀÇ] setMaxInactiveIntervalÀº ¼¼¼Ç ÀüÃ¼ÀÇ ¼ö¸í(·Î±×ÀÎ À¯Áö ½Ã°£ µî)À» ¹Ù²ã¹ö¸³´Ï´Ù.
				// ´Ü¼øÈ÷ ÀÎÁõ¹øÈ£ À¯È¿½Ã°£ Ã¼Å©¿ëÀÌ¶ó¸é, Â÷¶ó¸® '¹ß¼Û½Ã°£'À» ¼¼¼Ç¿¡ °°ÀÌ ÀúÀåÇÏ´Â °ÍÀÌ ¾ÈÀüÇÕ´Ï´Ù.
				// ¿©±â¼­´Â ÀÏ´Ü ±âÁ¸ ·ÎÁ÷À» À¯ÁöÇÏµÇ, ÁÖ¼®À¸·Î ³²±é´Ï´Ù.
				session.setMaxInactiveInterval(600); // 3ºĞ

				return new ResponseEntity<>("success", HttpStatus.OK); // 200
			} else {
				return new ResponseEntity<>("¸ŞÀÏ ¹ß¼Û Áß ¼­¹ö ¿À·ù ¹ß»ı", HttpStatus.INTERNAL_SERVER_ERROR); // 500
			}

		} catch (Exception e) {
			// ¸ŞÀÏ ¹ß¼Û Áß SMTP ¼­¹ö ¿¡·¯ µîÀÌ ¹ß»ıÇßÀ» ¶§ ¸ØÃßÁö ¾Ê°í ½ÇÆĞ ¸Ş½ÃÁö ¸®ÅÏ
			e.printStackTrace();
			return new ResponseEntity<>("¸ŞÀÏ ¼­¹ö¿ÍÀÇ Åë½Å ¹®Á¦·Î ¹ß¼Û¿¡ ½ÇÆĞÇß½À´Ï´Ù.", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@ResponseBody // ¹®ÀÚ¿­¸¸ ¹İÈ¯
	@RequestMapping("/checkAuthCode")
	public ResponseEntity<String> checkAuthCode(@RequestParam("inputCode") String inputCode, 
												@RequestParam("userId") String userId,
												HttpSession session) {

		String realCode = (String) session.getAttribute("authCode");
		
		if (realCode == null) {
	        return ResponseEntity.status(HttpStatus.GONE) // 410 ¿¡·¯
	                             .body("ÀÎÁõ ½Ã°£ÀÌ ¸¸·áµÇ¾ú½À´Ï´Ù. ÀÎÁõ¹øÈ£¸¦ ´Ù½Ã ¹Ş¾ÆÁÖ¼¼¿ä.");
	    }

		if (realCode != null && realCode.equals(inputCode)) {
			session.setAttribute("isPwResetAuthenticated", true);
			session.setAttribute("verifiedUserId", userId);
			session.removeAttribute("authCode");
			return new ResponseEntity<>("success", HttpStatus.OK); // 200
		} else {
			return new ResponseEntity<>("fail", HttpStatus.NOT_FOUND); // 404

		}
	}

	@RequestMapping("/findIdProcess")
	public ModelAndView findIdProcess(@RequestParam("email") String email, @RequestParam("name") String name) {

		ModelAndView mv = new ModelAndView();

		// ÀÌ¸§°ú ÀÌ¸ŞÀÏ·Î DB Á¶È¸
		UserVO resultUser = memberService.findId(name, email); // Service¿¡ ÀÌ ¸Ş¼­µå ÇÊ¿ä (ÀÌÀü ´äº¯ ÂüÁ¶)

		if (resultUser != null) {
			mv.addObject("resultUser", resultUser);
			mv.setViewName("/layout/find-idResult"); // °á°ú JSP·Î ÀÌµ¿
		} else {
			mv.addObject("msg", "ÀÏÄ¡ÇÏ´Â È¸¿ø Á¤º¸°¡ ¾ø½À´Ï´Ù.");
			mv.setViewName("redirect:/member/goFindId"); // ´Ù½Ã ÀÔ·ÂÃ¢À¸·Î
		}

		return mv;
	}

	// ºñ¹Ğ¹øÈ£ Ã£±â ½ÃÀÛ
	@RequestMapping("/goFindPw")
	public ModelAndView FindIdProcess() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/find-pw");
		return mav;
	}

	// ÀÎÁõ¹øÈ£ È®ÀÎÀº ¾ÆÀÌµğ Ã£±â¶û ¶È°°Àº api¸¦ È°¿ëÇÔ
	// ÀÎÁõ¹øÈ£ È®ÀÎÀº /checkAuthCode¸¦ È®ÀÎ
	@ResponseBody
	@RequestMapping("/sendAuthCodeForPw")
	public ResponseEntity<String> sendAuthCodeForPw(
	        @RequestParam("userId") String userId, 
	        @RequestParam("email") String email,
	        @RequestParam("name") String name, 
	        HttpSession session) {

	    // È¸¿ø Á¸Àç ¿©ºÎ Ã¼Å©
	    UserVO user = memberService.findUserByIdEmail(userId, email);
	    if (user == null) {
	        // 404 Not Found: ÀÏÄ¡ÇÏ´Â È¸¿øÀÌ ¾øÀ½
	        return ResponseEntity.status(HttpStatus.NOT_FOUND)
	                             .body("ÀÔ·ÂÇÏ½Å Á¤º¸¿Í ÀÏÄ¡ÇÏ´Â È¸¿øÀÌ ¾ø½À´Ï´Ù.");
	    }

	    // ¸ŞÀÏ ¹ß¼Û ¹× ÀÎÁõÄÚµå »ı¼º
	    String authCode = memberService.sendAuthCode(email);

	    if (authCode != null) {
	        // ¼¼¼Ç ÀúÀå ·ÎÁ÷
	        session.setAttribute("authCode", authCode);
	        session.setMaxInactiveInterval(180); // 3ºĞ

	        // 200 OK: ¼º°ø
	        return ResponseEntity.ok("success");
	    } else {
	        // 500 Internal Server Error: ¸ŞÀÏ ¹ß¼Û ½ÇÆĞ
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body("¸ŞÀÏ ¹ß¼Û Áß ¿À·ù°¡ ¹ß»ıÇß½À´Ï´Ù. Àá½Ã ÈÄ ´Ù½Ã ½ÃµµÇØÁÖ¼¼¿ä.");
	    }
	}

	@RequestMapping("/resetPwPage")
	public ModelAndView resetPwPage(@RequestParam("userId") String userId, HttpSession session) {
	    ModelAndView mav = new ModelAndView();

	    // ¼¼¼Ç¿¡¼­ ÀÎÁõ Á¤º¸ °¡Á®¿À±â
	    String verifiedUserId = (String) session.getAttribute("verifiedUserId");
	    Boolean isAuthenticated = (Boolean) session.getAttribute("isPwResetAuthenticated");

	    // º¸¾È °Ë»ç: ÀÎÁõ ÇÃ·¡±×°¡ ¾ø°Å³ª, ÀÎÁõµÈ ID¿Í ¿äÃ»ÇÑ ID°¡ ´Ù¸¦ °æ¿ì
	    if (isAuthenticated == null || !isAuthenticated || !userId.equals(verifiedUserId)) {
	        // 403 Forbidden »óÈ²: ¸ŞÀÎÀÌ³ª ¿¡·¯ ÆäÀÌÁö·Î ¸®´ÙÀÌ·ºÆ®
	        mav.setViewName("redirect:/member/findPw?error=unauthorized");
	        return mav;
	    }

	    mav.setViewName("/layout/reset-pw");
	    mav.addObject("userId", userId);
	    return mav;
	}
	// ºñ¹Ğ¹øÈ£ Àç¼³Á¤·ÎÁ÷ÀÔ´Ï´Ù.
	// ¿¹¿ÜÃ³¸® ÇÊ¿äÇÔ µ¥ÀÌÅÍ¸¦ ³Ö´Â °æ¿ì
	@RequestMapping("/resetPwProcess")
	public ModelAndView resetPwProcess(@RequestParam("userPw") String password, @RequestParam("userId") String userId) {
		ModelAndView mav = new ModelAndView();

		int result = memberService.updateUserPw(userId, password);
		if (result > 0) {
			// ¼º°ø (1°³ ÀÌ»óÀÇ ÇàÀÌ ¾÷µ¥ÀÌÆ®µÊ)
			System.out.println("ºñ¹Ğ¹øÈ£ º¯°æ ¼º°ø!");
			mav.setViewName("/layout/reset-pwsuccess");

		} else {
			// ½ÇÆĞ (¾÷µ¥ÀÌÆ®µÈ ÇàÀÌ ¾øÀ½ -> ¾ÆÀÌµğ°¡ Àß¸øµÇ¾ú°Å³ª DB ¿À·ù)
			System.out.println("ºñ¹Ğ¹øÈ£ º¯°æ ½ÇÆĞ");

			// ½ÇÆĞ ¸Ş½ÃÁö¸¦ ´ã¾Æ¼­ ´Ù½Ã ºñ¹Ğ¹øÈ£ º¯°æ ÆäÀÌÁö(¶Ç´Â ¿¡·¯ÆäÀÌÁö)·Î º¸³¿
			mav.addObject("msg", "ºñ¹Ğ¹øÈ£ º¯°æ¿¡ ½ÇÆĞÇß½À´Ï´Ù. ´Ù½Ã ½ÃµµÇØÁÖ¼¼¿ä.");

			// ´Ù½Ã ÀÔ·Â ÆäÀÌÁö·Î µ¹¾Æ°¡·Á¸é userId°¡ ÇÊ¿äÇÏ¹Ç·Î ´Ù½Ã ´ã¾ÆÁÜ
			mav.addObject("userId", userId);
			mav.setViewName("redirect:/resetPwPage");
		}
		return mav;
	}

	@RequestMapping("/goMemberDelete")
	public ModelAndView goMemberDelete(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/member-delete");
		return mav;
	}

	// È¸¿øÅ»Åğ ÇÁ·Î¼¼½º
	// Á÷Á¢ÀûÀÎ Æ®·£Àè¼Ç ±¸ÇöÀº impl¿¡ ±¸ÇöÇßÀ½
	@RequestMapping("/memberDeleteProcess")
	public ModelAndView memberDeleteProcess(HttpSession session, UserVO userVO, @RequestParam("reason") String reason,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		try {
			boolean isSuccess = memberService.withdrawProcess(userVO, reason);

			if (isSuccess) {
				logService.saveLog(userVO.getUserId(), "WITHDRAW", "È¸¿ø Å»Åğ Ã³¸®", request);
				session.invalidate();
				mav.addObject("msg", "Å»ÅğµÇ¾ú½À´Ï´Ù.");
				mav.addObject("url", "/main");
				mav.setViewName("/layout/member-deletesuccess");

			} else {
				mav.addObject("msg", "ºñ¹Ğ¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù.");
				mav.setViewName("redirect:/member/goMemberDelete");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("msg", "½Ã½ºÅÛ ¿À·ù·Î Å»Åğ¿¡ ½ÇÆĞÇß½À´Ï´Ù.");
			mav.setViewName("redirect:/member/goMemberDelete");
		}
		return mav;
	}

}
