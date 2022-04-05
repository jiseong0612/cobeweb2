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
	$('#uploadBtn').click(function(){
		var formData = new FormData();
		var inputFile = $('input[name=uploadFile]');
		var files = inputFile[0].files;
		
		for(let i = 0; i< files.length; i++){
			formData.append('uploadFile',  files[i]);	//{name: 'withMyLove.jpg', lastModified: 1645683688994, lastM...} JSON데이터를 넣어줌
		}
		console.log(formData);
		
		$.ajax({
			type : 'post',
			url : '/upload/uploadAjaxAction',
			data : formData,
			contentType : false,
			processData : false,
			success : function(result){
				console.log(result);
				alert("uploaded");
			},
			error(xhr,status, eror){
				console.log(xhr);
				console.log(status);
				console.log(eror);
			}
		});	//end ajax
	});
});
</script>
</head>
<body>
<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>
<button type="button" id="uploadBtn">submit!</button>
</body>
</html>