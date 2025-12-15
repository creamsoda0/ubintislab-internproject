package com.ubintis.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ubintis.board.vo.MainBoardVO;

@Mapper
public interface BoardMapper {

	int insertClip(MainBoardVO vo);

}
