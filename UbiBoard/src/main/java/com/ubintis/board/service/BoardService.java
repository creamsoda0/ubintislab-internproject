package com.ubintis.board.service;

import java.util.List;

import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.PagingVO;

public interface BoardService {

	int insertClip(MainBoardVO vo);

	List<MainBoardVO> getClipList(PagingVO paging);

	int getTotalCount(PagingVO paging);

}
