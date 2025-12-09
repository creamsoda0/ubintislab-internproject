package com.ubintis.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.MemberMapper;
import com.ubintis.board.vo.usersvo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
    private MemberMapper mapper;
	
	@Override
	public int idCheck(String userId) {
	    return mapper.idCheck(userId);
	}
	
	@Override
	public List<usersvo> getUserList() {
	    return mapper.getUserList();
	}
}
