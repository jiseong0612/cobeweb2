package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;
@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO reply) {
		return mapper.insert(reply);
	}

	@Override
	public ReplyVO read(long bno) {
		return mapper.read(bno);
	}

	@Override
	public int delete(long bno) {
		return mapper.delete(bno);
	}

	@Override
	public int update(ReplyVO reply) {
		return mapper.update(reply);
	}

	@Override
	public List<ReplyVO> getListWithPaging(Criteria cri, Long bno) {
		return mapper.getListWithPaging(cri, bno);
	}

}
