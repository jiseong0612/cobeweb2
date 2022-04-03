package org.zerock.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TransactionTest {
	public int add(int x, int y) throws Exception {
		return x + y;
	}
}
