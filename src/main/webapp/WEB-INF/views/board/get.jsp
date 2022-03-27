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
	
	//댓글 목록 조회
	const showList = function(page){
		let replyUL = $('.chat');
		
		replyService.getList(
			//reply json
			{bno : BNO_VALUE, page : page || 1},
			//callback func
			function(list){
				let html = '';
				if(list.length === 0){
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
				replyUL.html(html);
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
		let reply = {reply : $('#mreply').val(), replyer :$('#mreplyer').val(), bno :BNO_VALUE};
		replyService.add(
			reply,
			function(result){
				$modal.find('input').val('');
				$modal.modal('hide');
				showList(1); //목록 갱신
			}
		);
	}
 	
	$('.listBtn').click(function(e){
		e.preventDefault();
		$('#bno').remove();
		$('#hddnForm').submit();
	});
	
	$('.modBtn').click(function(e){
		e.preventDefault();
		$('#hddnForm').attr('action', '/board/modify').submit();
	});
	
	$('#addReplyBtn').on('click', showModal);
 	$('#modalRegisterBtn').on('click', addReply);
	
 	//댓글 상세 조회
 	$('.chat').on('click', 'li', function(){
 		let rno = $(this).data('rno');	//클릭한 글 번호
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
 	showList(1);
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
			    	<input class="form-control" name='reply' id="mreply" value='New Reply!!!!'>
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