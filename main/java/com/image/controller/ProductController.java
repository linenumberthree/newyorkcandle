package com.image.controller;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.image.dto.ProductDto;
import com.image.mapper.ProductMapper;
import com.image.mapper.SecurityMapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product/*")
public class ProductController {
	@Autowired ProductMapper mapper;
	@Autowired SecurityMapper smapper;
	
	@GetMapping("/detail")
	public String detail(HttpServletRequest request, Model model) {
		int productNo= Integer.parseInt(request.getParameter("productNo"));
		model.addAttribute("res", mapper.getDetail(productNo));
		return "/product/detail";
	}
	
	@GetMapping("/main")
	@PreAuthorize("isAnonymous()")
	public String index(HttpServletRequest request, Model model) {
		int page= 0;
		int start= 1;
		if(request.getParameter("page")!=null) {
			page= Integer.parseInt(request.getParameter("page"));
			start= ((int)Math.floor((page-1)/10))*10 +1;
		}
		
		int totalPage= (int)Math.ceil(mapper.count()/10.0);

		log.info("...........start: "+start);
		log.info("............totalpage: "+totalPage);
		log.info("select 10: "+mapper.listPage((page<=0?0:(page-1)*10)).toString());
		
		model.addAttribute("candleList", mapper.listPage((page<=0?0:(page-1)*10)));
		model.addAttribute("start", start);
		model.addAttribute("end", (totalPage<(start+9)?totalPage:start+9));
		model.addAttribute("current", page);
		model.addAttribute("totalPage", totalPage);
		return "/product/main";
	}
	
	@GetMapping("/newProduct")
	public String newProductForm() {
		return "/product/newProduct";
	}
	
	@PostMapping("/newProduct_action")
	public String newProduct_action(@RequestParam("thumbnail") MultipartFile thumbnailImg, @RequestParam("detailimg") MultipartFile detailImg, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		ProductDto dto= new ProductDto();
		dto.setCandleName(request.getParameter("productName"));
		dto.setAdminNo(smapper.read_security(request.getParameter("adminId")).getUserno());
		dto.setAdminIp(InetAddress.getLocalHost().getHostAddress());
		dto.setEffectNo(Integer.parseInt(request.getParameter("effect")));
		dto.setScentNo(Integer.parseInt(request.getParameter("scent")));
		dto.setPlaceNo(Integer.parseInt(request.getParameter("place")));
		mapper.insertProduct(dto);
		mapper.insertProductOption(dto.getCandleName());
		
		int productNo= mapper.getProductNo(dto.getCandleName());
		String thumbImgName= UUID.randomUUID().toString()+"_"+productNo+thumbnailImg.getOriginalFilename().substring(thumbnailImg.getOriginalFilename().indexOf("."));
		String thumbPath= "/vigdsing/tomcat/webapps/resources/thumbnail";
		String detailImgName= UUID.randomUUID().toString()+"_"+productNo+"_detail"+detailImg.getOriginalFilename().substring(detailImg.getOriginalFilename().indexOf("."));
		String detailPath= "/vigdsing/tomcat/webapps/resources/detail";
		File target= new File(thumbPath, thumbImgName);
		FileCopyUtils.copy(thumbnailImg.getBytes(), target);
		target= new File(detailPath, detailImgName);
		FileCopyUtils.copy(detailImg.getBytes(), target);
		dto.setThumbnailImg(thumbImgName); dto.setDetailImg(detailImgName); dto.setProductNo(productNo);
		log.info(".............FILENAME: "+dto.getThumbnailImg()+", "+dto.getDetailImg());
		mapper.addFiles(dto);
		return "redirect:/product/main";
	}
	
	@GetMapping("/delete")
	public String deleteForm(Model model, @RequestParam("productNo") int productNo) {
		model.addAttribute("res", mapper.getDetail(productNo));
		model.addAttribute("admin", smapper.read_security_by_no(mapper.getDetail(productNo).getAdminNo()));
		return "/product/delete";
	}
	@PostMapping("/delete_action")
	public String delete_action(@RequestParam("productNo") int productNo) {
		ProductDto dto= new ProductDto();
		dto.setProductNo(productNo);
		mapper.deleteProductOption(dto);
		mapper.deleteProduct(dto);
		return "redirect:/product/main";
	}
	
	@GetMapping("/edit")
	public String editForm(Model model, @RequestParam("productNo") int productNo) {
		model.addAttribute("res", mapper.getDetail(productNo));
		model.addAttribute("admin", smapper.read_security_by_no(mapper.getDetail(productNo).getAdminNo()));
		log.info(".................EDIT FORM _ ADMIN:"+smapper.read_security_by_no(mapper.getDetail(productNo).getAdminNo()).toString());
		return "/product/edit";
	}
	
	@PostMapping("/edit_action")
	public String edit_action(@RequestParam("thumbnail") MultipartFile thumbnailImg, @RequestParam("detailimg") MultipartFile detailImg, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		ProductDto dto= new ProductDto();
		dto= mapper.getDetail(Integer.parseInt(request.getParameter("productNo")));
		int productNo= dto.getProductNo();
		
		if(request.getParameter("productName")!=dto.getCandleName()) {
			dto.setCandleName(request.getParameter("productName"));
		}
		if(Integer.parseInt(request.getParameter("scent"))!=dto.getScentNo()) {
			dto.setScentNo(Integer.parseInt(request.getParameter("scent")));
		}
		if(Integer.parseInt(request.getParameter("effect"))!=dto.getEffectNo()){
			dto.setEffectNo(Integer.parseInt(request.getParameter("effect")));
		}
		if(Integer.parseInt(request.getParameter("place"))!=dto.getPlaceNo()){
			dto.setPlaceNo(Integer.parseInt(request.getParameter("place")));
		}
		if(!thumbnailImg.isEmpty()) {
			String thumbImgName= UUID.randomUUID().toString()+"_"+productNo+thumbnailImg.getOriginalFilename().substring(thumbnailImg.getOriginalFilename().indexOf("."));
			String thumbPath= "/vigdsing/tomcat/webapps/resources/thumbnail";
			File target= new File(thumbPath, thumbImgName);
			FileCopyUtils.copy(thumbnailImg.getBytes(), target);
			dto.setThumbnailImg(thumbImgName);
		}
		if(!detailImg.isEmpty()) {
			String detailImgName= UUID.randomUUID().toString()+"_"+productNo+"_detail"+detailImg.getOriginalFilename().substring(detailImg.getOriginalFilename().indexOf("."));
			String detailPath= "/vigdsing/tomcat/webapps/resources/detail";
			File target= new File(detailPath, detailImgName);
			FileCopyUtils.copy(detailImg.getBytes(), target);
			dto.setDetailImg(detailImgName);
		}
		
		log.info(".............FILENAME: "+dto.getThumbnailImg()+", "+dto.getDetailImg());
		mapper.updateProduct(dto);
		return "redirect:/product/detail?productNo="+productNo;
	}
}
