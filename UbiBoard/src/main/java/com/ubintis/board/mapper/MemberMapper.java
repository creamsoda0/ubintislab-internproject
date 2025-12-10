package com.ubintis.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ubintis.board.vo.UserVO;

@Mapper
public interface MemberMapper {
	/* public void insertMember(MemberVO member); */
	
	// 아이디 중복체크
	public int idCheck(String userId);
	
	public List<UserVO> getUserList();

	public void insertMember(UserVO userVO);

	public UserVO getMemberById(String userId);

	public void updateMember(UserVO userVO);
	
}
