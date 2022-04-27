<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//쿠키 생성
Cookie cookie = new Cookie("name", "jiseong");
cookie.setPath("/");
cookie.setMaxAge(60 * 60);
response.addCookie(cookie);


//쿠키 삭제
/* if(cookies != null && cookies.length > 0){
	for(int i = 0; i< cookies.length; i++){
		String cookieName = cookies[i].getName();
		System.out.println(cookieName);
		if(cookies[i].getName().equals("AAA")){
			//쿠키 새로 생성~~~
		}else if(cookies[i].getName().equals("BBB")){
			cookies[i].setMaxAge(0); //쿠키 삭제~~
		}
	}
}  */

//response header 
//Set-Cookie: name=jiseong; Max-Age=60; Expires=Wed, 27-Apr-2022 14:10:48 GMT; Path=/
String rememberMe = "";
Cookie[] cookies = request.getCookies();
if(cookie.getValue().equals("jiseong")){
	rememberMe = "checked";
}
pageContext.setAttribute("rememberMe", rememberMe);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재시간</title>
</head>
<body>
<label for="rememberMe">자동로그인</label>
<input type="checkbox" id="rememberMe" ${rememberMe }>
</body>
</html> 