package com.image.dto;

import lombok.Data;

@Data
public class ImageBoardDto {
	private String bname, btitle, bcontent, bfile, bpass, bip, bdate;
	private int bno, bhit;
}
