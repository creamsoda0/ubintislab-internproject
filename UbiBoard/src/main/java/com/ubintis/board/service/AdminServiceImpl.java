package com.ubintis.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ubintis.board.mapper.AdminMapper;
import com.ubintis.board.vo.SiteConfigVO;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
    private AdminMapper mapper;
	
	@Override
	public void updateSiteConfig(SiteConfigVO configVO) {
		// TODO Auto-generated method stub
		mapper.updateSiteConfig(configVO);
	}

	@Override
	public SiteConfigVO getSiteConfig() {
		// TODO Auto-generated method stub
		return mapper.getSiteConfig();
	}

}
