<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/header.jsp" %>
	<div class="container" id="notice">
		<h3>공지사항</h3>
		<p>이 포트폴리오는 상업적 목적이 아닌 개인 포트폴리오 용도로 제작되었으며
		홈페이지의 일부 내용과 기타 이미지 등은 출처가 따로 있음을 밝힙니다.</p>
		<img src="${pageContext.request.contextPath }/img/QRCodeImg.jpg" title="qrcode"/>
		<p><input type="checkBox" id="dontshow" name="dontshow"><label for="dontshow">24시간 동안 열지 않기</label>
		<input type="button" value="CLOSE" class="btn btn-default" id="close"/></p>
		<p>피드백: 상단 우측 [고객센터] - [1:1문의]</p>
	</div>
	<script>
		function setCookie(cname, cvalue, exdays) {
		  const d = new Date();
		  d.setTime(d.getTime() + (exdays*24*60*60*1000));
		  let expires = "expires="+ d.toUTCString();
		  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
		}
		function getCookie(cname) {
		  let name = cname + "=";
		  let decodedCookie = decodeURIComponent(document.cookie);
		  let ca = decodedCookie.split(';');
		  for(let i = 0; i <ca.length; i++) {
		    let c = ca[i];
		    while (c.charAt(0) == ' ') {
		      c = c.substring(1);
		    }
		    if (c.indexOf(name) == 0) {
		      return c.substring(name.length, c.length);
		    }
		  }
		  return "";
		}
		
		
		$(function(){
			$('#close').on('click', function(){
				if($('#dontshow:checked').length==1){
					setCookie('dontshow', 'done', 1);
				}
				$('#notice').fadeOut();
			})
			
			if(getCookie('dontshow')=="done"){
				$('#notice').hide();
			}else{ $('#notice').fadeIn(); }
			
		})
	</script>
<div class="main wrapper">
	<div id="carousel_main" class="carousel slide" data-ride="carousel">
	  <ol class="carousel-indicators">
	    <li data-target="#carousel_main" data-slide-to="0" class="active"></li>
	    <li data-target="#carousel_main" data-slide-to="1"></li>
	    <li data-target="#carousel_main" data-slide-to="2"></li>
	  </ol>
	  <div class="carousel-inner">
	    <div class="item active">
	      <img src="img/mainSlideImage1.jpg" class="d-block w-100" alt="event">
	    </div>
	    <div class="item">
	      <img src="img/mainSlideImage2.jpg" class="d-block w-100" alt="event">
	    </div>
	    <div class="item">
	      <img src="img/mainSlideImage3.jpg" class="d-block w-100" alt="event">
	    </div>
	  </div>
		  <a class="left carousel-control" href="#carousel_main" role="button" data-slide="prev">
		    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="right carousel-control" href="#carousel_main" role="button" data-slide="next">
		    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </a>
	</div>
	<div class="wrapper" style="text-align:center">
		<h4>금주의 인기 상품을 만나보세요.</h4>
		<c:forEach var="candle" items="${mainCandles }">
			<div class="col-sm-4">
				<a href='${pageContext.request.contextPath }/detail.product?catNo=1&productNo=${candle.getProductNo() }' title='상품 상세보기'>
				<img src="http://vigdsing.cafe24.com/resources/thumbnail/${candle.getThumbnailImg()}" alt="${candle.getCandleName() }" style="width:100%"/>
				<h4>${candle.getCandleName() }</h4>
				</a>
			</div>
		</c:forEach>
	</div>
	<div class="row">
	<hr/>
	</div>
	<div class="wrapper" style="text-align:center">
		<h4>BEST REVIEW</h4>
		<div class="col-sm-6">
			<h4>TITLE</h4>
			<h5>작성자</h5>
			<p>content content content content content content content content</p>
		</div>
		<div class="col-sm-6">
			<h4>TITLE</h4>
			<h5>작성자</h5>
			<p>content content content content content content content content</p>
		</div>
	</div>
</div>
<%@ include file="inc/footer.jsp" %>