package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class PageDTO {
	private int startPage, endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri;
	
	//토탈 갯수가 필요한 이유 : 페이지 계산을 위해서!
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.endPage = (int) (Math.ceil(cri.getPageNum() /10.0)) * 10;
		this.startPage = endPage - 9;
		
		this.prev = startPage > 1;
		
		int realEnd = (int)(Math.ceil(total / (cri.getAmount() *1.0)));
		
		this.endPage = realEnd <= endPage ? realEnd : endPage;
		
		this.next = realEnd > endPage;
		
	}
}
