<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>/sample/ALL page</h1>
	<%-- 익명 또는 로그인 하지 않는 경우 --%>
	<sec:authorize access="isAnonymous()">
		<a href="/customLogin">로그인</a>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_MEMBER')">
		멤버 권한
		<br><br>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		관리자 권한
		<br><br>
	</sec:authorize>
	
	<sec:authorize access="hasAnyRole('ROLE_MEMBER, ROLE_ADMIN')">
		멤버 또는 관리자
		<br><br>
	</sec:authorize>
	
	<%-- 인증된 사용자 --%>
	<sec:authorize access="isAuthenticated()">
		<a href="/customLogout">로그아웃</a>
	</sec:authorize>
	<br>
	<a href="/board/list">게시판</a>
</body>
</html>