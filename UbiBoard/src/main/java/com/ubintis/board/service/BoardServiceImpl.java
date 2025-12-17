package com.ubintis.board.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ubintis.board.mapper.BoardMapper;
import com.ubintis.board.vo.FileVO;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.MainCommentVO;
import com.ubintis.board.vo.PagingVO;
import com.ubintis.board.vo.SubCommentVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
    private BoardMapper mapper;
	
	private static final String UPLOAD_FOLDER = "D:\\sung-min-upload\\";
	
	@Transactional // [필수] 둘 중 하나라도 실패하면 롤백되어야 함
	@Override
	public void insertClip(MainBoardVO vo, List<MultipartFile> uploadFiles) throws Exception {

	    // 1. 게시글 먼저 저장 (XML의 insertClip 실행)
	    // 이 메서드가 끝나면 vo.getBoardId()에 방금 생긴 번호가 들어와 있습니다!
	    mapper.insertClip(vo); 
	    
	    // 확인용 로그
	    System.out.println(">>>>>>>>>> 생성된 게시글 번호: " + vo.getBoardId());

	    // 2. 파일 저장 로직
	    String uploadFolder = "D:\\sung-min-upload\\"; // 설정한 경로

	    // 이제 uploadFiles를 파라미터로 받아왔으니 에러가 안 납니다.
	    if (uploadFiles != null && !uploadFiles.isEmpty()) {
	        for (MultipartFile file : uploadFiles) {
	            if (!file.isEmpty()) {
	                
	                // --- 파일 저장 (물리적) ---
	                String originalFileName = file.getOriginalFilename();
	                String uuid = UUID.randomUUID().toString();
	                String savedFileName = uuid + "_" + originalFileName;
	                
	                File saveFile = new File(uploadFolder, savedFileName);
	                file.transferTo(saveFile); // 실제 저장

	                // --- 파일 정보 저장 (DB) ---
	                FileVO fileVO = new FileVO();
	                
	                // ★ 게시글 번호 연결 (가장 중요)
	                fileVO.setBoardId(vo.getBoardId()); 
	                
	                fileVO.setOriginalName(originalFileName);
	                fileVO.setSavedName(savedFileName);
	                fileVO.setFilePath("/static/upload/" + savedFileName); // 웹 접근 경로

	                // 3. 파일 테이블에 Insert
	                mapper.insertFile(fileVO);
	            }
	        }
	    }
	}

	@Override
	public List<MainBoardVO> getClipList(PagingVO paging) {
		
		return mapper.getClipList(paging);
	}

	@Override
	public int getTotalCount(PagingVO paging) {
		
		return mapper.getTotalCount(paging);
	}

	@Override
	public MainBoardVO getClipById(int boardId) {
		// TODO Auto-generated method stub
		return mapper.getClipById(boardId);
	}

	@Override
	public List<MainCommentVO> getCommentListById(int boardId) {
		// TODO Auto-generated method stub
		return mapper.getCommentListById(boardId);
	}

	@Override
	public List<SubCommentVO> getAllSubCommentListById(int boardId) {
		// TODO Auto-generated method stub
		return mapper.getAllSubCommentListById(boardId);
	}

	@Transactional 
	@Override
	public void deleteClipById(int boardId) {
		
		//삭제 전, 해당 게시글에 첨부된 파일 목록을 먼저 가져옴
		List<FileVO> fileList = mapper.getFileList(boardId);
		
	    // 1. 대댓글 먼저 삭제 
		mapper.deleteSubCommentsByBoardId(boardId);
	    
	    // 2. 그 다음 댓글 삭제
		mapper.deleteCommentsByBoardId(boardId);
	    
		// 첨부파일이 있으면 첨부파일 삭제
        if (fileList != null && !fileList.isEmpty()) {
            for (FileVO fileVO : fileList) {
                // 저장된 파일명(UUID 포함)으로 파일 객체 생성
                File file = new File(UPLOAD_FOLDER + fileVO.getSavedName());
                
                if (file.exists()) { // 파일이 실제로 존재하면
                    if (file.delete()) {
                        System.out.println("파일 삭제 성공: " + fileVO.getSavedName());
                    } else {
                        System.err.println("파일 삭제 실패: " + fileVO.getSavedName());
                    }
                }
            }
        }

	    // 3. 마지막으로 게시글 삭제
		mapper.deleteBoard(boardId);
	}

	@Override
	public void updateClipById(MainBoardVO mainVO) {
		mapper.updateClipById(mainVO);
		
	}

	@Override
	public void insertMainComment(MainCommentVO maincommentVO) {
		// TODO Auto-generated method stub
		mapper.insertMainComment(maincommentVO);
	}

	@Override
	public void writeSubComment(SubCommentVO subcommentVO) {
		// TODO Auto-generated method stub
		mapper.writeSubComment(subcommentVO);
	}

	@Override
	public MainCommentVO getMainCommentById(int commentId) {
		// TODO Auto-generated method stub
		return mapper.getMainCommentById(commentId);
	}
	
	@Transactional
	@Override
	public void deleteMainCommentById(int commentId) {
		// TODO Auto-generated method stub
		mapper.deleteSubCommentById(commentId);
		mapper.deleteMainCommentById(commentId);
	}

	@Override
	public SubCommentVO getSubCommentById(int subId) {
		// TODO Auto-generated method stub
		return mapper.getSubCommentById(subId);
	}

	@Override
	public void deleteSubCommentById(int subId) {
		// TODO Auto-generated method stub
		mapper.deleteSubCommentBySubId(subId);
	}

	@Override
	public void insertFile(FileVO fileVO) {
		// TODO Auto-generated method stub
		mapper.insertFile(fileVO);
	}

	@Override
	public List<FileVO> getFileList(int boardId) {
		// TODO Auto-generated method stub
		return mapper.getFileList(boardId);
	}

	@Override
	public void updateHit(int boardId) {
		// TODO Auto-generated method stub
		mapper.updateHit(boardId);
	}

	@Transactional // 트랜잭션 필수! (도중에 에러나면 파일 삭제/추가도 롤백)
	@Override
	public void updateClip(MainBoardVO vo, List<MultipartFile> uploadFiles, List<Integer> deleteFileIds) throws Exception {
	    
	    //  게시글 정보(제목, 내용) 수정
	    mapper.updateClipById(vo); 

	    //  [파일 삭제 로직] 사용자가 삭제 버튼 누른 파일들 지우기
		
	    if (deleteFileIds != null && !deleteFileIds.isEmpty()) {
	        for (Integer fileId : deleteFileIds) {
	            // DB에서 파일 정보 조회 (저장된 이름을 알아야 삭제 가능)
	            FileVO fileVO = mapper.getFileById(fileId); 
	            
	            if (fileVO != null) {
	                // 실제 파일 삭제
	                File file = new File(UPLOAD_FOLDER + fileVO.getSavedName());
	                if (file.exists()) {
	                    file.delete();
	                }
	                // DB에서 파일 기록 삭제
	                mapper.deleteFile(fileId); 
	            }
	        }
	    }

	    // 3. [파일 추가 로직] 새로 업로드한 파일들 저장 (Write 로직과 동일)
	    if (uploadFiles != null && !uploadFiles.isEmpty()) {
	        for (MultipartFile file : uploadFiles) {
	            if (!file.isEmpty()) {
	                String originalFileName = file.getOriginalFilename();
	                String uuid = UUID.randomUUID().toString();
	                String savedFileName = uuid + "_" + originalFileName;
	                
	                // 파일 저장
	                File saveFile = new File(UPLOAD_FOLDER, savedFileName);
	                if (!saveFile.getParentFile().exists()) {
	                    saveFile.getParentFile().mkdirs();
	                }
	                file.transferTo(saveFile);

	                // DB 저장
	                FileVO fileVO = new FileVO();
	                fileVO.setBoardId(vo.getBoardId());
	                fileVO.setOriginalName(originalFileName);
	                fileVO.setSavedName(savedFileName);
	                fileVO.setFilePath("/static/upload/" + savedFileName);
	                
	                mapper.insertFile(fileVO);
	            }
	        }
	    }
	}




}
