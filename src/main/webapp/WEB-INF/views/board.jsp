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
  width: 100;
  	padding: 10px;
  }

.where {
  display: block;
  margin: 25px 15px;
  font-size: 11px;
  color: #000;
  text-decoration: none;
  font-family: verdana;
  font-style: italic;
} 
.upload-name{
width: 40%;
}

.filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

body {margin: 10px}
.where {
  display: block;
  margin: 25px 15px;
  font-size: 11px;
  color: #000;
  text-decoration: none;
  font-family: verdana;
  font-style: italic;
} 

.filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
    display: inline-block;
    padding: .5em .75em;
    font-size: inherit;
    font-family: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}

.filebox.bs3-primary label {
  color: #fff;
    background-color: #337ab7;
    border-color: #2e6da4;
    } 
.label{
  margin-top: 8px;
}
.paging{
	width: 5%;
	margin: 0 auto;
	margin-bottom: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
}
.pagingOuter{
  width: 100%; 
}
.pagingIn{
  margin-right: 4px;
}
</style>
<% //content_write 글작성,  content_update 글 수정 %> 
<script>
$(document).ready(function(){
    //페이지 글쓰기 전환
    $("#write").click(function(e) {
    	e.preventDefault();
    	$(".select_img").empty();
    	$("#content_update").addClass("dn");
    	$("#content_list").addClass("dn");
    	$("#content_write").removeClass("dn");
    });
    //페이지 글목록 전환
    $("#list , #write_cancel, .update_back").click( function(){
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
  	//별점 주기 내용
	var star = 0;
    $('.star_grade a, .update_star a').click(function(e){ 
    	e.preventDefault();
	    $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */
	    $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
	    star = $(this).attr("value");
    });
    //자세히 보기
    var no = 0;
    $('.content_click a, .content_click').on('click',function(e){
    	e.preventDefault();
    	console.log($(this).children("td")[0].innerText );
    	var data = { no : $(this).children("td")[0].innerText }
    	console.log(data);
    	$.ajax({ 
			url: "/board_Detail", 
			data: data, 
			method:"POST", 
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json", 
			success : function(data){
				$(".select_img").empty();
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
		    		var html = "<div><img style='width: 25%;' src='/img/" + fileList[i].fileUUIDName + "'/><div style='width: 10%;'class='fileDelete' value='"+ fileList[i].fileUUIDName +"'>삭제</div></div>";
		    		$(".select_img").append(html);
				}
		    	
		    	 $(".fileDelete").off().on('click', function(){
		    		 console.log($(this).parent().addClass("dn"));
		    	    	console.log($(this).children().prevObject.eq(0).attr("value"));
		    	    	fileName = $(this).children().prevObject.eq(0).attr("value");
		    	    	data = { 'fileName' : fileName }
		    	    	 $.ajax({ 
		    				url: "/fileDelete", 
		    				data: data, 
		    				method:"POST", 
		    				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		    				dataType: "json", 
		    				success : function(data){
		    					console.log(data.result);
		    					if(data.result){
		    						alert("삭제되엇습니다.");
		    					}else {
		    					 	alert("문제가 발생했습니다");
		    					}
		    				}
		    	    	});
		    	 });
			}
		});
	});
    //디테일에서 수정
    $('#update').click(function(e){
    	var formData = new FormData();
    	e.preventDefault();
    	console.log(no);
    	console.log($("#write_file")[0].files.length);
    	console.log($("#write_file")[0].files[0]);
    	formData.append('title', $("#update_title").val());
    	formData.append('content',$("#update_content").val() );
    	formData.append('star', star);
    	formData.append('name', $('#update_name').text());
    	formData.append('no',  no);
    	if($("#update_file")[0].files.length!=0){
    		for(var i=0 ; i < $("#update_file")[0].files.length; i++) {
 		   		formData.append("files" , $("#update_file")[0].files[i]);
 			}
    	}
    	 
    	
    	if($("#update_file")[0].files.length!=0){
    		console.log("1");
	    	 $.ajax({ 
				url: "/updateWithFile", 
				data: formData, 
				method:'POST', 
				processData: false,
				contentType: false,
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
    	}else{
    		console.log("2");
    		$.ajax({ 
    			url: "/updateWithoutFile", 
    			data: formData, 
    			method:'POST', 
    			processData: false,
    			contentType: false,
    			dataType: "json", 
    			success : function(data){
    				$("#content_update").addClass("dn");
    		    	$("#content_write").addClass("dn");
    		    	$("#content_list").removeClass("dn");
    		    	alert("수정되었습니다.");
    		    	location.reload();
    			}
    		});  
    	}
    });
    //디테일에서 삭제
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
				$("#content_update").addClass("dn");
		    	$("#content_write").addClass("dn");
		    	$("#content_list").removeClass("dn");
		    	alert("삭제되었습니다.")
		    	location.reload();
			}
		});
    });
    //새글 작성
    var ajax_file = [];
    $("#write_file, #update_file").change(function(e){
    	e.preventDefault();
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
	   			var source = '<img style="width: 25%;"src="' + source_path + '"/><div></div>';
	   			$(".select_img").append(source);		
	   			console.log(index);
			}
			reader.readAsDataURL(filesArr[i]);
		}
    });
    imgBox
    $("#write_file, #update_file").change(function(e){
    	e.preventDefault();
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
	   			var source = '<img style="width: 25%;"src="' + source_path + '"/><div></div>';
	   			$(".select_img").append(source);		
	   			console.log(index);
			}
			reader.readAsDataURL(filesArr[i]);
		}
    });
   //파일 업로드 네임 input박스 설정
  $('.filebox .upload-hidden').change( function(){
    	var totalName = "";
    	console.log( $(this)[0].files);
    	for (var i = 0; i < $(this)[0].files.length; i++) {
	        if(window.FileReader){
	            var filename = $(this)[0].files[i].name;
	        } else {
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        }
			totalName += filename;
    	}
    	if($(this)[0].files.length == 1){
	        $(this).siblings('.upload-name').val(totalName);
        }else if ($(this)[0].files.length >= 2){
         var length = "파일" + $(this)[0].files.length + "개";
         $(this).siblings('.upload-name').val(length);
        }
    });
   $('#paging_second button').click(function(){
	  console.log( $(this).text());
	  var num = { num : $(this).text() };
	  console.log(num);
	   
	   
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
	  <li class="nav-item"> 
	    <a href="/userPage" id="move" class="nav-link text-info" >홈페이지 이동</a>
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
<div  id="content_list">
 <table class="table table-hover">  
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
</div>

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
		<div class="filebox bs3-primary">
         <input class="upload-name" value="파일선택" disabled/>      
         <label class="label"for="write_file">업로드</label> 
         <input id="write_file" name="file[]" type="file" enctype="multipart/form-data" multiple="multiple" class="upload-hidden"/> 
        </div>
		<hr>
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
		<div class="imgBox">
		 <div class="select_img filebox"></div>
		</div>
		<div class="filebox bs3-primary">
         <input class="upload-name" value="파일선택" disabled>      
         <label class="label" for="update_file">업로드</label> 
         <input id="update_file" name="file[]" type="file" enctype="multipart/form-data" multiple="multiple" class="upload-hidden"> 
        </div>
		<hr>
		<button class="btn btn-outline-success" id="update">수정</button>
		<button class="btn btn-outline-danger"  id="update_delete">삭제</button>
		<button class="btn btn-outline-secondary update_back" >뒤로가기</button><br>
	</form>
	
</div>
 



</div>
</div>
</body>
</html>