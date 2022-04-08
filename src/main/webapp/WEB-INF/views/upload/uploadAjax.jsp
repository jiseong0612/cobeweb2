<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
const checkExtension = function(fileName, fileSize){
	const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	const maxSize = 1024 * 1024 * 5; // 5MB
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과!!");
		return false;
	}
	if(regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}
const showUploadedFile = function(uploadResultArr){
	var html = '';
	$(uploadResultArr).each(function(i, obj){
		var lastIndexOfUnderBar = obj.fileName.lastIndexOf('_');
		var realName = obj.fileName.slice(lastIndexOfUnderBar + 1, obj.fileName.length);
		console.log(realName);
		html += '<li>' + realName + '</li>';
	});
	
	$('.uploadResult ul').append(html);
}

$(document).ready(function(){
	$('#uploadBtn').click(function(){
		var formData = new FormData();
		var inputFile = $('input[name=uploadFile]');
		var files = inputFile[0].files;
		
		for(let i = 0; i< files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append('uploadFile',  files[i]);
		}
				var cloneObj = $('.uploadDiv').clone();
		$.ajax({
			type : 'post',
			url : '/upload/uploadAjaxAction',
			data : formData,
			//dataType : 'json',
			contentType : false,
			processData : false,
			success : function(result){
				console.log("ajax result >>> ", result);
				
				showUploadedFile(result);
				
				$('input[name=uploadFile]').val('');
				
				
			},
			error(xhr,status, eror){
				console.log(xhr);
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
<div class="uploadResult">
	<ul>
	</ul>
</div>
<button type="button" id="uploadBtn">submit!</button>
</body>
</html>