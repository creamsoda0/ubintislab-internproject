package com.ubintis.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
    private MemberMapper mapper;
	
	@Override
	public int idCheck(String userId) {
	    return mapper.idCheck(userId);
	}
}
