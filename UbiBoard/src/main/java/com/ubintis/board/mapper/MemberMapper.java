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

	public UserVO findUserByEmail(String email);

	public UserVO findId(@Param("name") String name, @Param("email") String email);

	public UserVO findUserByIdEmail(@Param("userId") String userId,@Param("email") String email);

	public int updateUserPw(@Param("userId") String userId,@Param("password") String password);

	// 이거 수정봐야함
	public int deleteMember(String userId);

	public int migrateMember(UserVO vo);
	
}
