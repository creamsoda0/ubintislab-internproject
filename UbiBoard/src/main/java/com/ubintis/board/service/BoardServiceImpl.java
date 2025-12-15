package com.ubintis.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional //  중간에 실패하면 전부 취소
	@Override
	public void deleteClipById(int boardId) {
	    // 1. 대댓글 먼저 삭제 
		mapper.deleteSubCommentsByBoardId(boardId);
	    
	    // 2. 그 다음 댓글 삭제
		mapper.deleteCommentsByBoardId(boardId);
	    
	    // 3. 마지막으로 게시글 삭제
		mapper.deleteBoard(boardId);
	}


}
