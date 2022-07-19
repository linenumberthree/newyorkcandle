package com.image.mapper;

import java.util.ArrayList;

import com.image.dto.ImageBoardDto;

public interface ImageBoardMapper {
	public ArrayList<ImageBoardDto> selectAll();
	public ImageBoardDto selectOne(ImageBoardDto dto);
	public int update(ImageBoardDto dto);
	public int updateHit(ImageBoardDto dto);
	public int delete(ImageBoardDto dto);
	public int insert(ImageBoardDto dto);
	public ArrayList<ImageBoardDto> listPage(int start);
	public int count();
}
