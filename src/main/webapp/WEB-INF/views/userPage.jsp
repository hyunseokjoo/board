<%@page import="com.java.board.FilesBean"%>
<%@page import="java.util.List"%>
<%@page import="com.java.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<script src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style>
.cardOuter{
  width: 50%;
  margin: 0 auto;
  height: auto;
}
.card{
 margin: 10px 3%;
}
.dn{ 
 display: none;
}
.col-md-4 img{
  heigth: 100%;
}
</style>

<script>
$(document).ready(function(){ 
	var data = { data : "data"} ;
	$.ajax({ 
		url: "/userPage", 
		method: "POST",
		data: data,
		dataType: "json", 
		success : function(data){
			console.log(data.fileList);
			console.log(data.list);
			var list = data.list;
			var fileList = data.fileList;
			var html = "";
			for (var i = 0; i < list.length; i++) {
				html += '<div class="card mb-3 " style="max-width: 540px;">';
				html += '<div class="row no-gutters">';
				html += '<div class="col-md-4">';
				for (var j = 0; j < fileList.length; j++) {
					if(parseInt(list[i].no) == parseInt(fileList[j].boardNum)){
						html += '<img src="/img/'+ fileList[j].fileUUIDName +'" class="card-img" alt="...">';
					}
				}
				html += '</div>';
				html += '<div class="col-md-8" value="">';
				html += '<div class="card-body">';
				html += '<h5 class="card-title">'+ list[i].title +'</h5>';
				html += '<p class="card-text">'+ list[i].content +'</p>';
				html += '<p class="card-text"><small class="text-muted">'+ list[i].name +'</small></p>';
				html += '</div>';
				html += '</div>';
				html += '</div>';
				html += '</div>';
				
			}
			$(".cardOuter").append(html);
			
		}
	});
	
})

</script>
</head>
<html>
  <body>
  
  <div class="cardOuter">
  
  </div>
	
  </body>
</html>