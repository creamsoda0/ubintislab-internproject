package com.ubintis.board.batch;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.ubintis.board.vo.UserVO;

public class UserRowMapper implements RowMapper<UserVO> {
    @Override
    public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        UserVO user = new UserVO();
        user.setUserId(rs.getString("user_id")); 
        user.setPassword(rs.getString("password"));
        user.setName(rs.getString("name"));
        user.setBirth(rs.getDate("birth"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setEmail(rs.getString("email"));        
        user.setEmailAgreed(rs.getInt("email_agreed")); 
        user.setSmsAgreed(rs.getInt("sms_agreed"));
        user.setHintId(rs.getInt("hint_id"));
        user.setHintAnswer(rs.getString("hint_answer"));
        user.setRefreshToken(rs.getString("refresh_token"));
        user.setJoinDate(rs.getDate("join_date"));
        return user;
    }
}
