<%@page import="com.java.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<!--게시판 내용 있을 때  -->
<% if(user.getNo() != null){ %>
<div class="dn_1">
<form method="POST">
<h1>제목  <input  name="title" value = "<%=user.getTitle() %>"> </h1> 
    작성자 <%=request.getAttribute("id")%>
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
<% } %>
<!--게시판 내용 없을 때 -->
<% if(user.getNo() == null){ %>
<div class="dn_1">
<form method="POST">
<h1>제목  <input  name="title" > </h1> 
    작성자 <%=request.getAttribute("id")%>
<hr>
<h2>내용</h2>
 <input  name="content" value = "">
<hr>
<h2>첨부파일</h2>
<input type="file" enctype="multipart/form-data" multiple="multiple"><br><hr>
<button type="submit" formaction="/insert" name="no" >작성</button>
<button type="submit" formaction="/board" name="no" >뒤로</button><br>
</form>
</div>
<% } %>


</body>
</html>