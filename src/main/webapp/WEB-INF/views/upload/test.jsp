<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	var json ={
			name :"name",
			age : 18
	}
	console.log("obj >> ",json);
	console.log("stringify >> " ,JSON.stringify(json));
	console.log("parse >> " ,JSON.parse(JSON.stringify(json)));
	$.ajax({
		type : "post",
		url :"/upload/testAjax",
		contentType : 'application/json',
		data : json,
		success : function(result){
			console.log("success..........");
			console.log("1", result);
			console.log("2", JSON.parse(result));
		},
		error : function(xhr, status, ero){
			console.log(xhr);
		}
	});
</script>
</head>
<body>
	<h1>AjaxTest</h1>


</body>
</html>