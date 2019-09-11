<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$('#id').val('<%=request.getAttribute("id")%>');
	
	$('#cancel').on('click' , function(e){
		e.preventDefault();
		document.form1.method = "POST";
		document.form1.action = "/";
		document.form1.submit();
	});
	
	$('#signIn').on('click',function(e){
		e.preventDefault();
		console.log($('#id').val());
		if(check == false){
			alert("아이디를 중복검사를 해주세요!");
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
		
		var password = $('#password').val(); 
	    var passwordcheck = $('#passwordcheck').val();
		if(password != passwordcheck) {
	        alert("비밀번호가 일치 하지 않습니다.");
	        return;
	    }
		document.form1.method = "POST";
		document.form1.action = "/signIn/check";
		document.form1.submit(); 
	});
	
	$('#check').on('click', function(e){
		e.preventDefault();
		console.log($('#id').val());
		if($('#id').val() == ""){
			alert("아이디를 입력해 주세요!!");
			return;
		}
		document.form1.method = "POST";
		document.form1.action = "/signIn";
		document.form1.submit(); 
	});
/* 	 keyup paste */
	$("#passwordcheck").on("change", function() {
		var password = $('#password').val(); 
	    var passwordcheck = $(this).val();
	    if(password == passwordcheck) {
	        return;
	    }else {
	    	alert("틀림");
	    }    
	});
});


</script>

</head>
<body>
<div class="signInForm">
<form name="form1">
	<div class="signInMark">아이디 : </div>	<div class="signInLeft"><input id="id" type="text" name="id" > </div><button id="check">중복검사</button>
	<c:if test="${result == 'true'}">
	<div style="color:red">아이디를 사용불가능합니다.</div>
	</c:if>
	<c:if test="${result == 'false'}">
	<div style="color:green">아이디사용이 가능합니다.</div>
	</c:if>
	<div class="signInMark">비밀번호 : </div>	<div class="signInLeft"><input id="password" type="password"name="password"></div>
	<div class="signInMark">비밀번호 확인:</div><div class="signInLeft"><input id="passwordcheck" type="password"name="passwordcheck"></div>
	
	<div class="signInMark">생년월일 :</div> 	<div class="signInLeft"><input id="b_year" type="text"name="b_year">년<input id="b_month" name="b_month">월<input id="b_day" name="b_day">일</div>
	<div class="signInMark">성별 : </div>		<div class="signInLeft"><input id="gender" type="text"name="gender"></div>
	<div class="signInMark">이메일 : </div>	<div class="signInLeft"><input id="email" type="email"name="email"></div>
	<div class="signInMark">핸드폰번호 :</div> <div class="signInLeft"><input id="phone" type="text"name="phone"></div>
	<button id="signIn" name="signIn">회원가입</button>
	<button id="cancel" name="cancel">취소</button>
</form>
</div>
</body>
</html>