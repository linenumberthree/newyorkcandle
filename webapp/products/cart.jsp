<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/header.jsp" %>
	<div class="wrapper">
		<h3>장바구니</h3>
		<br/>
		<div style='float:left'>
		<label for='selectAll'>전체 선택</label><input type='checkBox' name='deleteCart' id='selectAll' value='selectAll'/>
		</div>
		<div class="box" id="resDiv">
		
		</div>
		<div style="float:left">
			<p><input type="button" id="deleteSelected" class='btn btn-warning' value='선택 삭제'/>
			<input type="button" id="deleteAll" class='btn btn-danger' value='전체 삭제'/></p>
		</div>
		<div style="float:right">
			<h3 id="priceRes"></h3>
			<input type="button" id="purchase" class='btn btn-primary form-control' value='구매'/>
		</div>
	</div>
	<script>
		var signIn= ${signIn};
		if(!signIn){
			location.href='login.view';
		}
		$(function(){
			getAllList(${res});
			
			$('.modifyOption').on('click', function(){
				var productNo= $(this).attr("id");
				var countTag= "#changeCount"+productNo;
				var optionTag= "#option"+productNo;
				
				var newCount= $(countTag).val();
				var option= $(optionTag).val();
				console.log(newCount+", "+option);
				$.ajax({
					url:"${pageContext.request.contextPath}/cartUpdate.do", dataType:"text", type:"get", data:{"option":option, "productNo":productNo, "count":newCount},
					success(data){
						alert('수정되었습니다.');
						$('#changeOption'+productNo).val(newCount);
						$('#optionPrice'+productNo).html(data.split('/')[1]+" 원");
						getPriceSum();
					}, error:function(xhr, textStatus, errorThrown){
						$("#optionPrice").html(textStatus+"/http - "+xhr.status+", "+errorThrown);
					}
				})
			})
			
			$('#selectAll').on('click', function(){
				if($('#selectAll').is(':checked')){
			      	$('.deleteCart').prop('checked', true);
			    }else{
			       	$('.deleteCart').prop('checked', false);
			    }
			})
			$('.deleteCart').on('click', function(){
				if($('input[class=deleteCart]:checked').length==$('.deleteCart').length){
			        $('#selectAll').prop('checked',true);
			    }else{
			       $('#selectAll').prop('checked',false);
			    }
			})
			
			$('input[type=checkbox]').click(function(index, item){
		    	getCheckedList();
			})
			
			$('#deleteAll').on('click', function(){
				if(confirm('전체 상품을 삭제하시겠습니까?')){
					location.href='cart_deleteAll.do';
				}else{
					return false;
				}				
			})
			$('#deleteSelected').on('click', function(){
				if(getCheckedList().length==0){
					alert('제품이 선택되지 않았습니다.');
					return false;
				}else{
					if(confirm('선택 상품을 삭제하시겠습니까?')){
						$.ajax({
							url:'${pageContext.request.contextPath}/cart_deleteSelected.do', dataType:"json", data: {"deleteList":getCheckedList()},
							success(data){
								alert('삭제되었습니다.');
								$('#resDiv').empty();
								getAllList(data);
							}, error:function(xhr, textStatus, errorThrown){
								$("#resDiv").html(textStatus+"/http - "+xhr.status+", "+errorThrown);
							}
						})
					}else{
						return false;
					}
				}
			})
				
			
			
			///////////////////////////////////////////////FUNCTIONS/////////////////////////////////////////////////
			
			function getPriceSum(res){
				var list= res;
				var sum= 0;
				for(var i in list){
					sum+= parseInt(list[i].optionPrice)*parseInt(list[i].count);
				}
				return sum;
			}
			function getCheckedList(){
				var deleteList= [];
				$(":checkbox[name='deleteCart']:checked").each(function(i) {
		    		deleteList.push($(this).val());
		        });
		    	console.log(deleteList);
		    	return deleteList;
			}
			function getAllList(data){
				var list= data;
				if(list.length==0){
					$(".box").html("<h3>담은 상품이 없습니다.</h3><p><a href='${pageContext.request.contextPath }/candles.product' title='캔들'>쇼핑하러 가기</a></p>");
				}else{
					var tableTag= "<table class='table table-hover'><thead><tr style='text-align:center'><th>선택</th><th>제품</th><th>옵션</th><th>가격</th></tr></thead><tbody>";
					for(var i in list){
						var checkTag="<tr><td><input type='checkBox' name='deleteCart' value='"+list[i].productNo+"/"+list[i].option+"' id='deleteCart"+list[i].productNo+"' class='deleteCart'/></td>";
						var imgTag="<td class='col-sm-3 cart'><img src='http://vigdsing.cafe24.com/resources/thumbnail/"+list[i].thumbnailImg+"' title='"+list[i].candleName+"' style='width:40%'/><span><h4>"+list[i].candleName+"</h4></span></td>";
						var optionTag="<td><p><input type='hidden' value='"+list[i].option+"' name='option"+list[i].productNo+"' id='option"+list[i].productNo+"'/>옵션: "+list[i].option+"</p>"
											+"<p>수량: <input type='number' name='changeCount"+list[i].productNo+"' value='"+list[i].count+"' id='changeCount"+list[i].productNo+"' min='1'/></p><p><input type='button' id='"+list[i].productNo+"' value='수정' class='btn btn-default modifyOption'/></td>"
						var priceTag= "<td><p id='optionPrice"+list[i].productNo+"'>"+(list[i].count*list[i].optionPrice)+" 원</p></td></tr>";
						
						tableTag+=(checkTag+imgTag+optionTag+priceTag);
					}
					$('#resDiv').append(tableTag+"</tbody></table>");
					$("#priceRes").html("총 "+getPriceSum(list)+"원");
				}
			}
		})
		
	</script>
<%@ include file="../inc/footer.jsp" %>