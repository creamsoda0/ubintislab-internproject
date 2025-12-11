package com.ubintis.board.service;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

	@Override
	public UserVO findUserByEmail(String email) {
		// TODO Auto-generated method stub
		return mapper.findUserByEmail(email);
	}
	// 이메일 인증코드 발송관련 
	@Autowired
	private JavaMailSender mailSender; // 설정파일에서 등록한 빈 주입

	// 인증번호 생성 및 이메일 발송
	public String sendAuthCode(String email) {
	    // 6자리 난수 생성
	    Random random = new Random();
	    int checkNum = random.nextInt(888888) + 111111;
	    String authCode = String.valueOf(checkNum);

	    // 이메일 내용 설정
	    String subject = "서산시청 아이디 찾기 인증번호입니다.";
	    String content = "인증번호는 [" + authCode + "] 입니다.";
	    String from = "dbs0877@gmail.com";

	    try {
	        MimeMessage mail = mailSender.createMimeMessage();
	        MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
	        
	        mailHelper.setFrom(from);
	        mailHelper.setTo(email);
	        mailHelper.setSubject(subject);
	        mailHelper.setText(content, true);
	        
	        // 메일 전송
	        mailSender.send(mail);
	        
	        return authCode; // 생성된 인증코드를 리턴 (Controller에서 사용)
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	        return null; // 실패 시 null
	    }
	}



}
