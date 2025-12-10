package com.ubintis.board.service;

import java.util.List;

import com.ubintis.board.vo.UserVO;

public interface MemberService {

	public int idCheck(String userId);

	public List<UserVO> getUserList();

	public void insertMember(UserVO userVO);

	public UserVO login(UserVO userVO);

	public UserVO getMember(String userId);

	public void updateMember(UserVO userVO);
}
