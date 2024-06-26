<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 로그인</title>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>

<script>

	function user_join(frm) {
		location.href = "userJoin.do";
		frm.submit();
	}
	function ho_join(frm) {
		location.href = "hoJoin.do";
		frm.submit();
	}


// 	function getQueryParam(param) {
//         var urlParams = new URLSearchParams(window.location.search);
//         return urlParams.get(param);
//     }

//     window.onload = function() {
//         var msg = getQueryParam("msg");
//         if (msg === "failure") {
//             alert("로그인 실패");
//         }
//     }
    
	window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');
        if (msg === 'success') {
            alert('회원가입이 완료되었습니다.');
        } else if (msg === 'failure') {
            alert('아이디 또는 비밀번호를 확인해주세요.');
        }
    }
	</script>
</head>
<body>
<div id="container">
<h1>병원 로그인</h1>
<form action="hoLogin.do" method="post">

<table class="tb">
	<tr>
		<td><input class="psTitle" type="text" name="hosId" value="${hospitalVO.hosId }" placeholder="아이디"></td>
	</tr>
	<tr>
		<td><input class="psTitle" type="password" name="hosPw" value="${hospitalVO.hosPw }" onclick="password(this.form)" placeholder="비밀번호"></td>
		
	</tr>
	<tr>
		<td>
			<input class="loginBtn" type="submit" value="로그인">
		</td>
	</tr>
	
	
</table>
</form>

<table class="select">

<!-- 		<td><input type="button" value="개인 회원가입" onclick="user_join(this.form)"></td> -->
		

	<tr>
		<td><a href="hoFindId.do">아이디찾기</a></td>
		<td class="s">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
		<td><a href="hoFindPwd.do">비밀번호 찾기</a></td>
		<td class="s">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
		<td><input class="joinBtn" type="button" value="병원 회원가입" onclick="ho_join(this.form)"></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td><a href="../index.jsp">메인화면 이동</a></td> -->
<!-- 	</tr> -->
</table>
</div>
</body>
</html>