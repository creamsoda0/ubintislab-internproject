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
	@RequestMapping ("/goWrite")
	public ModelAndView goWriteClip (HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		UserVO userInfo = memberservice.getMember(loginUser.getUserId());
		mav.addObject("userInfo", userInfo);
		mav.setViewName("/layout/write");
		return mav;	
	}
	
	@ResponseBody
	@RequestMapping(value="/write", produces = "text/plain;charset=UTF-8") 
	public String writeClip(HttpSession session, 
	                        MainBoardVO vo, 
	                        @RequestParam(value="uploadFile", required=false) MultipartFile uploadFile) {               
	    String msg = "";   
	 // 파일 업로드 처리 로직
	    try {
	        if (uploadFile != null && !uploadFile.isEmpty()) {
	            // 저장할 경로 설정  webcontext/resources/upload 
	            String uploadFolder = session.getServletContext().getRealPath("/static/upload/");
	            File dir = new File(uploadFolder);
	            if (!dir.exists()) {
	                dir.mkdirs(); // 폴더가 없으면 생성
	            }
	            // 로그인 유저를 세션에서 불러옴
	            UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	            if (loginUser != null) { 
	                vo.setUserId(loginUser.getUserId()); 
	                System.out.println("작성자 ID 주입 완료: " + vo.getUserId()); // 로그 확인용
	            } else {
	                return "로그인이 필요합니다."; // 로그인이 안 되어있으면 돌려보냄
	            }
	            // 파일명 중복 방지를 위한 UUID 적용
	            String originalFileName = uploadFile.getOriginalFilename();
	            String uuid = UUID.randomUUID().toString();
	            String savedFileName = uuid + "_" + originalFileName;
	            
	            // 서버에 파일 저장
	            File saveFile = new File(uploadFolder, savedFileName);
	            uploadFile.transferTo(saveFile);

	            // VO에 저장된 파일 경로(또는 파일명) 세팅
	            vo.setFilePath("/static/upload/" + savedFileName); 
	        }
	        // DB 저장
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
