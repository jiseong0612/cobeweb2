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
	
	<video controls="controls" width="1000">
		<source src="/display?fileName=2023/10/22/5d64ae0a-66c9-4c0d-91be-a8e5162abfde_SampleVideo_10mb.mp4">
		<source src="/display?fil4">
		
		Download the
		  <a href="/display?fileName=2023/10/22/5d64ae0a-66c9-4c0d-91be-a8e5162abfde_SampleVideo_10mb.mp4">WEBM</a>
		  or
		  <a href="/media/cc0-videos/flower.mp4">MP4</a>
 	 video.
	</video>
	<br>
	<br>
	<br>
	<input type="file" name="uploadFile"  multiple="multiple">
	<br>
	
	<button>submit</button>
</div>
<div class="uploadDiv">
	<ul></ul>
</div>
<script>
var uploadResult = $('.uploadDiv ul');

var showUploadedFile = function(uploadResultArr){
	var str = '';
	
	$(uploadResultArr).each(function(i, obj){
		if(!obj.image){
			str += '<li><img src="/resources/img/attachment.png"></li>';
		}else{
			var encodeFileName = encodeURIComponent(obj.uploadPath+'/s_'+obj.uuid+'_'+obj.fileName);
			str += '<li><img src="/display?fileName='+encodeFileName+'">'+obj.fileName+'</li>';
		}
	});
	
	uploadResult.append(str);
};

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
				dataType : 'json',
				success : function(result){
					$('[type=file]').val('');
					
					showUploadedFile(result);
				}
			});
		});
	});
</script>

</body>
</html>