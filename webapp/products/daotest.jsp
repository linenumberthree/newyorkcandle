<%@page import="mjlee.portfolio.dao.MemberDto"%>
<%@page import="mjlee.portfolio.dao.ProductDao"%>
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
<%
	//insert into cartDetail (cartNo, goodsCatNo, productNo, cartCount) values ((select cartNo from cart where cart.memberNo=2), 1, 2, 1);
	ProductDao dao= new ProductDao();
	MemberDto dto= new MemberDto();
	dto.setNo(1);
	out.println(dao.addToCart(dto, 1, 1, "S", 1));
	
%>
</body>
</html>