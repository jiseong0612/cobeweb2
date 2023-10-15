package org.zerock.service;

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
public class BoardServiceTests {

	@Autowired
	private BoardService boardService;

	@Test
	public void getList() {
		Criteria cri = new Criteria();
		System.out.println(boardService.getList(cri));
	}

	@Test
	public void register() {
		BoardVO board = new BoardVO();
		board.setTitle("aaa test");
		board.setContent("aaa content");
		board.setWriter("aa writer");

		long bno = boardService.register(board);

		if (bno > 0) {
			System.out.println("bno : " + board.getBno());
		}
	}
}
