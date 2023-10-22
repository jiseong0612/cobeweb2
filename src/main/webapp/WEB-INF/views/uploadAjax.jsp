<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<h2>uploadAjax</h2>
	<div class="uploadDiv">
		<input type="file" name="uploadFile"  multiple>
	</div>
	<button id="uploadBtn">submit</button>
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		</div>
	</div>
<script>
var maxSize = 1024 * 1024 * 50;
var regex = new RegExp("(.*?)\.(sh|zip|alz)$");
var uploadResult = $('.uploadResult ul');

var checkExtension = function(fileName, fileSize){
	if(fileSize >= maxSize){
		alert('파일 사이즈 초과!');
		return false;
	}
	
	if(regex.test(fileName)){
		alert('해당 종류의 파일은 업로드할 수 없습니다.');
		return false;
	}
	
	return true;
};

var showUploadedFile = function(uploadResultArr){
	var str = '';
	
	$(uploadResultArr).each(function(i, obj){
		if(obj.type === 'attach'){
			var encodeFileName = encodeURIComponent(obj.uploadPath+'/'+obj.uuid+'_'+obj.fileName);
			str += '<li><a href="/download?fileName='+encodeFileName+'"><img src="/resources/img/attachment.png">'+obj.fileName+'</a><span data-file="'+encodeFileName+'">x</span></li>';
		}else if(obj.type === 'video'){
			var encodeFileName = encodeURIComponent(obj.uploadPath+'/'+obj.uuid+'_'+obj.fileName);
			str += '<li>';
			str += '	<video controls="controls" width="700">';
			str += '		<source src="/display?fileName='+encodeFileName+'">';
			str += '	</video>';
			str += obj.fileName + '<span data-file="'+encodeFileName+'">x</span>';
			str += '</li>';
		}else if(obj.type ==='img'){
			var encodeFileName = encodeURIComponent(obj.uploadPath+'/s_'+obj.uuid+'_'+obj.fileName);
			str += '<li><img src="/display?fileName='+encodeFileName+'">'+obj.fileName+'<span data-file="'+encodeFileName+'" data-type="img">x</span></li>';
		}
	});
	
	uploadResult.append(str);
};

	$(document).ready(function(){
		//업로드 버튼 클릭
		$('button').on('click', function(){
			var files = $('[name=uploadFile]')[0].files;
			
			var formData = new FormData();
			
			
			for(var i = 0; i<files.length; i++){
 				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				
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
		
		//삭제 버튼 클릭
		$('.uploadResult').on('click', 'span', function(){
			var thisItem = $(this);
			var targetFile = $(this).data('file');
			var type = $(this).data('type');
			
			$.ajax({
				type : 'post',
				url : '/deleteFile',
				data : {fileName :targetFile, type :type},
				dataType : 'text',
				success : function(result){
					thisItem.closest('li').remove();
				}
			});
		});
	});
</script>

</body>
</html>