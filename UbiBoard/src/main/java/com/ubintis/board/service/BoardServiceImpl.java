package com.ubintis.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.BoardMapper;
import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.MainCommentVO;
import com.ubintis.board.vo.PagingVO;
import com.ubintis.board.vo.SubCommentVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
    private BoardMapper mapper;
	
	@Override
	public int insertClip(MainBoardVO vo) {
		
		return mapper.insertClip(vo);
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

}
