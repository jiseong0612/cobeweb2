package org.zeorck.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zeorck.mapper.TimeMapperTests;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class BoardServiceTests {
	@Autowired
	private BoardService service;
	
	@Test
	public void service() {
		log.info(service.toString());
	}
	
	@Test
	public void insertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("bb");
		board.setContent("bbContent");
		board.setWriter("jiseong");
		
		long bno = service.register(board);
		System.out.println("작성된 글 번호는 ? : "+ bno);
	}
	
	@Test
	public void getList() {
		service.getList().forEach(li-> System.out.println("list = > " + li));
	}
}
