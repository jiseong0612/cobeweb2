package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	@Autowired
	private ReplyService service;

	// 등록
	@PostMapping(value = "/new", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "text/plain;charset=utf-8") //MediaType.TEXT_PLAIN_VALUE 한글 내려줄땐 utf-8
	public ResponseEntity<String> create(@RequestBody ReplyVO reply) {
		int result = service.register(reply);
		if (result == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 수정
	@PatchMapping(value = "/{rno}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@PathVariable long rno, @RequestBody ReplyVO reply) {
		reply.setRno(rno);
		int result = service.update(reply);
		if (result == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 삭제
	@DeleteMapping(value = "/{rno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable long rno) {
		int result = service.delete(rno);
		if (result == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 1개 조회	
	@GetMapping(value = "/{rno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReplyVO> get(@PathVariable long rno) {
		return new ResponseEntity<>(service.read(rno), HttpStatus.OK);
	}

	// 목록조회
	@GetMapping(value = "/pages/{bno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable long bno, @PathVariable int page) {
		Criteria cri = new Criteria(page, 10); // 조회하려는 페이지, 게시글 수
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}

}
