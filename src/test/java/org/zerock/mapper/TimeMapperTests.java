package org.zerock.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.TimeMapper;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class TimeMapperTests {
	@Autowired
	private TimeMapper mapper;
	
	@Test
	public void timeMapperTest() {
		log.info("maRpper.getTime() = {}", mapper.getTime());
	}
	
	@Test
	public void getTime2() {
		int[] bnolist = {11, 12,13};
		List<String> list = new ArrayList<>();
		list.add("java");
		list.add("html");
		list.add("css");
		log.info(mapper.getTime2(list));
	}
}
