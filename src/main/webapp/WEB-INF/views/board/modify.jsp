<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<script src="../../resources/summernote/summernote-lite.min.js"></script>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Register</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Modify</div>
            <div class="panel-body">
                <form role="form" action="/board/modify" method="post">
                    <input type="hidden" name="pageNum" value="${cri.pageNum }">
                    <input type="hidden" name="amount" value="${cri.amount }">
                    <input type="hidden" name="type" value="${cri.type }">
					<input type="hidden" name="keyword" value="${cri.keyword }">
                    <div class="form-group">
                        <label>Bno</label>
                        <input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Title</label>
                            <input class="form-control" name='title' value='<c:out value="${board.title }"/>'>
                    </div>
                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name='content' id="summernote"><c:out value="${board.content}" /></textarea>
                    </div>
                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
                    </div>
	                    <button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
	                    <button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
                    	<button type="submit" data-oper='list' class="btn btn-info">List</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 첨부파일  -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Files</div>
            <div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple>
				</div>
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
        </div>
    </div>
</div>


<script>
var formObj = $('form'); 

$(document).ready(function(){
	$('#summernote').summernote({
		focus : true
	});
	
    $('.btn').on('click', function(e){
    	e.preventDefault();
    	
    	var operation = $(this).data('oper');
    	
    	if(operation === 'remove'){
    		formObj.attr('action', '/board/remove').attr('method','post');
    	}else if(operation === 'list'){
    		var pageNumTag = $('input[name="pageNum"]').clone();
            var amountTag = $('input[name="amount"]').clone();
            var typeTag = $('input[name="type"]').clone();
            var keywordTag = $('input[name="keyword"]').clone();

            formObj.attr('action', '/board/list').attr('method', 'get');
            formObj.empty();
            formObj.append(pageNumTag);
            formObj.append(amountTag);
            formObj.append(typeTag);
            formObj.append(keywordTag);
    	}else{
    		formObj.attr('action', '/board/modify').attr('method','post');
    		var str ='';
    		
    		$('.uploadResult ul li').each(function(i, obj){
    			var jObj = $(obj);
    			console.dir(jObj);
				
    			str += '<input type="hidden" name="attachList['+i+'].fileName" value="'+jObj.data('filename')+'">';
    			str += '<input type="hidden" name="attachList['+i+'].uuid" value="'+jObj.data('uuid')+'">';
    			str += '<input type="hidden" name="attachList['+i+'].uploadPath" value="'+jObj.data('path')+'">';
    			str += '<input type="hidden" name="attachList['+i+'].fileType" value="'+jObj.data('type')+'">';
   			});
    		
    		formObj.append(str);
    	}
    	formObj.submit();
    });
});
</script>
<%@include file="../includes/footer.jsp"%>
