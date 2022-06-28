<%@page import="mjlee.portfolio.dao.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="inc/header.jsp" %>
	<div class="container wrapper">
		<h3>마이페이지</h3>
		<div class="container box">
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#myInfo">내 정보</a></li>
			<li><a data-toggle="tab" href="#myPurchase">구매 목록</a></li>
			<li><a data-toggle="tab" href="#myPost">1:1문의</a></li>
			<li><a data-toggle="tab" href="#myEdit">회원 정보 수정</a></li>
		</ul>
		<br>
		<div class="tab-content">
			<div id="myInfo" class="tab-pane fade in active">
			  <h4>내 정보</h4>
			  <p>이름: ${tempAccount.getName() }</p>
			  <p>휴대폰 번호: ${tempAccount.getMobileNo() }</p>
			  <p>이메일: ${tempAccount.getEmail() }</p>
			  <p>주소: ${tempAccount.getAddress() } (${tempAccount.getPostNo() })</p>
			</div>
			<div id="myPurchase" class="tab-pane fade">
				<h4>구매 목록</h4>
			</div>
			<div id="myPost" class="tab-pane fade">
				<h4>1:1 문의 내역</h4>
			</div>
			<div id="myEdit" class="tab-pane fade">
				<h4>정보 수정</h4>
				<p><button type="button" data-toggle="modal" class="btn btn-primary" data-target="#modalEdit" id="memberEditBtn">수정</button>
				<button type="button" data-toggle="modal" class="btn btn-danger" data-target="#modalDelete" id="memberDelBtn">탈퇴</button>
				<div id="modalEdit" class="modal fade" role="dialog">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				        <h4 class="modal-title">회원 정보 수정</h4>
				      </div>
				      <div class="modal-body">
				        <p>정보 수정을 위해 비밀번호를 입력해주세요.</p>
				        <form action="edit.view" method="get" id="editForm">
				        <p><input type="password" class="form-control" id="editPwConfirm"/></p>
				        <p><input type="submit" class="btn btn-primary" id="editPwConfirmBtn" value="확인"/></p>
				        </form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				      </div>
				    </div>
				  </div>
				</div>
				<div id="modalDelete" class="modal fade" role="dialog">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				        <h4 class="modal-title">회원 탈퇴</h4>
				      </div>
				      <div class="modal-body">
				      	<p style="color:red; font-weight:bold;">회원 탈퇴 시 모든 정보가 삭제됩니다.</p>
				        <p>회원 탈퇴를 위해 비밀번호를 입력해주세요.</p>
				        <form action="terminate.do" method="post" id="delForm">
				        <p><input type="password" class="form-control" id="delPwConfirm"/></p>
				        <p><input type="submit" class="btn btn-primary" id="delPwConfirmBtn" value="확인"/></p>
				        </form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
			</div>
		</div>
		<script>
		$(function(){
			$('#editForm').on('submit', function(){
				if($('#editPwConfirm').val() != "${tempAccount.getPw()}"){
					alert('비밀번호가 올바르지 않습니다.');
					return false;
				}
				if($('#editPwConfirm').val()==""){
					alert('비밀번호를 입력해주세요.');
					return false;
				}
			})
			$('#delForm').on('submit', function(){
				if($('#delPwConfirm').val() != "${tempAccount.getPw()}"){
					alert('비밀번호가 올바르지 않습니다.');
					return false;
				}
				if($('#delPwConfirm').val()==""){
					alert('비밀번호를 입력해주세요.');
					return false;
				}
			})
		})
		</script>
	</div>
	
<%@ include file="inc/footer.jsp" %>