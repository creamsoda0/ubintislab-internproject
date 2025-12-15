package com.ubintis.board.service;

import java.util.List;

import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.MainCommentVO;
import com.ubintis.board.vo.PagingVO;
import com.ubintis.board.vo.SubCommentVO;

public interface BoardService {

	int insertClip(MainBoardVO vo);

	List<MainBoardVO> getClipList(PagingVO paging);

	int getTotalCount(PagingVO paging);

	MainBoardVO getClipById(int boardId);

	List<MainCommentVO> getCommentListById(int boardId);

	List<SubCommentVO> getAllSubCommentListById(int boardId);

	void deleteClipById(int boardId);

	void updateClipById(MainBoardVO mainVO);

	void insertMainComment(MainCommentVO maincommentVO);

	void writeSubComment(SubCommentVO subcommentVO);

}
