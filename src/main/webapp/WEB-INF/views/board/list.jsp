<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>

<script>
$(document).ready(function(){
	//글작성,수정삭제 여부 결과
	let result = '<c:out value="${result}"/>';
	
	checkModal(result);
	history.replaceState({}, null, null);
	
	function checkModal(result){
		if(result === '' || history.state){
			return;
		}
		
		if(parseInt(result) > 0){
			console.log(result + "번 글이 등록되었습니다.");
		}
	}
	//글작성 버튼
	$("#regBtn").click(function(){
		location.href="/board/register";		
	});
	
	//페이지 이동
	$('.page-link').on('click', function(event){
		event.preventDefault();
		var pageNum = $(this).attr('href');
		
		var boardAmount = $('#boardAmount').val();
		$('#pageNum').attr('value', pageNum);
		$('#amount').val(boardAmount);
		$('#hddnForm').submit();
	});
	
	//글상세 이동
	$('.bno').on('click',function(event){
		event.preventDefault();
		
		let bno = $(this).attr('href');
		$('#hddnForm').append('<input type="hidden" name="bno" value="'+ bno+'">')
		$('#hddnForm').attr('action', '/board/get').submit();
	});
	
	$('#searchBtn').on('click',function(event){
		event.preventDefault();
		$('#hddnForm').find('input[name=pageNum]').val(1);
		$('#hddnForm').submit();
	});
});
</script>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board List Page
				<button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="board">
							<tr class="odd gradeX">
								<td>${board.bno }</td>
								<td><a class="bno" href='<c:out value="${board.bno }"/>'>${board.title }</a></td>
								<td>${board.writer }</td>
								<td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${board.updateDate }" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<form id="hddnForm" action="/board/list" method="get">
					<select  id="type" name="type">
						<option value="TCW" ${pageMaker.cri.type == 'TCW'? 'selected' : ''} >전체</option>
						<option value="T" 	${pageMaker.cri.type == 'T'? 'selected' : ''}>제목</option>
						<option value="C" 	${pageMaker.cri.type == 'C'? 'selected' : ''}>내용</option>
						<option value="W" 	${pageMaker.cri.type == 'W'? 'selected' : ''}>작성자</option>
					</select>
					<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" id="amount" value="${pageMaker.cri.amount }">
					<input type="text"  name="keyword" id="keyword" value="${param.keyword }">
					<button id="searchBtn" class="btn btn-default">Search</button>
				</form>
				
				<!-- 페이징 -->
				<div class="pull-right">
					<select class="form-control" id="boardAmount">
						<option value="10" ${pageMaker.cri.amount == 10 ? 'selected' :''}>10개</option>
						<option value="5"  ${pageMaker.cri.amount == 5 ? 'selected' :''} >5개</option>
						<option value="3"  ${pageMaker.cri.amount == 3 ? 'selected' :''} >3개</option>
					</select>
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li class="page-item"><a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
								<li class="page-item ${pageMaker.cri.pageNum == num ? 'active': '' }" ><a class="page-link" href="${num}">${num}</a></li>
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>