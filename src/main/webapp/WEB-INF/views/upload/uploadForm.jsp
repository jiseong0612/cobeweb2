<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="/upload/uploadFormAction" enctype="multipart/form-data">
	<input type="file" name="uploadFile" multiple>
	<button type="submit">submit</button>
</form>
</body>
</html>