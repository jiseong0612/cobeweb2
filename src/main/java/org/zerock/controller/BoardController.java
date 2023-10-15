package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {

	@Autowired
	private BoardService boardService;

	@GetMapping("/list")
	public String boardList(Criteria cri, Model model) {
		List<BoardVO> boardList = boardService.getList(cri);

		model.addAttribute("list", boardList);
		model.addAttribute("pageMaker", new PageDTO(cri, boardService.getTotalCount(cri)));
		
		return "board/list";
	}
	
	@GetMapping("/register")
	public String register() {
		return "board/register";
	}
	
	@GetMapping("/get")
	public String get(Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		BoardVO board = boardService.get(bno);
		
		model.addAttribute("board", board);
		return "board/get";
	}
	
	@GetMapping("/modify")
	public String modify(Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		BoardVO board = boardService.get(bno);
		
		model.addAttribute("board", board);
		return "board/modify";
	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		Long bno = boardService.register(board);

		rttr.addFlashAttribute("result", bno);
		return "redirect:/board/list";
	}

	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		int count = boardService.modify(board);

		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("test", "Testest");

		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(Long bno, Criteria cri, RedirectAttributes rttr) {
		int count = boardService.remove(bno);

		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
}
