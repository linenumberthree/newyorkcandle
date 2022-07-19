<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../inc/header.jsp" %>
	<div class="wrapper">
		<h3>상품 관리</h3>
		<div class="container">
		<div class="box">
			<table class="table table-hover">
			<thead>
			<tr><th>NO</th><th>상품명</th><th>향</th><th>효과</th><th>장소</th><th>등록일자</th></tr>
			</thead>
			<tbody>
				<c:forEach var="res" items="${candleList}" varStatus="status">
					<tr><td>${res.productNo }</td><td><a href="${pageContext.request.contextPath }/product/detail?productNo=${res.productNo}">${res.candleName }</a></td><td>${res.scentName }</td><td>${res.effectName }</td><td>${res.placeName }</td><td>${res.productDate }</td></tr>
				</c:forEach>
			</tbody>
			</table>

			<ul class="pagination">
				<c:forEach var="j" begin="${ start }" end="${ end }">
				<c:if test="${j%10==1 && j>1}"><li><a href="${pageContext.request.contextPath }/product/main?page=${start-1 }"> 이전 </a></li></c:if>
				<li <c:if test="${current== j }"> class="active" </c:if>><a href="${pageContext.request.contextPath }/product/main?page=${j }">${ j }</a></li>
				<c:if test="${j%10==0 && j<totalPage}"><li><a href="${pageContext.request.contextPath }/product/main?page=${end+1 }"> 다음 </a></li></c:if>
				</c:forEach>
			</ul>
		</div>
		<div class="container">
			<a href="${pageContext.request.contextPath }/product/newProduct" class="btn btn-danger">NEW</a>
		</div>
	</div>
	<!-- <script>
		$(function(){
			$('input[type=checkbox]').click(function(index, item){
		    	var checkedScent= []; var checkedEffect= []; var checkedPlace= [];
		    	$(":checkbox[name='scent']:checked").each(function(i) {
		    		checkedScent.push($(this).val());
		        });
		    	$(":checkbox[name='effect']:checked").each(function(i) {
		    		checkedEffect.push($(this).val());
		        });
		    	$(":checkbox[name='place']:checked").each(function(i) {
		    		checkedPlace.push($(this).val());
		        });
		    	
		    	
		    	$.ajax({
			    	url:"${pageContext.request.contextPath}/search.product", dataType:"json", type:"get", data:{"scent":checkedScent, "effect":checkedEffect, "place":checkedPlace},
			    	success:function(data){
			    		$(".result").empty();
			    		var list= data;
			    		if(list.length==0){
			    			$(".result").html("<h4>검색 결과가 없습니다.</h4>");
			    		}else{
			    			for(var i in list){
				    			var form= "<div class='col-sm-3'>"
				    			//var img= "<a href='http://vigdsing.cafe24.com/Springboard_img/product/detail?catNo=1&productNo="+list[i].productNo+"' title='상품 상세보기'><img src='${pageContext.request.contextPath}/img/candleImage/"+list[i].productNo+".jpg' alt='"+list[i].candleName+"' style='width:100%'/>";
				    			var img= "<a href='localhost:8080/Springboard_img/product/detail?catNo=1&productNo="+list[i].productNo+"' title='상품 상세보기'><img src='${pageContext.request.contextPath}/img/candleImage/"+list[i].productNo+".jpg' alt='"+list[i].candleName+"' style='width:100%'/>";
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
		    });
			
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
	</script> -->
	</div>
<%@ include file="../inc/footer.jsp" %>