<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../reply/replyJS.jsp" %>
<script>
$(document).ready(function(){
	const BNO_VALUE = $('#bno').val();	//글번호 상수
	const $modal = $('.modal');
	let rno;
	//시간표시 컨트롤
	var displayTime = function(timeValue){
		let today = new Date();
		let gap = today.getTime() - timeValue;
		let dateObj = new Date(timeValue);
		let str = '';
		
		if(gap < (1000 * 60 * 60 * 24)){
			let hh = dateObj.getHours();
			let mi = dateObj.getMinutes();
			let ss = dateObj.getSeconds();
			return [(hh > 9? '' : '0') + hh, ':', (mi > 9? '' : '0') + mi + ':' + (ss > 9? '':'0')+ ss].join('');
		}else{
			let yy = dateObj.getFullYear();
			let mm = dateObj.getMonth()	+ 1;	//getMonth is zero-based
			let dd = dateObj.getDate();
			return [yy,'/'+ (mm > 9? '':'0')+ mm + '/' + (dd > 9 ? '':'0') + dd].join('');
		}
	}
	//댓글 페이징
	var pageNum = 1;
	const showReplyPage = function(replyCnt){
		let endNum = Math.ceil( pageNum / 10.0) * 10;
		let startNum = endNum - 9;
		let prev = startNum != 1;
		let next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt / 10.0);			
		}
		if(endNum * 10  < replyCnt){
			next = true;
		}
		
		let html = '<ul class="pagination pull-right">';
		if(prev){
			html += '<li class="page-item"><a class="page-link" href="'+( startNum - 1 )+'"></a></li>'
		}
		for(let i = startNum; i<= endNum; i++){
			let active = (pageNum == i) ? 'active': '';
			html += '<li class="page-itme '+active+'"><a class="page-link" href="'+i+'">'+i+'</a></li>';
		}
		if(next){
			html += '<li class="page-item"><a class="page-link" href="'+( endNum + 1 )+'"></a></li>'
		}
		
		html+= '</ul>';
		
		$('#replyPaging').html(html);
	}
	
	//댓글 목록 조회
	const showList = function(page){
		replyService.getList(
			//reply json
			{bno : BNO_VALUE, page : page || 1},
			//callback func
			function(replyCnt, list){
				if(page == -1){ //-1이면 마지막 페이지를 다시 호출 새로운 댓글 추가시 맨 마지막 페이지 호출(마지막 댓글 보여주기 위함)
					pageNum = Math.ceil(replyCnt / 10.0);
					showList(pageNum);
					return;
				}
				
				let html = '';
				
				if(list == null || list.length === 0){	//댓글이 없으면 숨김
					replyUL.html('');
					return;
				}
				
				for(var i = 0; i<list.length; i++){
					html += '<li class="left clearfix"  data-rno="'+list[i].rno+'">';
					html += '	<div>';
					html += '		<div class="header">';
					html += '			<strong class="primary-font">'+list[i].replyer+'</strong>';
					html += '			<small class="pull-right text-muted">'+displayTime(list[i].replyDate)+'</small>';
					html += '		</div>';
					html += '		<p>'+list[i].reply+'</p>';
					html += '	</div>';
					html += '</li>';
				}
				$('.chat').html(html);
				showReplyPage(replyCnt);
			},
		);
		
		
	};
	
	//댓글모달 노출
	const showModal = function(){
		$modal.find('input').val('');
		$('#mreplyDate').closest('div').hide();
		$('#modalModBtn').hide();
		$('#modalRemoveBtn').hide();
		$('#modalRegisterBtn').show();	//등록버튼 숨김
		$modal.modal('show');
	}
	
	//댓글 등록
	const addReply = function(){
		let reply = {
				reply : $('#mreply').val(), 
				replyer :$('#mreplyer').val(), 
				bno :BNO_VALUE
		};
		
		replyService.add(
			reply,
			function(result){
				$modal.find('input').val('');
				$modal.modal('hide');
				showList(-1); //목록 갱신 (-1 : 마지막페이지 호출)
			}
		);
	}
	
	//글목록
	$('.listBtn').click(function(e){
		e.preventDefault();
		$('#bno').remove();
		$('#hddnForm').submit();
	});
	
	//글수정
	$('.modBtn').click(function(e){
		e.preventDefault();
		$('#hddnForm').attr('action', '/board/modify').submit();
	});
	
	//모달 닫기
	$("#modalCloseBtn").on("click", function(e){ $('.modal').modal('hide'); });
	
	$('#addReplyBtn').on('click', showModal);
 	$('#modalRegisterBtn').on('click', addReply);
 	
 	//댓글 상세 조회
 	$('.chat').on('click', 'li', function(){
 		rno = $(this).data('rno');	//클릭한 글 번호
 		replyService.get(
			rno,
			//callback func
			function(reply){
				$('#mreply').val(reply.reply);
				$('#mreplyer').val(reply.replyer);
				$('#mreplyDate').val(displayTime(reply.replyDate));
				$('#mreplyDate').closest('div').show();
				$('#modalModBtn').show();
				$('#modalRemoveBtn').show();
				$('#modalRegisterBtn').hide();	//등록버튼 숨김
				$modal.modal('show');
			},
			//error func
			function(err){
				alert('ERROR..');
			},
		);
	});
 	
 	//댓글수정
 	$('#modalModBtn').on('click', function(){
 		console.log(rno);
 		let reply = {rno: rno, reply: $('#mreply').val(), replyer: $('#mreplyer').val()};
 		replyService.update(
 				reply,
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
		);
 		//수정 후 모달 닫기
 		$('#modalCloseBtn').click();
 		showList(pageNum);
 	});
 	
 	//댓글삭제
 	$('#modalRemoveBtn').on('click', function(){
 		replyService.remove(
			rno,
			//callback func
			function(result){
				alert(result);
				$('#myModal').modal('hide');
				showList(pageNum);
			},
			//error func
			function(err){
				alert('ERROR..');
			},
 		);
	 	
 	});

 	$('#replyPaging').on('click','li a',function(e){
 		e.preventDefault();
 		let replyPageNum = $(this).attr('href');
 		pageNum = replyPageNum;
 		showList(replyPageNum);
 	});
 	
 	//첫 화면 노출시 댓글목록조회
	showList(-1);
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
		<!-- 댓글 -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i>Reply
						<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
					</div>
					<div class="panel-body">
						<ul class="chat">
							<li class="left clearfix"  data-rno="12">
								<div>
									<div class="header">
										<strong class="primary-font">ERROR999</strong>
										<small class="pull-right text-muted">2018-01-01 13:13</small>
									</div>
									<p>ERROR!!!</p>
								</div>
							</li>
						</ul>
					<!-- 댓글 페이징영역 -->
					<div id="replyPaging"></div>
					</div>
				</div>
			
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        		<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
      		</div>
			<div class="modal-body">
				<div class="form-group">
			    	<label>Reply</label> 
			    	<input class="form-control" autofocus="autofocus" name='reply' id="mreply" value='New Reply!!!!'>
			  	</div>      
				<div class="form-group">
				  <label>Replyer</label> 
				  <input class="form-control" name='replyer' id="mreplyer" value='replyer'>
				</div>
				<div class="form-group">
				  <label>Reply Date</label> 
				  <input class="form-control" name='replyDate' id="mreplyDate" value='2018-01-01 13:13'>
				</div>
			</div>
			<div class="modal-footer">
			  <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
			  <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
			  <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
			  <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>          
		</div>
	</div>
</div>
<!-- /.modal -->
<%@ include file="../includes/footer.jsp"%>