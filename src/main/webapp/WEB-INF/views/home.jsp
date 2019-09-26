<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery.min.js"></script>
<style> 
  .div_out{
  display: flex;
  align-content: center;
  }
  #form{
  border-radius:5px;
  box-shadow: 0px 0px 3px 0px #00A800;
  width: 40%;
  margin: 10% auto;
  max-width: 350px;
  }
  #div_top{
  text-align: center;
  padding-top: 20px;
  padding-bottom: 20px; 
  width: 80%;
  }
  #div_id{
  width: 80%;
  margin: auto;
  }
  #div_id input{
  height: 30px;
  margin: 10px 0px;
  border: none;
  border-radius:5px;
  box-shadow: 0px 0px 3px 0px #00A800;
  margin: 0 auto;
  width: 100%;
  }
  #div_pass{
  margin: auto;
  width: 80%;
  }
  #div_pass input{
  height: 30px;
  margin: 10px 0px;
  border: none;
  border-radius:5px;
  box-shadow: 0px 0px 3px 0px #00A800;
  width:100%;
  }
  
  #div_button1{
  text-align: center;
  margin: auto;
  width:60%;
  }
  #div_button1 button{
  height: 25px;
  color: white;
  cursor: pointer;
  border: none;
  font-size: 15px;
  background-color: #00A800;
  border-radius:5px;
  margin :5px auto;
  width:70%;
  }
  #div_button1 button:hover{
  background-color: gray;
  }
  #div_button2{
  text-align: center;
  margin: auto;
  width: 60%;
  }
  #div_button2 button{
  height: 25px;
  color: white;
  cursor: pointer;
  border: none;
  margin-bottom:5px;
  width: 70%;
  font-size: 15px;
  background-color: #00A800;
  border-radius:5px;
  }
  #div_button2 button:hover{
  background-color: gray;
  }
</style>
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
<div class="div_out">
<form id="form" name="form1" method="POST">
	<div id="div_top">로그인 정보를 입력해주세요.</div>
	<div id="div_id"><input type="text" name="id" id="id" placeholder="아이디"></div>
	<div id="div_pass"> <input type="password" name="password" id="password" placeholder="패스워드"></div>
	<div id="div_button1"><button class="login">로그인</button></div><div id="div_button2"><button formaction="/signIn" >회원가입</button></div>
</form>
<c:if test="${msg == 'failure'}">
	<div style="color:red">아이디와 비밀번호가 맞지않습니다.</div>
</c:if>
</div>
</body>
</html>