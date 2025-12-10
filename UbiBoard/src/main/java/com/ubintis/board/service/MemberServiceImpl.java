package com.ubintis.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.MemberMapper;
import com.ubintis.board.vo.UserVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
    private MemberMapper mapper;
	
	@Override
	public int idCheck(@Param("userId") String userId) {
	    return mapper.idCheck(userId);
	}
	
	@Override
	public List<UserVO> getUserList() {
	    return mapper.getUserList();
	}

	@Override
	public void insertMember(UserVO userVO) {
		mapper.insertMember(userVO);
		
	}
}
