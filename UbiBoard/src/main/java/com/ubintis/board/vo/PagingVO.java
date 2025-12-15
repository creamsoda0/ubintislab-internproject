package com.ubintis.board.vo; // 패키지명 확인

public class PagingVO {
    private int pageNum = 1;  // 현재 페이지 번호
    private int amount = 3;   // 페이지당 보여줄 개수

    // 기본 생성자: 1페이지, 10개씩
    public PagingVO() {
        this(1, 3);
    }
    
    public int getSkip() {
        return (this.pageNum - 1) * this.amount;
    }

    public PagingVO(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
    
    
}