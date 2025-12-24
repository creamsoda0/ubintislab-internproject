package com.ubintis.board.controller;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

import com.ubintis.board.service.AdminService;
import com.ubintis.board.service.LogService;
import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.SiteConfigVO;
import com.ubintis.board.vo.UserPolicyVO;
import com.ubintis.board.vo.UserVO;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private LogService logService;
	
	@Autowired
	private AdminService adminService;

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

	// ¾ÆÀÌµð Áßº¹ Ã¼Å©
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(@RequestParam("userId") String userId) {

		// DBÁ¶È¸ ÈÄ ¸î °³ÀÎÁö(0 or 1) ¾ÆÀÌµð´Â Áßº¹ÀÌ ¾ÈµÇ¹Ç·Î 0,1 µÑ Áß ÇÏ³ª
		int cnt = memberService.idCheck(userId);

		return cnt; // 0ÀÌ¸é »ç¿ë °¡´É, 1ÀÌ¸é Áßº¹
	}

	@RequestMapping(value = "/joinProcess", method = RequestMethod.POST)
	public ModelAndView joinProcess(UserVO userVO, HttpServletRequest request) throws Exception {
	    ModelAndView mav = new ModelAndView();
	    String userIp = request.getRemoteAddr();
	    
	    // ±âº» ÀÌµ¿ °æ·Î¸¦ °¡ÀÔ ÆûÀ¸·Î ¼³Á¤ (½ÇÆÐ ½Ã ´ëºñ)
	    // forward ½Ã¿¡´Â redirect: Å°¿öµå ¾øÀÌ JSP °æ·Î¸¸ Àû½À´Ï´Ù.
	    mav.setViewName("layout/join-form"); 
	    
	    // ¾ÆÀÌµð Áßº¹È®ÀÎ Àç°Ë»ç
	    int cnt = memberService.idCheck(userVO.getUserId());
	    if (cnt >= 1) {
	    	return mav;
	    }

	    // ¾ÆÀÌµð Á¤±Ô½Ä (¿µ¹® ¼Ò¹®ÀÚ/¼ýÀÚ, 5~20ÀÚ)
	    String idRegex = "^[a-z0-9]{5,20}$";
	    if (!Pattern.matches(idRegex, userVO.getUserId())) {
	        mav.addObject("msg", "¾ÆÀÌµð´Â ¿µ¹® ¼Ò¹®ÀÚ¿Í ¼ýÀÚ¸¸ °¡´ÉÇÕ´Ï´Ù (5~20ÀÚ).");
	        return mav; 
	    }

	    // ºñ¹Ð¹øÈ£ Á¤±Ô½Ä (9~25ÀÚ, ¿µ¹®+¼ýÀÚ+Æ¯¼ö¹®ÀÚ)
	    String pwRegex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,25}$";
	    if (!Pattern.matches(pwRegex, userVO.getPassword())) {
	        mav.addObject("msg", "ºñ¹Ð¹øÈ£ º¸¾È ±ÔÄ¢À» ÁöÄÑÁÖ¼¼¿ä (¿µ¹®,¼ýÀÚ,Æ¯¼ö¹®ÀÚ Æ÷ÇÔ 9~25ÀÚ).");
	        return mav;
	    }

	    // ÀÌ¸§ Á¤±Ô½Ä
	    String nameRegex = "^[°¡-ÆRa-zA-Z]{2,20}$";
	    if (!Pattern.matches(nameRegex, userVO.getName())) {
	        mav.addObject("msg", "ÀÌ¸§Àº ÇÑ±Û ¶Ç´Â ¿µ¹®À¸·Î 2~20ÀÚ ÀÌ³»¿©¾ß ÇÕ´Ï´Ù.");
	        return mav;
	    }

	    // ÀÌ¸ÞÀÏ ¾ÆÀÌµð/µµ¸ÞÀÎ Á¤±Ô½Ä (¼ýÀÚ ¹× ÇÏÀÌÇÂ µî Çã¿ë)
	    String emailIdRegex = "^[a-zA-Z0-9]{2,40}$";
	    String emailDomainRegex = "^[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$";

	    if (!Pattern.matches(emailIdRegex, userVO.getEmailId())) {
	        mav.addObject("msg", "ÀÌ¸ÞÀÏ ¾ÆÀÌµð Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù.");
	        return mav;
	    }
	    if (!Pattern.matches(emailDomainRegex, userVO.getEmailDomain())) {
	        mav.addObject("msg", "ÀÌ¸ÞÀÏ µµ¸ÞÀÎ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù.");
	        return mav;
	    }

	 // ÁÖ¼Ò °ËÁõ (±âº»ÁÖ¼Ò ¹× »ó¼¼ÁÖ¼Ò)
	    if (userVO.getZipCode() == null || userVO.getZipCode().isEmpty() || 
	        userVO.getAddr1() == null || userVO.getAddr1().isEmpty()) {
	        mav.addObject("msg", "ÁÖ¼Ò °Ë»öÀ» ÅëÇØ ±âº» ÁÖ¼Ò¸¦ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
	        return mav; // forward ¹æ½ÄÀ¸·Î ÀÔ·Â°ª À¯Áö
	    }

	    String addr2 = (userVO.getAddr2() != null) ? userVO.getAddr2().trim() : "";

	    // »ó¼¼ÁÖ¼Ò ÇÊ¼ö ÀÔ·Â Ã¼Å©
	    if (addr2.isEmpty()) {
	        mav.addObject("msg", "»ó¼¼ ÁÖ¼Ò¸¦ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
	        return mav;
	    }

	    // »ó¼¼ÁÖ¼Ò Á¤±Ô½Ä °Ë»ç (º¸¾È: ÇÑ±Û, ¿µ¹®, ¼ýÀÚ, °ø¹é, (), - . , ¸¸ Çã¿ë)
	    // Java¿¡¼­´Â ¹é½½·¡½Ã(\)¸¦ µÎ ¹ø(\\) ½á¾ß ÇÕ´Ï´Ù.
	    String addr2Regex = "^[°¡-ÆRa-zA-Z0-9\\s\\(\\)\\-\\.,]*$";
	    if (!Pattern.matches(addr2Regex, addr2)) {
	        mav.addObject("msg", "»ó¼¼ ÁÖ¼Ò¿¡ Çã¿ëµÇÁö ¾Ê´Â Æ¯¼ö¹®ÀÚ°¡ Æ÷ÇÔµÇ¾î ÀÖ½À´Ï´Ù.");
	        return mav;
	    }

	    // »ó¼¼ÁÖ¼Ò ±æÀÌ Ã¼Å© (DB ÄÃ·³ Å©±â¿¡ ¸ÂÃã)
	    if (addr2.length() > 100) {
	        mav.addObject("msg", "»ó¼¼ ÁÖ¼Ò´Â 100ÀÚ ÀÌ³»·Î ÀÔ·ÂÇØÁÖ¼¼¿ä.");
	        return mav;
	    }
    
	    // --- µ¥ÀÌÅÍ °¡°ø ·ÎÁ÷ (ÀÌÇÏ µ¿ÀÏ) ---
	    if (userVO.getEmailId() != null && !userVO.getEmailId().isEmpty()) {
	        userVO.setEmail(userVO.getEmailId() + "@" + userVO.getEmailDomain());
	    }

	    // ÁÖ¼Ò ÇÕÄ¡±â
	    String fullAddress = "";
	    if (userVO.getZipCode() != null && !userVO.getZipCode().isEmpty()) {
	        fullAddress += "(" + userVO.getZipCode() + ") ";
	    }
	    userVO.setAddress(fullAddress + userVO.getAddr1() + " " + userVO.getAddr2());
	    userVO.setJoinDate(new Date());

	    // DB ÀúÀå ¹× ·Î±×
	    memberService.insertMember(userVO);
	    logService.saveLog(userVO.getUserId(), "JOIN", "È¸¿ø°¡ÀÔ ¼º°ø", userIp);

	    // ¼º°ø ½Ã¿¡¸¸ ¼º°ø ÆäÀÌÁö·Î ÀÌµ¿
	    mav.setViewName("layout/join-success"); 
	    return mav;
	}
	
	
	@RequestMapping(value = "/goLoginPage")
	public ModelAndView goLoginPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/login-page");

		return mav;
	}

	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> loginProcess(
	        @RequestParam("userId") String userId,  
	        @RequestParam("password") String password,  
	        HttpSession session,  
	        HttpServletRequest request) {

	    Map<String, Object> result = new HashMap<>();
	    String userIp = request.getRemoteAddr();
	    LocalDateTime now = LocalDateTime.now();

	    try {
	        // 1. »ç¿ëÀÚ Á¸Àç ¿©ºÎ È®ÀÎ 
	        UserVO loginUser = memberService.getMember(userId);
	        if (loginUser == null) {
	            logService.saveLog(userId, "LOGIN_FAIL", "¾ÆÀÌµð Á¸ÀçÇÏÁö ¾ÊÀ½", userIp);
	            result.put("message", "µî·ÏµÇÁö ¾ÊÀº °èÁ¤ÀÔ´Ï´Ù.");
	            return new ResponseEntity<>(result, HttpStatus.NOT_FOUND);
	        }

	        // 2. Á¤Ã¥ ¹× ¼³Á¤ Á¤º¸ ·Îµå
	        UserPolicyVO policy = memberService.getUserPolicyById(loginUser.getUserId());
	        SiteConfigVO config = adminService.getSiteConfig();
	        String tempLockSetting = config.getUseTempLock(); // "on" ¶Ç´Â null/off

	        // 3. ÇöÀç °èÁ¤ÀÌ Àá±Ý »óÅÂÀÎÁö È®ÀÎ 
	        if (policy.getLoginFail() >= 5) {
	            if ("on".equals(tempLockSetting) && policy.getUntilLock() != null && now.isBefore(policy.getUntilLock())) {
	                // ÀÓ½Ã Àá±Ý ÁøÇà Áß
	                long remainingMin = java.time.Duration.between(now, policy.getUntilLock()).toMinutes() + 1;
	                result.put("message", "ºñ¹Ð¹øÈ£ ¿À·ù·Î ÀÓ½Ã Àá±ÝµÈ °èÁ¤ÀÔ´Ï´Ù. ¾à " + remainingMin + "ºÐ ÈÄ ´Ù½Ã ½ÃµµÇÏ¼¼¿ä.");
	                result.put("status", 100);
	                return new ResponseEntity<>(result, HttpStatus.FORBIDDEN);
	            } else if (!"on".equals(tempLockSetting)) {
	                // ¿µ±¸ Àá±Ý »óÅÂ (°ü¸®ÀÚ È®ÀÎ ÇÊ¿ä)
	                result.put("message", "ºñ¹Ð¹øÈ£ 5È¸ ¿À·ù·Î °èÁ¤ÀÌ Àá°å½À´Ï´Ù. °ü¸®ÀÚ¿¡°Ô ¹®ÀÇÇÏ¼¼¿ä.");
	                return new ResponseEntity<>(result, HttpStatus.FORBIDDEN);
	            }
	        }

	        // 4. ºñ¹Ð¹øÈ£ °ËÁõ ½Ãµµ
	        loginUser.setPassword(password);
	        UserVO authUser = memberService.login(loginUser);

	        // --- ·Î±×ÀÎ ½ÇÆÐ Ã³¸® (ºñ¹Ð¹øÈ£ ºÒÀÏÄ¡) ---
	        if (authUser == null) {
	            int newFailCount = memberService.increaseFailCount(userId);
	            
	            if (newFailCount >= 5) {
	                if ("on".equals(tempLockSetting)) {
	                    memberService.updateUntilLock(userId); // ÇöÀç½Ã°£ + 5ºÐ ¼³Á¤
	                    result.put("message", "ºñ¹Ð¹øÈ£ 5È¸ ¿À·ù·Î 5ºÐ°£ °èÁ¤ÀÌ ÀÓ½Ã Àá±ÝµÇ¾ú½À´Ï´Ù.");
	                } else {
	                    result.put("message", "ºñ¹Ð¹øÈ£ 5È¸ ¿À·ù·Î °èÁ¤ÀÌ Àá°å½À´Ï´Ù.");
	                }
	                logService.saveLog(userId, "LOGIN_LOCK", "ºñ¹Ð¹øÈ£ 5È¸ ¿À·ù·Î Àá±Ý Àû¿ë", userIp);
	                return new ResponseEntity<>(result, HttpStatus.FORBIDDEN);
	            }
	            
	            logService.saveLog(userId, "LOGIN_FAIL", "ºñ¹Ð¹øÈ£ ºÒÀÏÄ¡ (" + newFailCount + "È¸)", userIp);
	            result.put("message", "¾ÆÀÌµð ¶Ç´Â ºñ¹Ð¹øÈ£°¡ ¸ÂÁö ¾Ê½À´Ï´Ù. (½ÇÆÐ È½¼ö: " + newFailCount + "/5)");
	            return new ResponseEntity<>(result, HttpStatus.UNAUTHORIZED);
	        }

	        // --- ·Î±×ÀÎ ¼º°ø Ã³¸® ---
	        // 5. ÈÞ¸é °èÁ¤ Ã¼Å©
	        if (authUser.getDormantId() != null && authUser.getDormantId() != 0) {
	            logService.saveLog(userId, "DORMANT_ACCESS", "ÈÞ¸é °èÁ¤ Á¢¼Ó ½Ãµµ", userIp);
	            result.put("status", "DORMANT");
	            result.put("message", "ÈÞ¸é »óÅÂÀÎ °èÁ¤ÀÔ´Ï´Ù. ¾È³» ÆäÀÌÁö·Î ÀÌµ¿ÇÕ´Ï´Ù.");
	            return new ResponseEntity<>(result, HttpStatus.OK);
	        }

	        // 6. °³ÀÎÁ¤º¸ Àçµ¿ÀÇ Ã¼Å© (1³â ÁÖ±â)
	        LocalDateTime lastAgreed = policy.getLastAgreement().toInstant()
	                .atZone(ZoneId.systemDefault()).toLocalDateTime();
	        
	        if (lastAgreed.isBefore(now.minusYears(1))) {
	            session.setAttribute("RE_AGREE_REQUIRED", true);
	            result.put("status", "needReAgree");
	            result.put("message", "°³ÀÎÁ¤º¸ È°¿ë Àçµ¿ÀÇ°¡ ÇÊ¿äÇÕ´Ï´Ù.");
	        } else {
	            result.put("status", "success");
	            result.put("message", "·Î±×ÀÎ ¼º°ø");
	        }

	        // 7. ¼º°ø ½Ã °øÅë Ã³¸® (½ÇÆÐ È½¼ö ÃÊ±âÈ­, ¼¼¼Ç ÀúÀå)
	        memberService.resetFailCount(userId);
	        session.setAttribute("loginUser", authUser);
	        logService.saveLog(userId, "LOGIN", "·Î±×ÀÎ ¼º°ø", userIp);

	        // °ü¸®ÀÚ ±ÇÇÑ È®ÀÎ
	        if (memberService.selectAdminById(userId) >= 1) {
	            session.setAttribute("admin", true);
	            result.put("status", "admin");
	        }

	        return new ResponseEntity<>(result, HttpStatus.OK);

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("message", "½Ã½ºÅÛ ¿À·ù°¡ ¹ß»ýÇß½À´Ï´Ù.");
	        return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	// ÈÞ¸é°èÁ¤ÀüÈ¯À» À§ÇÑ ÀÌ¸ÞÀÏ ÀÎÁõÄÚµå ÀÚµ¿ º¸³»±â
	@RequestMapping("/goActivateUser")
	public ModelAndView goActivateUser (@RequestParam("userId") String userId,
										HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		UserVO dormantUser = memberService.getDormantUserById(userId);
		String authCode = memberService.sendAuthCode(dormantUser.getEmail());
		
		mav.addObject("userId", userId);
		mav.setViewName("/layout/dormant-auth");
	    if(authCode != null) {
	        // ¼¼¼Ç¿¡ ÀÎÁõÄÚµå¸¦ ÀúÀåÇØµÒ (³ªÁß¿¡ ºñ±³¿ë)
	        session.setAttribute("authCode", authCode);
	        // ¼¼¼Ç À¯È¿½Ã°£ ¼³Á¤ (¿¹: 3ºÐ = 180ÃÊ)
	        session.setMaxInactiveInterval(180); 
	        return mav;
	    } else {
	    	throw new Exception("ÀÌ¸ÞÀÏ ÀÎÁõ ¼­ºñ½º°¡ ÀÀ´äÇÏÁö ¾Ê½À´Ï´Ù.");        
	    }	
	}
	
	@RequestMapping(value = "/resendAuthCode", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> resendAuthCode(@RequestParam("userId") String userId, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        UserVO dormantUser = memberService.getDormantUserById(userId);
	        String newAuthCode = memberService.sendAuthCode(dormantUser.getEmail());
	        
	        if (newAuthCode != null) {
	            session.setAttribute("authCode", newAuthCode);
	            session.setMaxInactiveInterval(600); // 3ºÐ °»½Å
	            
	            result.put("message", "ÀÎÁõ¹øÈ£°¡ Àç¹ß¼ÛµÇ¾ú½À´Ï´Ù.");
	            // 200 OK: Ç¥ÁØ ¼º°ø ÄÚµå
	            return new ResponseEntity<>(result, HttpStatus.OK); 
	        } else {
	            result.put("message", "ÀÎÁõ¹øÈ£ »ý¼º¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
	            // 400 Bad Request: Å¬¶óÀÌ¾ðÆ®ÀÇ ¿äÃ»ÀÌ Àß¸øµÇ¾ú°Å³ª Ã³¸®°¡ ºÒ°¡´ÉÇÒ ¶§
	            return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	        }
	    } catch (Exception e) {
	        result.put("message", "¼­¹ö ¿À·ù: " + e.getMessage());
	        // 500 Internal Server Error: ¼­¹ö ³»ºÎ ·ÎÁ÷ Áß ¿¹¿Ü ¹ß»ý ½Ã
	        return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@RequestMapping ("/verifyDormantAuthCode")
	public ModelAndView verifyCode (@RequestParam("authCode") String inputCode,
									@RequestParam("userId") String userId,
									HttpServletRequest request,
									HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		String userIp = request.getRemoteAddr();
		String realCode = (String) session.getAttribute("authCode");
		if (realCode == null) {
			mav.setViewName("redirect:/member/goActivateUser");
	        return mav;
	        }
		if(realCode != null && realCode.equals(inputCode)) {
			memberService.activateDormantUser(userId);
			session.removeAttribute("authCode");
			mav.addObject("userId", userId);
			mav.setViewName("/layout/dormant-success");
			logService.saveLog(userId, "RESTORE_DORMANT", "ÈÞ¸é°èÁ¤ º¹±¸", userIp);
			return mav;
		}
		throw new Exception("ÈÞ¸é°èÁ¤ÀüÈ¯ÀÌ ½ÇÆÐÇÏ¿´½À´Ï´Ù.");
	}
	

	// ·Î±×¾Æ¿ô (¼¼¼Ç »èÁ¦)
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session, HttpServletRequest request) {
		// ¼¼¼Ç¿¡ ÀúÀåµÈ ¸ðµç Á¤º¸ »èÁ¦ (·Î±×¾Æ¿ô Ã³¸®)
		ModelAndView mav = new ModelAndView();
		String userIp = request.getRemoteAddr();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser != null) {
			logService.saveLog(loginUser.getUserId(), "LOGOUT", "·Î±×¾Æ¿ô ¼º°ø", userIp);
		}
		mav.setViewName("redirect:/default");
		session.invalidate();
		return mav; // ¸ÞÀÎÀ¸·Î ÀÌµ¿
	}

	// È¸¿øÁ¤º¸ ¼öÁ¤ ÆäÀÌÁö ÀÌµ¿
	@RequestMapping("/memberUpdate")
	public ModelAndView memberUpdate(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		UserVO userInfo = memberService.getMember(loginUser.getUserId());

		// ÁÖ¼Ò ºÐ¸®ÇØ¼­ ³Ö±â
		String dbAddress = userInfo.getAddress();

		String zip = "";
		String addr = "";

		if (dbAddress != null && dbAddress.contains("(") && dbAddress.contains(")")) {
			int start = dbAddress.indexOf("(");
			int end = dbAddress.indexOf(")");

			// ¿ìÆí¹øÈ£ ÃßÃâ; °ýÈ£ »çÀÌÀÇ °ª
			zip = dbAddress.substring(start + 1, end);
			// ÁÖ¼Ò ÃßÃâ
			addr = dbAddress.substring(end + 1).trim();
		}
		// ºÐ¸®ÇÑ °ªÀ» jsp·Î Àü´Þ
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

		// ¿ìÆí¹øÈ£°¡ ÀÖ´Â °æ¿ì¿¡¸¸ °ýÈ£¿Í ÇÔ²² Ãß°¡
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

	

	// ¾ÆÀÌµð Ã£±â ±¸Çö
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

		// ÀÔ·Â°ª ´©¶ô Ã¼Å© (¼­¹ö´Ü ´õºí Ã¼Å©)
		if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
			return new ResponseEntity<>("ÀÌ¸§°ú ÀÌ¸ÞÀÏÀ» ÀÔ·ÂÇØÁÖ¼¼¿ä.", HttpStatus.BAD_REQUEST); // 400
		}

		try {
			//ÀÌ¸ÞÀÏ·Î È¸¿ø Á¤º¸ Ã£±â
			UserVO user = memberService.findUserByEmail(email);

			// È¸¿øÀÌ ¾ø°Å³ª, ÀÔ·ÂÇÑ 'ÀÌ¸§'°ú DBÀÇ 'ÀÌ¸§'ÀÌ ´Ù¸£¸é ½ÇÆÐ Ã³¸®
			if (user == null || !user.getName().equals(name)) {
				return new ResponseEntity<>("ÀÏÄ¡ÇÏ´Â È¸¿øÀÌ ¾ø½À´Ï´Ù.", HttpStatus.NOT_FOUND); // 404
			}

			// ÀÎÁõÄÚµå »ý¼º ¹× ¹ß¼Û
			String authCode = memberService.sendAuthCode(email);

			if (authCode != null) {
				
				session.setAttribute("authCode", authCode);

				session.setMaxInactiveInterval(600); 

				return new ResponseEntity<>("success", HttpStatus.OK); // 200
			} else {
				return new ResponseEntity<>("¸ÞÀÏ ¹ß¼Û Áß ¼­¹ö ¿À·ù ¹ß»ý", HttpStatus.INTERNAL_SERVER_ERROR); // 500
			}

		} catch (Exception e) {
			// ¸ÞÀÏ ¹ß¼Û Áß SMTP ¼­¹ö ¿¡·¯ µîÀÌ ¹ß»ýÇßÀ» ¶§ ¸ØÃßÁö ¾Ê°í ½ÇÆÐ ¸Þ½ÃÁö ¸®ÅÏ
			e.printStackTrace();
			return new ResponseEntity<>("¸ÞÀÏ ¼­¹ö¿ÍÀÇ Åë½Å ¹®Á¦·Î ¹ß¼Û¿¡ ½ÇÆÐÇß½À´Ï´Ù.", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@ResponseBody // ¹®ÀÚ¿­¸¸ ¹ÝÈ¯
	@RequestMapping("/checkAuthCode")
	public ResponseEntity<String> checkAuthCode(@RequestParam("inputCode") String inputCode, 
												@RequestParam("userId") String userId,
												HttpSession session) {

		String realCode = (String) session.getAttribute("authCode");
		
		if (realCode == null) {
	        return ResponseEntity.status(HttpStatus.GONE) // 410 ¿¡·¯
	                             .body("ÀÎÁõ ½Ã°£ÀÌ ¸¸·áµÇ¾ú½À´Ï´Ù. ÀÎÁõ¹øÈ£¸¦ ´Ù½Ã ¹Þ¾ÆÁÖ¼¼¿ä.");
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

		// ÀÌ¸§°ú ÀÌ¸ÞÀÏ·Î DB Á¶È¸
		UserVO resultUser = memberService.findId(name, email); // Service¿¡ ÀÌ ¸Þ¼­µå ÇÊ¿ä (ÀÌÀü ´äº¯ ÂüÁ¶)

		if (resultUser != null) {
			mv.addObject("resultUser", resultUser);
			mv.setViewName("/layout/find-idResult"); // °á°ú JSP·Î ÀÌµ¿
		} else {
			mv.addObject("msg", "ÀÏÄ¡ÇÏ´Â È¸¿ø Á¤º¸°¡ ¾ø½À´Ï´Ù.");
			mv.setViewName("redirect:/member/goFindId"); // ´Ù½Ã ÀÔ·ÂÃ¢À¸·Î
		}

		return mv;
	}

	// ºñ¹Ð¹øÈ£ Ã£±â ½ÃÀÛ
	@RequestMapping("/goFindPw")
	public ModelAndView FindIdProcess() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/find-pw");
		return mav;
	}

	// ÀÎÁõ¹øÈ£ È®ÀÎÀº ¾ÆÀÌµð Ã£±â¶û ¶È°°Àº api¸¦ È°¿ëÇÔ
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

	    // ¸ÞÀÏ ¹ß¼Û ¹× ÀÎÁõÄÚµå »ý¼º
	    String authCode = memberService.sendAuthCode(email);

	    if (authCode != null) {
	        // ¼¼¼Ç ÀúÀå ·ÎÁ÷
	        session.setAttribute("authCode", authCode);
	        session.setMaxInactiveInterval(180); // 3ºÐ

	        // 200 OK: ¼º°ø
	        return ResponseEntity.ok("success");
	    } else {
	        // 500 Internal Server Error: ¸ÞÀÏ ¹ß¼Û ½ÇÆÐ
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body("¸ÞÀÏ ¹ß¼Û Áß ¿À·ù°¡ ¹ß»ýÇß½À´Ï´Ù. Àá½Ã ÈÄ ´Ù½Ã ½ÃµµÇØÁÖ¼¼¿ä.");
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
	        // 403 Forbidden »óÈ²: ¸ÞÀÎÀÌ³ª ¿¡·¯ ÆäÀÌÁö·Î ¸®´ÙÀÌ·ºÆ®
	        mav.setViewName("redirect:/member/findPw?error=unauthorized");
	        return mav;
	    }

	    mav.setViewName("/layout/reset-pw");
	    mav.addObject("userId", userId);
	    return mav;
	}
	// ºñ¹Ð¹øÈ£ Àç¼³Á¤·ÎÁ÷ÀÔ´Ï´Ù.
	// ¿¹¿ÜÃ³¸® ÇÊ¿äÇÔ µ¥ÀÌÅÍ¸¦ ³Ö´Â °æ¿ì
	@RequestMapping("/resetPwProcess")
	public ModelAndView resetPwProcess(@RequestParam("userPw") String password, @RequestParam("userId") String userId) {
		ModelAndView mav = new ModelAndView();

		// ºñ¹Ð¹øÈ£ Á¤±Ô½Ä Ã¼Å© (9~25ÀÚ, ¿µ¹®+¼ýÀÚ+Æ¯¼ö¹®ÀÚ)
		String pwRegex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,25}$";
		if (!Pattern.matches(pwRegex, password)) {
			mav.addObject("msg", "Àß¸øµÈ Á¢±ÙÀÔ´Ï´Ù. ºñ¹Ð¹øÈ£ º¸¾È ±ÔÄ¢À» ÁöÄÑÁÖ¼¼¿ä.");
			mav.setViewName("redirect:/member/resetPwPage");
			return mav;
		}
		
		int result = memberService.updateUserPw(userId, password);
		if (result > 0) {
			// ¼º°ø (1°³ ÀÌ»óÀÇ ÇàÀÌ ¾÷µ¥ÀÌÆ®µÊ)
			System.out.println("ºñ¹Ð¹øÈ£ º¯°æ ¼º°ø!");
			mav.setViewName("/layout/reset-pwsuccess");

		} else {
			// ½ÇÆÐ (¾÷µ¥ÀÌÆ®µÈ ÇàÀÌ ¾øÀ½ -> ¾ÆÀÌµð°¡ Àß¸øµÇ¾ú°Å³ª DB ¿À·ù)
			System.out.println("ºñ¹Ð¹øÈ£ º¯°æ ½ÇÆÐ");

			// ½ÇÆÐ ¸Þ½ÃÁö¸¦ ´ã¾Æ¼­ ´Ù½Ã ºñ¹Ð¹øÈ£ º¯°æ ÆäÀÌÁö(¶Ç´Â ¿¡·¯ÆäÀÌÁö)·Î º¸³¿
			mav.addObject("msg", "ºñ¹Ð¹øÈ£ º¯°æ¿¡ ½ÇÆÐÇß½À´Ï´Ù. ´Ù½Ã ½ÃµµÇØÁÖ¼¼¿ä.");

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

	// È¸¿øÅ»Åð ÇÁ·Î¼¼½º
	// Á÷Á¢ÀûÀÎ Æ®·£Àè¼Ç ±¸ÇöÀº impl¿¡ ±¸ÇöÇßÀ½
	@RequestMapping("/memberDeleteProcess")
	public ModelAndView memberDeleteProcess(HttpSession session, UserVO userVO, @RequestParam("reason") String reason,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String userIp = request.getRemoteAddr();
		try {
			boolean isSuccess = memberService.withdrawProcess(userVO, reason);

			if (isSuccess) {
				logService.saveLog(userVO.getUserId(), "WITHDRAW", "È¸¿ø Å»Åð Ã³¸®", userIp);
				session.invalidate();
				mav.addObject("msg", "Å»ÅðµÇ¾ú½À´Ï´Ù.");
				mav.addObject("url", "/main");
				mav.setViewName("/layout/member-deletesuccess");

			} else {
				mav.addObject("msg", "ºñ¹Ð¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù.");
				mav.setViewName("redirect:/member/goMemberDelete");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("msg", "½Ã½ºÅÛ ¿À·ù·Î Å»Åð¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
			mav.setViewName("redirect:/member/goMemberDelete");
		}
		return mav;
	}
	
	// ·Î±×ÀÎ Àá±Ý ½ÇÆÐ ÀÌ¸ÞÀÏ ÀÎÁõ ÆäÀÌÁö·Î ÀÌµ¿
	@RequestMapping("/goUnlockAuth")
	public ModelAndView goUnlockAuth (UserVO userVO) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("userVO", userVO);
		mav.setViewName("/layout/unlock-login");
		
		return mav;
		
	}
	
	// ·Î±×ÀÎ Àá±Ý ÇØÁ¦ ÀÌ¸ÞÀÏ ÀÎÁõ ¹ß¼Û
	@ResponseBody
	@RequestMapping(value = "/sendUnlockAuthCode", method = RequestMethod.POST)
	public ResponseEntity<String> sendUnlockAuthCode(@RequestParam("userId") String userId,
													@RequestParam("email") String email,
													UserVO userVO, HttpSession session) {
		
		userVO.setUserId(userId);
		userVO.setEmail(email);
	    UserVO member = memberService.findLoginFailUser(userVO); 
	    if (member == null) {
	        // ÇØ´ç Á¤º¸¿Í ÀÏÄ¡ÇÏ´Â À¯Àú°¡ ¾ø°Å³ª Àá±Ý »óÅÂ°¡ ¾Æ´Ò ¶§
	        return new ResponseEntity<>("fail_no_user", HttpStatus.NOT_FOUND);
	    }
	    try {
	    	String authcode = memberService.sendAuthCode(userVO.getEmail());
	        
	        session.setAttribute("authCode", authcode);
	        session.setAttribute("unlockTargetId", userVO.getUserId());
	        session.setMaxInactiveInterval(180); // 3ºÐ¸¸ À¯È¿
	        return new ResponseEntity<>("success", HttpStatus.OK);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ResponseEntity<>("fail_send", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	// ·Î±×ÀÎ Àá±Ý ÇØÁ¦ 
	@RequestMapping(value = "/unlockAccount")
	public ModelAndView unlockAccount (HttpSession session, UserVO userVO, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String userIp = request.getRemoteAddr();
		// º¸¾ÈÃ³¸®°¡ ÇÊ¿äÇÑ °ÍÀÏ±î? unlockTargetId==verifiedUserId ?
		String userId =(String) session.getAttribute("verifiedUserId");
		userVO.setUserId(userId);
		memberService.recoverLoginFail(userVO.getUserId());
		logService.saveLog(userId, "RESTORE LOGIN FAIL", "·Î±×ÀÎ Àá±èÇØÁ¦ ¼º°ø", userIp);
		
		mav.setViewName("/layout/unlock-loginsuccess");
		
		return mav;
	}
	
	@RequestMapping (value = "/goReAgreePage")
	public ModelAndView goReAgreePage (HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/layout/re-agree");
		return mav;
	}
	
	@RequestMapping (value="/updateReAgree")
	public ModelAndView updateReAgree (HttpSession session, 
							HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		String userIp = request.getRemoteAddr();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		if (loginUser != null) {
			try {
				memberService.updateLastAgreement(loginUser.getUserId());
				loginUser.setLastAgreement(new java.util.Date());
				logService.saveLog(userId, "RE_AGREE", "¾à°ü Àçµ¿ÀÇ ¿Ï·á", userIp);
				session.removeAttribute("RE_AGREE_REQUIRED");
			}catch (Exception e) {
	            e.printStackTrace();
	            throw new Exception();
	            }
		}
		
		mav.setViewName("redirect:/goMain");
		return mav;
	}
	
}
