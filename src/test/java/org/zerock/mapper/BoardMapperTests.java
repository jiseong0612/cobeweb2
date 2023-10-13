package org.zerock.mapper;


import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Autowired
	private BoardMapper boardMapper;

	@Test
	public void getList() {
		System.out.println(boardMapper.getList());
	}

	@Test
	public void insert() {
		BoardVO board = new BoardVO();
		board.setTitle("test title 타이틀");
		board.setContent("content 내용 내용");
		board.setWriter("user00");

		int result = boardMapper.insert(board);
	}

	@Test
	public void insertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("test title 타이틀");
		board.setContent("content 내용 내용");
		board.setWriter("user00");

		int result = boardMapper.insertSelectKey(board);

		System.out.println(board.getBno());
	}

	@Test
	public void read() {
		BoardVO board = boardMapper.read(24L);
	}

	@Test
	public void update() {
		BoardVO board = new BoardVO();
		board.setBno(24L);
		board.setTitle("update title");
		board.setContent("update content");
		board.setWriter("user00");

		int result = boardMapper.update(board);
	}

	@Test
	public void delete() {
		int result = boardMapper.delete(24L);
	}
	
	@Test
	public void getListWithPaging() {
		Criteria cri = new Criteria();
		List<BoardVO> list = boardMapper.getListWithPaging(cri);
	}
}
