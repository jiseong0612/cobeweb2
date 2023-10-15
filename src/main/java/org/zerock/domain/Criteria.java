package org.zerock.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum, amount;
	
	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		//super(); //Criteria 클래스는 아무런 상속을 받지 않고 독립적인 클래스로 보이며, super() 호출이 필요한 경우가 아닙니다.
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
