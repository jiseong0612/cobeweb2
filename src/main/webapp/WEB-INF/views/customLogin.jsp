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
			<input type="text" name="username" value="admin">
		</div>
		<div>
			<input type="text" name="password" value="admin">
		</div>
		<div>
			<input type="submit">
		</div>
		<textarea rows="" cols="">${_csrf }</textarea>
		<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
</body>
</html>