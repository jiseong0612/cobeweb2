package org.zerock.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {

	@Autowired
	private BoardService service;
	
	@GetMapping(value="/getText")
	public ResponseEntity<BoardVO> getText(HttpServletResponse response) throws IOException {
		BoardVO board = new BoardVO();
			ResponseEntity<BoardVO> result = null;
			
			result = ResponseEntity.status(HttpStatus.OK).body(board);
			
			return result;
	}
	
	@GetMapping(value="/getText2")
	public Object getText(HttpServletResponse response, String type) throws IOException {
		if(type.equals("Y")) {
			response.setContentType("audio/mpeg");
//			response.setHeader("Content-Disposition", "attachment; filename=audio.mp3"); 첨부파일 다운로드
			
			return null;
		}else {
			Criteria cri = new Criteria();
			List<BoardVO> list = service.getList(cri);
			return list;
		}
	}
}
