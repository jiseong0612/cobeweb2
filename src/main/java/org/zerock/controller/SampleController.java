package org.zerock.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/sample")
@Slf4j
public class SampleController {
	@GetMapping("/all")
	public String doAll() {
		log.info("do all can access everybody");
		return "sample/all";
	}
	@GetMapping("/member")
	public String domember() {
		log.info("login member");
		return "sample/member";
	}

	@GetMapping("/admin")
	public String doadmin() {
		log.info("admin only");
		return "sample/admin";
	}
}
