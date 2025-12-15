package com.ubintis.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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

	

}
