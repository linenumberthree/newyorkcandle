package mjlee.portfolio.dao;

public class CandleDto {
	private String candleName, scentName, effectName, placeName, option, thumbnailImg, detailImg;
	
	private int productNo, goodsCatNo, scentNo, effectNo, placeNo, optionPrice, count;

	public CandleDto(String candleName, String scentName, String effectName, String placeName, int productNo,
			int goodsCatNo, int scentNo, int effectNo, int placeNo, int optionPrice, String thumbnailImg, String detailImg) {
		super();
		this.candleName = candleName;
		this.scentName = scentName;
		this.effectName = effectName;
		this.placeName = placeName;
		this.productNo = productNo;
		this.goodsCatNo = goodsCatNo;
		this.scentNo = scentNo;
		this.effectNo = effectNo;
		this.placeNo = placeNo;
		this.optionPrice= optionPrice;
		this.thumbnailImg= thumbnailImg;
		this.detailImg= detailImg;
	}
	
	public CandleDto(int productNo, String candleName, String thumbnailImg) {
		super();
		this.candleName = candleName;
		this.productNo = productNo;
		this.thumbnailImg= thumbnailImg;
	}

	public CandleDto() {
		super();
	}

	@Override
	public String toString() {
		return "CandleDto [candleName=" + candleName + ", scentName=" + scentName + ", effectName=" + effectName
				+ ", placeName=" + placeName + ", productNo=" + productNo + ", goodsCatNo=" + goodsCatNo + ", scentNo="
				+ scentNo + ", effectNo=" + effectNo + ", placeNo=" + placeNo + ", optionPrice=" + optionPrice + "]";
	}

	public String getCandleName() {
		return candleName;
	}
	public void setCandleName(String candleName) {
		this.candleName = candleName;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getGoodsCatNo() {
		return goodsCatNo;
	}
	public void setGoodsCatNo(int goodsCatNo) {
		this.goodsCatNo = goodsCatNo;
	}
	public int getScentNo() {
		return scentNo;
	}
	public void setScentNo(int scentNo) {
		this.scentNo = scentNo;
	}
	public int getEffectNo() {
		return effectNo;
	}
	public void setEffectNo(int effectNo) {
		this.effectNo = effectNo;
	}
	public int getPlaceNo() {
		return placeNo;
	}
	public void setPlaceNo(int placeNo) {
		this.placeNo = placeNo;
	}
	public String getScentName() {
		return scentName;
	}
	public void setScentName(String scentName) {
		this.scentName = scentName;
	}
	public String getEffectName() {
		return effectName;
	}
	public void setEffectName(String effectName) {
		this.effectName = effectName;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public int getOptionPrice() {
		return optionPrice;
	}
	public void setOptionPrice(int optionPrice) {
		this.optionPrice = optionPrice;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public String getThumbnailImg() {
		return thumbnailImg;
	}
	public void setThumbnailImg(String thumbnailImg) {
		this.thumbnailImg = thumbnailImg;
	}
	public String getDetailImg() {
		return detailImg;
	}
	public void setDetailImg(String detailImg) {
		this.detailImg = detailImg;
	}
}
