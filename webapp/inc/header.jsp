<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Newyork Candles</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<style>
.header_mj{ box-shadow: 0 0 5px rgb(0 0 0 / 10%); }
.menu{ font-size:12px; width:200px;}
.mainTop .navbar-nav>li>a{ padding-top:3px; padding-bottom:3px; color:#1c1c1c; }
.mainTop{ height:20px; font-size:12px; }
.logo{ text-align:left; height:100px; }
.logo img { width: 100%; }
.mainHeader .categories { display: table; margin-top: 37px; }
.mainHeader .categories>li{ display:table-cell; float:none; font-size:16px; }
.mainHeader .categories>li>a{ color: #184b9e; }
.mainHeader .icons { display: table; margin-top: 23px; font-size: 20px; }
.mainHeader .dropdown{ width:140px; text-align:center; }
.footer{ height:200px; text-align:center; font-family:sans-serif; box-shadow: 0 0 5px rgb(0 0 0 / 10%); }
.footer .footer-nav{ font-size:20px; font-weight:bold; }
.wrapper{ margin-top:100px; margin-left:170px; padding-bottom:220px; font-family: 'Noto Serif KR', serif; width:80%;}
.wrapper_m{ margin-top:50px; margin-left:170px; padding-bottom:50px; font-family: 'Noto Serif KR', serif; width:80%;}
.sidenav{ width:160px; height:120px; margin-left:100px; background-color:#F5DA81; position:fixed; padding-top:80px; padding-bottom:220px;}
.carousel{ margin:0px 200px 0px 200px; text-align:center; }
.carousel-inner{ width:100%; }
.box{ padding:5%; box-shadow: 0 0 5px rgb(0 0 0 / 10%); text-align:center; }
.innerbox{ font-weight:bold; margin:8% auto 3% auto; width:60%; }
ul.nav.navbar-nav.icons.col-sm-3.lnb span { display: block;  text-align:center; }
span.lnb_text { font-size: 57%; }
ul.nav.navbar-nav.icons.col-sm-3.lnb span { display: block; text-align: center; }
.join label{ float:right; }
.join input{ float: left; }
.edit label{ float:right; }
.edit input{ float: left; }
#notice { width: 250px; position: fixed; float: right; left: 5%; top: 20%; box-shadow: 0 0 10px rgb(0 0 0 / 20%); border-radius: 20px; }
.search p { margin: 20px 0; }
.search p label { display: -webkit-inline-box; width: 80px; margin: 0 3px; }
.search p strong { display: inline-block; width: 50px; }
.candleList .col-sm-3 { margin-bottom: 20px; }
.candleList .col-sm-3 img { border: 1px solid #ddd; height:380px; }
</style>
</head>
<body>
<div class="header_mj">
	<div class="container mainTop">
		<ul class="nav navbar-nav navbar-right">
		<c:if test="${!signIn}">
	      <li><a href="${pageContext.request.contextPath }/join.view">회원가입</a></li>
	      <li><a href="${pageContext.request.contextPath }/login.view">로그인</a></li>
	    </c:if>
	    <c:if test="${signIn }">
	    	<li><a href="${pageContext.request.contextPath }/mypage.do">마이페이지</a></li>
	    	<li><a href="${pageContext.request.contextPath }/logout.do">로그아웃</a></li>
	    </c:if>
	      <li><a href="#" class="dropdown-toggle" id="menu1" data-toggle="dropdown">고객센터</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
				<!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">공지사항</a></li>
				<li role="presentation"><a role="menuitem" tabindex="-1" href="#">FAQ</a></li>
				<li role="presentation"><a role="menuitem" tabindex="-1" href="#">주문/배송 조회</a></li> -->
				<li role="presentation" class="divider"></li>
				<li role="presentation"><a role="menuitem" tabindex="-1" href="http://vigdsing.cafe24.com/Springboard_img/imageBoard/main">1:1 문의</a></li>    
    			</ul>
	      </li>
	    </ul>
	</div>
	<div class="container mainHeader">
		<h1 class="logo col-sm-3  text-left">
			<a href="${pageContext.request.contextPath }/main.view" title="홈"><img
				src="${pageContext.request.contextPath }/img/logo_new.png" alt="logo"/></a>
		</h1>
		<ul class="nav navbar-nav categories col-sm-6">
		<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">캔들</a>
			<ul class="dropdown-menu">
				<!-- <li><a href="http://vigdsing.cafe24.com/Springboard_img/product/main?page=1">캔들</a></li> -->
				<li><a href="${pageContext.request.contextPath }/candles.product">캔들</a></li>
			</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">디퓨저/오일</a>
			<ul class="dropdown-menu"><!-- 
				<li><a href="#">page 1-1</a></li>
				<li><a href="#">page 1-2</a></li>
				<li><a href="#">page 1-3</a></li> -->
			</ul>
			</li>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">워머/액세서리</a>
			<ul class="dropdown-menu">
				<!-- <li><a href="#">page 1-1</a></li>
				<li><a href="#">page 1-2</a></li>
				<li><a href="#">page 1-3</a></li> -->
			</ul>
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">신제품</a>
			<ul class="dropdown-menu">
				<!-- <li><a href="#">page 1-1</a></li>
				<li><a href="#">page 1-2</a></li>
				<li><a href="#">page 1-3</a></li> -->
			</ul>
			</li>
		</ul>
		<ul class="nav navbar-nav icons col-sm-3  lnb   text-right">
		<c:if test="${signIn }">
			<li><a href="${pageContext.request.contextPath }/mypage.do"><span class="glyphicon glyphicon-user"></span><span  class="lnb_text">MyPage</span></a></li>
			<li><a href="${pageContext.request.contextPath }/cart.view"><span class="glyphicon glyphicon-shopping-cart"></span><span  class="lnb_text">Cart</span></a></li>
		</c:if>
			<li><a href="${pageContext.request.contextPath }/candles.product"><span class="glyphicon glyphicon-search"></span></a></li>
		</ul>
	</div>
</div>