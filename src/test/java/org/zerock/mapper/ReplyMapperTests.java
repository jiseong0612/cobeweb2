package org.zerock.mapper;


import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	@Autowired
	private ReplyMapper replyMapper;

	@Test
	public void testMapper() {
		log.info(replyMapper);
	}
	
	@Test
	public void getList() {
		System.out.println(replyMapper.getList());
	}

	@Test
	public void insert() {
		ReplyVO reply = new ReplyVO();
		
		reply.setBno(655461L);
		reply.setReplyer("tester");
		reply.setReply("잘 좀 합시다 예????");
		
		int result = replyMapper.insert(reply);
	}

	@Test
	public void insertSelectKey() {
	}

	@Test
	public void read() {
		ReplyVO reply = replyMapper.read(3L);
		
	}

	@Test
	public void update() {
		ReplyVO reply = new ReplyVO();
		reply.setRno(1L);
		reply.setReply("댓글 수정");
		
		int result = replyMapper.update(reply);
	}

	@Test
	public void delete() {
		int delete = replyMapper.delete(2L);
	}
	
	@Test
	public void getListWithPaging() {
		Criteria cri = new Criteria();
		List<ReplyVO> list = replyMapper.getListWithPaging(cri, 655461L);
		
	}
	
	@Test
	public void testPageDto() {
	}
	
}
