<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.uploadResult{
		width : 100%;
		background-color : gray;
	}
	
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img{
		width: 20px;
	}
</style>
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
		if(!obj.image){
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			html += '<li><div><a href="/upload/download?fileName='+fileCallPath+'"><img src="/resources/img/attachFile.jpg">' + obj.fileName + '</a><span data-file="'+fileCallPath+'" data-type="file">x</span><div></li>';
		}else{
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			html +='<li><div><a href="/upload/download?fileName='+fileCallPath+'"><img src="/upload/display?fileName='+fileCallPath+'"></a><span data-file="'+fileCallPath+'" data-type="image">x</span><div></li>';
		}
	});
	$('.uploadResult ul').append(html);
}


$(document).ready(function(){
	$('.uploadResult').on('click', 'span', function(){
		var targetFile = $(this).data('file');
		var type = $(this).data('type');
		
		$.ajax({
			type : 'post',
			url : '/upload/deleteFile',
			data : { fileName : targetFile, type : type},
			success : function(result){
				console.log(result);
			},
			error : function(xhr){
				console.log(xhr.responseText);
			}
		});
	});
	
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
			dataType : 'json',
			contentType : false,
			processData : false,
			success : function(result){
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