<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../inc/header.jsp" %>
<div class="box">
<div class="container panel panel-default">
	<h3 class="panel-heading">상품 데이터 삭제</h3>
	<form action="${pageContext.request.contextPath }/product/delete_action?${_csrf.parameterName}=${_csrf.token }" method="post" id="delete_action">
	<fieldSet>
	<div class="form-group">
	<label for="password">관리자 비밀번호를 입력하세요.</label>
	<input type="password" name="password" id="password" class="form-control"/>
	</div>
	<div class="form-group">
	<input type="submit" value="삭제" id="delete_submit" class="btn btn-block btn-danger"/>
	<input type="button" value="목록" id="delete_list" class="btn btn-block btn-default"/>
	<input type="hidden" name="productNo" id="productNo" value="${res.productNo }">
	<input type="hidden" id="adminId" value="<sec:authentication property="principal.member.userid"/>"/>
	</div>
	<script>
	$(function(){
		$('#delete_action').on('submit', function(){
			if($('#password').val()==""){
				alert("비밀번호를 입력하세요.")
				$('#password').focus()
				return false;
			}else{
				$.ajax({
					url:"${pageContext.request.contextPath}/security/checkPw", dataType:"text", type:"post", data:{"id":$("#adminId").val(), "pw":$("#password").val(), "${_csrf.parameterName}":"${_csrf.token }"},
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
		$('#delete_list').on('click', function(){
			location.href="${pageContext.request.contextPath}/product/main";
		})
	})
	</script>
	</fieldSet>
	</form>
</div>
</div>
<%@ include file="../inc/footer.jsp" %>