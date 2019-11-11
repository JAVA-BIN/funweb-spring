<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>Welcome to Fun Web</title>
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" media="all">
<link href="/resources/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<link href="/resources/css/print.css" rel="stylesheet" type="text/css"  media="print">
<link href="/resources/css/iphone.css" rel="stylesheet" type="text/css" media="screen">
</head>
<body>
<div id="wrap">
  <!--  헤더 영역 -->
	<jsp:include page="../include/header.jsp" />	
  <div class="clear"></div>
	<div id="sub_img_center"></div>
<div class="clear"></div>
   <!--  nav 영역 -->
	<jsp:include page="../include/nav_center.jsp" />
<article>
    
<h1>Notice Write</h1>
<form action="/board/fileWrite" method="post" name="frm" enctype="multipart/form-data">
<table id="notice">
	<tr>
		<th class="twrite">ID</th>
	<td class="left" width="300">
	<input type="text" name="username" value="${id}" readonly>
	</td>
	</tr>
	<tr>
  		<th class="twrite">TITLE</th>
    	<td class="left">
    	<input type="text" name="subject">
    	</td>
	</tr> 
	<tr>
  		<th class="twrite">FILE</th>
    	<td class="left">
    		<div id="file_container">
   			 	<input type="file" name="files" multiple>
    		</div>
    		<button type="button" onclick="addFileElement(); ">파일 추가</button>
    	</td>
	</tr> 
	<tr>
  		<th class="twrite">TEXT</th>
    	<td class="left">
    		<textarea name="content" rows="13" cols="40"></textarea>
    	</td>
	</tr>  
</table>
<div id="table_search">
	<input type="submit" value="글쓰기" class="btn" />
	<input type="reset" value="다시작성" class="btn" />
	<input type="button" value="목록보기" class="btn" onclick="location.href='/board/fileList';"/>
</div>
</form> 
</article>  
     <div class="clear"></div>
   <jsp:include page="../include/footer.jsp" />
</div>
<script>
var num = 2; // 초기값 2
function addFileElement() {
	if (num > 5) { // 파일업로드 최대 5개까지만 허용할 때
		alert('최대 5개까지만 업로드 가능합니다.');
		return;
	}
	// div요소에 file타입 input요소를 추가하기
	var input = '<br><input type="file" name="filename" multiple>';
	num++; // 다음번 추가를 위해 값을 1 증가
	// id속성값이 file_container인 div요소의 참조 구하기
	var fileContainer = document.getElementById('file_container');
	fileContainer.innerHTML += input;
}
</script>
</body>
</html> 