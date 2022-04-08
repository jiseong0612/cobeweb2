package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import net.coobird.thumbnailator.Thumbnailator;

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
	
	@ResponseBody
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile) throws IllegalStateException, IOException {
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "c:\\upload";
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile file :uploadFile) {
			AttachFileDTO attachDto = new AttachFileDTO();
			String uploadFileName = file.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			File saveFile = new File(uploadPath, uploadFileName);
			//try catch...
			file.transferTo(saveFile);
			
			attachDto.setFileName(uploadFileName);
			attachDto.setUuid(uuid.toString());
			attachDto.setUploadPath(uploadFolderPath);
			if(checkImageType(saveFile)) {
				attachDto.setImage(true);
				FileOutputStream fos = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(file.getInputStream(), fos, 100, 100);
				fos.close();
			}
			list.add(attachDto);
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//이미지 파일인지 검사
	public boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch (Exception e) { 
			e.printStackTrace();
		}
		return false;	
	}
	
	//날짜별 경로 생성
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
}
