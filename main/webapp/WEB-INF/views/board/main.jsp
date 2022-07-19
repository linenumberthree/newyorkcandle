<%@ include file="../inc/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="box">
	<div class="container title">
		<h3 style="text-align:center">BOARD</h3>
	</div>
	<div class="container body panel panel-default">
		<table class="table table-hover">
		<thead>
		<tr><th>NO</th><th>Writer</th><th>Title</th><th>Date</th><th>Hit</th></tr>
		</thead>
		<tbody>
			<c:forEach var="i" items="${res }" varStatus="status">
			<tr><td>${(current)*10 + status.count}</td><td>${i.getBname() }</td><td><a href="${pageContext.request.contextPath }/imageBoard/detail?bno=${i.getBno()}" title="상세보기">${i.getBtitle() }</a></td><td>${i.getBdate() }</td><td>${i.getBhit() }</td></tr>
			</c:forEach>
		</tbody>
		<tfoot>
		<tr><td colspan="5" style="text-align:center">
		<ul class="pagination">
			<c:forEach var="j" begin="${ start }" end="${ end }">
			<c:if test="${j%10==1 && j>1}"><li><a href="${pageContext.request.contextPath }/imageBoard/main?page=${start-1 }"> 이전 </a></li></c:if>
			<li <c:if test="${current== j }"> class="active" </c:if>><a href="${pageContext.request.contextPath }/imageBoard/main?page=${j-1 }">${ j }</a></li>
			<c:if test="${j%10==0 && j<totalPage}"><li><a href="${pageContext.request.contextPath }/imageBoard/main?page=${end+1 }"> 다음 </a></li></c:if>
			</c:forEach>
		</ul>
		</table>
	</div>
	<div class="container">
		<a href="${pageContext.request.contextPath }/imageBoard/write" class="btn btn-danger">NEW</a>
	</div>
	<script>
		var msg="${success}";
		if(msg=="fail"){
			alert('실패: 관리자에게 문의하세요.');
		}
		if(msg=="success"){
			alert('성공');
		}
	</script>
</div>
<%@ include file="../inc/footer.jsp" %>