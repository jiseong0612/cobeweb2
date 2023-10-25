package org.zerock.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@GetMapping("/accessError")
	public String accessError(Authentication auth, Model model) {
		log.info("access failed.................... : " + auth);
		
		model.addAttribute("msg" , "access denided");
		return "accessError";
	}
}
