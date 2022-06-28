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
<style>
#notice { width: 300px; position: fixed; left: 5%; top: 20%; }
</style>
</head>
<body>
	<div class="container panel panel-info">
		<pre>
			24시간 쿠키 설정, 공지사항 팝업
		</pre>
	</div>
	<div class="container" id="notice">
		<h3>공지사항</h3>
		<p>이 포트폴리오는 상업적 목적이 아닌 개인 포트폴리오 용도로 제작되었으며
		홈페이지의 일부 내용과 기타 이미지 등은 출처가 따로 있음을 밝힙니다.</p>
		<img src="${pageContext.request.contextPath }/img/QRCodeImg.jpg" title="qrcode"/>
		<p><input type="checkBox" id="dontshow" name="dontshow"><label for="dontshow">24시간 동안 이 창 열지 않기</label>
		<input type="button" value="CLOSE" class="btn btn-default" id="close"/></p>
	</div>
	<script>
		function setCookie(cname, cvalue, exdays) {
		  const d = new Date();
		  d.setTime(d.getTime() + (exdays*24*60*60*1000));
		  let expires = "expires="+ d.toUTCString();
		  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
		}
		function getCookie(cname) {
		  let name = cname + "=";
		  let decodedCookie = decodeURIComponent(document.cookie);
		  let ca = decodedCookie.split(';');
		  for(let i = 0; i <ca.length; i++) {
		    let c = ca[i];
		    while (c.charAt(0) == ' ') {
		      c = c.substring(1);
		    }
		    if (c.indexOf(name) == 0) {
		      return c.substring(name.length, c.length);
		    }
		  }
		  return "";
		}
		
		
		$(function(){
			$('#close').on('click', function(){
				if($('#dontshow:checked').length==1){
					setCookie('dontshow', 'done', 1);
				}
				$('#notice').fadeOut();
			})
			
			if(getCookie('dontshow')=="done"){
				$('#notice').hide();
			}else{ $('#notice').fadeIn(); }
			
		})
	</script>
</body>
</html>