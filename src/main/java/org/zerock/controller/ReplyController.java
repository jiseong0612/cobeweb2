package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies")
@Log4j
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	@GetMapping(value = "/{rno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReplyVO>get(@PathVariable Long rno){
		ReplyVO reply = replyService.get(rno);
		return new ResponseEntity<ReplyVO>(reply, HttpStatus.OK);
	}

	@GetMapping(value = "/pages/{bno}/{pageNum}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReplyVO>> getList(Criteria cri, @PathVariable Long bno) {
		List<ReplyVO> list = replyService.getList(cri, bno);

		return new ResponseEntity<List<ReplyVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/new", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> create(@RequestBody ReplyVO reply) {
		int insertCount = replyService.register(reply);

		return insertCount == 1 
			? new ResponseEntity<String>("success", HttpStatus.OK)
			: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping(value = "{rno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable Long rno) {
		int result = replyService.remove(rno);

		return result == 1 
			? new ResponseEntity<String>("success", HttpStatus.OK) 
			: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PATCH, RequestMethod.PUT}
		, value = "/{rno}"
		, produces = MediaType.TEXT_PLAIN_VALUE
		, consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String>modify(@RequestBody ReplyVO reply){
//		public ResponseEntity<String>modify(@RequestBody ReplyVO reply, @PathVariable Long rno){
//		reply.setRno(rno); rno이걸 굳이 path variable 로 안 받아도 reply 객체에 다 담길것 같아서 ? 주석해봄 test
		int result = replyService.modify(reply);
		
		return result == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
