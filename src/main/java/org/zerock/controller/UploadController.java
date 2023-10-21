package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

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
	public ResponseEntity<List<AttachFileDTO>> uploadFormAction(MultipartFile[] uploadFile, @RequestParam Map<String, String> inMap,HttpServletResponse response) throws IllegalStateException, IOException {
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		String uploadFolder = "C:\\Users\\hjs\\Desktop\\test";
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		//today 년/월/일 폴더 생성
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile file : uploadFile) {
			AttachFileDTO attach = new AttachFileDTO();
			log.info("getOriginalFilename : " +file.getOriginalFilename());
			log.info("getContentType : " +file.getContentType());
			log.info("getName : " +file.getName());
			log.info("getSize : " +file.getSize());
			String uuid = UUID.randomUUID().toString();
			String uploadFileName = uuid+"_"+file.getOriginalFilename();
			File saveFile = new File(uploadPath, uploadFileName);
			file.transferTo(saveFile);
			
			//attach 객체 세팅
			attach.setFileName(file.getOriginalFilename());
			attach.setUuid(uuid);
			attach.setUploadPath(uploadFolderPath);
			
			//이미지인 경우 섬네일 생성
			if(checkImageType(saveFile)) {
				attach.setImage(true);
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
				Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);
				
				thumbnail.close();
			}
			
			list.add(attach);
		}
		
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getFiles(String fileName){
		String uploadFolder =  "C:\\Users\\hjs\\Desktop\\test";
		File file = new File(uploadFolder, fileName);
		
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.setContentType(MediaType.parseMediaType(Files.probeContentType(file.toPath())));
			
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
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
