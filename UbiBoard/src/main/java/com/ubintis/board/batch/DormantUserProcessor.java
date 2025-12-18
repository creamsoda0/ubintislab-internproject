package com.ubintis.board.batch;

import org.springframework.batch.item.ItemProcessor;

import com.ubintis.board.vo.UserVO;

public class DormantUserProcessor implements ItemProcessor<UserVO, UserVO> {
    @Override
    public UserVO process(UserVO item) throws Exception {
        // 휴면 처리 전 로그를 찍거나 특정 필드를 수정할 수 있습니다.
        System.out.println("Processing dormant user: " + item.getUserId());
        return item; // 그대로 반환하면 Writer로 넘어갑니다.
    }
}
