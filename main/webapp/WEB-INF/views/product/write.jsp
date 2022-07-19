<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="box">
	<div class="container">
	<h3 style="text-align:left">새 글 작성</h3>
	<form action="${pageContext.request.contextPath }/imageBoard/write_action?${_csrf.parameterName}=${_csrf.token }" method="post" id="new_write" enctype="multipart/form-data">
	<fieldset>
	<label for="btitle">제목</label>
	<input type="text" name="btitle" id="btitle" class="form-control"/>
	<label for="bname">작성자</label>
	<input type="text" name="bname" id="bname" class="form-control" value="<sec:authentication property="principal.member.username"/>" readonly/>
	<label for="bcontent">내용</label>
	<textarea class="form-control" rows="10" id="bcontent" name="bcontent"></textarea>
	<label for="bpass">비밀번호 (글 삭제, 수정 시 필요합니다.)</label>
	<input type="password" name="bpass" id="bpass" class="form-control"/>
	<label for="bfile">첨부파일</label>
	<input type="file" name="bfile" id="bfile" class="form-control"/>
	<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" /> --%>
	<br/>
		<input type="submit" value="작성" id="new_submit" class="btn btn-primary btn-block"/><br/>
		<input type="reset" value="취소" id="new_cancle" class="btn btn-basic btn-block"/><br/>
		<input type="button" value="목록" id="new_back" class="btn btn-basic btn-block"/>
		<script>
		$(function(){
			$('#new_write').on('submit', function(){
				console.log("제출")
				if($("#btitle").val()=="" || $("#bname").val()=="" || $("#bcontent").val()==""){
					console.log("빈칸있음")
					alert('값을 입력하세요.')
					return false
				}
				if($('#bpass').val()==""){
					alert('비밀번호를 입력하세요.')
					return false;
				}
			})
			$('#new_cancle').on('click', function(){
				if(!confirm('작성된 내용이 초기화됩니다. 계속할까요?')){
					return false;
				}
			})
			$('#new_back').on('click', function(){
				if(!confirm('저장되지 않았습니다. 목록으로 돌아갈까요?')){
					return false;
				}else{
					history.go(-1);
				}
			})
		})
		</script>
	</fieldset>
	</form>
	</div>
</div>
<%@ include file="../inc/footer.jsp" %>