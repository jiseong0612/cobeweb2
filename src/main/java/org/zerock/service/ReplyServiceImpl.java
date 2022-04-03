package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private final ReplyMapper mapper;
	private final BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO reply) {
		boardMapper.updateReplyCnt(reply.getBno(), 1);
		return mapper.insert(reply);
	}

	@Override
	public ReplyVO read(long bno) {
		return mapper.read(bno);
	}
	
	@Transactional
	@Override
	public int delete(long rno) {
		ReplyVO reply = mapper.read(rno);
		boardMapper.updateReplyCnt(reply.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public int update(ReplyVO reply) {
		return mapper.update(reply);
	}

	//이거 페이징처리 안함
	@Override
	public List<ReplyVO> getListWithPaging(Criteria cri, Long bno) {
		return mapper.getListWithPaging(cri, bno);
	}

	//이거 페이징처리함
	@Override
	public ReplyPageDTO getListPage(Criteria cri, long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
