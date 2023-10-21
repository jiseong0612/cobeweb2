<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<h1>upload with ajax</h1>
<div>
	<input type="file" name="uploadFile"  multiple="multiple">
	
	<button>submit</button>
</div>
<script>
	$(document).ready(function(){
		$('button').on('click', function(){
			var files = $('[name=uploadFile]')[0].files;
			
			var formData = new FormData();
			
			for(var i = 0; i<files.length; i++){
				formData.append('uploadFile', files[i]);
			}
			
			$.ajax({
				type: 'post',
				url : '/uploadFormAction',
				data : formData,
				contentType : false,
				processData : false,
				success : function(result){
					alert("upload");
				}
			});
			
		});
	});
</script>

</body>
</html>