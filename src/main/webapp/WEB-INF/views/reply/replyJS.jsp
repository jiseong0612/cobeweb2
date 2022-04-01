<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	var replyService = (function() {

		//댓글 등록
		function add(reply, callback, error) {
			$.ajax({
				type : 'post',
				url : '/replies/new',
				data : JSON.stringify(reply), //자바스크립트 객체를 json으로 변환
				contentType : 'application/json',
				success : function(result, status, xhr) {
					if (callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if (error) {
						error(er);
					}
				}
			});

		}

		//댓글 목록 조회
		function getList(param, callback, error) {
			var bno = param.bno;
			var page = param.page || 1;
			$.ajax({
				type : 'get',
				url  : '/replies/pages/'+bno+'/'+page+'.json',
				dataType : 'json',
				success : function(data){
					if(callback){
						callback(data.replyCnt, data.list);
					}
				},
				error : function(xhr, status, err){
					if(error){
						error();
					}
					
				}
			});
		}
		
		//삭제
		function remove(rno, callback, error){
			$.ajax({
				type : 'delete',
				url  : '/replies/'+rno,
				success : function(data){
					console.log('break.....');
					alert(data);
					if(callback){
						callback(data);
					}
				},
			 	error : function(xhr, status, er){
					if(error){
						error();
					}
				},
			})
			
		}
		
		//수정
		function update(reply, callback, error){
			$.ajax({
				type : 'patch',
				url  : '/replies/'+reply.rno,
				contentType : 'application/json',
				data : JSON.stringify(reply),
				success : function(data){
					if(callback){
						callback(data);
					}
				},
				error : function(xhr, status, er){
					if(error){
						error();
					}
				},
			});
		}
		
		//1개 조회
		function get(rno, callback, error){
			$.ajax({
				type : 'get',
				url  : '/replies/'+rno,
				dataType : 'json',
				success : function(data){
					if(callback){
						callback(data);
					}
				},
				error : function(xhr, status, er){
					if(error){
						error();
					}
				},
			});
		}
		return {
			add : add,
			getList : getList,
			remove : remove,
			update : update,
			get : get,
		};
	})();
</script>