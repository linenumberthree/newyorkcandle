<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../inc/header.jsp" %>
<div class="box">
	<div class="container">
	<h3 style="text-align:left">글 수정</h3>
	<form action="${pageContext.request.contextPath }/imageBoard/edit_action?${_csrf.parameterName}=${_csrf.token }" method="post" id="update_write" enctype="multipart/form-data">
	<fieldset>
	<input type="text" name="bno" id="bno" style="display:none" value="${selectOne.getBno()}">
	<label for="btitle">제목</label>
	<input type="text" name="btitle" id="btitle" class="form-control" value="${selectOne.getBtitle()}"/>
	<label for="bname">작성자</label>
	<input type="text" name="bname" id="bname" class="form-control"  value="<sec:authentication property='principal.member.username'/>" readonly/>
	<label for="bcontent">내용</label>
	<textarea class="form-control" rows="10" name="bcontent" id="bcontent">${selectOne.getBcontent().replaceAll("<br/>", "") }</textarea>
	<label for="bpass">비밀번호</label>
	<input type="password" name="bpass" id="bpass" class="form-control"/>
	<label for="bfile">첨부파일</label>
	<input type="file" name="bfile" id="bfile" class="form-control"/>
	<br/>
	<p>
		<input type="submit" value="수정" id="update_submit" class="btn btn-primary btn-block"/><br/>
		<input type="reset" value="취소" id="update_cancle" class="btn btn-basic btn-block"/><br/>
		<input type="button" value="목록" id="update_back" class="btn btn-basic btn-block"/>
		<script>
		console.log("ready");
		$(function(){
			$('#update_write').on('submit', function(){
				if($("#btitle").val()=="" || $("#bname").val()=="" || $("#bcontent").val()==""){
					console.log("data null")
					alert('값을 입력하세요.')
					return false
				}
				if($('#bpass').val()==""){
					alert('비밀번호를 입력하세요.')
					return false;
				}else if($('#bpass').val()=="${selectOne.getBpass()}"){
					return true;
				}else{
					alert('비밀번호가 틀렸습니다.')
					$('#bpass').focus();
					return false;
				}
			})
			$('#update_cancle').on('click', function(){
				if(!confirm('글 작성을 취소할까요?')){
					return false;
				}
			})
			$('#update_back').on('click', function(){
				if(!confirm('저장되지 않았습니다. 목록으로 돌아갈까요?')){
					return false;
				}else{
					location.href="${pageContext.request.contextPath }/imageBoard/main"
				}
			})
		})
		</script>
	</p>
	</fieldset>
	</form>
	</div>
</div>
<%@ include file="../inc/footer.jsp" %>