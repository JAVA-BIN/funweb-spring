<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>Welcome to Fun Web</title>
<link href="./css/default.css" rel="stylesheet" type="text/css" media="all">
<link href="./css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<link href="./css/print.css" rel="stylesheet" type="text/css"  media="print">
<link href="./css/iphone.css" rel="stylesheet" type="text/css" media="screen">
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
<form action="fupdate.do" method="post" name="frm" onsubmit="return check();" enctype="multipart/form-data">
<%-- 수정할 글번호는 눈에 안보이는 hidden 타입 입력요소 사용 --%>
<input type="hidden" name="pageNum" value="${pageNum}">
<input type="hidden" name="num" value="${num}">
<table id="notice">
	<tr>
		<th class="twrite">NAME</th>
	<td class="left" width="300">
	<input type="text" name="username" value="${board.username}" readonly="readonly">
	</td>
	</tr>
	<tr>
  		<th class="twrite">PASSWORD</th>
    	<td class="left">
    	<input type="password" name="passwd" placeholder="작성자 확인을 위해 패스워드를 입력하세요.">
    	</td>
	</tr> 
	<tr>
		<th class="twrite">ID</th>
	<td class="left" width="300">
	<input type="text" name="username" value="${id}" readonly>
	</td>
	</tr>
	<tr>
  		<th class="twrite">TITLE</th>
    	<td class="left">
    	<input type="text" name="subject" value="${board.subject}>">
    	</td>
	</tr> 
	<tr>
  		<th class="twrite">FILE</th>
    	<td class="left" >
    	
    		<c:if test="${not empty attachList}">
    			<ul>
    			<c:forEach var="attach" items="${attachList}">
    				<li>
    				<div class="attach-item">
						${attach.filename} 
    					<span class="del" style="color: red; font-weight: bold;" >X</span>
    				</div>
    				<input type="hidden" name="oldFiles" value="${attach.uuid}_${attach.filename}" /> 
    				</li>
    			</c:forEach>
    			</ul> 
    		</c:if>
    		
    		<button type="button" id="btn">새로 업로드</button>
    		<div id="newFilesContainer"></div>
    	</td>
	</tr>     		
    <tr>
    	<th class="twrite">TEXT</th>
    		<td class="left" >
    		<textarea name="content" rows="13" cols="40">${board.content}</textarea>
    		</td>
	</tr>  
</table>
<div id="table_search">
	<input type="submit" value="글수정" class="btn" />
	<input type="reset" value="다시작성" class="btn" />
	<input type="button" value="목록보기" class="btn" onclick="location.href='fnotice.do?pageNum=${pageNum}';"/>
</div>
</form> 
</article>  
     <div class="clear"></div>
   <jsp:include page="../include/footer.jsp" />
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
function check() {
	var objPasswd = document.frm.passwd;
	if (objPasswd != null) {
		if (objPasswd.value.length == 0) {
			alert('게시글 패스워드는 필수 입력사항입니다.');
			objPasswd.focus(); // 커서가 깜빡이게함
			return false;
		} 
	}
	// 수정 의도 확인
	var result = confirm('${num}번 글을 정말로 수정하시겠소?');
	if (result == false) {
		return false;
	}
}

// id btn인 버튼에 클릭이벤트 연결
$('#btn').on('click', function() {
	let str = '<input type="file" name="newFile' + num + '"><br>';
	$('#newFilesContainer').append(str);
	num++;
});

//class명이 del인 span태그에 클릭이벤트 연결하기
 $('span.del').on('click', function () {  
	var $li = $(this).closest('li');
	$li.children('input[type="hidden"]').attr('name', 'delFiles');
	$li.children('div.attach-item').remove();	
});
 
</script>
</body>
</html> 