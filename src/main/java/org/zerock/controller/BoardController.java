package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@GetMapping("/")
	public String boardList(Model model) {
		
		List<BoardVO> boardList = boardService.getList();
		
		model.addAttribute("boardList", boardList);
		return "board/list";
		
	}
}
