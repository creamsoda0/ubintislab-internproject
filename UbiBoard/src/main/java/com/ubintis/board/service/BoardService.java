package com.ubintis.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.ubintis.board.vo.FileVO;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.MainCommentVO;
import com.ubintis.board.vo.PagingVO;
import com.ubintis.board.vo.SubCommentVO;

public interface BoardService {

	void insertClip(MainBoardVO vo, List<MultipartFile> uploadFiles) throws Exception;
	
	void insertFile(FileVO fileVO);

	List<MainBoardVO> getClipList(PagingVO paging);

	int getTotalCount(PagingVO paging);

	MainBoardVO getClipById(int boardId);

	List<MainCommentVO> getCommentListById(int boardId);

	List<SubCommentVO> getAllSubCommentListById(int boardId);

	void deleteClipById(int boardId);

	void updateClipById(MainBoardVO mainVO);

	void insertMainComment(MainCommentVO maincommentVO);

	void writeSubComment(SubCommentVO subcommentVO);

	MainCommentVO getMainCommentById(int commentId);

	void deleteMainCommentById(int commentId);

	SubCommentVO getSubCommentById(int subId);

	void deleteSubCommentById(int subId);

	List<FileVO> getFileList(int boardId);

	void updateHit(int boardId);

	void updateClip(MainBoardVO mainVO, List<MultipartFile> uploadFiles, List<Integer> deleteFileIds) throws Exception;

	// 좋아요 상태 확인 (화면 진입 시 하트 색칠용)
	public boolean checkLike(int boardId, String userId);

	// 좋아요 토글 (누르면 ON/OFF) - 결과값으로 현재 상태와 카운트를 리턴
	public Map<String, Object> toggleLike(int boardId, String userId);

}
