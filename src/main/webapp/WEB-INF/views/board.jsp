<%@page import="com.java.board.BoardBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<meta charset="UTF-8">
<title>게시판</title>
<style>
  .dn {
	 display:none;
  }
  .btn{
    width: 100%;
  }
  .div_outer{
   top : 0px;
   width: 200px;
   position: fixed;
   height: 100%;
  }
  .nav{
    margin-top: 50px;
  } 
  .right{
  	position: relative;
  	width: 80%;
  	left: 195px;
   	height: auto;
  }
  .outer{
   margin: 0 auto;
   width: 100%;
   height: 200px;
   max-width: 1500px;
  }
  .table{  
   margin: 5% auto; 
   width: 75%;
  } 
  .content_outer{ 
   margin: 5% auto; 
   width: 75%;
  }
  .content_outer button{ 
   width: 20%; 
  }
  #star_grade a{
   text-decoration: none;
   color: gray;
  }
  .on{
   color: red;
  } 
  .select_img{
  	padding: 10px;
  }
</style> 
<% //content_write 글작성,  content_update 글 수정 %>
<script>
$(document).ready(function(){
	var star = 0;
    $('.star_grade a, .update_star a').click(function(){ 
	    $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */
	    $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
	    star = $(this).attr("value");
    });
    //페이지 글쓰기 전환
    $("#write").click(function(e){
    	e.preventDefault();
    	$("#content_update").addClass("dn");
    	$("#content_list").addClass("dn");
    	$("#content_write").removeClass("dn");
    });
    //페이지 글목록 전환
    $("#list , #write_cancel .update_back").on('click', function(e){ 
    	$("#content_update").addClass("dn");
    	$("#content_write").addClass("dn");
    	$("#content_list").removeClass("dn");
    });
    //글 작성
    $("#content_insert").click(function(e){
    	e.preventDefault();
    	var formData = new FormData();
    	console.log($("#write_file")[0].files.length);
    	console.log($("#write_file")[0].files[0]);
    	formData.append('title', $("#write_title").val());
    	formData.append('content', $("#write_content").val() );
    	formData.append('star', star);
    	formData.append('name', $('#write_name').text());
    	formData.append('no',  no);
    	for(var i=0 ; i < $("#write_file")[0].files.length; i++) {
    		   formData.append("files" , $("#write_file")[0].files[i]);
    	}
    	$.ajax({ 
			url: "/insert", 
			data: formData, 
			method:"POST", 
			processData: false,
			contentType: false,
			dataType: "json", 
			success : function(data){
				console.log(data);
				$("#content_update").addClass("dn");
		    	$("#content_write").addClass("dn");
		    	$("#content_list").removeClass("dn");
		    	location.reload();
			}
		});
    });
    //자세히 보기 = 수정
    var no = 0;
    $('.content_click').on('click', function(e){
    	e.preventDefault();
    	var data = { no : $(this).children("td")[0].innerText }
    	$.ajax({ 
			url: "/board_Detail", 
			data: data, 
			method:"POST", 
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json", 
			success : function(data){
				//오류 해결
				//console.log(typeof data);json 아니고 오브젝트
				//var str = JSON.stringify(data);// string으로 변환해줌.
				//console.log(typeof str);
				console.log(data);
				var result = data.info;
				var fileList = data.fileList;
				console.log(result);
				console.log(fileList);
				$("#content_list").addClass("dn");
		    	$("#content_write").addClass("dn");
		    	$("#content_update").removeClass("dn");
		    	//값 넣기
		    	no = result.no;
		    	$("#update_name").text(result.name);
		    	$("#update_title").val(result.title); 
		    	$("#update_content").val(result.content);
		    	star = result.star;
		    	for (var i = 0; i < result.star; i++) {
		    		$(".update_star").children('a').eq(i).addClass('on');
				}
		    	//http://localhost:8080/img/KakaoTalk_20190827_110419813.png
		    	for (var i = 0; i < fileList.length; i++) {
		    		var html = "<img style='width: 25%;' src='/img/" + fileList[i].fileUUIDName + "'/>";
		    		$(".select_img").append(html);
				}
		    	
			}
		});
	});
    $('#update').click(function(e){
    	e.preventDefault();
    	var formData = new FormData();
    	formData.append('title', $("#update_title").val());
    	formData.append('content',$("#update_content").val() );
    	formData.append('star', star);
    	formData.append('name', $('#update_name').text());
    	formData.append('no',  no);
    	
    	console.log(data);
    	$.ajax({ 
			url: "/update", 
			data: formData, 
			method:"POST", 
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json", 
			success : function(data){
				console.log("1");
				$("#content_update").addClass("dn");
		    	$("#content_write").addClass("dn");
		    	$("#content_list").removeClass("dn");
		    	alert("수정되었습니다.");
		    	location.reload();
			}
		});
    });
    
    $('#update_delete').click(function(e){
    	e.preventDefault();
    	var data = { 'no' : no };
    	$.ajax({ 
			url: "/delete", 
			data: data, 
			method:"POST", 
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json", 
			success : function(data){
				console.log("1");
				$("#content_update").addClass("dn");
		    	$("#content_write").addClass("dn");
		    	$("#content_list").removeClass("dn");
		    	alert("삭제되었습니다.")
		    	location.reload();
			}
		});
    });
    var ajax_file = [];
    $("#write_file").change(function(e){
    	$(".select_img").empty();
    	var files = e.target.files;
    	var filesArr = Array.prototype.slice.call(files);
    	var index = 0;
    	for (var i = 0; i < filesArr.length; i++) {
    		if(!filesArr[i].type.match("image.*")){
    			alert("확장자는 이미지 확장자만 가능합니다");
    			return;
    		}
    		ajax_file.push(filesArr[i]);
    		console.log(filesArr[i]);
    		var reader = new FileReader();
			reader.onload = function(data){
	   			var source_path = data.target.result;
	   			var source = '<img style="width: 25%;"src="' + source_path + '"/>';
	   			$(".select_img").append(source);		
	   			console.log(index);
			}
			reader.readAsDataURL(filesArr[i]);
		}
    	
    });
}); 
</script>
</head>
<body>
<!-- nav bar --> 
<!-- content 내용 작성할때 class right사용 하자--> 
<div class="outer"> 
<div>  
  <div class="div_outer border">
    <ul class="nav flex-column">
    	<li class="nav-item">
	    <a id="list" class="nav-link text-info" >글관리</a>
	  </li>
	  <li class="nav-item"> 
	    <a id="write" class="nav-link text-info" >글쓰기</a>
	  </li>
	</ul>
  </div>
</div> 

<div class="right">
<!-- nav bar 상단 -->
<ul class="navbar-nav px-3">
   <li class="nav-item text-nowrap">    
   <!-- 로그아웃 적용 --> 
   <a class="nav-link" href="/logout" style="float:right;">로그 아웃</a>
   <%=request.getAttribute("id")%> 님 환영합니다.
   <input class="form-control" type="text" placeholder="Search" aria-label="Search" style="width: 20%; float: right;"> 
   </li>
</ul>

<!-- 글관리(list) -->
 <table class="table table-hover" id="content_list">  
  <thead> 
    <tr>
      <th scope="col">번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
    </tr>
  </thead>
  <tbody>
     	<% List<BoardBean> list = (List<BoardBean>) request.getAttribute("list");
     	System.out.println(list);
		
			if(list != null){
			int size =list.size();
			for(int i = size ; i > 0 ; i--){
		%>	<tr class="content_click">	
				<td><%=list.get(i-1).getNo() %></td>
				<td><a href="/detail?no=<%=i %>" name="no" value="<%=list.get(i-1).getNo() %>"><%=list.get(i-1).getTitle() %></a></td>
				<td><%=list.get(i-1).getName() %></td>
			<tr>
		<%
			 }
			}
		%>
  </tbody>
</table> 

<!-- 게시판 새글 작성 때    -->
<div class="content_outer dn" id="content_write"> 
	<form name="write_form" method="POST">
	 <div class="form-group">
		<label style="font-size: 40px;">제목</label>  <div style="float: right;">작성자 <a id="write_name"><%=request.getAttribute("id")%></a> </div>
		<input id="write_title" class="form-control" name="title" placeholder="제목을 입력해주세요">
		<hr>
	 </div> 
	 <div class="form-group">
		<h5>내용</h5>
		 <textarea id="write_content" class="form-control" name="content" rows="5" placeholder="내용을입력해주세요"></textarea>
		<hr>
	 </div>
	  <div class="form-group">
	   <p class="star_grade" >
	        <a href="#" value="1">★</a>
	        <a href="#" value="2">★</a>
	        <a href="#" value="3">★</a>
	        <a href="#" value="4">★</a>
	        <a href="#" value="5">★</a>
		</p> 
	 </div>
		<h5>첨부파일</h5> 
		<div class="select_img"><img src="" /></div>
		<input id="write_file" class="btn btn-outline-primary" name="file[]" type="file" enctype="multipart/form-data" multiple="multiple"><br><hr>
		<button class="btn btn-outline-success" id="content_insert" >작성</button>
		<button class="btn btn-outline-danger" id="write_cancel">취소</button><br>
	</form>
</div>

<!-- 게시판 글 수정때   -->
<div class="content_outer dn" id="content_update"> 
	<form method="POST">
	 <div class="form-group">
		<label style="font-size: 40px;">제목</label>  <div style="float: right;">작성자<br><a id="update_name"></a></div>
		<input id="update_title" class="form-control" name="title"  >
		<hr>
	 </div> 
	 <div class="form-group">
		<h5>내용</h5>
		 <textarea  id="update_content" class="form-control" name="content"rows="5" ></textarea>
		<hr>
	 </div>
	 <div class="form-group">
	   <p class="update_star">
	        <a href="#" value="1">★</a>
	        <a href="#" value="2">★</a>
	        <a href="#" value="3">★</a>
	        <a href="#" value="4">★</a>
	        <a href="#" value="5">★</a>
		</p> 
	 </div>
		<h5>첨부파일</h5>
		<div class="select_img"></div>
		<input  id="update_file" name="file"  class="btn btn-outline-primary" type="file" enctype="multipart/form-data" multiple="multiple"><br><hr>
		<button class="btn btn-outline-success" id="update">수정</button>
		<button class="btn btn-outline-danger"  id="update_delete">삭제</button>
		<button class="btn btn-outline-secondary update_back" >뒤로가기</button><br>
	</form>
</div>
 



</div>
</div>
</body>
</html>