package com.image.controller;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.security.Principal;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.image.dto.ImageBoardDto;
import com.image.mapper.ImageBoardMapper;
import com.image.mapper.SecurityMapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/imageBoard/*")
public class BoardController {
	@Autowired ImageBoardMapper bmapper;
	
	@GetMapping("/main")
	public String index(HttpServletRequest request, Model model) {
		int page= 0;
		int start= 1;
		if(request.getParameter("page")!=null) {
			page= Integer.parseInt(request.getParameter("page"));
			start= ((int)Math.floor((page-1)/10))*10 +1;
		}
		
		int totalPage= (int)Math.ceil(bmapper.count()/10.0);
		/*
		 * log.info("...........start: "+start);
		 * log.info("............totalpage: "+totalPage);
		 * log.info("select 10: "+bmapper.listPage(page*10).toString());
		 */
		model.addAttribute("res", bmapper.listPage((page<=0?0:(page-1)*10)));
		model.addAttribute("start", start);
		model.addAttribute("end", (totalPage<(start+9)?totalPage:start+9));
		model.addAttribute("current", page);
		model.addAttribute("totalPage", totalPage);
		return "board/main";
	}
	
	@GetMapping("/detail")
	public String detail(ImageBoardDto dto, Model model) {
		log.info("............update hit: "+bmapper.updateHit(dto));
		model.addAttribute("select", bmapper.selectOne(dto));
		log.info("..................select: "+bmapper.selectOne(dto).toString());
		return "board/detail";
	}
	
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}
	
	@PostMapping("/write_action")
	public String write_action(@RequestParam("bfile") MultipartFile bfile, HttpServletRequest request, RedirectAttributes rAtt) throws IOException {
		log.info("......................0: ");
		ImageBoardDto dto= new ImageBoardDto();
		dto.setBname(request.getParameter("bname")); dto.setBtitle(request.getParameter("btitle")); dto.setBpass(request.getParameter("bpass"));
		dto.setBcontent(request.getParameter("bcontent")); dto.setBip(InetAddress.getLocalHost().getHostAddress().toString());
		if(!bfile.isEmpty()) {
			String imgName= UUID.randomUUID().toString()+"_"+bfile.getOriginalFilename();
			//String path= "C://upload";
			String path= request.getSession().getServletContext().getRealPath("/resources/img");
			log.info("......................1: "+imgName+"/"+path);
			File target= new File(path, imgName);
			dto.setBfile(imgName);
			FileCopyUtils.copy(bfile.getBytes(), target);
		}
		int res= bmapper.insert(dto);
		log.info("...........................insert: "+res);
		rAtt.addFlashAttribute("select", bmapper.selectOne(dto));
		if(res>0) {
			rAtt.addFlashAttribute("success", "success");
		}else {
			rAtt.addFlashAttribute("success", "fail");
		}
		return "redirect:/imageBoard/main";
	}
	
	@GetMapping("/edit")
	public String edit(ImageBoardDto dto, Model model) {
		model.addAttribute("selectOne", bmapper.selectOne(dto));
		return "board/edit";
	}
	
	@PostMapping("/edit_action")
	public String edit_action(@RequestParam("bfile") MultipartFile bfile, HttpServletRequest request, RedirectAttributes rAtt) throws IOException {
		log.info("......................0: ");
		ImageBoardDto dto= new ImageBoardDto();
		dto.setBno(Integer.parseInt(request.getParameter("bno"))); dto.setBname(request.getParameter("bname")); dto.setBtitle(request.getParameter("btitle")); dto.setBpass(request.getParameter("bpass"));
		dto.setBcontent(request.getParameter("bcontent"));
		if(!bfile.isEmpty()) {
			String imgName= UUID.randomUUID().toString()+"_"+bfile.getOriginalFilename();
			//String path= "C://upload";
			String path= request.getSession().getServletContext().getRealPath("/resources/img");
			log.info("......................1: "+imgName);
			File target= new File(path, imgName);
			dto.setBfile(imgName);
			FileCopyUtils.copy(bfile.getBytes(), target);
		}else {
			dto.setBfile(bmapper.selectOne(dto).getBfile());
		}
		int res= bmapper.update(dto);
		log.info("...........................update: "+res);
		rAtt.addFlashAttribute("select", bmapper.selectOne(dto));
		if(res>0) {
			rAtt.addFlashAttribute("success", "success");
		}else {
			rAtt.addFlashAttribute("success", "fail");
		}
		return "redirect:/imageBoard/detail?bno="+dto.getBno();
	}
	
	@GetMapping("/delete")
	public String delete(ImageBoardDto dto, Model model) {
		model.addAttribute("select", bmapper.selectOne(dto));
		return "board/delete";
	}
	
	@PostMapping("/delete_action")
	public String delete_action(ImageBoardDto dto, Model model) {
		int res= bmapper.delete(dto);
		log.info("...................................delete: "+res);
		if(res>0) {
			model.addAttribute("success", "success");
		}else {
			model.addAttribute("success", "fail");
		}
		return "redirect:/imageBoard/main";
	}
	
	/*
	 * public String uploadRes(MultipartFile file, HttpServletRequest request, Model model) {
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
	 * 
	 */
}
