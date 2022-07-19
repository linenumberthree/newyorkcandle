<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../inc/header.jsp" %>
<div class="box">
<div class="container panel panel-default">
	<h3 class="panel-heading">글 삭제</h3>
	<form action="${pageContext.request.contextPath }/imageBoard/delete_action?${_csrf.parameterName}=${_csrf.token }" method="post" id="delete_action">
	<fieldSet>
	<div class="form-group">
	<label for="bpass">비밀번호를 입력하세요.</label>
	<input type="password" name="bpass" id="bpass" class="form-control"/>
	</div>
	<div class="form-group">
	<input type="submit" value="삭제" id="delete_submit" class="btn btn-block btn-danger"/>
	<input type="reset" value="취소" id="delete_cancle" class="btn btn-block btn-default"/>
	<input type="button" value="목록" id="delete_list" class="btn btn-block btn-default"/>
	<input type="text" name="bno" id="bno" style="display:none" value="${select.getBno() }">
	</div>
	<script>
	$(function(){
		$('#delete_action').on('submit', function(){
			if($('#bpass').val()==""){
				alert("비밀번호를 입력하세요.")
				$('#bpass').focus()
				return false;
			}
			if($('#bpass').val()!="${select.getBpass() }"){
				alert("비밀번호가 틀렸습니다.")
				$('#bpass').focus()
				return false;
			}
		})
		$('#delete_cancle').on('click', function(){
			$('#delete_pw').reset();
		})
		$('#delete_list').on('click', function(){
			location.href="${pageContext.request.contextPath }/imageBoard/main"
		})
	})
	</script>
	</fieldSet>
	</form>
</div>
</div>
<%@ include file="../inc/footer.jsp" %>