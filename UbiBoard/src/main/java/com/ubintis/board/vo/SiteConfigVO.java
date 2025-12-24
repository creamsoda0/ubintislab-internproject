package com.ubintis.board.vo;

public class SiteConfigVO {
	
	private int configId;

	private String tempLockEnabled; // 체크박스는 체크 안 하면 null, 체크하면 "on"
	private String useTempLock; // on/null
    private int sessionTimeOut;
    private int postsPerPage;
    private int lockMinutes;
	public int getLockMinutes() {
		return lockMinutes;
	}
	public void setLockMinutes(int lockMinutes) {
		this.lockMinutes = lockMinutes;
	}
	public String getTempLockEnabled() {
		return tempLockEnabled;
	}
	public void setTempLockEnabled(String tempLockEnabled) {
		this.tempLockEnabled = tempLockEnabled;
	}
	public String getUseTempLock() {
		return useTempLock;
	}
	public void setUseTempLock(String useTempLock) {
		this.useTempLock = useTempLock;
	}
	public int getSessionTimeOut() {
		return sessionTimeOut;
	}
	public void setSessionTimeOut(int sessionTimeOut) {
		this.sessionTimeOut = sessionTimeOut;
	}
	public int getPostsPerPage() {
		return postsPerPage;
	}
	public void setPostsPerPage(int postsPerPage) {
		this.postsPerPage = postsPerPage;
	}
	public int getConfigId() {
		return configId;
	}
	public void setConfigId(int configId) {
		this.configId = configId;
	}


}
