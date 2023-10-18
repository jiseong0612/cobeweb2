package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {

	List<ReplyVO> getList();

	List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);

	int insert(ReplyVO reply);

	int insertSelectKey(ReplyVO reply);

	ReplyVO read(Long rno);

	int update(ReplyVO reply);

	int delete(Long rno);

	int getCountByBno(Long bno);

	List<ReplyVO> searchTest(Map<String, Map<String, String>> outer);
}
