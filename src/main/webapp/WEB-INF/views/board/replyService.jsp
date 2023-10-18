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
					console.log('error');
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
		
		var displayTime = function(timeValue){
			var today = new Date();
			var gap = today.getTime() - timeValue;
			var dateObj = new Date(timeValue);
			
			var str = '';
			
			//24시간이 지나지 않음(밀리세컨이라 1000 곱한다)
			if(gap < (1000 * 60 * 60 * 24)){
				var hh = dateObj.getHours();
				var mm = dateObj.getMinutes();
				var ss = dateObj.getSeconds();
				
				//0을 더하는 이유는 7시인경우 07시로 표현하기 위함
				return [ (hh > 9 ? '' : '0') + hh, ':', (mm > 9 ? '' : '0') + mm,
					':', (ss > 9 ? '' : '0') + ss ].join('');
			}else {
				var yy = dateObj.getFullYear();
				var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
				var dd = dateObj.getDate();

				return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
						(dd > 9 ? '' : '0') + dd ].join('');
			}
		} 
		
		return {
			add : add,
			getList : getList,
			remove : remove,
			update : update,
			get : get,
			displayTime : displayTime
		};
	})();
</script>