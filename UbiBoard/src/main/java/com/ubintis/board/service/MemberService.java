package com.ubintis.board.service;

import java.util.List;

import com.ubintis.board.vo.UserPolicyVO;
import com.ubintis.board.vo.UserVO;

public interface MemberService {

	public int idCheck(String userId);

	public List<UserVO> getUserList();

	public void insertMember(UserVO userVO) throws Exception;

	public UserVO login(UserVO userVO);

	public UserVO getMember(String userId);

	public void updateMember(UserVO userVO);

	public UserVO findUserByEmail(String email);

	public String sendAuthCode(String email);

	public UserVO findId(String name, String email);

	public UserVO findUserByIdEmail(String userId, String email);

	public int updateUserPw(String userId, String password);

	public boolean withdrawProcess(UserVO userVO, String reason) throws Exception;

	public UserVO getDormantUserById(String userId);

	public void activateDormantUser(String userId);

	public void resetFailCount(String userId);

	public int increaseFailCount(String userId);

	public UserVO findLoginFailUser(UserVO userVO);

	public void recoverLoginFail(String userId);

	public void updateLastAgreement(String userId);

	public UserPolicyVO getUserPolicyById(String userId);

	public int selectAdminById(String userId);

	
}
