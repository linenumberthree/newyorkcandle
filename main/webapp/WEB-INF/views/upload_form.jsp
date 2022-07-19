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
	<div class="container panel panel-info">
		<h3 class="panel-heading">Spring- 이미지 업로드</h3>
		<form action="${pageContext.request.contextPath }/image/upload" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="name">글쓴이</label>
				<input type="text" name="name" id="name" class="form-control"/>
			</div>
			<div class="form-group">
				<label for="title">제목</label>
				<input type="text" name="title" id="title" class="form-control"/>
			</div>
			<div class="form-group">
				<label for="file">파일 업로드</label>
				<input type="file" name="file" id="file" class="form-control"/>
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-danger" title="파일업로드" value="업로드"/>
			</div>
		</form>
	</div>
</body>
</html>