package com.ubintis.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ubintis.board.service.BoardService;
import com.ubintis.board.service.MemberService;
import com.ubintis.board.vo.FileVO;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.MainCommentVO;
import com.ubintis.board.vo.SubCommentVO;
import com.ubintis.board.vo.UserVO;

@Controller
@RequestMapping("/clip")
public class ClipController {

	@Autowired
	private MemberService memberservice;

	@Autowired
	private BoardService boardservice;

	// 글쓰는 페이지로 가는 API
	@RequestMapping("/goWrite")
	public ModelAndView goWriteClip(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		UserVO userInfo = memberservice.getMember(loginUser.getUserId());
		mav.addObject("userInfo", userInfo);
		mav.setViewName("/layout/write");
		return mav;
	}

	@ResponseBody // AJAX 통신이므로 필수!
    @RequestMapping(value = "/write", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public String writeClip(
            HttpSession session, 
            MainBoardVO vo, 
            @RequestParam(value="uploadFiles", required=false) List<MultipartFile> uploadFiles
    ) {
        String msg = "";

        try {
            // 1. 세션에서 로그인 사용자 정보 가져오기 (안전장치)
            UserVO loginUser = (UserVO) session.getAttribute("loginUser");
            if (loginUser != null) {
                vo.setUserId(loginUser.getUserId());
            } else {
                return "로그인이 필요합니다.";
            }

            // 2. 서비스 호출 (핵심!)
            // ★ 여기서 게시글 저장 + 파일 저장 + DB 등록이 '한 방'에 처리됨
            // ★ 트랜잭션도 Service 안에서 알아서 처리됨
            boardservice.insertClip(vo, uploadFiles);

            msg = "게시글이 정상적으로 저장되었습니다.";

        } catch (Exception e) {
            e.printStackTrace();
            msg = "에러 발생: " + e.getMessage();
        }

        return msg;
    }

	// 파일 다운로드 로직
	@RequestMapping("/download")
	public void download(@RequestParam("filePath") String filePath, HttpServletResponse response) throws Exception {

		// 1. DB에 저장된 경로: "/static/upload/uuid_파일명.jpg"
		// 우리가 필요한 건 실제 파일명인 "uuid_파일명.jpg" 부분임
		// 경로에서 파일명만 잘라냄
		String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);

		// 2. 실제 물리적 파일 경로 (아까 설정한 D드라이브 경로)
		// 주의: filePath 전체를 쓰는 게 아니라, 폴더 경로 + 파일명을 합쳐야 함
		String uploadFolder = "D:\\sung-min-upload";
		File file = new File(uploadFolder, fileName);

		if (!file.exists()) {
			System.out.println("파일이 존재하지 않습니다.");
			return;
		}

		// 3. 다운로드 시 보여줄 "원본 파일명" 만들기 (UUID 제거)
		// 저장될 때 "uuid_원래이름" 형식이므로, 첫 번째 "_" 뒤를 자름
		String originalName = fileName.substring(fileName.indexOf("_") + 1);

		// 4. 한글 파일명 깨짐 방지 (브라우저 호환성 처리)
		// 이 처리를 안 하면 한글 파일은 "___.___" 처럼 깨져서 나옴
		String encodedOriginalName = new String(originalName.getBytes("UTF-8"), "ISO-8859-1");

		// 5. 헤더 설정 (브라우저에게 "이건 다운로드 파일이야"라고 알려줌)
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedOriginalName + "\"");
		response.setContentLength((int) file.length());

		// 6. 파일 내보내기 (스트림 전송)
		FileInputStream fis = new FileInputStream(file);
		OutputStream os = response.getOutputStream();

		byte[] b = new byte[4096]; // 버퍼 생성
		int read = 0;
		while ((read = fis.read(b)) != -1) {
			os.write(b, 0, read);
		}

		os.flush();
		os.close();
		fis.close();
	}

	@RequestMapping("/read")
	public ModelAndView read(@RequestParam("boardId") int boardId) {
	    
	    ModelAndView mav = new ModelAndView();
	    boardservice.updateHit(boardId);
	    // 1. 게시글 상세 정보 가져오기
	    MainBoardVO mainVO = boardservice.getClipById(boardId);

	    // 2. [추가] 게시글에 첨부된 파일 리스트 가져오기 (따로 호출)
	    List<FileVO> fileList = boardservice.getFileList(boardId);

	    // 3. 댓글 리스트 가져오기
	    List<MainCommentVO> mainCommentList = boardservice.getCommentListById(boardId);
	    List<SubCommentVO> subCommentList = boardservice.getAllSubCommentListById(boardId);

	    // 4. 화면에 데이터 전달
	    mav.addObject("board", mainVO);           // 게시글 정보
	    mav.addObject("fileList", fileList);      // [추가] 파일 리스트 (이름: fileList)
	    mav.addObject("commentList", mainCommentList);
	    mav.addObject("subCommentList", subCommentList);

	    mav.setViewName("/layout/read");

	    return mav;
	}

	// 게시글 삭제 로직
	@RequestMapping("/deleteClip")
	public ModelAndView deleteClip(@RequestParam("boardId") int boardId, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		MainBoardVO board = boardservice.getClipById(boardId);

		// 로그인을 한 번 더 확인하여 취약점 방지
		if (!loginUser.getUserId().equals(board.getUserId())) {
			mav.addObject("msg", "본인의 글만 삭제할 수 있습니다.");
			mav.setViewName("redirect:/goMain");
			return mav;
		}

		boardservice.deleteClipById(boardId);
		mav.setViewName("redirect:/goMain");

		return mav;
	}

	// 게시글 수정 페이지로 가는 로직
	@RequestMapping("/goModify")
	public ModelAndView goModify(@RequestParam("boardId") int boardId) {
		ModelAndView mav = new ModelAndView();
		MainBoardVO mainboardVO = boardservice.getClipById(boardId);
		List<FileVO> fileList = boardservice.getFileList(boardId);
		mav.addObject("fileList", fileList);
		mav.addObject("board", mainboardVO);
		mav.setViewName("/layout/modify");
		return mav;
	}

	@ResponseBody // AJAX 응답 필수
	@RequestMapping(value = "/updateClip", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String updateClip(
	        MainBoardVO mainVO, 
	        HttpSession session,
	        // 1. 새로 추가된 파일들
	        @RequestParam(value = "uploadFiles", required = false) List<MultipartFile> uploadFiles,
	        // 2. 삭제할 기존 파일들의 ID 목록
	        @RequestParam(value = "deleteFileIds", required = false) List<Integer> deleteFileIds
	) {
	    try {
	        // [보안 체크 1] 로그인 여부
	        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
	        if (loginUser == null) {
	            return "로그인이 필요합니다.";
	        }

	        // [보안 체크 2] 본인 글인지 확인 (DB에서 원본 글 조회)
	        MainBoardVO originalBoard = boardservice.getClipById(mainVO.getBoardId());
	        if (originalBoard == null) {
	            return "존재하지 않는 게시글입니다.";
	        }
	        if (!loginUser.getUserId().equals(originalBoard.getUserId())) {
	            return "본인의 글만 수정할 수 있습니다.";
	        }

	        // [핵심] 서비스 호출 (게시글 수정 + 파일 추가 + 파일 삭제를 한 방에 처리)
	        // mainVO에는 boardId, title, content가 들어있음
	        boardservice.updateClip(mainVO, uploadFiles, deleteFileIds);

	        return "게시글이 정상적으로 수정되었습니다.";

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "에러 발생: " + e.getMessage();
	    }
	}

	// 댓글작성 로직
	@RequestMapping("/writeComment")
	public ModelAndView writeComment(MainCommentVO maincommentVO, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// userId 를 가져옴.
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		maincommentVO.setUserId(loginUser.getUserId());

		boardservice.insertMainComment(maincommentVO);

		mav.setViewName("redirect:/clip/read?boardId=" + maincommentVO.getBoardId());
		return mav;
	}

	// 대댓글 작성 로직
	@RequestMapping("/writeSubComment")
	public ModelAndView writeSubComment(SubCommentVO subcommentVO, @RequestParam("boardId") String boardId,
			HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// userId 를 가져옴.
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		subcommentVO.setUserId(loginUser.getUserId());

		boardservice.writeSubComment(subcommentVO);
		// 댓글이 잘달렸는지 볼려는 리다이렉트
		mav.setViewName("redirect:/clip/read?boardId=" + boardId);

		return mav;
	}

	// 댓글 삭제 로직
	@RequestMapping("/deleteComment")
	public ModelAndView deleteComment(MainCommentVO maincommentVO, HttpSession session,
			@RequestParam("boardId") int boardId) {
		ModelAndView mav = new ModelAndView();

		maincommentVO = boardservice.getMainCommentById(maincommentVO.getCommentId());

		// 삭제 로직이므로 보안상 한 번더 확인
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (!loginUser.getUserId().equals(maincommentVO.getUserId())) {
			mav.addObject("msg", "본인의 댓글만 삭제할 수 있습니다.");
			mav.setViewName("redirect:/goMain");
			return mav;
		}

		boardservice.deleteMainCommentById(maincommentVO.getCommentId());
		mav.setViewName("redirect:/clip/read?boardId=" + boardId);

		return mav;
	}

	// 대댓글 삭제 로직
	@RequestMapping("/deleteSubComment")
	public ModelAndView deleteSubComment(SubCommentVO subcommentVO, HttpSession session,
			@RequestParam("boardId") int boardId) {
		ModelAndView mav = new ModelAndView();
		subcommentVO = boardservice.getSubCommentById(subcommentVO.getSubId());

		// 삭제 로직이므로 보안상 한 번더 확인
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (!loginUser.getUserId().equals(subcommentVO.getUserId())) {
			mav.addObject("msg", "본인의 댓글만 삭제할 수 있습니다.");
			mav.setViewName("redirect:/goMain");
			return mav;
		}
		boardservice.deleteSubCommentById(subcommentVO.getSubId());
		mav.setViewName("redirect:/clip/read?boardId=" + boardId);

		return mav;
	}

}
