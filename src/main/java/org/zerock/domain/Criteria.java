package org.zerock.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum, amount;
	
	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
