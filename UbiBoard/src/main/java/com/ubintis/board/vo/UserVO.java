package com.ubintis.board.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class UserVO {
	private String userId;
	private String password;
	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;
	private String phone;
	private String address;
	private String email;
	private int emailAgreed;
	private int smsAgreed;
	private int hintId;
	private String hintAnswer;
	private String refreshToken;
	private Date joinDate;
	
	
	// 아래는 프론트에만 있는 값
	
	private String zipCode;
	private String addr1;
	private String addr2;
	private String emailId;
	private String emailDomain;
	
	
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
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
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getEmailDomain() {
		return emailDomain;
	}
	public void setEmailDomain(String emailDomain) {
		this.emailDomain = emailDomain;
	}
	
	
}
