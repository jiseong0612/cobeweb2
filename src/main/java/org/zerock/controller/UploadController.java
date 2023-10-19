package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UploadController {

	@GetMapping("/uplaodForm")
	public String uplaodForm() {
		return "uplaodForm";
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormAction(MultipartFile[] uploadFile) {
		for(MultipartFile file : uploadFile) {
			log.info(file.getOriginalFilename());
		}
	}
}
