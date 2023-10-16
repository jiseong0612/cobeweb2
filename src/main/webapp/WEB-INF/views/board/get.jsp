<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<%@include file="replyService.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Register</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Read Page</div>
            <div class="panel-body">
                <div class="form-group">
                    <label>Bno</label>
                    <input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Title</label>
                    <input class="form-control" name='title' value='<c:out value="${board.title }"/>' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content}" /></textarea>
                </div>

                <div class="form-group">
                    <label>Writer</label>
                    <input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly">
                </div>
                <a href="/board/list" class="listBtn"><button type="submit" class="btn btn-default">List</button></a>
                <a href="/board/modify?bno=<c:out value="${board.bno }"/>" class="modbtn"><button type="reset" class="btn btn-default">Modify</button></a>
            </div>
        </div>
    </div>
</div>
<!-- 첨부파일 -->
<div class="bigPictureWrapper">
    <div class="bigPicture"></div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Files</div>
            <div class="panel-body">
                <div class='uploadResult'>
                    <ul>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 댓글 -->
<div class='row'>
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply1232
            </div>
            <div class="panel-body">
                <ul class="chat">
                    <li class="left  clearfix" data-rno="12">
                        <div>
                            <div class="header">
                                <strong class="primary-font">user000</strong>
                                <small class="pull-right text-muted">2018-01-01 13: 13</small>
                            </div>
                            <p>good job</p>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="panel-footer"></div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
    aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name='reply' value='New Reply!!!!'>
                </div>
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name='replyer' value='replyer' readonly>
                </div>
                <div class="form-group">
                    <label>Reply Date</label>
                    <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
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


<form id="actionForm" action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" value="${cri.amount }">
    <input type="hidden" name="bno" value="${board.bno }">
    <input type="hidden" name="type" value="${cri.type }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
</form>

<form id="operForm" action="/board/modify" method="get">
    <input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
    <input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount }"/>'>
    <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
</form>
<script>
var actionForm = $('#actionForm');
var bnoValue = '<c:out value="${board.bno}" />';

$(document).ready(function(){
	$('.listBtn').on('click', function(e){
		e.preventDefault();
		
		actionForm.attr('action', '/board/list');
		actionForm.find('input[name="bno"]').remove();
		actionForm.submit();
	});
	
	$('.modbtn').on('click', function(e){
		e.preventDefault();
		
		actionForm.attr('action', '/board/modify');
		actionForm.submit();
	});
});
</script>
<%@include file="../includes/footer.jsp"%>
