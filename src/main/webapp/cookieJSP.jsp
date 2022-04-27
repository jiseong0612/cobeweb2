<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

Cookie cookie = new Cookie("name", "jiseong");
cookie.setPath("/");
cookie.setMaxAge(60 * 1);
response.addCookie(cookie);


Cookie[] cookies = request.getCookies();

if(cookies != null && cookies.length > 0){
	for(int i = 0; i< cookies.length; i++){
		
	}
}

//response header 
//Set-Cookie: name=jiseong; Max-Age=60; Expires=Wed, 27-Apr-2022 14:10:48 GMT; Path=/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재시간</title>
</head>
<body>
<%= cookie.getName() %>은 <%= cookie.getValue() %> 입니다.

</body>
</html>