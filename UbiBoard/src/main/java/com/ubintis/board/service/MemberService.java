package com.ubintis.board.service;

import java.util.List;

import com.ubintis.board.vo.UserVO;

public interface MemberService {

	public int idCheck(String userId);

	public List<UserVO> getUserList();
}
