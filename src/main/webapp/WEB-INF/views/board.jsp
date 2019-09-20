<%@page import="com.java.board.BoardBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

</head>
<body>
<h1>게시판</h1> <%=request.getAttribute("id")%> 님 환영합니다.
<hr>
<table>
	<th>번호</th>
	<th>제목</th>
	<th>내용</th>
	<th>작성자</th>
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
</table>
<hr>
<form>
<button type="submit" formaction="/detail">글쓰기</button>
</form>
</body>
</html>