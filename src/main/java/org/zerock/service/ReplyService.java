package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper replyMapper;
	@Autowired
	private BoardMapper boardMapper;
 
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		return replyMapper.getListWithPaging(cri, bno);
	}
	
	public int getCountByBno(Long bno) {
		return replyMapper.getCountByBno(bno);
	}
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(replyMapper.getCountByBno(bno), replyMapper.getListWithPaging(cri, bno));
	}

	@Transactional
	public int register(ReplyVO reply) {
		boardMapper.updateReplyCnt(reply.getBno(), 1);
		
		return replyMapper.insert(reply);
	}

	public ReplyVO get(Long rno) {
		return replyMapper.read(rno);
	}

	public int modify(ReplyVO board) {
		return replyMapper.update(board);
	}

	@Transactional
	public int remove(Long rno) {
		ReplyVO reply = replyMapper.read(rno);
		
		boardMapper.updateReplyCnt(reply.getBno(), -1);
		return replyMapper.delete(rno);
	}
}
