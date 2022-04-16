<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String name = "jiseong";
	String[] nameArr = {"userA", "userB", "userC"};
	System.out.println(name);
	pageContext.setAttribute("nameArr", nameArr);	//pageContext 스코프를 열어 담는다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp에서 java 사용 후 jstl 사용 방법</title>
</head>

<body>
	<h2>하이요 ^^</h2>
	<c:if test="${name eq 'jiseong' }">		<!-- pageContext스코프에 담긴 키값으로 사용. -->
		yes
	</c:if>
	<select>
		<c:forEach items="${nameArr }" var="name" varStatus="status">
			<option value="${status.index }">${name }</option>
		</c:forEach>
	</select>
	
	<c:forEach items="${nameArr }" var="name" varStatus="status">
		<input type="radio" value="${status.index }" name="nameRD" id="rd_${status.index }" ${status.first == true ? "checked" :""}>
		<label for="rd_${status.index }">${name }</label>
	</c:forEach>
</body>
</html>
<!-- 
<script src="http://code.jquery.com/jquery-latest.js"></script>
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
</html> -->