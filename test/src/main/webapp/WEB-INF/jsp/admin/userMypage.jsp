<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userMypage</title>
<jsp:include page="../../css/mypageCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
	.profileImg {
		text-align: center;
		max-width: 150px;
		border-radius: 50%;
		object-fit: cover;
		width: 150px;
		height: 150px;
		display: block;
		margin: 0 auto;	
	}
	.myPetContainer {
		display: flex;
		flex-wrap: wrap;
		gap: 20px;
		justify-content: center;
		margin-top: 20px;
	}
	.myPet {
		width: 150px;
		border-radius: 10px;
		padding: 20px;
		box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		text-align: center;
	}
	.myPet img {
		border-radius: 10px;
		width: 150px;
		height: 150px;
        margin-bottom: 10px;		
	}
	.myPet h3 {
		margin: 5px 0;
		color: #2C307D;
	}
	.noImg {
		width: 150px;
		height: 150px;
		background-color: #E0EAF5;
		border-radius: 10px;
        margin-bottom: 20px;	
	}
    .myPetH2 {
        display: flex;
        align-items: center;
    }
    .myPetH2 h2 {
        margin-right: 20px;
    }
    .myPetBtn {
        margin-top: 0;
        float: none;
    }
    
</style>
<script>
	function userDelete_ok(frm) {
	    if (confirm("정말로 탈퇴하시겠습니까?")) {
	        frm.action = "deleteUser.do"; // 탈퇴 요청을 보낼 URL을 지정합니다.
	        frm.method = "POST";
	        frm.submit(); // 폼을 제출합니다.
	    }
	}
</script>
</head>
<body>
<h1>회원 마이페이지</h1>
<div id="container">
	<a href="getUserList.do">회원관리목록 가기</a>
	<hr>
<%-- \${user } : ${user } --%>
<%-- \${pets } : ${pets } --%>
		
<div class="box">
<div class="name">
<h1 class="h1" style="display:inline">${user.name }</h1>
<p style="display:inline; font-size:28px;">님</p>
		
<br><br>
		<c:if test="${user.condition == '결제전'}">
		[토탁플러스 미가입] 
		</c:if>
		<c:if test="${user.condition == '결제완료'}">
		<div class="img2">
		<img src="../img/3.png" width="300" >
		</div>
		<div class="date">
		${umo.startformattedDate } ~ ${umo.endformattedDate }
		</div>
		</c:if>
</div>

</div>	
<h2>내 정보</h2>	
<hr>
		
<%-- 		${user.condition } --%>
			<form action="updateUser.do">
			<input type="hidden" name="userIdx" value="${user.userIdx}">
			<p>
				<c:if test="${not empty user.userImg}">
					<img src="${user.userImg}" alt="${user.userIdx}의 이미지" style="max-width: 150px;" class="profileImg">
				</c:if>
			</p>
			<table border frame=void style="width:100%; height: 35px;">
			<tr>
				<th>이메일 </th>
				<td>${user.email}</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${user.nickname}</td>
			</tr>
		<!-- 	<tr> -->
		<!-- 		<td>비밀번호<td> -->
		<%-- 		<td>${user.password}</td> --%>
		<!-- 	</tr> -->
			<tr>
				<th>이름</th>
				<td>${user.name}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${user.birth}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${user.phone}</td>
			</tr>
			</table>
			</form>
		<br><br><br>	
		
        <c:if test="${user.role == 'user'}">
        <div class="myPetH2">
            <h2>마이펫</h2>
        </div>
            <hr>
            <div class="myPetContainer">
                <c:choose>
                    <c:when test="${empty pets}">
                        <div>등록된 펫 정보가 없습니다.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="pet" items="${pets}">
                            <div class="myPet">
                                <c:if test="${not empty pet.petImg}">
                                    <img src="${pet.petImg}" alt="${pet.petName}의 이미지">
                                </c:if>
                                <c:if test="${empty pet.petImg}">
                                    <div class="noImg"></div>
                                </c:if>
                                <h3>${pet.petName}</h3>
                                <p>동물분류: ${pet.animal}</p>
                                <p>펫나이: ${pet.petAge}살</p>
                                
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
		    
			</c:if>

	</div>
</body>
</html>