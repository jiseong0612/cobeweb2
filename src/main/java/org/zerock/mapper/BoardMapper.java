package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {

	public List<BoardVO>getList();
	
	int insert(BoardVO board);
	
	int insertSelectKey(BoardVO board);
	
	BoardVO read(Long bno);
	
	int update(BoardVO board);
	
	int delete(Long bno);
	
}
