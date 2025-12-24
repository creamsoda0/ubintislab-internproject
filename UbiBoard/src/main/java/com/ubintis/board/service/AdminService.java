package com.ubintis.board.service;

import com.ubintis.board.vo.SiteConfigVO;

public interface AdminService {

	void updateSiteConfig(SiteConfigVO configVO);

	SiteConfigVO getSiteConfig();

}
