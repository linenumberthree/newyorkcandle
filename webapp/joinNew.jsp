<%@page import="mjlee.portfolio.dao.MemberDao"%>
<%@page import="mjlee.portfolio.controller.MailManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="inc/header.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	var dupId= false;
	var authChecked= false;
	var authCode= "";
	$('#postcode').on('click', function(){
		new daum.Postcode({
			oncomplete: function(data){
				console.log(data)
				$('#joinAddPost').val(data.zonecode)
				$('#joinAdd').val(data.address)
				$('#joinAddDetail').focus()
			}
		}).open()
	})
	$('#joinReset').on('click', function(){
		alert('모든 작성 내용이 초기화됩니다.')
	})
	$('#joinCancle').on('click', function(){
		location.href="${pageContext.request.contextPath }/main.view";
	})
	
	$('#joinForm').on('submit', function(){
		if($('#joinName').val()=="" || $('#joinId').val()=="" || $('#joinPw').val()=="" || $('#joinEmail').val()==""){
			alert('필수값은 모두 입력되어야 합니다. 빈칸을 확인해주세요.');
			return false;
		}
		if($('#joinPwConfirm').val() != $('#joinPw').val()){
			alert('비밀번호가 틀렸습니다.');
			return false;
		}
		if(!dupId){
			alert('아이디 중복 확인을 해주세요.');
			return false;
		}
		if(!authChecked){
			alert('인증번호가 올바르지 않습니다.');
			return false;
		}
	})
	$('#joinEmail').keyup(function(){
		var reg= /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		if($('#joinEmail').val() =="" || reg.test($('#joinEmail').val())){
			$('.emailRes').fadeOut();
		}else if(!reg.test($('#joinEmail').val())){
			$('.emailRes').fadeIn();
			$('.emailResOut').css({"color":"red"}, {"font-weight":"bold"});
			$('.emailResOut').html("이메일 형식에 맞추어 입력해주세요.");
		}
	})
	$('#emailConfirmCheckBtn').on('click', function(){
		console.log(authCode);
		if($('#joinEmail').val()==""){
			alert('이메일을 입력하세요.');
			return false;
		}else if($('#emailConfirmCheck').val() == authCode){
			alert('인증되었습니다.');
			authChecked= true;
			$('#emailConfirmCheck').prop('readonly', true);
			$('#joinEmail').prop('readonly', true);
		}else if($('#emailConfirmCheck').val()==""){
			alert('인증번호를 입력하세요.');
			return false;
		}else{
			alert('인증번호가 올바르지 않습니다.');
			return false;
		}
	})
	$('#idConfirm').on('click', function(){
		var reg= /^[a-z]+[a-z0-9]{5,19}$/;
		$('#DupIdRes').fadeIn();
		if($('#joinId').val()==""){
			alert('아이디를 입력하세요.');
			return false;
		}else if(!reg.test($('#joinId').val())){
			$("#DupIdRes").fadeIn();
			$('#DupIdRes').css({"color":"red"}, {"font-weight":"bold"});
			$('#DupIdRes').html("영문/숫자로 이루어진 6~20자로 입력해주세요.");
		}else{
			$.ajax({
				url:"idDupCheck.join", type:"post", dataType:"text", data:{"joinId":$('#joinId').val()},
				success:function(data){
					if(data==0){
						var res= "중복된 아이디입니다.";
						dupId= false;
					}else if(data==1){
						var res= "사용 가능한 아이디입니다."
						$('#joinId').prop('readonly', true);
						$('#DupIdRes').css({"color":"blue"}, {"font-weight":"bold"});
						dupId= true;
					}
					$('#DupIdRes').html(res);
				}, error:function(xhr, textStatus, errorThrown){
					$("#DupIdRes").html(textStatus+"/http - "+xhr.status+", "+errorThrown);
				}
			})			
		}
	})
	$('#idConfirmReset').on('click', function(){
		dupId= false;
		$('#joinId').prop('readonly', false);
		$('#DupIdRes').fadeOut();
	})
	$('#emailConfirmSendMail').on('click', function(){
		if($('#joinEmail').val()==""){
			alert('이메일을 입력하세요.');
			return false;
		}else{
			$.ajax({
				type:"get", url:"emailAuthCheck.join", data:{"joinEmailAuth":$('#joinEmail').val()} ,
				success:function(data){
					console.log(data);
					var res= $.trim(data);
		        	if(res == "error"){
		        		alert("중복된 이메일입니다. 다른 이메일을 입력해주세요.");
						$("#joinEmail").focus();
		        	}else{	        		
						alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호를 확인해주세요.");
						authCode= res;
			     	}
				}
			})
		}
	})
	$('#joinPwConfirm').keyup(function(){
		$('.pwRes').fadeIn();
		var reg=/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[A-Z])(?=.*[!@#$%^&+=]).*$/;
		if($('#joinPwConfirm').val() == $('#joinPw').val()){
			$('.pwResOut').css({"color":"blue"}, {"font-weight":"bold"});
			$('.pwResOut').html("비밀번호가 일치합니다.");
		}else{
			$('.pwResOut').css({"color":"red"}, {"font-weight":"bold"});
			$('.pwResOut').html("비밀번호가 일치하지 않습니다.");
		}
		if($('#joinPwConfirm').val() =="" || $('#joinPw').val() == ""){
			$('.pwRes').fadeOut();
		}else if($('#joinPwConfirm').val() == $('#joinPw').val() && !reg.test($('#joinPw').val())){
			$('.pwResOut').css({"color":"red"}, {"font-weight":"bold"});
			$('.pwResOut').html("특수문자, 대문자, 숫자가 최소 1회 입력되어야 합니다.");
		}
	})
	$('#joinPhone').keyup(function(){
		var reg= /^010(?:\d{3}|\d{4})\d{4}$/;
		if(!reg.test($('#joinPhone').val())){
			$('.phoneRes').fadeIn();
			$('.phoneResOut').css({"color":"red"}, {"font-weight":"bold"});
			$('.phoneResOut').html("휴대폰 번호 형식에 맞추어 입력해주세요.");
		}else{
			$('.phoneRes').fadeOut();
		}
	})
})
</script>
	<div class="container wrapper">
		<h3>회원 가입<br/></h3>
		<div class="box container">
			<form action="joinNew.join" method="post" id="joinForm">
			<div class="join">
			<div class="row form-group">
				<div class="col-sm-1">
				<label for="joinName">이름 *</label>
				</div>
				<div class="col-sm-5">
				<input type="text" id="joinName" name="joinName" class="form-control"/>
				</div>
				<div class="col-sm-6">
				<p style="font-size:13px; color:red; float:left;">가입 후 수정할 수 없습니다.</p>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1">
				<label for="joinId">아이디 *</label>
				</div>
				<div class="col-sm-5">
				<input type="text" id="joinId" name="joinId" class="form-control" maxlength="20"/>
				</div>
				<div class="col-sm-6">
				<p style="font-size:13px; float:left;">최대 20자 입력 가능</p>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1"></div>
				<div class="col-sm-2">
				<input type="button" id="idConfirm" class="btn btn-primary" value="중복확인"/>
				</div>
				<div class="col-sm-2">
				<input type="button" id="idConfirmReset" class="btn btn-primary" value="재입력"/>
				</div>
				<div class="col-sm-4">
				<p id="DupIdRes" style="color:red; font-weight:bold;"></p>
				</div>
			<div class="row form-group idRes">
				<div class="col-sm-6 idResOut" style="text-align:left"></div>
			</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1">
				<label for="joinPw">비밀번호*</label>
				</div>
				<div class="col-sm-5">
				<input type="password" id="joinPw" name="joinPw" class="form-control"/>
				</div>
				<div class="col-sm-1">
				<label for="joinPwConfirm">확인</label>
				</div>
				<div class="col-sm-5">
				<input type="password" id="joinPwConfirm" name="joinPwConfirm" class="form-control"/>
				</div>
			<div class="row form-group pwRes">
				<div class="col-sm-6 pwResOut" style="text-align:left"></div>
			</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1">
				<label for="joinEmail">이메일*</label>
				</div>
				<div class="col-sm-5">
				<input type="text" id="joinEmail" name="joinEmail" class="form-control" placeholder="example@gmail.com"/>
				</div>
				<div class="col-sm-4">
				<input type="button" id="emailConfirmSendMail" class="btn btn-primary" value="인증번호 전송"/>
				</div>
			<div class="row form-group emailRes">
				<div class="col-sm-1"></div>
				<div class="col-sm-5 emailResOut" style="text-align:left"></div>
			</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1"></div>
				<div class="col-sm-5">
				<input type="text" id="emailConfirmCheck" class="form-control" placeholder="인증번호"/>
				</div>
				<div class="col-sm-2">
				<input type="button" id="emailConfirmCheckBtn" class="btn btn-primary" value="확인"/>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1">
				<label for="joinAddPost">우편번호</label>
				</div>
				<div class="col-sm-5">
				<input type="text" id="joinAddPost" name="joinAddPost" class="form-control" readonly/>
				</div>
				<div class="col-sm-6">
				<input type="button" id="postcode" class="btn btn-primary" value="우편번호 검색"/>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1">
				<label for="joinAdd">주소</label>
				</div>
				<div class="col-sm-5">
				<input type="text" id="joinAdd" name="joinAdd" class="form-control" readonly/>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1"></div>
				<div class="col-sm-5">
				<input type="text" id="joinAddDetail" name="joinAddDetail" class="form-control" placeholder="상세 주소를 입력하세요."/>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1">
				<label for="joinPhone">전화번호<br/>(- 제외)</label>
				</div>
				<div class="col-sm-5">
				<input type="text" id="joinPhone" name="joinPhone" class="form-control" placeholder="01011112222"/>
				</div>
			<div class="row form-group phoneRes">
				<div class="col-sm-1"></div>
				<div class="col-sm-5 phoneResOut" style="text-align:left"></div>
			</div>
			</div>
			</div>
			<div class="form-group">
			<input type="submit" id="joinSubmit" value="회원가입" class="btn btn-primary"/>
			<input type="reset" id="joinReset" value="초기화" class="btn btn-default"/>
			<input type="button" id="joinCancle" value="취소" class="btn btn-warning"/>
			</div>
			</form>
		</div>
	</div>
<%@include file="inc/footer.jsp" %>