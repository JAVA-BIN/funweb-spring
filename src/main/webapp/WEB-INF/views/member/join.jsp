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
<div id="sub_img_member"></div>
<div class="clear"></div>
 	<!-- nav 영역 -->
  <jsp:include page="../include/nav_member.jsp" />
<article>
    
<h1>Join Us</h1>
<form name="frm" id="join" action="/member/join" method="post" onsubmit="return check();">    
<fieldset>
	<legend>Basic Info</legend>
	<label>User ID</label> <input id="id" name="id" type="text" class="id"> 
						   <input type="button" value="ID 중복확인" class="dup" onclick="winOpen();">
	<span id="id-message"></span>	<br>
	
				   
				   
				   
				   
				   
				   
	<label>Password</label> <input name="passwd" type="password" class="pass"><br>
	<label>Retype Password</label> <input name="passwd2" type="password" class="pass"><br>
	<label>Name</label> <input name="name" type="text" class="nick"><br>
	<label>E-Mail</label> <input name="email" type="email" class="email" ><br>
	<label>Retype E-mail</label> <input name="email2" type="email" class="email"><br>
</fieldset>


<fieldset>
	<legend>Optional</legend>
	<label>Address</label> <input name="address" type="text" class="address"><br>
	<label>Phone Number</label> <input name="tel" type="tel" class="phone"><br>
	<label>Mobile Phone Number</label> <input name="mtel" type="tel" class="mobile"><br>
</fieldset>

<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit" > 
<input name="" type="button" value="Cancel" class="cancel">
</div>

</form> 
    
</article>    
    <div class="clear"></div>
    <jsp:include page="../include/footer.jsp" />
    
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$('#id').keyup(function () {
	var id = $(this).val();
	console.log(id);
	$.ajax({
		url: '/member/joinIdDupCheckJson',
		data: {id: id},
		success: function (data) {
			console.log(typeof data);
			console.log(data);
			idDupMessage(data);
		}
	});
});

function idDupMessage(isIdDup) {
	if (isIdDup) { // 중복 true
		 $('span#id-message').html('중복된 아이디야 애송이').css('color', 'red');
	} else { // 중복아님 false
		 $('span#id-message').html('사용가능한 ID').css('color', 'green');
	}
}
</script>


<script>
// 사용자 입력값 검증
function check() {
	if (frm.id.value.length < 3) {
		alert('ID는 세글자 이상 사용가능합니다.');
		frm.id.select();
		return false;
	}
	if (frm.passwd.value.length == 0) {
		alert('password는 필수 입력 항목입니다.');
		frm.passwd.focus();
		return false;
	}
	if (frm.name.value.length == 0) {
		alert('name은 필수 입력 항목입니다.');
		frm.name.focus();
		return false;
	}
	if (frm.email.value.length == 0) {
		alert('email은 필수 입력 항목입니다.');
		frm.email.focus();
		return false;
	}
	if (document.frm.passwd.value != document.frm.passwd2.value) {
		alert('password 입력값이 서로 다릅니다.');
		document.frm.passwd.select();
		return false;
	}
	if (frm.email.value != frm.email2.value) {
		alert('email 입력값이 서로 다릅니다.');
		document.frm.email.select();
		return false;
	}
	return true;
}

// 새로운 브라우저를 띄우고 아이디 중복 확인해주는 기능
function winOpen() {
	// var inputId = document.getElementById('id').value;
	var inputId = document.frm.id.value;
	// id입력값이 공백이면 '아이디를 입력하세요' focus 주기
	if (inputId == '') { // inputId.length == 0
		alert('ID를 입력하세요.');
		document.frm.id.focus();
		return;
	}
	// 새로운 자식창(브라우저) 열기
	// open() 호출한쪽은 부모창
	// open()에 의해 새로열린 창은 자식창
	// 부모-자식 관계가 있음. 자식창의 데이터를 부모창으로 가져올 수 있음.
	var childWindow = window.open('joinIdDupCheck.do?userid='+inputId, '', 'width=400, height=200'); // ? = 파라미터값 찾아옴
	//childWindow.document.write('입력한 아이디: '+inputId+'<br>');
}
</script>

</body>
</html>   