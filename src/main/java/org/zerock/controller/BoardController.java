package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {

	@Autowired
	private BoardService boardService;

	@GetMapping("/list")
	public String boardList(Model model) {
		List<BoardVO> boardList = boardService.getList();

		model.addAttribute("boardList", boardList);
		return "board/list";
	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.debug("BoardController.register START !!!");

		Long bno = boardService.register(board);

		rttr.addFlashAttribute("result", bno);
		return "redirect:/board/list";
	}

	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		int count = boardService.modify(board);

		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(BoardVO board, RedirectAttributes rttr) {
		int count = boardService.remove(board.getBno());

		if (count == 1) {
			rttr.addFlashAttribute("result", count);
		}

		return "redirect:/board/list";
	}
}
