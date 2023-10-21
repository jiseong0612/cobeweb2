package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;
import oracle.security.crypto.core.AlgID;

@Controller
@Slf4j
public class UploadController {

	@GetMapping("/uploadForm")
	public String uploadForm() {
		return "uploadForm";
	}
	
	@GetMapping("/uploadAjax")
	public String uploadAjax() {
		return "uploadAjax";
	}
	
	
	@PostMapping("/uploadFormAction")
	public void uploadFormAction(MultipartFile[] uploadFile, @RequestParam Map<String, String> inMap,HttpServletResponse response) throws IllegalStateException, IOException {
		String uploadFoler = "C:\\Users\\hjs\\Desktop\\test";
		
		File uploadPath = new File(uploadFoler, getFolder());
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile file : uploadFile) {
			log.info("getOriginalFilename : " +file.getOriginalFilename());
			log.info("getContentType : " +file.getContentType());
			log.info("getName : " +file.getName());
			log.info("getSize : " +file.getSize());
			String uuid = UUID.randomUUID().toString();
			String uploadFileName = uuid+"_"+file.getOriginalFilename();
			File saveFile = new File(uploadPath, uploadFileName);
			file.transferTo(saveFile);
			
			if(checkImageType(saveFile)) {
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
				Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);
				
				thumbnail.close();
			}
			
		}
		
		response.setStatus(HttpStatus.OK.value());
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		
		String str = sdf.format(today);
		
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
