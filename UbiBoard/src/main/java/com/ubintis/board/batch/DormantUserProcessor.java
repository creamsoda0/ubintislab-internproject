package com.ubintis.board.batch;

import org.springframework.batch.item.ItemProcessor;

import com.ubintis.board.vo.UserVO;

public class DormantUserProcessor implements ItemProcessor<UserVO, UserVO> {
    @Override
    public UserVO process(UserVO item) throws Exception {
        
        System.out.println("Processing dormant user: " + item.getUserId());
        
        return item; // 그대로 반환하면 Writer로 넘어갑니다.
    }
}
