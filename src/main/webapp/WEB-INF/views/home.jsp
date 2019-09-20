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
	$('.login').on('click',function(e){
		e.preventDefault();
		var id = $('#id').val();
		var password = $('#password').val();
		if(id == ""){
			alert("아이디를 입력해주세요");
			 $('#id').focus();
			 return;
		}else if(password == ""){
			alert("비밀번호를 입력해주세요");
			$('#password').focus();
			return;
		}else {
			document.form1.method="post";
			document.form1.action="/";
			document.form1.submit();
		}
	});
});
</script>

</head>
<body>

<form name="form1" method="POST">
	아이디 : <input type="text" name="id" id="id">
	비밀번호 : <input type="password" name="password" id="password">
	<button class="login">로그인</button>
	<button formaction="/signIn" >회원가입</button>
</form>

<c:if test="${msg == 'failure'}">
	<div style="color:red">아이디와 비밀번호가 맞지않습니다.</div>
</c:if>

</body>
</html>