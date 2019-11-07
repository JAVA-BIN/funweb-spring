<%@page import="com.exam.domain.BoardVO"%>
<%@page import="com.exam.repository.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>Welcome to Fun Web</title>
<link href="./css/default.css" rel="stylesheet" type="text/css" media="all">
<link href="./css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<link href="./css/print.css" rel="stylesheet" type="text/css"  media="print">
<link href="./css/iphone.css" rel="stylesheet" type="text/css" media="screen">
<script>
function check() {
	var strPasswd = document.frm.passwd.value.trim();
	if (strPasswd.length == 0) {
		alert('게시글 패스워드는 필수 입력사항입니다.');
		objPasswd.focus(); // 커서가 깜빡이게함
		return false;
	}
	return true;
}
</script>
<script>
	function checkDelete() {
		var result = confirm('${board.num}번 글을 정말로 삭제하시겠소?');
		if (result == true) {
		location.href = 'deleteForm.do?num=${board.num}&pageNum=${pageNum}';			
		}
	}
</script>
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
    
<h1>Notice Delete</h1>
	<form action="delete.do" method="post" name="frm" onsubmit="return check();">
	<%-- 수정할 글번호는 눈에 안보이는 hidden 타입 입력요소 사용 --%>
	<input type="hidden" name="pageNum" value="${pageNum}">
	<input type="hidden" name="num" value="${num}">
	<table id="notice">
		<tr>
			<th class="twrite">글 패스워드</th>
			<td><input type="password" name="passwd" /></td>
		</tr>
	</table>
	<div id="table_search">
	<input type="submit" value="글삭제" class="btn" />
	<input type="reset" value="다시작성" class="btn" />
	<input type="button" value="목록보기" class="btn" onclick="location.href='notice.do?pageNum=${pageNum}';"/>
	</div>
</form>
</article>  
     <div class="clear"></div>
   <jsp:include page="../include/footer.jsp" />
</div>
</body>
</html> 