package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@RequestMapping("/sample")
@Log4j
@Controller
public class SampleController {

	@GetMapping("/all")
	public String doAll() {
		log.info("all can access everybody");
		
		return "sample/all";
	}
	
	@GetMapping("/member")
	public String doMember() {
		log.info("member can access everybody");
		
		return "sample/member";
	}
	
	@GetMapping("/admin")
	public String doAdmin() {
		log.info("admin can access everybody");
		
		return "sample/admin";
	}

	
}
