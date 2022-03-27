<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../reply/replyJS.jsp" %>
<script>
$(document).ready(function(){
	var bnoValue = $('#bno').val();
	
	$('.listBtn').click(function(e){
		e.preventDefault();
		$('#bno').remove();
		$('#hddnForm').submit();
	});
	
	$('.modBtn').click(function(e){
		e.preventDefault();
		$('#hddnForm').attr('action', '/board/modify').submit();
	});
	
 	//댓글 목록 조회
	replyService.getList(
		//reply json
		{bno : bnoValue, page : 1},
		//callback func
		function(list){
			list.forEach(li =>console.log(li));
		}
	);
 	
	//등록
	/* replyService.add(
		//reply json
		{reply : 'JS test', replyer : 'tester', bno :bnoValue},
		//callback func
		function(result){
			alert('result ' + result);
		}
	); */
	
	//댓글 1개 조회
/* 	replyService.get(
		24,
		//callback func
		function(data){
			console.log(data);
		},
		//error func
		function(err){
			alert('ERROR..');
		},
	); */
	
	//삭제
/* 	replyService.remove(
		//삭제할 댓글 번호
		10,
		//callback func
		function(count){
			console.log(count);
			if(count === 'success'){
				alert('REMOVED');
			}
		},
		//error func
		function(err){
			alert('ERROR..');
		}
	);*/
	 
	 //수정
/* 	replyService.update(
		{rno : 11, reply : 'sara i miss you', replyer : 'rocky'},
		//callback func
		function(count){
			console.log(count);
			if(count === 'success'){
				alert('update');
			}
		},
		//error func
		function(err){
			alert('ERROR..');
		},
	); */

});
</script>
<form id="hddnForm" action="/board/list" method="get">
	<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" 	id="amount"  value="${cri.amount }">
	<input type="hidden" name="bno" 	id="bno" 	 value="${board.bno }">
	<input type="hidden" name="type" 	id="type" 	 value="${cri.type }">
	<input type="hidden" name="keyword" id="keyword" value="${cri.keyword }">
</form>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read</div>
			<div class="panel-body">
				<div class="form-group">
					<label>BNO</label> <input class="form-control" name="bno" readonly value="<c:out value='${board.bno }'/>">
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name="title" readonly value="<c:out value='${board.title }'/>">
				</div>
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name="content" readonly><c:out value='${board.content }'/></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name="writer"  readonly value="<c:out value='${board.writer}'/>">
				</div>
				<button type="button" class="btn btn-default listBtn"><a href="/board/list">List</a></button>
				<button type="button" class="btn btn-default modBtn"><a href="/board/modify?bno=<c:out value='${board.bno}'/>">Modify</a></button>
			</div>
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>