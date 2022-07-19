package com.image.dto;

import lombok.Data;

@Data
public class ProductDto {
	private String candleName, scentName, effectName, placeName, adminIp, productDate, thumbnailImg, detailImg;
	private int productNo, goodsCatNo, scentNo, effectNo, placeNo, optionPrice, adminNo;
}
