<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/header.jsp" %>
<div class="container wrapper">
	<h3>계정 정보 찾기</h3>
	<div class="container box">
	<ul class="nav nav-tabs">
		<li class="active" id="findIdTab"><a data-toggle="tab" href="#findId">ID찾기</a></li>
		<li id="findPwTab"><a data-toggle="tab" href="#findPw">비밀번호 찾기</a></li>
	</ul>
	<div class="tab-content">
		<div id="findId" class="tab-pane fade in active">
		  <h4>ID 찾기</h4>
		  <div class="row form-group">
		  	<div class="col-sm-2"><label for="findId_name">이름</label></div>
		  	<div class="col-sm-5"><input type="text" id="findId_name" name="findId_name" class="form-control" placeholder="가입 시 입력한 이름"/></div> 
		  </div>
		  <div class="row form-group">
		  	<div class="col-sm-2"><label for="findId_email">Email</label></div>
		  	<div class="col-sm-5"><input type="text" id="findId_email" name="findId_email" class="form-control" placeholder="가입 시 입력한 이메일"/></div>
		  	<div class="col-sm-4"><input type="button" id="findId_sendAuth" value="인증번호 받기" class="btn btn-primary"/></div>
		  </div>
		  <div class="row form-group">
		  	<div class="col-sm-2"><label for="findId_authCode">인증번호</label></div>
		  	<div class="col-sm-5"><input type="text" id="findId_authCode" name="findId_authCode" class="form-control"/></div>
		  </div>
		  <div class="row form-group">
		  <div class="col-sm-2"></div>
		  	<input type="button" id="findIdBtn" value="확인" class="btn btn-primary"/>
		  	<input type="button" id="findIdCancleBtn" value="취소" class="btn btn-danger"/>
		  </div>
		</div>
		<div id="findPw" class="tab-pane fade">
		  <h4>비밀번호 찾기</h4>
		  <div class="row form-group">
		  	<div class="col-sm-2"><label for="findPw_id">ID</label></div>
		  	<div class="col-sm-5"><input type="text" id="findPw_id" name="findPw_id" class="form-control" placeholder="가입 시 입력한 아이디"/></div> 
		  </div>
		  <div class="row form-group">
		  	<div class="col-sm-2"><label for="findPw_email">Email</label></div>
		  	<div class="col-sm-5"><input type="text" id="findPw_email" name="findPw_email" class="form-control" placeholder="가입 시 입력한 이메일"/></div>
		  	<div class="col-sm-4"><input type="button" id="findPw_sendAuth" value="인증번호 받기" class="btn btn-primary"/></div>
		  </div>
		  <div class="row form-group">
		  	<div class="col-sm-2"><label for="findId_authCode">인증번호</label></div>
		  	<div class="col-sm-5"><input type="text" id="findPw_authCode" name="findPw_authCode" class="form-control"/></div>
		  </div>
		  <div class="row form-group">
		  <div class="col-sm-2"></div>
		  	<input type="button" id="findPwBtn" value="확인" class="btn btn-primary"/>
		  	<input type="button" id="findPwCancleBtn" value="취소" class="btn btn-danger"/>
		  </div>
		</div>
	</div>
	</div>
	<div class="modal fade" id="findIdModal">
		<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">아이디 찾기</h4>
		      </div>
		      <div class="modal-body" style="text-align:center">
		        <p>입력하신 계정 정보와 일치하는 아이디는</p>
		        <div id="foundIdRes" style="font-weight:bold"></div><p>입니다.</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		        <a href="login.view" class="btn btn-primary">로그인</a>
		        <a data-toggle="tab" href="#findPw" class="btn btn-warning" data-dismiss="modal" id="findPwTabOpen">비밀번호 찾기</a>
		      </div>
		    </div>
		  </div>
	</div>
	<div class="modal fade" id="findPwModal">
		<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">비밀번호 찾기</h4>
		      </div>
		      <div class="modal-body" style="text-align:center">
		        <p>입력하신 이메일로 비밀번호를 전송하였습니다.</p>
		        <p style="font-weight:bold">로그인 후 반드시 새 비밀번호로 변경해주세요.</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		        <a href="login.view" class="btn btn-primary">로그인</a>
		      </div>
		    </div>
		  </div>
	</div>
	<script>
	$(function(){
		var authChecked= false;
		var authCode= "";
		var foundId= "";
		var foundPw= "";
		$('#findId_sendAuth').on('click', function(){
			$.ajax({
				type:"get", url:"findId.do", data:{"findId_email":$('#findId_email').val(), "findId_name":$('#findId_name').val()} ,
				success:function(data){
					console.log(data);
					var res= $.trim(data).split('/')[0];
			        if(res == "error"){
			        	alert("계정 정보를 찾을 수 없습니다.");
						$("#findId_name").focus();
			        }else{	        		
						alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호를 확인해주세요.");
						authCode= res;
						console.log(res);
						foundId= $.trim(data).split('/')[1];
			        }
			    }
			})
		})
		$('#findPw_sendAuth').on('click', function(){
			$.ajax({
				type:"get", url:"findPw.do", data:{"findPw_email":$('#findPw_email').val(), "findPw_id":$('#findPw_id').val()},
				success:function(data){
					console.log(data);
					var res= $.trim(data).split('/')[0];
			        if(res == "error"){
			        	alert("계정 정보를 찾을 수 없습니다.");
						$("#findId_name").focus();
			        }else{	        		
						alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호를 확인해주세요.");
						authCode= res;
						console.log(res);
						foundPw= $.trim(data).split('/')[1];
			        }
			    }
			})
		})
		$('#findIdBtn').on('click', function(){
			if($('#findId_email').val()=="" || $('#findId_name').val()=="" || $('#findId_authCode').val()==""){
				alert('빈칸을 확인해주세요.');
				return false;
			}
			if($('#findId_authCode').val()!="" && $('#findId_authCode').val()!=authCode){
				alert('잘못된 인증번호입니다. 다시 입력해주세요.');
				return false;
			}else if($('#findId_authCode').val() == authCode){
				$('#findIdModal').modal();
				document.getElementById("foundIdRes").innerHTML= "<h4>"+foundId+"</h4>";
			}
		})
		$('#findPwBtn').on('click', function(){
			if($('#findPw_id').val()=="" || $('#findPw_email').val()=="" || $('#findPw_authCode').val()==""){
				alert('빈칸을 확인해주세요.');
				return false;
			}
			if($('#findPw_authCode').val()!="" && $('#findPw_authCode').val()!=authCode){
				alert('잘못된 인증번호입니다. 다시 입력해주세요.');
				return false;
			}else if($('#findPw_authCode').val() == authCode){
				$.ajax({
					type:"post", url:"findPwSendMail.do", data:{"findPw_id":$('#findPw_id').val(), "findPw_email":$('#findPw_email').val(), "foundPw":foundPw},
					success:function(data){
						var res= $.trim(data);
				        if(res == "error"){
				        	alert("메일 전송 실패");
				        }else{	        		
				        	$('#findPwModal').modal();
				        }
				    }
				})
			}
		})
		$('#findPwCancleBtn').on('click', function(){
			location.href="${pageContext.request.contextPath }/login.view";
		})
		$('#findIdCancleBtn').on('click', function(){
			location.href="${pageContext.request.contextPath }/login.view";
		})
		$('#findPwTabOpen').on('click', function(){
			$('#findIdTab').removeClass('active');
			$('#findPwTab').addClass('active');
		})
	})
	</script>
</div>
<%@ include file="../inc/footer.jsp" %>