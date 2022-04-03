package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Slf4j
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml" })

public class TransactionTestssss {
	@Autowired
	TransactionTest test;
	
	@Test
	public void testt() throws Exception {
		int result = test.add(5, 10);
		System.out.println(result);
	}
}
