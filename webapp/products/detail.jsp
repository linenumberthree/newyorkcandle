<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/header.jsp" %>
	
	<div class="wrapper_m">
		<div class="row box">
			<div class="col-sm-4">
				<img src="http://vigdsing.cafe24.com/resources/thumbnail/${res.getThumbnailImg() }" title="${res.getCandleName() }" style="width:100%"/>
			</div>
			<div class="col-sm-8">
				<h3>${res.candleName }</h3>
				<hr/>
				판매 가격: <h4 id="PriceRes">${res.optionPrice } 원</h4>
				<hr/>
				<p>선택 옵션</p>
				<div class="col-sm-1" style="text-align:right">* 옵션</div>
				<div class="col-sm-5">
					<p><select name="candleOption${res.getProductNo() }" class="product form-control" id="${res.getProductNo() }">
						<option value="S" selected>S</option>
						<option value="M">M (+5000)</option>
						<option value="L">L (+8000)</option>
					</select></p>
				</div>
				<div class="col-sm-1" style="text-align:right">* 수량</div>
				<div class="col-sm-5">
					<p><input type="number" id="count" name="count" class="form-control" value="1"/></p>
				</div>
				<br/>
				<p style="text-align:left">유의사항</p>
				<p style="text-align:left">배송비: 구매 시 결제</p>
				<hr/>
				<p class="col-sm-8"><input type="button" id="purchase" class="btn btn-primary form-control" value="바로 구매"/></p>
				<p class="col-sm-4"><!-- <input type="button" id="cart" class="btn btn-default form-control" value="glyphicon glyphicon-shopping-cart"> -->
				<a href="#" class="btn btn-default form-control" id="cart">
		          <span class="glyphicon glyphicon-shopping-cart"></span>
		        </a>
				</p>
				<c:if test="${signIn}"><p class="col-sm-8"><input type="button" id="heart" class="btn btn-warning form-control" value="찜"/></p></c:if>
				<c:if test="${!signIn }"><p class="col-sm-8"></p></c:if>
				<p class="col-sm-4"><a href="${pageContext.request.contextPath }/candles.product" id="list" class="btn btn-default form-control">목록</a></p>
			</div>
		</div>
	</div>
	<div class="wrapper_m">
		<ul class="row nav nav-tabs">
			<li class="active col-sm-4"><a data-toggle="tab" href="#productDetail">상세정보</a></li>
			<li class="col-sm-4"><a data-toggle="tab" href="#productReview">후기</a></li>
			<li class="col-sm-4"><a data-toggle="tab" href="#productQnA">문의</a></li>
		</ul>
		<div class="box">
			<div class="tab-content">
				<div id="productDetail" class="tab-pane fade in active">
				  <img src="http://vigdsing.cafe24.com/resources/detail/${res.getDetailImg()}" title="상세정보"/>
				</div>
				<div id="productReview" class="tab-pane fade">
					<h4>제품 후기</h4>
				</div>
				<div id="productQnA" class="tab-pane fade">
					<h4>제품 문의</h4>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			optionChange();
			
			$('#cart').on('click', function(){
				var count= $('#count').val();
				var option= $('.product').val();
				location.href="${pageContext.request.contextPath}/cart.do?catNo=1&productNo=${res.productNo}&option="+option+"&count="+count;
				return false;
			})
			
			function optionChange(){
				$(".product").change(function(){
					$.ajax({
						url:"${pageContext.request.contextPath}/price.product", dataType:"text", type:"get", data:{"option":$(this).val(), "productNo":$(this).attr("name")},
						success(data){
							var productNo= data.split("/")[0];
							var price= data.split("/")[1];
							var resTag= "#PriceRes";
							$(resTag).html(price+" 원");
						},  error:function(xhr, textStatus, errorThrown){
							$(".result").html(textStatus+"/http - "+xhr.status+", "+errorThrown);
						}
					})
				})
			}
		})
	</script>
<%@ include file="../inc/footer.jsp" %>