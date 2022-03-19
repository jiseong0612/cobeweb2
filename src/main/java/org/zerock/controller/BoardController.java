package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
	private final BoardService service;

	// 목록
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", service.getList());
		return "board/list";
	}

	// 조회
	@GetMapping("/read")
	public String read(Long bno, Model model) {
		model.addAttribute("board", service.get(bno));
		return "board/read";
	}

	// 등록
	@GetMapping("/register")
	public String reigster() {
		return "board/register";
	}

	// 등록
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		service.register(board);
		rttr.addFlashAttribute("rowCnt", board.getBno());
		return "redirect:/board/list";
	}

	// 삭제
	@PostMapping("/remove")
	public String remove(Long bno, RedirectAttributes rttr) {
		int count = service.remove(bno);
		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}

	// 수정
	@GetMapping("/modify")
	public String modify() {
		return "board/modify";
	}

	// 수정
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		int count = service.modify(board);

		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}

}
