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
	<div class="container panel panel-warning">
		<h3 class="panel-info">Spring - 이미지 업로드 결과</h3>
		<p>작성자: ${name }</p>
		<p>제목: ${title }</p>
		<p><img src="/upload/${savedImg}" alt="file"/>
	</div>
	<div class="container">
		<a href="javascript:history.go(-1)" class="btn btn-danger">돌아가기</a>
	</div>
</body>
</html>