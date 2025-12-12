package com.ubintis.board.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.BoardService;
import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.UserVO;

@Controller
@RequestMapping ("/clip")
public class ClipController {
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private BoardService boardservice;
	
	//글쓰는 페이지로 가는 API 
	// 비회원은 출입이 안되기 때문에 이를 막아놓는 로직을 입력해놓았습니다.
	@RequestMapping ("/goWrite")
	public ModelAndView goWriteClip (HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		//이전 로그인 api에서 session에 저장해놓은 회원정보를 바탕으로 회원로직을 구현했습니다.
		if (loginUser==null) {
			mav.setViewName("redirect:/member/goLoginPage");
			return mav;
		}
		UserVO userInfo = memberservice.getMember(loginUser.getUserId());
		mav.addObject("userInfo", userInfo);
		mav.setViewName("/layout/write");
		return mav;	
	}
	
	@ResponseBody
	@RequestMapping("/clip/write") // JSP 경로와 맞춤
	public String writeClip(HttpSession session, 
	                        MainBoardVO vo, 
	                        @RequestParam(value="uploadFile", required=false) MultipartFile uploadFile) {
	                        
	    String msg = "";
	    
	    try {
	        // 파일 업로드 처리 로직
	        if (uploadFile != null && !uploadFile.isEmpty()) {
	            // 저장할 경로 설정 (예: 웹루트/resources/upload 또는 외부 경로)
	            String uploadFolder = session.getServletContext().getRealPath("/static/upload/");
	            File dir = new File(uploadFolder);
	            if (!dir.exists()) {
	                dir.mkdirs(); // 폴더가 없으면 생성
	            }

	            // 파일명 중복 방지를 위한 UUID 적용
	            String originalFileName = uploadFile.getOriginalFilename();
	            String uuid = UUID.randomUUID().toString();
	            String savedFileName = uuid + "_" + originalFileName;
	            
	            // 서버에 파일 저장
	            File saveFile = new File(uploadFolder, savedFileName);
	            uploadFile.transferTo(saveFile);

	            // 2. VO에 저장된 파일 경로(또는 파일명) 세팅
	            vo.setFilePath("/static/upload/" + savedFileName); 
	            // 혹은 vo.setFileName(originalFileName); 등 DB 구조에 맞게 설정
	        }

	        // 3. 작성자 정보 세팅 (세션이 있다면)
	        // MemberVO user = (MemberVO) session.getAttribute("loginUser");
	        // if(user != null) vo.setWriter(user.getName());

	        // 4. DB 저장
	        int result = boardservice.insertClip(vo);

	        if (result >= 1) {
	            msg = "글이 정상 저장되었습니다.";
	        } else {
	            msg = "글 저장 실패, 관리자에게 문의 하세요.";
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        msg = "에러 발생: " + e.getMessage();
	    }
	    
	    return msg;
	}
	
	
}
