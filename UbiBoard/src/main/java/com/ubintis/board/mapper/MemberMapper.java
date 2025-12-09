package com.ubintis.board.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	/* public void insertMember(MemberVO member); */
	
	// 아이디 중복체크
	public int idCheck(String userId);
	
}
