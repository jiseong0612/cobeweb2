package org.zerock.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/sample")
@Slf4j
public class SampleController {
	@GetMapping(value = "/getText", produces ="text/plain;charset=utf-8")
	public String getText() {
		return "안녕하세요";
	}
	
	@PostMapping("/hello")
	public Hello hello(@RequestBody Hello hello) {
		return hello;
	}
	
	static class Hello{
		private String name;
		private int age;
	
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}
		
		
	}
}
