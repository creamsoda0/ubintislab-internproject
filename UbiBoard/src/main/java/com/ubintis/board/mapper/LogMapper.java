package com.ubintis.board.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ubintis.board.vo.UserLogVO;

@Mapper
public interface LogMapper {

	void insertLog(UserLogVO logVO);
		
}
