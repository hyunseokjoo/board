<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
function idChecker () {
	var data = new Object();
	data.id = document.getElementsByName("id_check")[0].value;
	console.log(data);
	$.ajax({
        url: "/board/login/check",
        type: "POST",
        contentType: "application/json; charset=utf-8;",
        dataType: '',
        data: data,
        success: function(data){
            if(data.status == 1){
            	alert("사용가능한 ID입니다.")
            } else if (data.status == 2){
            	alert("이미 사용중인 ID입니다")
            } else{
            	alert("예기치 못한 에러가 발생 했습니다. 고객센터에 문의해 주세요.")
            }
        },
        error: function(){
            alert("simpleWithObject err");
        }
    });
}


</script>
</head>
<body>

<form action="" method="POST">
	아이디 :<input type="text" name="id_check" > <button type="button" name="id_check" onclick="idChecker()">중복확인</button> <br> 
	비밀번호:<input type="password" name="password"><br> 
	비밀번호재확인:<input type="password" name="passwordCheck"><br> 
	이메일  :<input type="email" name="email"><br> 
	생년월일 	: 년<input type="text" name="b_year"> 
			월<input type="text" name="b_month"> 
			일<input type="text" name="b_day"> <br>
	핸드폰번호	:<input type="text" name="phone"><br> 
	성별	:<input type="text" name="gender"><br> 
	<button type="submit">로그인</button>
</form>

</body>
</html>