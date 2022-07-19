package com.image.mapper;

import com.image.dto.UserDto;

public interface SecurityMapper {
	public UserDto read_security(String id);
	public UserDto read_security_by_no(int adminNo);
	public int joinNew(UserDto dto);
	public int checkDupId(String id);
}
