package org.zerock.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/upload")
public class UploadController {
	@GetMapping("/aa")
	public String test() {
		return "upload/test";
	}
	
	@PostMapping("/testAjax")
	@ResponseBody
	public Map<String, String>  testAjax(HttpServletRequest request) throws IOException {
		JSONObject json = new JSONObject();
		Map<String, String> map = new HashMap<>();
		System.out.println(request.getParameter("name"));
		map.put("name", request.getParameter("name"));
		map.put("age", request.getParameter("age"));
		json.put("sara123", map);
        return map;

	}
	
	@GetMapping("/uploadForm")
	public String uploadForm() {
		return "upload/uploadForm";
	}
	
	@GetMapping("/uploadAjax")
	public String uploadAjax() {
		return "upload/uploadAjax";
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormAction(MultipartFile[] uploadFile) throws IllegalStateException, IOException {
		String uploadFolder = "c:\\upload";
		for(MultipartFile file : uploadFile) {
			System.out.println(file.getOriginalFilename());
			System.out.println(file.getSize());
			System.out.println(file.getContentType());
			File saveFile = new File(uploadFolder, file.getOriginalFilename());
			file.transferTo(saveFile);
		}
	}
	
	@PostMapping("/uploadAjaxAction")
	public ResponseEntity<String> uploadAjaxAction(MultipartFile[] uploadFile) throws IllegalStateException, IOException {
		String uploadFolder = "c:\\upload";
		for(MultipartFile file :uploadFile) {
			String uploadFileName = file.getOriginalFilename();
			
			File saveFile = new File(uploadFolder, uploadFileName);
			file.transferTo(saveFile);
		}
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
}
