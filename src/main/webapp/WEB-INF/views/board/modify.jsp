<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<script>
	$(document).ready(function(){
		const $form = $('form');
		
		//버튼 일괄 컨트롤
		$(".btn").click(function(e){ 
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			if(operation === 'modify'){
				if(confirm("수정 하시겠습니까?")){
					$form.attr("action", "/board/modify").attr("method","post").submit();
				}
			}else if(operation === 'remove'){
				if(confirm("삭제 하시겠습니까?")){
					$form.attr("action", "/board/remove").attr("method","post").submit();
				}
			}else if(operation === 'list'){
				$form.attr("action", "/board/list").attr("method","get").submit();
			}
		});
	});
</script>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify/Delete</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Modify/Delete</div>
			<div class="panel-body">
				<form>
					<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount"  id="amount"  value="${cri.amount }">	
					<input type="hidden" name="type"    id="type"    value="${cri.type }">
					<input type="hidden" name="keyword" id="keyword" value="${cri.keyword }">
					<div class="form-group">
						<label>BNO</label> <input class="form-control" name="bno"  readOnly value="<c:out value='${board.bno }'/>">
					</div>
					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title"  value="<c:out value='${board.title }'/>">
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content" ><c:out value='${board.content }'/></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="writer" readOnly value="<c:out value='${board.writer}'/>">
					</div>
					
					<button data-oper='modify' class="btn btn-default">Modify</button>
					<button data-oper='remove' class="btn btn-danger">Remove</button>
					<button data-oper='list'   class="btn btn-info">List</button>
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>