package com.image.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ImageController {
	@GetMapping("/image/index")
	public String uploadIndex() {
		log.info("...........INDEX Load");
		return "/upload_form";
	}
	@PostMapping("/image/upload")
	public String uploadRes(MultipartFile file, HttpServletRequest request, Model model) {
		log.info("................FILE NAME: "+file.getOriginalFilename());
		log.info("................SIZE: "+file.getSize());
		log.info("................CONTENT TYPE: "+file.getContentType());
		// 파일명에 고유값 더하기 (중복방지)
		String saved= UUID.randomUUID().toString()+"_"+file.getOriginalFilename();
		// 업로드
		String path="C://upload";
		// 호스팅용
		// String path= request.getSession().getServletContext().getRealPath("/")+"upload";
		log.info("PATH: "+path);
		File target= new File(path, saved);				 // new File(파일 경로, 파일명)
		try {
			FileCopyUtils.copy(file.getBytes(), target); // 실제 파일 처리는 스프링에서 제공되는 메서드 사용
		} catch (IOException e) {
			e.printStackTrace();
		}
		model.addAttribute("savedImg", saved);
		model.addAttribute("name", request.getParameter("name"));
		model.addAttribute("title", request.getParameter("title"));
		
		return "/upload_res";
	}
}
