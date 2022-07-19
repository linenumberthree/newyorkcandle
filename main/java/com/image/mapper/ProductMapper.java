package com.image.mapper;

import java.util.List;

import com.image.dto.ProductDto;

public interface ProductMapper {
	public int insertProduct(ProductDto dto);
	public int insertProductOption(String candleName);
	public int addFiles(ProductDto dto);
	public int getProductNo(String candleName);
	public List<ProductDto> getAllProducts();
	public int updateProduct(ProductDto dto);
	public int deleteProduct(ProductDto dto);
	public int deleteProductOption(ProductDto dto);
	public ProductDto getDetail(int productNo);	
	public int count();
	public List<ProductDto> listPage(int page);
}
