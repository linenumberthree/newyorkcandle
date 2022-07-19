<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../inc/header.jsp" %>
<div class="box">
	<div class="container">
	<h3 style="text-align:left">상품 데이터 수정</h3>
	<form action="${pageContext.request.contextPath }/product/edit_action?${_csrf.parameterName}=${_csrf.token }" method="post" id="edit_form" enctype="multipart/form-data">
		<fieldset>
		<input type="hidden" id="productNo" name="productNo" value="${res.productNo }"/>
		<label for="category">상품 종류</label>
		<select name="category" class="form-control" id="category" disabled>
			<option value="1" selected>캔들</option>
		</select><hr/>
		<label for="productName">상품명</label>
		<input type="text" name="productName" id="productName" class="form-control" value="${res.candleName }"/><hr/>
		<label for="adminId">등록자</label>
		<input type="text" name="adminId" id="adminId" class="form-control" value="<sec:authentication property="principal.member.userid"/>" readonly/><hr/>
		<label for="adminPw">비밀번호</label>
		<input type="password" name="adminPw" id="adminPw" class="form-control"/><hr/>
		<label for="scent">향</label>
			<select name="scent" class="form-control" id="scent">
				<option value="1" id="scent1">시트러스</option>
				<option value="2" id="scent2">프루티</option>
				<option value="3" id="scent3">플로럴</option>
				<option value="4" id="scent4">스윗</option>
				<option value="5" id="scent5">우디</option>
				<option value="6" id="scent6">클린</option>
			</select><hr/>
		<label for="effect">효과</label>
			<select name="effect" class="form-control" id="effect">
				<option value="1" id="effect1">집중력 향상</option>
				<option value="2" id="effect2">심신 안정</option>
				<option value="3" id="effect3">기분 전환</option>
				<option value="4" id="effect4">숙면</option>
			</select><hr/>
		<label for="place">장소</label>
			<select name="place" class="form-control" id="place">
				<option value="1" id="place1">침실</option>
				<option value="2" id="place2">거실</option>
				<option value="3" id="place3">부엌</option>
				<option value="4" id="place4">화장실</option>
				<option value="5" id="place5">기타</option>
			</select><hr/>
		<label for="thumbnail">썸네일이미지(대표이미지)</label>
		<input type="file" name="thumbnail" id="thumbnail" class="form-control"/><hr/>
		<label for="detailimg">상세정보이미지(상품정보)</label>
		<input type="file" name="detailimg" id="detailimg" class="form-control"/><hr/>
		<br/>
			<input type="submit" value="등록" id="new_submit" class="btn btn-primary btn-block"/><br/>
			<input type="reset" value="초기화" id="new_cancle" class="btn btn-basic btn-block"/><br/>
			<input type="button" value="목록" id="new_back" class="btn btn-basic btn-block"/>
		</fieldset>
	</form>
	</div>
	
	<script>
		$(function(){
			console.log("${res.scentNo}, "+${res.scentNo});
			$('#scent'+${res.scentNo}).attr("selected", "selected");
			$('#effect'+${res.effectNo}).attr("selected", "selected");
			$('#place'+${res.placeNo}).attr("selected", "selected");
			
			$("#edit_form").on('submit', function(){
				if($('#productName').val()=="" || $('#adminPw').val()==""){
					alert('빈칸을 확인해주세요.');
					return false;
				}else{
					$.ajax({
						url:"${pageContext.request.contextPath}/security/checkPw", dataType:"text", type:"post", data:{"id":$("#adminId").val(), "pw":$("#adminPw").val(), "${_csrf.parameterName}":"${_csrf.token }"},
						success(data){
							console.log(data);
							if(data=='fail'){
								alert('비밀번호가 일치하지 않습니다.');
								return false;
							}
						},  error:function(xhr, textStatus, errorThrown){
							console.log(textStatus+"/http - "+xhr.status+", "+errorThrown);
						}
					})
				}
			})
		})
		</script>
</div>
<%@ include file="../inc/footer.jsp" %>