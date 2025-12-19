package com.ubintis.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.LogMapper;
import com.ubintis.board.vo.UserLogVO;

@Service
public class LogServiceImpl implements LogService {

	@Autowired
    private LogMapper logMapper;
	
	// 로그 저장 메서드
    public void saveLog(String userId, String type, String detail, String ipAddress) {
        
        UserLogVO logVO = new UserLogVO(userId, type, detail, ipAddress);
        logMapper.insertLog(logVO);
    }

	/*
	 * // IP 주소 가져오는 유틸 메서드 private String getClientIp(HttpServletRequest request) {
	 * String ip = request.getHeader("X-Forwarded-For"); if (ip == null ||
	 * ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { ip =
	 * request.getHeader("Proxy-Client-IP"); } if (ip == null || ip.length() == 0 ||
	 * "unknown".equalsIgnoreCase(ip)) { ip =
	 * request.getHeader("WL-Proxy-Client-IP"); } if (ip == null || ip.length() == 0
	 * || "unknown".equalsIgnoreCase(ip)) { ip = request.getRemoteAddr(); } return
	 * ip; }
	 */
	
}
