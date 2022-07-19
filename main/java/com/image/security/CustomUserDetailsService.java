package com.image.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.image.dto.UserDto;
import com.image.mapper.SecurityMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	@Setter(onMethod_ = {@Autowired})
	private SecurityMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException{
		log.warn("LOAD USER BY USERNAME: "+userName);
		UserDto vo= new UserDto();
		try {
			vo= mapper.read_security(userName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		log.warn("QUERIED BY MEMBER MAPPER: "+vo);
		return vo==null? null:new CustomUser(vo);
	}
}
