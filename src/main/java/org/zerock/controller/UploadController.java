package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Slf4j
public class UploadController {
	private final static String UPLOAD_FOLDER = "C:\\Users\\hjs\\Desktop\\test\\";

	@GetMapping("/uploadForm")
	public String uploadForm() {
		return "uploadForm";
	}

	@GetMapping("/uploadAjax")
	public String uploadAjax() {
		return "uploadAjax";
	}

	@PostMapping("/uploadFormAction")
	public ResponseEntity<List<AttachFileDTO>> uploadFormAction(MultipartFile[] uploadFile,
			@RequestParam Map<String, String> inMap, HttpServletResponse response)
			throws IllegalStateException, IOException {
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		String uploadFolderPath = getFolder();
		File uploadPath = new File(UPLOAD_FOLDER, uploadFolderPath);

		// today 년/월/일 폴더 생성
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}

		for (MultipartFile file : uploadFile) {
			AttachFileDTO attach = new AttachFileDTO();
			log.info("getOriginalFilename : " + file.getOriginalFilename());
			log.info("getContentType : " + file.getContentType());
			log.info("getName : " + file.getName());
			log.info("getSize : " + file.getSize());
			String uuid = UUID.randomUUID().toString();
			String uploadFileName = uuid + "_" + file.getOriginalFilename();
			File saveFile = new File(uploadPath, uploadFileName);
			
			//파일 저장!!!
			file.transferTo(saveFile);

			// attach 객체 세팅
			attach.setFileName(file.getOriginalFilename());
			attach.setUuid(uuid);
			attach.setUploadPath(uploadFolderPath);

			// 이미지인 경우 섬네일 생성
			String type = checkImageType(saveFile);
			if (type.contains("image")) {
				attach.setType("img");
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);

				thumbnail.close();
			}else if(type.contains("video")) {
				attach.setType("video");
			}else {
				attach.setType("attach");
			}

			list.add(attach);
		}

		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}

	@GetMapping("/display")
	public ResponseEntity<byte[]> getFiles(String fileName) {
		File file = new File(UPLOAD_FOLDER, fileName);

		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();

			header.add("content-Type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> download(String fileName) throws MalformedURLException {
		String path = "C:\\Users\\hjs\\Desktop\\test\\";
		
//		Resource resource = new FileSystemResource(path + fileName);
		Resource resource = new UrlResource("file:"+path + fileName); 
		
		if(!resource.exists()) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		String reosurceOriginalFileName = resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("content-Disposition", "attachment; filename=" + new String(reosurceOriginalFileName.getBytes("UTF-8"), "ISO-8859-1"));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) throws UnsupportedEncodingException{
		File file;
		fileName = new URLDecoder().decode(fileName, "UTF-8");	//스프링에서 post로 받을때 디코딩이 안된다.
		try {
			//파일 삭제
			file = new File(UPLOAD_FOLDER + fileName);
			file.delete();
			
			//섬네일 이미지도 삭제
			if(type != null && type.equals("img")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				file = new File(largeFileName);
				file.delete();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();

		String str = sdf.format(today);

		return str.replace("-", File.separator);
	}

	private String checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "null";
	}
}
