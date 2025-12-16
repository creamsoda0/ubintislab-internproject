package com.ubintis.board.vo;

import java.util.Date;

public class FileVO {
	private int fileId;
	private int boardId;
	private String originalName;
	private String savedName;
	private String filePath;
	
	// [수정 1] 오타 수정: filSize -> fileSize ('e' 추가)
	private long fileSize; 
	
	private Date regDate;
	private Date modDate;
	
	public int getFileId() {
		return fileId;
	}
	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public String getSavedName() {
		return savedName;
	}
	public void setSavedName(String savedName) {
		this.savedName = savedName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	// [수정 2] 메서드 이름 오타 수정 (getFilSize -> getFileSize)
	// [수정 3] 리턴 타입 통일 (int -> long)
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public Date getRegDate() {
		return regDate;
	}
	// [수정 4] 관례상 setRegDate가 맞음 (setReg_date -> setRegDate)
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getModDate() {
		return modDate;
	}
	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}
}