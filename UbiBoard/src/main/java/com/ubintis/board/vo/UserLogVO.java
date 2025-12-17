package com.ubintis.board.vo;

import java.util.Date;

public class UserLogVO {
    private long logId;
    private String userId;
    private String activityType; // LOGIN, JOIN, WITHDRAW, DORMANT
    private String activityDetail;
    private String ipAddress;
    private Date regDate;
    
 // 생성자 (편의용)
    public UserLogVO() {}
    public UserLogVO(String userId, String activityType, String activityDetail, String ipAddress) {
        this.userId = userId;
        this.activityType = activityType;
        this.activityDetail = activityDetail;
        this.ipAddress = ipAddress;
    }
    
	public long getLogId() {
		return logId;
	}
	public void setLogId(long logId) {
		this.logId = logId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getActivityType() {
		return activityType;
	}
	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}
	public String getActivityDetail() {
		return activityDetail;
	}
	public void setActivityDetail(String activityDetail) {
		this.activityDetail = activityDetail;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
    
    
    
}