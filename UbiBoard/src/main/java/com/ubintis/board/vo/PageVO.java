package com.ubintis.board.vo;

public class PageVO {
    private int startPage; // 시작 페이지 번호 (예: 1, 11, 21...)
    private int endPage;   // 끝 페이지 번호 (예: 10, 20, 30...)
    private boolean prev, next; // 이전, 다음 버튼 표시 여부
    private int total;     // 전체 글 개수
    private PagingVO Paging;  // 현재 페이지 정보

    public PageVO(PagingVO Paging, int total) {
        this.Paging = Paging;
        this.total = total;

        // 페이징 계산 로직 (끝 페이지 번호 계산)
        // 10개씩 보여준다고 가정할 때, 현재 페이지가 3페이지면 끝은 10
        this.endPage = (int) (Math.ceil(Paging.getPageNum() / 10.0)) * 10;
        this.startPage = this.endPage - 9;

        // 실제 끝 페이지 번호 (데이터가 125개라면 끝 페이지는 13이어야 함)
        int realEnd = (int) (Math.ceil((total * 1.0) / Paging.getAmount()));

        if (realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public PagingVO getPaging() {
		return Paging;
	}

	public void setPaging(PagingVO paging) {
		Paging = paging;
	}
    
}