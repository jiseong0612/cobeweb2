<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>custom login page</h1>
	<h2>${error }</h2>
	<h2>${logout }</h2>
	
	<form method="post" action="/login">
		<div>
			userid:<input type="text" name="userid" value="admin90">
		</div>
		<div>
			username:<input type="text" name="username" value="관리자90">
		</div>
		<div>
			userpw:<input type="text" name="password" value="pw90">
		</div>
		<div>
			<input type="checkbox" name="remember-me" id="rmChkBox">
			<label for="rmChkBox">자동 로그인</label>
		</div>
		<div>
			<input type="submit">
		</div>
		<textarea rows="" cols="">${_csrf }</textarea>
		<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
</body>
</html>