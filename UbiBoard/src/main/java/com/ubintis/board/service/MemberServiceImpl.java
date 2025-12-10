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

	@Override
	public UserVO login(UserVO userVO) {
		// 아이디로 회원 정보 꺼내오기
	    UserVO dbUser = mapper.getMemberById(userVO.getUserId());
	    
	    // 일치하는 아이디가 있는지, 그리고 비밀번호가 맞는지 확인
	    if (dbUser != null) {
	        // 비밀번호 비교 
	        if (dbUser.getPassword().equals(userVO.getPassword())) {
	            return dbUser; // 로그인 성공 시 회원 정보 리턴
	        }
	    }
	    return null; // 실패 시 null 리턴
	}

	@Override
	public UserVO getMember(String userId) {
		
		return mapper.getMemberById(userId);
	}

	@Override
	public void updateMember(UserVO userVO) {
		mapper.updateMember(userVO);
	}


}
