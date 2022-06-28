<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/header.jsp" %>
	<div class="wrapper">
		<h3>Candles | 캔들</h3>
			<h4>검색조건</h4>
			<div class="search">
				<p><strong>향</strong>
					<input type="checkbox" name="scent" value="1" id="citrus"/><label for="citrus"> 시트러스</label>
					<input type="checkbox" name="scent" value="2" id="fruity"/><label for="fruity"> 프루티</label>
					<input type="checkbox" name="scent" value="3" id="floral"/><label for="floral"> 플로럴</label>
					<input type="checkbox" name="scent" value="4" id="sweet"/><label for="sweet"> 스윗</label>
					<input type="checkbox" name="scent" value="5" id="woody"/><label for="woody"> 우디</label>
					<input type="checkbox" name="scent" value="6" id="clean"/><label for="clean"> 클린</label>
				</p>
				<p><strong>효과</strong>
					<input type="checkbox" name="effect" value="1" id="concentrate"/><label for="concentrate"> 집중력 향상</label>
					<input type="checkbox" name="effect" value="2" id="innerpeace"/><label for="innerpeace"> 심신 안정</label>
					<input type="checkbox" name="effect" value="3" id="changemood"/><label for="changemood"> 기분 전환</label>
					<input type="checkbox" name="effect" value="4" id="deepsleep"/><label for="deepsleep"> 숙면</label>
				</p>
				<p><strong>장소</strong>
					<input type="checkbox" name="place" value="1" id="bedroom"/><label for="bedroom"> 침실</label>
					<input type="checkbox" name="place" value="2" id="livingroom"/><label for="livingroom"> 거실</label>
					<input type="checkbox" name="place" value="3" id="kitchen"/><label for="kitchen"> 부엌</label>
					<input type="checkbox" name="place" value="4" id="bathroom"/><label for="bathroom"> 화장실</label>
					<input type="checkbox" name="place" value="5" id="etc"/><label for="etc"> etc</label>
				</p>
				<hr/>
				<div class="row"><div class="col-sm-1"><strong><label for="searchName">제품명</label></strong></div>
				<div class="col-sm-3"><input type="text" name="searchName" id="searchName" class="form-control"></div></div>
			</div>
			<div><p><a href="${pageContext.request.contextPath }/candles.view" class="btn btn-primary" style="margin-top: 10px">검색 조건 초기화</a></p></div>
		<div class="box candleList">
			<div class="row form-group result">
				<c:forEach var="res" items="${candleList}" varStatus="status">
					<div class="col-sm-3">
						<%-- <a href='http://vigdsing.cafe24.com/Springboard_img/product/detail?catNo=1&productNo=${res.getProductNo() }' title='상품 상세보기'> --%>
						<a href='${pageContext.request.contextPath }/detail.product?catNo=1&productNo=${res.getProductNo() }' title='상품 상세보기'>
						<img src="http://vigdsing.cafe24.com/resources/thumbnail/${ res.getThumbnailImg()}" alt="${res.getCandleName() }"/>
						<h4>${res.getCandleName() }</h4>
						<p>${res.getScentName() } / ${res.getEffectName() } / ${res.getPlaceName() }</p>
						</a>
						<p>
						<select name="candleOption${res.getProductNo() }" class="product" id="${res.getProductNo() }">
							<option value="S" selected>S</option>
							<option value="M">M</option>
							<option value="L">L</option>
						</select>
						</p>
						<p id="candleOption${res.getProductNo() }Price">${res.getOptionPrice() } w</p>
					</div>
				</c:forEach>
			</div>
			<ul class="pagination">
				<c:forEach var="j" begin="${ start }" end="${ end }">
				<c:if test="${j%10==1 && j>1}"><li><a href="${pageContext.request.contextPath }/candles.product?page=${start-1 }"> 이전 </a></li></c:if>
				<li <c:if test="${current== j }"> class="active" </c:if>><a href="${pageContext.request.contextPath }/candles.product?page=${j }">${ j }</a></li>
				<c:if test="${j%10==0 && j<totalPage}"><li><a href="${pageContext.request.contextPath }/candles.product?page=${end+1 }"> 다음 </a></li></c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	<script>
		$(function(){
			var checkedScent= []; var checkedEffect= []; var checkedPlace= [];
			$('input[type=checkbox]').click(function(index, item){
				checkedScent= []; checkedEffect= []; checkedPlace= [];
		    	$(":checkbox[name='scent']:checked").each(function(i) {
		    		checkedScent.push($(this).val());
		        });
		    	$(":checkbox[name='effect']:checked").each(function(i) {
		    		checkedEffect.push($(this).val());
		        });
		    	$(":checkbox[name='place']:checked").each(function(i) {
		    		checkedPlace.push($(this).val());
		        });
		    	
			    searchProductList("", checkedScent, checkedEffect, checkedPlace);
		    });
			
			$("#searchName").keyup(function(){
				searchProductList($("#searchName").val(), checkedScent, checkedEffect, checkedPlace)
			})
			optionChange();
			
		})
		
		function optionChange(){
			$(".product").change(function(){
				$.ajax({
					url:"${pageContext.request.contextPath}/price.product", dataType:"text", type:"get", data:{"option":$(this).val(), "productNo":$(this).attr("name")},
					success(data){
						var productNo= data.split("/")[0];
						var price= data.split("/")[1];
						var resTag= "#candleOption"+productNo+"Price";
						$(resTag).html(price+" w");
					},  error:function(xhr, textStatus, errorThrown){
						$(".result").html(textStatus+"/http - "+xhr.status+", "+errorThrown);
					}
				})
			})
		}
		
		function searchProductList(productName, checkedScent, checkedEffect, checkedPlace){
			$.ajax({
				url:"${pageContext.request.contextPath}/search.product", dataType:"json", type:"get", data:{"productName": productName, "scent":checkedScent, "effect":checkedEffect, "place":checkedPlace},
		    	success:function(data){
		    		$(".result").empty();
		    		var list= data;
		    		if(list.length==0){
		    			$(".result").html("<h4>검색 결과가 없습니다.</h4>");
		    		}else{
		    			for(var i in list){
			    			var form= "<div class='col-sm-3'>"
			    			//var img= "<a href='http://vigdsing.cafe24.com/Springboard_img/product/detail?catNo=1&productNo="+list[i].productNo+"' title='상품 상세보기'><img src='${pageContext.request.contextPath}/img/candleImage/"+list[i].productNo+".jpg' alt='"+list[i].candleName+"' style='width:100%'/>";
			    			var img= "<a href='${pageContext.request.contextPath}/detail.product?catNo=1&productNo="+list[i].productNo+"' title='상품 상세보기'><img src='http://vigdsing.cafe24.com/resources/thumbnail/"+list[i].thumbnailImg+"' alt='"+list[i].candleName+"'/>";
			    			var name= "<h4>"+list[i].candleName+"</h4>";
			    			var tag= "<p>"+list[i].scentName+" / "+list[i].effectName+" / "+list[i].placeName+"</p></a>";
			    			var selectBox= "<p><select name='candleOption"+list[i].productNo+"' class='product' id='"+list[i].productNo+"'>"
			    				+"<option value='S' selected>S</option>"
			    				+"<option value='M'>M</option>"
			    				+"<option value='L'>L</option>"
			    				+"</select></p>"
			    				+"<p id='candleOption"+list[i].productNo+"Price'>"+list[i].optionPrice+" w</p>";
			    			form+= img+name+tag+selectBox+"</div>";
			    			$(".result").append(form);
			    			optionChange();
			    		}
		    		}
		    	}, error:function(xhr, textStatus, errorThrown){
					$(".result").html(textStatus+"/http - "+xhr.status+", "+errorThrown);
				}
			})
		}
	</script>
<%@ include file="../inc/footer.jsp" %>