package com.ubintis.board.vo;

import java.util.Date;

public class userwithdrawvo {
	private int withdrawId;
	private int userId;
	private String password;
	private String name;
	private Date birth;
	private String phone;
	private String address;
	private String email;
	private int emailAgreed;
	private int smsAgreed;
	private int hintId;
	private String hintAnswer;
	private String refreshToken;
	private Date withdrawDate;
	// joindate 추가해야할 수도 있음.
	public int getWithdrawId() {
		return withdrawId;
	}
	public void setWithdrawId(int withdrawId) {
		this.withdrawId = withdrawId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
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
	public int getEmailAgreed() {
		return emailAgreed;
	}
	public void setEmailAgreed(int emailAgreed) {
		this.emailAgreed = emailAgreed;
	}
	public int getSmsAgreed() {
		return smsAgreed;
	}
	public void setSmsAgreed(int smsAgreed) {
		this.smsAgreed = smsAgreed;
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
	public Date getWithdrawDate() {
		return withdrawDate;
	}
	public void setWithdrawDate(Date withdrawDate) {
		this.withdrawDate = withdrawDate;
	}
	
	
}
