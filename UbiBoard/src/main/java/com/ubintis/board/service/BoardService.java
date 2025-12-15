package com.ubintis.board.service;

import java.util.List;

import com.ubintis.board.vo.MainBoardVO;

public interface BoardService {

	int insertClip(MainBoardVO vo);

	List<MainBoardVO> getClipList();

}
