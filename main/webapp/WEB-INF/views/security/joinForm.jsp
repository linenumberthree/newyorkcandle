<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>TITLE</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container panel panel-info">
		<h3 class="panel-heading">회원가입</h3>
		<form action="${pageContext.request.contextPath }/security/join?${_csrf.parameterName}=${_csrf.token }" method="post" id="joinform">
			<div class="form-group">
				<label for="name">이름</label>
				<input type="text" name="name" id="name" class="form-control"/>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id" class="form-control"/>
				<label for="pw">비밀번호</label>
				<input type="password" name="pw" id="pw" class="form-control"/>
			</div>
			<div class="form-group">
				<input type="submit" id="submit" class="btn btn-danger" value="가입"/>
			</div>
		</form>
	</div>
	
	<script>
		$(function(){
			$("#joinForm").on('submit', function(){
				if($("#name").val()=="" || $("#id").val()=="" || $("#pw").val()==""){
					alert("빈칸을 확인해주세요.");
					return false;
				}
			})
			
			var res= ${res};
			if(res!=""){
				alert(res);
			}
		})
	</script>
</body>
</html>