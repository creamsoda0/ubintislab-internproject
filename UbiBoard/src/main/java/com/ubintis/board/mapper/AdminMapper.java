package com.ubintis.board.mapper;
import org.apache.ibatis.annotations.Mapper;

import com.ubintis.board.vo.SiteConfigVO;

@Mapper
public interface AdminMapper {

	void updateSiteConfig(SiteConfigVO configVO);

	SiteConfigVO getSiteConfig();

}
