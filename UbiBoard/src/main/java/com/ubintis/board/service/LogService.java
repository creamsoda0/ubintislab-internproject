package com.ubintis.board.service;

import javax.servlet.http.HttpServletRequest;

public interface LogService {

	void saveLog(String userId, String type, String detail, HttpServletRequest request);
}
