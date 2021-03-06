package org.zerock.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Slf4j
public class BoardMapperTests {
	@Autowired
	private BoardMapper mapper;
	
	@Test
	public void getList() {
		//log.info("list ={}", mapper.getList());
		System.out.println( mapper.getList());
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setType("W");
		cri.setKeyword("1123");
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(b -> log.info("b = {}",b));
	}
	
	@Test 
	public void insert() {
			
			BoardVO board = new BoardVO();
			board.setTitle("bb");
			board.setContent("bbContent");
			board.setWriter("jiseong");
			
			mapper.insert(board);
	}
	
	@Test
	public void insertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("bb");
		board.setContent("bbContent");
		board.setWriter("jiseong");
		int result = mapper.insertSelectKey(board);
		System.out.println(">>> "+ result); 		// 추가된 행 수 : 1
		System.out.println(">>> "+ board.getBno());	// 마지막 글 번호 : 6
	}
	
	@Test
	public void read() {
		long bno = 23L;
		BoardVO board = mapper.read(bno);
		
		System.out.println(">>> "+board);
	}
	@Test
	public void delete() {
		long bno = 1L;
		int result = mapper.delete(bno);
		
		System.out.println(">>> "+result);
	}
	@Test
	public void update() {
		BoardVO board = new BoardVO();
		board.setBno(2L);
		board.setTitle("bb");
		board.setContent("ccc");
		board.setWriter("bbb");
		int result = mapper.update(board);
		
		System.out.println(">>> "+result);
	}
	
	
	@Test
	public void getLists() {
		int[] bnolist = {11, 12,13};
		List<Integer> list = new ArrayList<>();
		list.add(10);
		list.add(10);
		list.add(10);
		String bnolists =  mapper.getLists();
		System.out.println(bnolists);
	}
}
