<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토닥토닥 메인</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	function fetchData(category) {
		let vo = {};
		vo.searchCondition = category;
		vo.searchKeyword = document.querySelector("input[name='searchKeyword']").value;
		$.ajax("getHosSearch.do", { 
	        type: 'GET',
	        data: vo,
	        success: function(data) {
	        	$("#listDisp").empty();
 
			    let dispHtml = "";
			    for (let hospital of data) {
			        dispHtml += "<tr>";
			        dispHtml += "<td>" + hospital.hosIdx + "</td>";
			        dispHtml += "<td><a href='hospital/hosDetail.do?hosIdx=" + hospital.hosIdx + "'>" + hospital.hosName + "</a></td>";
			        dispHtml += "<td>" + hospital.roadAddressName + "</td>";
			        dispHtml += "<td>" + hospital.hosPhone + "</td>";
			        dispHtml += "<td>" + hospital.openTime + " ~ " + hospital.closeTime + "</td>";
			        dispHtml += "<td>" + hospital.animal + "</td>";
			        dispHtml += "</tr>";
			    }
			    
			    $("#listDisp").html(dispHtml);
	        },
	        error: function() {
	        	alert("실패");
	        }
	    });
	}

</script>
</head>
	<body>
		<div id="container">
		    <h1>병원 예약</h1>
		    <hr>
		    <br>
		    <h3>병원 검색</h3>
		    <form id="getHosSearchList" onsubmit="fetchData('search'); return false;">
		        <p>통합검색</p>
		        <input type="text" name="searchKeyword" placeholder="Search">
		        <input type="submit" value="검색">
		    </form>
		    <form>
		    	<select>
		    		<option value="sido">시/도</option>
		    		<option value="seoul">시/도</option>
		    		<option value="gyeonggi">시/도</option>
		    		<option value="incheon">시/도</option>
		    		<option value="daejeon">시/도</option>
		    		<option value="sejong">시/도</option>
		    		<option value="chungbug">시/도</option>
		    		<option value="chungnam">시/도</option>
		    		<option value="chungbug">시/도</option>
		    		<option value="chungbug">시/도</option>
		    		<option value="chungbug">시/도</option>
		    		<option value="chungbug">시/도</option>
		    	</select>
		    	<select>
		    		<option value="sigungu">시/군/구</option>		    	
		    	</select>
				<select>
		    		<option value="eupMyeonDong">읍면동</option>				
				</select>
		    </form>
		    <div>
		    	<button class="tab" onclick="fetchData('all')">전체</button>
		        <button class="tab" onclick="fetchData('common')">일반병원</button>
		        <button class="tab" onclick="fetchData('special')">특수병원</button>
		        <button class="tab" onclick="fetchData('night')">야간진료</button>
		        <button class="tab" onclick="fetchData('24h')">24시</button>
		    </div>
		</div>
		<table>
		    <thead>
		        <tr>
		            <th>번호</th>
		            <th>병원명</th>
		            <th>주소</th>
		            <th>전화번호</th>
		            <th>운영시간</th>
		            <th>분류</th>
		        </tr>
		    </thead>
		    <tbody id="listDisp">
		    	<c:forEach var="hospital" items="${hosList }">
				<tr>
					<td>${hospital.hosIdx}</td>
					<td><a href="hosDetail.do?hosIdx=${hospital.hosIdx}">${hospital.hosName}</a>
					</td>
					<td>${hospital.roadAddressName}</td>
					<td>${hospital.hosPhone}</td>
					<td>${hospital.openTime} ~ ${hospital.closeTime}</td>
					<td>${hospital.animal}</td>
				</tr>
			</c:forEach>
		    </tbody>
		</table>
		<hr>
		<p>
		    <a href="insertHosAdrress.do">병원 입력</a>
		</p>

	</body>
</html>
