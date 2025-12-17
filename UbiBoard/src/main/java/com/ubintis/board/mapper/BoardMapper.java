package com.ubintis.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ubintis.board.vo.FileVO;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.MainCommentVO;
import com.ubintis.board.vo.PagingVO;
import com.ubintis.board.vo.SubCommentVO;

@Mapper
public interface BoardMapper {

	int insertClip(MainBoardVO vo);

	List<MainBoardVO> getClipList(PagingVO paging);

	int getTotalCount(PagingVO paging);

	MainBoardVO getClipById(int boardId);

	List<MainCommentVO> getCommentListById(int boardId);

	List<SubCommentVO> getAllSubCommentListById(int boardId);

	void deleteSubCommentsByBoardId(int boardId);

	void deleteCommentsByBoardId(int boardId);

	void deleteBoard(int boardId);

	void updateClipById(MainBoardVO mainVO);

	void insertMainComment(MainCommentVO maincommentVO);

	void writeSubComment(SubCommentVO subcommentVO);

	MainCommentVO getMainCommentById(int commentId);

	void deleteMainCommentById(int commentId);

	void deleteSubCommentById(int commentId);

	SubCommentVO getSubCommentById(int subId);

	void deleteSubCommentBySubId(int subId);

	void insertFile(FileVO fileVO);

	List<FileVO> getFileList(int boardId);

	void updateHit(int boardId);

	FileVO getFileById(Integer fileId);

	void deleteFile(Integer fileId);

	int checkLike(@Param("boardId") int boardId, @Param("userId") String userId);
	
	void insertLike(@Param("boardId") int boardId, @Param("userId") String userId);
	
	void deleteLike(@Param("boardId") int boardId, @Param("userId") String userId);
	
	void updateLikeCount(@Param("boardId") int boardId, @Param("amount") int amount);
	
	int getLikeCount(int boardId);

}
