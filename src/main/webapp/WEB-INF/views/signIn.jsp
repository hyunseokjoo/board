<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.signInForm {
	width: 60%;
 	margin: 30%;
}
.signInMark {
	display: inline-block;
	width: 40%;
	height: 20px;
}
.signInForm input{
	width: 30%;
}
.signInLeft{
	display: inline-block;
	width: 55%;
	height: 20px;
}
</style>

</head>
<body>
<div class="signInForm">
<form method="POST">
	<div class="signInMark">아이디 : </div>	<div class="signInLeft"><input type="text" name="id"> </div>
	<div class="signInMark">비밀번호 : </div>	<div class="signInLeft"><input type="password"name="password"></div>
	<div class="signInMark">비밀번호 확인:</div><div class="signInLeft"><input type="password"name="passwordcheck"></div>
	<div class="signInMark">생년월일 :</div> 	<div class="signInLeft"><input typew="text"name="b_year">년<input name="b_month">월<input name="b_day">일</div>
	<div class="signInMark">성별 : </div>		<div class="signInLeft"><input type="text"name="gender"></div>
	<div class="signInMark">이메일 : </div>	<div class="signInLeft"><input type="email"name="email"></div>
	<div class="signInMark">핸드폰번호 :</div> <div class="signInLeft"><input type="text"name="phone"></div>
	<button name="signIn" formaction="/signIn">회원가입</button>
	<button name="cancel" formaction="/home" >취소</button>
</form>
</div>
</body>
</html>