<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>글 목록</h1>
<c:choose>
	<c:when test="${boardList == null }">
		<h1>작성된 글이 없습니다.</h1>
	</c:when>
	<c:otherwise>
		<c:forEach var="board" items="${boardList }">
			<li>글번호 :  ${board.bno } 제목 : ${board.title }</li>
		</c:forEach>
	</c:otherwise>
</c:choose>

</body>
</html>