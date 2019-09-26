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
  #star_grade a.on{
   color: red;
  } 
</style> 
<% //content_write 글작성,  content_update 글 수정 %>
<script>
$(document).ready(function(){
    $('#star_grade input').click(function(){
    	
        $(this).parent().children("input").prop("checked" , false); 
        $(this).attr('checked', true).prevAll("input").prop('checked', true);
        
        
        var it = ($(this).attr('checked', true).prevAll("input").length + 1);
        
        $(this).attr('checked', true).prevAll("input")[it];
        console.log($(this).attr('checked', false).prevAll("input"));
        console.log($(this).attr('checked', true).prevAll("input").context.attr('checked' , true ));
        
        
        return false;
    });
    $('#star_grade a').click(function(){ 
	    $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */
	    $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
	    console.log($(this).attr("value"));
    });
}); 
</script>


</head>
<body> 
<!-- content 내용 작성할때 class right사용 하자--> 
<div class="outer"> 
<div>  
  <div class="div_outer border">
    <ul class="nav flex-column">
	  <li class="nav-item"> 
	    <a class="nav-link text-info" href="#" >글쓰기</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link text-info" href="#">글관리</a>
	  </li>
	</ul>
  </div>
</div> 
<div class="right">
<ul class="navbar-nav px-3">
   <li class="nav-item text-nowrap">    
   <a class="nav-link" href="#" style="float:right;">로그 아웃</a>
   <%=request.getAttribute("id")%> 님 환영합니다.
   <input class="form-control" type="text" placeholder="Search" aria-label="Search" style="width: 20%; float: right;"> 
   </li>
</ul>


<%-- <table class="table table-hover">  
  <thead> 
    <tr>
      <th scope="col">번호</th>
      <th scope="col">제목</th>
      <th scope="col">내용</th>
      <th scope="col">작성자</th>
    </tr>
  </thead>
  <tbody>
     	<%
	 	List<BoardBean> list = (List<BoardBean>) request.getAttribute("list");
		
			if(list != null){
			int size =list.size();
			for(int i = size ; i > 0 ; i--){
		%>	<tr onclick="title_click(this)">	
				<td><%=list.get(i-1).getNo() %></td>
				<td><a href="/detail?no=<%=i %>" name="no" value="<%=list.get(i-1).getNo() %>"><%=list.get(i-1).getTitle() %></a></td>
				<td><%=list.get(i-1).getContent() %></td>
				<td><%=list.get(i-1).getName() %></td>
			<tr>
		<%
			 }
			}
		%>
  </tbody>
</table> --%>

<!-- 게시판 새글 작성 때    -->
<div class="dn content_outer" id="content_write"> 
	<form method="POST">
	 <div class="form-group">
		<label style="font-size: 40px;">제목</label>  <div style="float: right;">작성자</div>
		<input class="form-control" name="title" value = "" placeholder="제목을 입력해주세요">
		<hr>
	 </div> 
	 <div class="form-group">
		<h5>내용</h5>
		 <textarea class="form-control" name="content" value = "" rows="5" placeholder="내용을입력해주세요"></textarea>
		<hr>
	 </div>
		<h5>첨부파일</h5> 
		<input class="btn btn-outline-primary" type="file" enctype="multipart/form-data" multiple="multiple"><br><hr>
		<button class="btn btn-outline-success" type="submit"  formaction="/update" name="no" value="">작성</button>
		<button class="btn btn-outline-danger" type="submit" formaction="/delete" name="no" value="">취소</button><br>
	</form>
</div>

<!-- 게시판 글 수정때   -->
<div class=" content_outer" id="content_update"> 
	<form method="POST">
	 <div class="form-group">
		<label style="font-size: 40px;">제목</label>  <div style="float: right;">작성자</div>
		<input class="form-control" name="title" value = "" placeholder="제목을 입력해주세요">
		<hr>
	 </div> 
	 <div class="form-group">
		<h5>내용</h5>
		 <textarea class="form-control" name="content" value = "" rows="5" placeholder="내용을입력해주세요"></textarea>
		<hr>
	 </div>
	 <div class="form-group">
	 	<p id="star_grade">
		    <input type="radio" value="1" > 
		    <input type="radio" value="2" >
		    <input type="radio" value="3" >
		    <input type="radio" value="4" >
		    <input type="radio" value="5" >
	    </p>
		<!-- <p id="star_grade">
	        <a href="#" value="1">★</a>
	        <a href="#" value="2">★</a>
	        <a href="#" value="3">★</a>
	        <a href="#" value="4">★</a>
	        <a href="#" value="5">★</a>
		</p> -->
	 </div>
		<h5>첨부파일</h5>
		<input class="btn btn-outline-primary" type="file" enctype="multipart/form-data" multiple="multiple"><br><hr>
		<button class="btn btn-outline-success" type="submit"  formaction="/update" name="no" value="">작성</button>
		<button class="btn btn-outline-danger" type="submit" formaction="/delete" name="no" value="">취소</button><br>
	</form>
</div>
 



</div>
</div>
</body>
</html>