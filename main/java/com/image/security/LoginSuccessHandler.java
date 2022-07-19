package com.image.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		log.warn("................LOGINSUCCESSHANDLER: login success");
		
		List<String> roleNames= new ArrayList<>();
		auth.getAuthorities().forEach(authority -> {roleNames.add(authority.getAuthority()); } );
		
		log.warn("................LOGIN SUCCESS HANDLER: role name= "+roleNames);
		
		if(roleNames.get(0).contains("admin")) {
			response.sendRedirect(request.getContextPath()+"/product/main"); return;
		}else {
			response.sendRedirect(request.getContextPath()+"/security/login"); return;
		}
	}
}