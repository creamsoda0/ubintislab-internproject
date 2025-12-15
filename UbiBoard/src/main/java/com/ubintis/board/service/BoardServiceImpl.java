package com.ubintis.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.BoardMapper;
import com.ubintis.board.vo.MainBoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
    private BoardMapper mapper;
	
	@Override
	public int insertClip(MainBoardVO vo) {
		// TODO Auto-generated method stub
		return mapper.insertClip(vo);
	}

	@Override
	public List<MainBoardVO> getClipList() {
		// TODO Auto-generated method stub
		return mapper.getClipList();
	}

}
