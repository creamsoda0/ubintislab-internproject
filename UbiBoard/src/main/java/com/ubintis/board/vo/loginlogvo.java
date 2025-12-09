package com.ubintis.board.vo;

public class loginlogvo {
	private int LogId;
	private int userNo;
	private String regLog;
	private String withdrawLog;
	private String dormantLog;
	public int getLogId() {
		return LogId;
	}
	public void setLogId(int logId) {
		LogId = logId;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getRegLog() {
		return regLog;
	}
	public void setRegLog(String regLog) {
		this.regLog = regLog;
	}
	public String getWithdrawLog() {
		return withdrawLog;
	}
	public void setWithdrawLog(String withdrawLog) {
		this.withdrawLog = withdrawLog;
	}
	public String getDormantLog() {
		return dormantLog;
	}
	public void setDormantLog(String dormantLog) {
		this.dormantLog = dormantLog;
	}
}
