package com.ubintis.board.vo;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

public class SecurityUserVO extends User{ //User는 시큐리티가 제공하는 클래스
	private UserVO userVO;
	
	public SecurityUserVO(UserVO userVO) {
		// 부모 클래스 (User) 생성자에 ID, PW, 권한전달
		super(userVO.getUserId(), userVO.getPassword(),
				AuthorityUtils.createAuthorityList("ROLE_USER"));
		this.userVO=userVO;
		
	}
	public UserVO getUser() {
		return userVO;
	}

}
