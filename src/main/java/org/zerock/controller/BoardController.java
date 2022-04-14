package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	private final BoardService service;
	
	// 목록
	@GetMapping("/list")
	public String list(Criteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalCount(cri)));
		return "board/list";
	}
	
	@GetMapping("/testView")
	public String testView() {
		return "testView";
	}
	@GetMapping("/test")
	public void test(@RequestParam String list) {
		String[] listArr = list.split("/");
		
		for(int i = 0 ; i < listArr.length; i++) {
			BoardVO board = service.get((long)Integer.parseInt(listArr[i]));
			System.out.println(board);
		}
	}

	// 조회
	@GetMapping({"/get", "/modify"})
	public void get(Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
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
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}


	// 수정
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr) {
		int count = service.modify(board);

		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}

	// 삭제
	@PostMapping("/remove")
	public String remove(Long bno, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr) {
		int count = service.remove(bno);
		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
}
