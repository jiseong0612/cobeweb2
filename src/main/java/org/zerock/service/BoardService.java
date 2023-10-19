package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

@Service
public class BoardService {

	@Autowired
	private BoardMapper boardMapper;
 
	public List<BoardVO> getList(Criteria cri) {
		return boardMapper.getListWithPaging(cri);
	}
	
	public int getTotalCount(Criteria cri) {
		return boardMapper.getTotalCount(cri);
	}

	public Long register(BoardVO board) {
		boardMapper.insertSelectKey(board);
		return board.getBno();
	}

	public BoardVO get(Long bno) {
		return boardMapper.read(bno);
	}

	public int modify(BoardVO board) {
		return boardMapper.update(board);
	}

	public int remove(Long bno) {
		return boardMapper.delete(bno);
	}
}
