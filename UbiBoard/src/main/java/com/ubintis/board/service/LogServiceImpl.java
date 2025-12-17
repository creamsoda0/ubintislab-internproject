package com.ubintis.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.LogMapper;

@Service
public class LogServiceImpl implements LogService {

	@Autowired
    private LogMapper logMapper;
	
}
