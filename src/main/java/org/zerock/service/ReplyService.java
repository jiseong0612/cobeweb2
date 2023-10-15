package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper replyMapper;
 
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		return replyMapper.getListWithPaging(cri, bno);
	}
	
	public int getTotalCount(Criteria cri) {
		return replyMapper.getTotalCount(cri);
	}

	public int register(ReplyVO reply) {

		return replyMapper.insert(reply);
	}

	public ReplyVO get(Long rno) {
		return replyMapper.read(rno);
	}

	public int modify(ReplyVO board) {
		return replyMapper.update(board);
	}

	public int remove(Long rno) {
		return replyMapper.delete(rno);
	}
}
