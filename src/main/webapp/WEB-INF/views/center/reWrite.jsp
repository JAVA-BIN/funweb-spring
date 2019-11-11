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
<h1>Notice ReWrite</h1>
<form action="/board/reply" method="post" name="frm">
<input type="hidden" name="reRef" value="${param.reRef}">
<input type="hidden" name="reLev" value="${param.reLev}">
<input type="hidden" name="reSeq" value="${param.reSeq}">
<table id="notice">
	<tr>
		<th class="twrite">NAME</th>
	<td class="left" width="300">
	<input type="text" name="username">
	</td>
	</tr>
	<tr>
  		<th class="twrite">PASSWORD</th>
    	<td class="left">
    	<input type="password" name="passwd">
    	</td>
	</tr> 
	<tr>
  		<th class="twrite">TITLE</th>
    	<td class="left">
    	<input type="text" name="subject" value="답글: ">
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
	<input type="submit" value="답글쓰기" class="btn" />
	<input type="reset" value="다시작성" class="btn" />
	<input type="button" value="목록보기" class="btn" onclick="location.href='notice.do'"/>
</div>
</form> 
</article>  
     <div class="clear"></div>
   <jsp:include page="../include/footer.jsp" />
</div>
</body>
</html> 