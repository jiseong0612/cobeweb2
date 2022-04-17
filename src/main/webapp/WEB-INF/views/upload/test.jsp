<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
	var data ={
			name :"name",
			age : 18
	}
	
	$('#buttonBtn').on('click', function(){
		$.ajax({
			type : "post",
			url :"/upload/testAjax",
			dataType : 'text',
			data :data,
			success : function(result){
				console.log("result >>> ", result);
				console.log("JSON.parse(result) >>> ", JSON.parse(result));
			},
			error : function(xhr, status, ero){
				console.log(xhr);
			}
		});
	});
});
</script>
</head>
<body>
	<h1>AjaxTest</h1>
{
	name :"name",
	age : 18
}

<button id="buttonBtn">버튼</button>

</body>
</html>