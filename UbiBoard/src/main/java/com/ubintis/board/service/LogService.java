package com.ubintis.board.service;

public interface LogService {

	void saveLog(String userId, String type, String detail, String ipAddress);
}
