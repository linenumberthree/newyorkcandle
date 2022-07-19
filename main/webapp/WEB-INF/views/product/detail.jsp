<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../inc/header.jsp" %>
	<div class="container panel panel-info">
		<h3 class="panel-heading">제품 데이터 상세 보기</h3>
		<p>상품명: ${res.candleName }</p>
		<p>상품번호: ${res.productNo }</p>
		<p>썸네일 이미지명: ${res.thumbnailImg }</p>
		<p>제품정보 이미지명: ${res.detailImg }</p>
		<p>상세정보: 향(${res.scentName }) / 효과(${res.effectName }) / 장소(${res.placeName })</p>
	</div>
	<div class="container">
		<form action="${pageContext.request.contextPath }/product/edit" method="get" id="edit">
		<p style="text-align:left">
			<input type="hidden" name="productNo" id="productNo" value="${res.productNo }">
				<sec:authorize access="isAuthenticated()"> 
					<sec:authentication var="principal" property="principal.member" />
					<c:if test="${res.adminNo == principal.userno }">
						<input type="submit" value="수정" id="detail_edit" class="btn btn-primary"/>  
					</c:if>
				</sec:authorize>
			<input type="button" value="목록" id="detail_back" class="btn btn-basic"/>
		</p>
		</form>
		<sec:authorize access="isAuthenticated()">
			<sec:authentication var="principal" property="principal.member" />
			<c:if test="${res.adminNo == principal.userno }">
				<form action="${pageContext.request.contextPath }/product/delete" method="get" id="delete">
					<p style="text-align:right">
						<input type="text" name="productNo" id="productNo" style="display:none" value="${res.productNo }">
						<input type="submit" value="삭제" id="detail_delete" class="btn btn-danger"/>
					</p>
				</form>
			</c:if>
		</sec:authorize>
	</div>
	<script>
	$(function(){
		$('#detail_back').on('click', function(){
			location.href= '${pageContext.request.contextPath}/product/main';
		})
	})
	</script>
<%@ include file="../inc/footer.jsp" %>