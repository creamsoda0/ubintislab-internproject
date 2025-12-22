package com.ubintis.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.MemberMapper;
import com.ubintis.board.vo.SecurityUserVO;
import com.ubintis.board.vo.UserVO;

@Service("customUserDetailsService")
public class CustomUserDetailService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	public UserDetails loadUserByUserId(String userId)throws Exception {
		
		UserVO userVO = memberMapper.getUserById(userId);
		
		if (userVO == null ) {
			throw new Exception();
		}
		
		return new SecurityUserVO(userVO);
		
	}

}
