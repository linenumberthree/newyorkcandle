<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="inc/header.jsp" %>
<%
	Cookie[] temp= request.getCookies();		//쿠키 가져오기
	String tempid="";
	String checked="-";
	if(temp.length > 1){		//계정에 대한 정보가 기록된 쿠키가 있으면 (없으면 첫번째 쿠키가 jsessionid가 됨(기본))
		for(Cookie c:temp){
			if(c.getValue().equals("checked")){
				tempid= c.getName();		//계정정보 쿠키의 아이디 가져오기
				checked= c.getValue();	//계정정보 쿠키의 체크박스값 가져오기
				pageContext.setAttribute("checked", checked);
				pageContext.setAttribute("rememberId", tempid);
				break;
			}
		}
		
	}
%>
	<div class="container wrapper">
		<h3>회원 로그인</h3>
		<div class="container box">
		<form action="login.do" method="post" id="form loginForm">
			<div class="row form-group">
				<div class="col-sm-2">
				<label for="loginId">아이디</label>
				</div>
				<div class="col-sm-4">
				<input type="text" id="loginId" name="loginId" class="form-control" value="${rememberId }"/>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-2">
				<label for="loginPw">비밀번호</label>
				</div>
				<div class="col-sm-4">
				<input type="password" id="loginPw" name="loginPw" class="form-control"/>
				</div>
			</div>
			<div class="row form-group">
			<p><input type="checkbox" name="remember" id="remember"/><label for="remember">계정 정보 기억하기</label></p>
			</div>
			<div class="row form-group">
				<input type="submit" id="loginBtn" value="로그인" class="btn btn-primary"/>
				<a href="javascript:history.go(-1)" id="loginCancleBtn" class="btn btn-danger">취소</a>
				<a href="findAccount.view" class="btn btn-warning">ID/PW 찾기</a>
				<p><br/>아직 Newyork Candles 회원이 아니신가요? <a href="${pageContext.request.contextPath }/join.view">회원가입</a></p>
			</div>
		</form>
		<p><a href="http://vigdsing.cafe24.com/Springboard_img/security/login" title="관리자페이지 이동" class="btn btn-default">관리자 계정으로 로그인</a></p>
		</div>
		
		<script>
		$(function(){
			if("${checked}"== "checked"){			<%-- 계정정보가 기록된 쿠키가 있으면 --%>
				$('#remember').prop('checked', true);		<%-- 체크박스 체크하기--%>
			}else{
				$('#remember').prop('checked', false);		<%-- 체크했다는 쿠키가 없으면 체크박스 해제--%>
			}
			$('#loginForm').on('submit', function(){
				if($('#loginId').val()=="" || $('#loginPw').val()==""){
					alert('빈칸을 확인해주세요.');
					return false;
				}		
			})
		})
		</script>
	</div>
<%@include file="inc/footer.jsp" %>