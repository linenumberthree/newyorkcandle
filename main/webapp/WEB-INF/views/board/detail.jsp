<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../inc/header.jsp" %>
<div class="box">
	<div class="container body panel panel-default">
	<h3 style="text-align:center">${select.getBtitle() }</h3>
	<p style="text-align:right">${select.getBname() } (${select.getBip() }) | 조회수: ${select.getBhit() }<br/></p>
	<p style="border-width:0.3px; border-color:lightgray; border-style:dashed;"></p>
	<p style="height:300px">${select.getBcontent() }</p>
	<p style="border-width:0.3px; border-color:lightgray; border-style:dashed;"></p>
	<c:if test="${select.getBfile()!= null }">
	<p><img src="${pageContext.request.contextPath }/resources/img/${select.getBfile() }" alt="첨부파일" style="width:100%"/></p>
	<p style="border-width:0.3px; border-color:lightgray; border-style:dashed;"></p>
	</c:if>	
	<form action="${pageContext.request.contextPath }/imageBoard/edit" method="get" id="edit">
	<p style="text-align:left">
		<input type="hidden" name="bno" id="bno" value="${select.getBno() }">
		<input type="submit" value="수정" id="detail_edit" class="btn btn-primary"/>  
		<input type="button" value="목록" id="detail_back" class="btn btn-basic"/>
	</p>
	</form>
	<form action="${pageContext.request.contextPath }/imageBoard/delete" method="get" id="delete">
		<p style="text-align:right">
			<input type="text" name="bno" id="bno" style="display:none" value="${select.getBno() }">
			<input type="submit" value="삭제" id="detail_delete" class="btn btn-danger"/>
		</p>
	</form>
	<script>
		$(function(){
			$('#edit').on('submit', function(){
				alert('글을 수정합니다')
			})
			$('#detail_back').on('click', function(){
				location.href="${pageContext.request.contextPath }/imageBoard/main"
			})
			$('#detail_delete').on('click', function(){
				if(!confirm("이 글을 삭제할까요?")){
					return false;
				}			
			})
			var msg="${success}";
			if(msg=="fail"){
				alert('실패: 관리자에게 문의하세요.');
			}
			if(msg=="success"){
				alert('성공');
			}
		})
		</script>
	</div>
</div>
<%@ include file="../inc/footer.jsp" %>