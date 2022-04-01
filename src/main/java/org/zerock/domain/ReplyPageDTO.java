package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
@Data
@Getter
@AllArgsConstructor
public class ReplyPageDTO {
	private int replyCnt;	//토탈 갯수가 필요한 이유 : 페이지 계산을 위해서!
	private List<ReplyVO> list;
}
