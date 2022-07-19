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
	<div class="container panel panel-warning">
		<h3 class="panel-heading"><span style="float:center; font-size:20px; color:red; font-weight:bold">상품 등록은 판매자 회원만 가능합니다. 판매자 계정으로 로그인 해 주세요.</span></h3>
		<form action="${pageContext.request.contextPath }/login" method="post">
			<fieldSet>
				<legend>로그인</legend>
				<div class="form-group">
					<label for="username">아이디</label>
					<input type="text" name="username" id="username" placeholder="아이디" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="password">비밀번호</label>
					<input type="password" name="password" id="password" placeholder="비밀번호" class="form-control"/>
				</div>
				<div class="form-group">
					<input type="checkbox" name="remember-me" id="remember-me"/>
					<label for="remember-me">아이디 기억하기</label>
				</div>
				<div class="form-group">
					<input type="submit" value="로그인" class="btn btn-danger"/>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				</div>
			</fieldSet>
		</form>
		<a href="${pageContext.request.contextPath }/security/joinForm" title="회원가입">판매자 신규 회원 등록</a>
	</div>
</body>
</html>