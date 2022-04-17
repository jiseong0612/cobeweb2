package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public int modify(BoardVO board);
	
	public int remove(Long bno);
	
	public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Long bno);
}
