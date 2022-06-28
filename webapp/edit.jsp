<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/inc/header.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<div class="container wrapper">
	<h3>정보 수정</h3>
	<div class="box container">
		<form action="memberEdit.do" method="post" id="editForm">
		<div class="edit">
		<div class="row form-group">
			<div class="col-sm-1">
			<label for="editName">이름 *</label>
			</div>
			<div class="col-sm-5">
			<input type="text" id="editName" name="editName" class="form-control" value="${tempAccount.getName() }" readonly/>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-sm-1">
			<label for="editId">아이디 *</label>
			</div>
			<div class="col-sm-5">
			<input type="text" id="editId" name="editId" class="form-control" value="${tempAccount.getId() }" readonly/>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-sm-1">
			<label for="editNewPw">새 비밀번호 *</label>
			</div>
			<div class="col-sm-4">
			<input type="password" id="editNewPw" name="editNewPw" class="form-control" />
			</div>
			<div class="col-sm-1">
			<label for="editNewPwConfirm">비밀번호 확인</label>
			</div>
			<div class="col-sm-4">
			<input type="password" id="editNewPwConfirm" name="editNewPwConfirm" class="form-control" />
			</div>
			<div class="col-sm-2">
			<input type="button" id="newPwCheckBtn" value="확인" class="btn btn-primary" />
			</div>
		</div>
		<div class="row form-group pwRes">
			<div class="col-sm-1"></div>
			<div class="col-sm-5 pwResOut" style="text-align:left"></div>
			</div>
		<div class="row form-group">
			<div class="col-sm-1">
			<label for="editEmail">이메일</label>
			</div>
			<div class="col-sm-5">
			<input type="text" id="editEmail" name="editEmail" class="form-control" value="${tempAccount.getEmail()}"/>
			</div>
			<div class="col-sm-2">
			<input type="button" id="emailSendAuthBtn" class="btn btn-primary" value="재인증"/>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-sm-1"></div>
			<div class="col-sm-5">
			<input type="text" id="newEmailConfirm" class="form-control" placeholder="인증번호"/>
			</div>
			<div class="col-sm-2">
			<input type="button" id="emailConfirmBtn" class="btn btn-primary" value="확인"/>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-sm-1">
			<label for="editAddPost">우편번호</label>
			</div>
			<div class="col-sm-5">
			<input type="text" id="editAddPost" name="editAddPost" class="form-control" <c:if test="${tempAccount.getPostNo() != null}"> value="${tempAccount.getPostNo() }"</c:if> readonly/>
			</div>
			<div class="col-sm-2">
			<input type="button" id="editPostCode" class="btn btn-primary" value="우편번호 검색"/>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-sm-1">
			<label for="editAdd">주소</label>
			</div>
			<div class="col-sm-5">
			<input type="text" id="editAdd" name="editAdd" class="form-control" <c:if test="${tempAccount.getAddress().trim() != '/'}"> value="${tempAccount.getAddress().split('/')[0] }"</c:if> readonly/>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-sm-1"></div>
			<div class="col-sm-5">
			<input type="text" id="editAddDetail" name="editAddDetail" class="form-control" <c:if test="${tempAccount.getAddress().trim() != '/'}"> value="${tempAccount.getAddress().split('/')[1] }"</c:if> placeholder="상세 주소를 입력하세요."/>
			</div>
		</div>
		<div class="row form-group">
			<div class="col-sm-1">
			<label for="editPhone">전화번호<br/>(- 제외)</label>
			</div>
			<div class="col-sm-5">
			<input type="text" id="editPhone" name="editPhone" class="form-control" <c:if test="${tempAccount.getMobileNo() != '-'}"> value="${tempAccount.getMobileNo()}"</c:if>/>
			</div>
		</div>
		</div>
		<div class="form-group">
		<input type="submit" id="editSubmit" value="수정" class="btn btn-primary"/>
		<input type="reset" id="editReset" value="초기화" class="btn btn-default"/>
		<input type="button" id="editCancle" value="취소" class="btn btn-warning"/>
		</div>
	</form>
</div>
</div>
<script>
$(function(){
	var newPwChecked= false;
	var editAuthChecked= false;
	var authCode="";
	$('#newPwCheckBtn').on('click', function(){
		if($('#editNewPw').val() == "${tempAccount.getPw()}"){
				alert('현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.');
				return false;
		}
		if($('#editNewPw').val()=="" || $('#editNewPwConfirm').val()==""){
			alert('새 비밀번호를 입력하세요.');
			return false;
		}else if($('#editNewPw').val() == $('#editNewPwConfirm').val()){
			alert('비밀번호 확인 완료');
			$('#editNewPw').prop('readonly', true);
			$('#editNewPwConfirm').prop('readonly', true);
			newPwChecked= true;
		}
	})
	$('#editPostCode').on('click', function(){
		new daum.Postcode({
			oncomplete: function(data){
				console.log(data)
				$('#editAddPost').val(data.zonecode)
				$('#editAdd').val(data.address)
				$('#editAddDetail').focus()
			}
		}).open()
	})
	$('#emailSendAuthBtn').on('click', function(){
		if($('#editEmail').val()=="${tempAccount.getEmail()}"){
			alert('인증 과정을 생략합니다.')
			$('#editEmail').prop('readonly', true);
			$('#newEmailConfirm').prop('readonly', true);
			editAuthChecked= true;
		}else if($('#editEmail').val()==""){
			alert('이메일을 입력하세요.');
			return false;
		}else{
			$.ajax({
				 type:"get", url:"emailAuthCheck.join", data:{"joinEmailAuth":$('#editEmail').val()} ,
				 success:function(data){
					 console.log(data);
					 var res= $.trim(data);
			        	if(res == "error"){
			        		alert("중복된 이메일입니다. 다른 이메일을 입력해주세요.");
							$("#editEmail").focus();
			        	}else{	        		
							alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호 확인을 해주십시오.");
							authCode= res;
							console.log(res);
			        	}
			      }
			})
		}
	})
	$('#emailConfirmBtn').on('click', function(){
		if($('#newEmailConfirm').val() == authCode){
			alert('인증되었습니다.');
			editAuthChecked= true;
			$('#newEmailConfirm').prop('readonly', true);
			$('#editEmail').prop('readonly', true);
		}
	})
	$('#editReset').on('click', function(){
		alert('모든 작성 내용이 초기화됩니다.')
		newPwChecked= false;
		editAuthChecked= false;
		$('#newEmailConfirm').prop('readonly', false);
		$('#editEmail').prop('readonly', false);
		$('#editNewPw').prop('readonly', false);
		$('#editNewPwConfirm').prop('readonly', false);
		
	})
	$('#editCancle').on('click', function(){
		location.href="${pageContext.request.contextPath }/mypage.do";
	})
	
	$('#editForm').on('submit', function(){
		if($('#editNewPw').val()=="" || $('#editEmail').val()==""){
			alert('필수값은 모두 입력되어야 합니다. 빈칸을 확인해주세요.')
			return false;
		}
		if(!newPwChecked){
			alert('새 비밀번호를 확인하세요.');
			return false;
		}
		if(!emailAuthChecked){
			alert('이메일 인증을 해주세요.');
			return false;
		}
	})
	$('#editNewPwConfirm').keyup(function(){
		$('.pwRes').fadeIn();
		var reg=/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[A-Z])(?=.*[!@#$%^&+=]).*$/;
		if($('#editNewPwConfirm').val() == $('#editNewPw').val()){
			$('.pwResOut').css({"color":"blue"}, {"font-weight":"bold"});
			$('.pwResOut').html("비밀번호가 일치합니다.");
		}else{
			$('.pwResOut').css({"color":"red"}, {"font-weight":"bold"});
			$('.pwResOut').html("비밀번호가 일치하지 않습니다.");
		}
		if($('#editNewPwConfirm').val() =="" || $('#editNewPw').val() == ""){
			$('.pwRes').fadeOut();
		}else if($('#editNewPwConfirm').val() == $('#editNewPw').val() && !reg.test($('#editNewPw').val())){
			$('.pwResOut').css({"color":"red"}, {"font-weight":"bold"});
			$('.pwResOut').html("특수문자, 대문자, 숫자가 최소 1회 입력되어야 합니다.");
		}
	})
	if($('#editNewPwConfirm').val() =="" || $('#editNewPw').val() == ""){
		$('.pwRes').fadeOut();
	}
})
</script>
<%@ include file="/inc/footer.jsp" %>