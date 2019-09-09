<%@page import="com.java.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.dn_1 .dn_2 {
	 display:none;
	}
</style>
</head>
<body>

<%
	
	BoardBean user = (BoardBean) request.getAttribute("info");
%>
<div class="dn_1">
<form method="POST">
<h1>제목  <input  name="title" value = "<%=user.getTitle() %>"> </h1> 
    작성자 <%=user.getName() %>
<hr>
<h2>내용</h2>
 <input  name="content" value = "<%=user.getContent() %>">
<hr>
<h2>첨부파일</h2>
<input type="file" enctype="multipart/form-data" multiple="multiple"><br><hr>
<button type="submit" formaction="/update" name="no" value="<%=user.getNo()%>">작성</button>
<button type="submit" formaction="/delete" name="no" value="<%=user.getNo()%>">삭제</button><br>
</form>
</div>
<%-- <div class="dn_2">
<form method="POST">
<h1>제목  <input  name="title" value = "<%=user.getTitle() %>"> </h1> 
    작성자 <%=user.getName() %>
<hr>
<h2>내용</h2>
 <input  name="content" value = "<%=user.getContent() %>">
<hr>
<h2>첨부파일</h2>
<input type="file" enctype="multipart/form-data" multiple="multiple"><br><hr>
<button type="submit" formaction="/update" name="no" value="<%=user.getNo()%>">수정</button>
<button type="submit" formaction="/delete" name="no" value="<%=user.getNo()%>">삭제</button><br>
</form>
</div> --%>
</body>
</html>