package com.ubintis.board.service;

import java.util.List;

import com.ubintis.board.vo.usersvo;

public interface MemberService {

	public int idCheck(String userId);

	public List<usersvo> getUserList();
}
