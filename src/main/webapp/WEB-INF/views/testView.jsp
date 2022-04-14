<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<h2>하위요 ^^ testView</h2>

<div>
	<input type="checkbox" class="chk" name="skill" value="10" id="java" checked><label for="java">java</label>
	<input type="checkbox" class="chk" name="skill" value="11" id="html" checked><label for="html">html</label>
	<input type="checkbox" class="chk" name="skill" value="12" id="sql"><label for="sql">sql</label>
	<button>click</button>
</div>
<script>
$(document).ready(function(){
	
	$('button').on('click', function(){
		var list = '';
		$('.chk:checked').each(function(){
			list += $(this).val()+'/';
		})
		console.log(list);
		
		$.ajax({
			type : 'get',
			url : '/board/test',
			data : {list : list},
			success : function(result){
				console.log(result);
			},
			error : function(xhr){
				console.log(xhr.responseText);
			}
		});
	});
});
</script>
</body>
</html>