package com.ubintis.board.vo;

import java.time.LocalDateTime;
import java.util.Date;

public class UserPolicyVO {

	private int policyId;
	private String userId;
	private Date recentLogin;
	private Date lastAgreement;
	private Date joinDate;
	private int loginFail;
	private Date dormantDate;
	private String dormantReason;
	private Date withdrawDate;
	private String withdrawReason;
	private LocalDateTime untilLock;
	
	
	public LocalDateTime getUntilLock() {
		return untilLock;
	}
	public void setUntilLock(LocalDateTime untilLock) {
		this.untilLock = untilLock;
	}
	public int getPolicyId() {
		return policyId;
	}
	public void setPolicyId(int policyId) {
		this.policyId = policyId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getRecentLogin() {
		return recentLogin;
	}
	public void setRecentLogin(Date recentLogin) {
		this.recentLogin = recentLogin;
	}
	public Date getLastAgreement() {
		return lastAgreement;
	}
	public void setLastAgreement(Date lastAgreement) {
		this.lastAgreement = lastAgreement;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public int getLoginFail() {
		return loginFail;
	}
	public void setLoginFail(int loginFail) {
		this.loginFail = loginFail;
	}
	public Date getDormantDate() {
		return dormantDate;
	}
	public void setDormantDate(Date dormantDate) {
		this.dormantDate = dormantDate;
	}
	public String getDormantReason() {
		return dormantReason;
	}
	public void setDormantReason(String dormantReason) {
		this.dormantReason = dormantReason;
	}
	public Date getWithdrawDate() {
		return withdrawDate;
	}
	public void setWithdrawDate(Date withdrawDate) {
		this.withdrawDate = withdrawDate;
	}
	public String getWithdrawReason() {
		return withdrawReason;
	}
	public void setWithdrawReason(String withdrawReason) {
		this.withdrawReason = withdrawReason;
	}
	
	
}
