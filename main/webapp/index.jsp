<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Title</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<%-- <div class="container panel panel-info">
		<h3 class="panel-heading">IMAGE</h3>
		<p>resources </p>
		<p><img src="${pageContext.request.contextPath }/resources/food.jpg" title="food" style="width:80%"/></p>
		
		<hr/>
		<p>img 경로 생성</p>
		<p><img src="${pageContext.request.contextPath }/img/food.jpg" title="food" style="width:80%"/></p>
	</div>
	<div class="container">
		<a href="${pageContext.request.contextPath }/image/index">이미지 업로드 연습</a>
	</div> --%>
	<script>
	location.href="${pageContext.request.contextPath}/product/main";
	</script>
</body>
</html>