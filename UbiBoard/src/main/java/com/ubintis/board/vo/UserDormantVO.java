package com.ubintis.board.vo;

import java.util.Date;

// 현재 만들어는 놨지만 사용처는 없습니다.
// 휴면 계정의 경우 같은 로그인 서비스 계층에서 같은 로직을 이용할 것이므로 
// 아래 기능들은 UserVO에서 사용하고 있습니다. 
// 추가되는 dormantID, dormantDate, reason 등등....
public class UserDormantVO {

	private int dormantId;
	private String user_id;
	private String password;
	private String name;
	private Date birth;
	private String phone;
	private String address;
	private String email;
	private int emailAggreed;
	private int smsAggreed;
	private int hintId;
	private String hintAnswer;
	private String refreshToken;
	private Date joinDate;
	private Date dormantDate;
	private String reason;
	public int getDormantId() {
		return dormantId;
	}
	public void setDormantId(int dormantId) {
		this.dormantId = dormantId;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getEmailAggreed() {
		return emailAggreed;
	}
	public void setEmailAggreed(int emailAggreed) {
		this.emailAggreed = emailAggreed;
	}
	public int getSmsAggreed() {
		return smsAggreed;
	}
	public void setSmsAggreed(int smsAggreed) {
		this.smsAggreed = smsAggreed;
	}
	public int getHintId() {
		return hintId;
	}
	public void setHintId(int hintId) {
		this.hintId = hintId;
	}
	public String getHintAnswer() {
		return hintAnswer;
	}
	public void setHintAnswer(String hintAnswer) {
		this.hintAnswer = hintAnswer;
	}
	public String getRefreshToken() {
		return refreshToken;
	}
	public void setRefreshToken(String refreshToken) {
		this.refreshToken = refreshToken;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public Date getDormantDate() {
		return dormantDate;
	}
	public void setDormantDate(Date dormantDate) {
		this.dormantDate = dormantDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
}
