package com.ubintis.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ubintis.board.vo.MainBoardVO;
import com.ubintis.board.vo.PagingVO;

@Mapper
public interface BoardMapper {

	int insertClip(MainBoardVO vo);

	List<MainBoardVO> getClipList(PagingVO paging);

	int getTotalCount(PagingVO paging);

}
