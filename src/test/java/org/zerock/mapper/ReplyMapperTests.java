package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class ReplyMapperTests {
	@Autowired
	private ReplyMapper mapper;
	
	@Test
	public void getCountByBno() {
		log.info("count = {}", mapper.getCountByBno(23L));
	}
	
	@Test
	public void replyInsert() {
		ReplyVO reply = new ReplyVO();
		reply.setBno(23L);
		reply.setReply("안녕test3333");
		reply.setReplyer("jiseong3333");
		mapper.insert(reply);
	}
	
	@Test
	public void read() {
		ReplyVO reply = mapper.read(23L);
		log.info("reply = {}", reply);
	}
	
	@Test
	public void update() {
		ReplyVO reply = new ReplyVO();
		reply.setBno(23L);
		reply.setReply("안녕test2222222");
		reply.setReplyer("jiseong222222");
		mapper.update(reply);
	}
	
	@Test
	public void delete() {
		int result = mapper.delete(23L);
		System.out.println("result = " + result);
	}
	
	@Test
	public void getListWithPaging() {
		List<ReplyVO> list = mapper.getListWithPaging(new Criteria(2, 10), 23L);
		log.info("list size = {}", list.size());
		list.forEach(reply -> System.out.println(reply));
	}
}
