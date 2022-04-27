<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String name = "jiseong";
	String[] nameArr = {"userA", "userB", "userC"};
	System.out.println(name);
	pageContext.setAttribute("nameArr", nameArr);	//pageContext 스코프를 열어 담는다.
	
	List<Map<String, String>> list = new ArrayList<>();
	Map<String, String> shMap = new HashMap<>();
	Map<String, String> ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "서울특별시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "경기도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "부산광역시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "대구광역시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "인천광역시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "광주광역시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "대전광역시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "울산광역시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "세종특별자치시");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "강원도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "충청북도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "충청남도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "전라북도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "전라남도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "경상북도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "경상남도");
	list.add(ADDRESS01);
	ADDRESS01 = new HashMap<>();
	ADDRESS01.put("ADDRESS01", "제주특별자치도");
	list.add(ADDRESS01);
	pageContext.setAttribute("list", list);	//pageContext 스코프를 열어 담는다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp에서 java 사용 후 jstl 사용 방법</title>
</head>

<body>
	<h2>하이요 ^^</h2>
	<select>
		<c:forEach items="${list }" var="list" varStatus="status">
			<option value="${list.ADDRESS01[3] }" >${list.ADDRESS01[3] } == ${fn:substring(list.ADDRESS01,2,3)}</option>
		</c:forEach>
	</select>
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