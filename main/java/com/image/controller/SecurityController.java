package com.image.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.image.dto.UserDto;
import com.image.mapper.SecurityMapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/security/*")
public class SecurityController {
	@Autowired SecurityMapper mapper;
	
	
	@GetMapping("/login")
	public String login() {
		log.info(".............LOGIN PAGE..");
		return "security/login";
	}
	
	@GetMapping("/joinForm")
	public String joinForm() {
		log.info("................LOAD JOIN PAGE..");
		return "security/joinForm";
	}
	
	@PreAuthorize("isAnonymous()")
	@PostMapping("/join")
	public String joinAction(HttpServletRequest request, HttpServletResponse response, Model model) throws UnknownHostException {
		UserDto dto= new UserDto();
		dto.setUserid(request.getParameter("id")); dto.setUserpw(new BCryptPasswordEncoder().encode(request.getParameter("pw"))); dto.setUsername(request.getParameter("name"));
		dto.setUserip(InetAddress.getLocalHost().getHostAddress());
		if(mapper.checkDupId(request.getParameter("id"))==0) {
			try {
				if(mapper.joinNew(dto)>0) {
					log.info(".................JOIN SUCCESS: "+mapper.read_security(dto.getUserid()));
					model.addAttribute("res", "SUCCESS");
					return "redirect:/security/login";
				}else {
					model.addAttribute("res", "FAIL");
					return "redirect:/imageBoard/main";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			model.addAttribute("res", "중복된 아이디입니다.");
			return "redirect:/security/joinForm";
		}
		return "redirect:/imageBoard/main";
	}
	
	@GetMapping("/403")
	public String Error_403() {
		return "/security/403";
	}

	@PostMapping("/checkPw")
	public void checkPw(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpServletRequest request, HttpServletResponse response) throws IOException {
		BCryptPasswordEncoder enc= new BCryptPasswordEncoder();
		PrintWriter out= response.getWriter();
		log.info("...................CHECK PW _ ADMIN: "+mapper.read_security(id).toString());
		if(enc.matches(pw, mapper.read_security(id).getUserpw())) {
			System.out.println("비밀번호 일치");
			out.print("checked");
		}else {
			System.out.println("비밀번호 일치 X");
			out.print("fail");
		}
	}
}
