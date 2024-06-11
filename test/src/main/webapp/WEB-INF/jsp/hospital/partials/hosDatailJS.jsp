<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function insertNotice(hosIdx){
		//병원(기업)계정만 공지 작성
		//해당 병원 계정 일치 여부 확인 후, 공지 입력
		location.href = "../notice/insertProNotice.do?hosIdx=" + hosIdx;
	}
	window.onload = function(){
   	console.log("windowOpen() 실행~~");
   	console.log("${hospital}");
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng("${hospital.addy}","${hospital.addx}"), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  
	
	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	//주소로 좌표를 검색합니다
	geocoder.addressSearch("${hospital.roadAddressName}", function(result, status) {
	
		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {
		
		    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		    console.log("result[0].y : " + result[0].y + ", result[0].x : " + result[0].x);
		
		    // 결과값으로 받은 위치를 마커로 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: coords
		    });
		
		    // 인포윈도우로 장소에 대한 설명을 표시합니다
		    var infowindow = new kakao.maps.InfoWindow({
		        content: '<div style="width:150px;text-align:center;padding:6px 0;">${hospital.hosName}</div>'
		    });
		    infowindow.open(map, marker);
		
		    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		    map.setCenter(coords);
		 	// 마커를 결과값으로 받은 위치로 옮긴다.
            	//marker.setPosition(coords)
		} 
	});
	
};
	    // 리뷰 수정 버튼 클릭 이벤트
	    function editReview(reviewIdx) {
    	 	console.log("editReview Index: " + reviewIdx);
	 	    document.getElementById('view_' + reviewIdx).classList.add('hidden');
	 	    document.getElementById('edit_' + reviewIdx).classList.remove('hidden');
	    }
		// 리뷰 삭제 버튼 클릭 이벤트
		function confirmDelete(reviewIdx) {
		    if (confirm("삭제하시겠습니까?")) {
		        document.getElementById("deleteReviewForm_" + reviewIdx).submit();
		    }
		}
		// 리뷰 수정 취소 버튼 클릭 이벤트
		function cancelEdit(reviewIdx) {
		    console.log("cancelEdit Index: " + reviewIdx);
		    document.getElementById('view_' + reviewIdx).classList.remove('hidden');
		    document.getElementById('edit_' + reviewIdx).classList.add('hidden');
		}
		
		// 선택된 진료 완료 상태 내역의 reserIdx를 hidden필드에 설정
	    function updateHiddenField() {
	        var selectBox = document.getElementById("finishSelect");
	        var selectedValue = selectBox .options[selectBox.selectedIndex].value;
	        document.getElementById("selectedReserIdx").value = selectedValue;
	        console.log("Selected ReserIdx: " + selectedValue); // 확인용 로그
	    }
		
	    /* document.getElementById("reviewForm").addEventListener("submit", function(event) {
	        var selectedReserIdx = document.getElementById("selectedReserIdx").value;
	        if (!selectedReserIdx) {
	            event.preventDefault();
	            alert("예약을 선택하세요.");
	        }
	    }); */
		
	 
</script>