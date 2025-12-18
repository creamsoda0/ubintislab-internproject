package com.ubintis.board.batch;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.ubintis.board.vo.UserVO;

public class DormantUserWriter implements ItemWriter<UserVO> {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void write(List<? extends UserVO> items) throws Exception {
		for (UserVO user : items) {
			sqlSession.insert("com.ubintis.board.mapper.MemberMapper.insertDormant", user);
			sqlSession.update("com.ubintis.board.mapper.MemberMapper.maskDormantUser", user.getUserId());
		}
		System.out.println(items.size() + "명의 계정이 휴면 처리(마스킹) 되었습니다.");
	}
}