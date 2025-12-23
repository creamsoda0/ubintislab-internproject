package com.ubintis.board.service;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ubintis.board.mapper.MemberMapper;
import com.ubintis.board.vo.UserDormantVO;
import com.ubintis.board.vo.UserVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
    private MemberMapper mapper;
	
	// 패스워드 암호화 관련 의존성 주입
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

	
	@Override
	public int idCheck(@Param("userId") String userId) {
	    return mapper.idCheck(userId);
	}
	
	@Override
	public List<UserVO> getUserList() {
	    return mapper.getUserList();
	}
	
	@Override
	@Transactional
	public void insertMember(UserVO userVO) {
		
		// 아이디가 중복일시 예외 던지는 로직
		int count = mapper.idCheck(userVO.getUserId());
		if (count > 0) {
            throw new IllegalStateException("이미 존재하는 아이디입니다.");
        }
		// 아이디 길이 체크
		if (userVO.getUserId() != null && userVO.getUserId().length() > 20) {
	        // 비정상적인 요청이므로 즉시 에러 발생시킴
	        throw new IllegalArgumentException("아이디는 20자를 초과할 수 없습니다.");
	    }
	    
	    // 이름 길이 체크
	    if (userVO.getName() != null && userVO.getName().length() > 20) {
	        throw new IllegalArgumentException("이름은 20자를 초과할 수 없습니다.");
	    }
	    
	    // 수신동의의 경우 null일경우 기본값 비수신으로 처리
	    if (userVO.getEmailAgreed() == null) {
	         userVO.setEmailAgreed(0); 
	         // 필수라면 throw new IllegalArgumentException(...)
	    }
	    
        // 사용자가 입력한 있는 그대로의 비밀번호
        String rawPw = userVO.getPassword();
        // 암호화된 비밀번호
        String encodePw = passwordEncoder.encode(rawPw);       
        // 암호화된 비번을 다시 VO에 담아서 DB로 보냄
        userVO.setPassword(encodePw);
        
		mapper.insertMember(userVO);
		mapper.insertUserPolicy(userVO);
	}
	
	/*
	 * // XSS 방어용 프라이빗 메서드 
	 * (직접 경우의 수를 조사해서 손으로 친버전 ^^)
	 * private String preventXss(String value) { if
	 * (value == null) return null; return value.replaceAll("&", "&amp;")
	 * .replaceAll("<", "&lt;") .replaceAll(">", "&gt;") .replaceAll("\"", "&quot;")
	 * .replaceAll("'", "&#x27;"); }
	 */

	@Override
	public UserVO login(UserVO userVO) {
	    // 먼저 입력받은 아이디 자체를 변수에 담아둡니다 (NPE 방지)
	    String inputId = userVO.getUserId();
	    String inputPw = userVO.getPassword();

	    // 일반 회원 테이블에서 조회
	    UserVO dbUser = mapper.getMemberById(inputId);
	    
	    if (dbUser != null) {
	        // 일반 회원에 존재할 경우 비밀번호 검증
	        if (passwordEncoder.matches(inputPw, dbUser.getPassword())) {
	            return dbUser; // 로그인 성공
	        }
	        // 비밀번호가 틀렸다면 여기서 더 진행하지 않고 null 반환 (또는 실패 처리)
	        return null; 
	    }

	    // 일반 회원에 없다면 휴면 계정 테이블에서 조회
	    // 이때 dbUser.getUserId()가 아니라 처음에 받아온 inputId를 써야 안전합니다.
	    UserVO dormantVO = mapper.getDormantUserById(inputId);
	    if (dormantVO != null) {
	        // 휴면 계정의 경우 비밀번호 일치 여부는 보통 안내 페이지 이동 후 판단하거나
	        // 여기서 바로 체크할 수도 있습니다. (프로젝트 정책에 따라)
	        if (passwordEncoder.matches(inputPw, dormantVO.getPassword())) {
	             return dormantVO; // 휴면 계정으로 로그인 성공 (컨트롤러에서 분기 처리됨)
	        }
	    }
	    
	    return null; // 어디에도 없거나 비번이 틀린 경우
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
	    String subject = "유비앤티스랩 인턴 프로젝트 아이디 찾기 인증번호입니다.";
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

	@Override
	public UserVO findId(String name, String email) {
		
		return mapper.findId(name, email);
	}

	@Override
	public UserVO findUserByIdEmail(String userId, String email) {
		
		return mapper.findUserByIdEmail(userId, email);
	}

	@Override
	public int updateUserPw(String userId, String password) {
		//암호화 추가
		String encodePw = passwordEncoder.encode(password);
		
		password = encodePw;
		
		return mapper.updateUserPw(userId, password);
	}

	@Transactional(rollbackFor = Exception.class) // 하나라도 실패하면 자동 롤백
	public boolean withdrawProcess(UserVO userVO, String reason) throws Exception {
	    // 정보 조회 및 검증
	    UserVO fullInfo = this.login(userVO);
	    if (fullInfo == null) return false; // 비번 틀림

	    // 이관
	    // (Service 내부에서 DAO 호출 시 fullInfo와 reason을 적절히 매핑해서 넘김)
	    fullInfo.setWithdrawReason(reason); // VO에 reason 필드가 있다고 가정
	    int migrateResult = mapper.migrateMember(fullInfo); 
	    if (migrateResult == 0) throw new Exception("Migration Failed");

	    // 삭제
	    int dResult = mapper.deleteMember(userVO.getUserId());
	    int uResult = mapper.updateWithDrawUserPolicy(userVO.getUserId(), reason);
	    if (dResult == 0 && uResult == 0) throw new Exception("Delete Failed");
	    
	    return true; // 성공
	}

	@Override
	public UserVO getDormantUserById(String userId) {
		// TODO Auto-generated method stub
		return mapper.getDormantUserById(userId);
	}

	@Override
	@Transactional
	public void activateDormantUser(String userId) {
		UserVO userVO = mapper.getDormantUserById(userId);
		
		mapper.ActivateDormantUser(userVO);
		mapper.migrateDormantUser(userId);
		mapper.updateDormantUserPolicy(userId);
		
	}

	@Override
	public void resetFailCount(String userId) {
		// TODO Auto-generated method stub
		mapper.resetFailCount(userId);
	}

	@Override
	public int increaseFailCount(String userId) {
		// TODO Auto-generated method stub
		mapper.increaseFailCount(userId);
		
		return mapper.getFailCount(userId);
	}

	@Override
	public UserVO findLoginFailUser(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.findLoginFailUser(userVO);
	}

	@Override
	public void recoverLoginFail(String userId) {
		// TODO Auto-generated method stub
		mapper.recoverLoginFail(userId);
	}

	@Override
	public void updateLastAgreement(String userId) {
		// TODO Auto-generated method stub
		mapper.updateLastAgreement(userId);
	}
	
	



}
