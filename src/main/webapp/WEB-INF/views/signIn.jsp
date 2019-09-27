<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style>
 .form_out{
  display: flex;
  align-content: center;
 }
 .div_out{
  padding: 20px;
 }
 .dn{
  display:none;
 }
 #form{
  border-radius:5px;
  box-shadow: 0px 0px 3px 0px #00A800;
  width: 80%;
  margin: 10% auto;
  max-width: 500px;
  }
</style>
<script>
$(document).ready(function(){
	var id_check = false;
	var pass_check = false;
	$('#cancel').on('click' , function(e){
		e.preventDefault();
		document.form1.method = "GET";
		document.form1.action = "/";
		document.form1.submit();
	});
	//회원가입 예외 처리 - 아이디 중복검사 비밀번호 재확인
	$('#signIn').off().on('click' , function(e){
		e.preventDefault();
		console.log($('#id').val());
		if(!id_check){
			alert("아이디를 중복 확인해주세요");
			return;
		}
		
		if($('#id').val() == ""){
			alert("아이디를 입력해 주세요!!");
			$('#id').focus();
			return;
		}else if($('#password').val() == ""){
			alert("비밀번호를 입력해주세요!!");
			$('#password').focus();
			return;
		}else if($('#passwordCheck').val() == ""){
			alert("비밀번호를 재입력해주세요!!");
			$('#passwordCheck').focus();
			return;
		}
		if(!pass_check) {
	        alert("비밀번호가 일치 하지 않습니다.");
	        return;
	    }
		document.form1.method = "POST";
		document.form1.action = "/signIn/check";
		document.form1.submit(); 
	});
	//아이디 중복검사 체크
	$('#id_check').on('click', function(e){
		e.preventDefault();
		if($('#id').val() == ""){
			alert("아이디를 입력해 주세요!!");
			return;
		}
		
		var data = { id : $('#id').val() }
		$.ajax({ 
			url: "/id_check", 
			data: data, 
			method:"POST", 
			dataType: "json", 
			success : function(data){
				var str = JSON.parse(data);
				 $( '#id_true' ).addClass( 'dn' );
				 $( '#id_false' ).addClass( 'dn' );
				if(!str){
				 $( '#id_true' ).removeClass( 'dn' );
				 id_check = true;
				}else if (str){
				 $('#id_false').removeClass( 'dn' );
				 id_check = false;
				}	
			}
		});
	});
	/* 	 keyup paste */
	//비밀번호1, 비밀번호2 일치 여부
	$("#passwordCheck, #password").on("change", function() {
	    $('#pass_false').addClass( 'dn' );
	    $('#pass_true').addClass( 'dn' );
		var password = $('#password').val(); 
	    var passwordcheck = $('#passwordCheck').val(); 	
	    if(password == passwordcheck) {
	    	$('#pass_true').removeClass( 'dn' );
	    	pass_check = true;
	        return;
	    }else {
	    	$('#pass_false').removeClass( 'dn' );
	    	pass_check = false;
	    }
	});	
});


</script>

</head>
<body>
<div class="signInForm">
<div class="form_out">
<form id="form" name="form1">
<div class="div_out">
	<div class="signInMark form-group"><a style="color: red;">* </a>아이디 :<br>
		<div class="signInLeft "><input id="id" class="form-control" type="text" name="id" > 
		<button type="button" class="btn btn-success" id="id_check">중복검사</button>	
		</div>
	</div>
	<div style="color:red" class="dn" id="id_false" >아이디를 사용중이거나 탈퇴한 아이디 입니다.</div>
	<div style="color:green" class="dn" id="id_true" >사용 가능한 아이디합니다.</div>
	
	
	<div class="signInMark form-group"><a style="color: red;">* </a>비밀번호 : 	
	  <div class="signInLeft"><input class="form-control" id="password" type="password"name="password">
	  </div>
	  </div>
	<div class="signInMark form-group"><a style="color: red;">* </a>비밀번호 확인:
	  <div class="signInLeft"><input class="form-control" id="passwordCheck" type="password"name="passwordcheck">
	  </div>
	</div>
	<div style="color:green" class="dn" id="pass_true" >비밀번호가 일치 합니다</div>
	<div style="color:red" class="dn" id="pass_false" >비밀번호가 다릅니다. 다시 입력해주세요</div>
	<div class="signInMark form-group">
		생년월일 :
	<div class="signInLeft">
	<div class="form-row">
	    <div class="col-7">
	     	 <input id="b_year" class="form-control col-auto" type="text"name="b_year" placeholder="년">
	    </div>
	    <div class="col">
	      	<select  id="b_month" class="form-control col-auto" name="b_month" >
				<%for(int i =1; i < 13; i++){ %>
				 <option value="<%=i%>월"><%=i %>월</option>
				<%} %>
			</select>
	    </div>
	    <div class="col">
	     	<input id="b_day" class="form-control" name="b_day" placeholder="일">
	    </div>
 	 </div>
	<div class="signInMark form-group">성별 : 
	 <div class="signInLeft ">		
	 <select id="gender" class="form-control"type="text" name="gender">
	  <option value="남">남</option>
	  <option value="여">여</option>
	 </select>
	 </div>
    </div>
	<div class="signInMark">이메일 :
		<div class="signInLeft"><input id="email" class="form-control" type="email"name="email">
		</div>
	</div>
	<div class="signInMark">핸드폰번호 :
		<div class="signInLeft"><input id="phone" class="form-control"  type="text"name="phone">
		</div>
	</div> 
	<button type="button" class="btn btn-success" id="signIn" name="signIn" >회원가입</button>
	<button type="button" class="btn btn-danger" id="cancel" name="cancel" >취소</button>
	</div>
</form>
</div>
</div>

</body>
</html>