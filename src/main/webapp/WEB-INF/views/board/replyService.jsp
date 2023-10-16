<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	console.log('reply module....');
	
	var replyService = (function(){
		var add = function(reply, callback){
			$.ajax({
				type : 'post',
				url : '/replies/new',
				data : JSON.stringify(reply),
				contentType : 'application/json',
				success : function(result){
					if(callback)callback(result);
				},
				error : function(xhr, status, er){
					if(error)error(er);
				}
			});
		};
		
		var getList = function(param, callback, error){
			var bno = param.bno;
			var pageNum = param.pageNum;
			$.ajax({
				type : 'get',
				url : '/replies/pages/'+bno+'/'+pageNum,
				success : function(result){
					if(callback)callback(result);
				},
				error : function(xhr, status, er){
					if(error)error(er);
				}
			});
		};
		
		var remove = function(rno, callback, error){
			$.ajax({
				type : 'delete',
				url : '/replies/'+rno,
				success : function(result){
					if(callback)callback(result);
				},
				error : function(xhr, status, er){
					if(error)error(er);
				}
			});
		};
		
		var update = function(reply, callback, error){
			$.ajax({
				type : 'put',
				url : '/replies/'+reply.rno,
				data : JSON.stringify(reply),
				contentType : 'application/json',
				success : function(result){
					if(callback)callback(result);
				},
				error : function(xhr, status, er){
					if(error)error(er);
				}
			});
		};
		
		var get = function(rno, callback, error){
			$.ajax({
				type : 'get',
				url : '/replies/'+rno,
				success : function(result){
					if(callback)callback(result);
				},
				error : function(xhr, status, er){
					if(error)error(er);
				}
			});
			
		};
		
		return {
			add : add,
			getList : getList,
			remove : remove,
			update : update,
			get : get
		};
	})();
</script>