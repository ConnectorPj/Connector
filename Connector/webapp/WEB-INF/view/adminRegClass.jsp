<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->

<title>스터디 소개</title>

<!-- 타이틀 이미지 슬라이더 -->

<link href="/resources/css/classDetail.css" rel="stylesheet"
	type="text/css" />
<link href="/resources/css/mainStyle.css" rel="stylesheet"
	type="text/css" />
<link href="/resources/css/review/review.css" rel="stylesheet"
	type="text/css" />


<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=c50d46bc6244185fdb36b57523e93fb4&libraries"></script>
<script type="text/javascript">

function updateClass(studyId) {

	$.ajax({
		type : "post",
		url : "/updateClass.do",
		dataType : "json",
		data : {
			studyId : studyId
		},
		success : function(data) {
			console.log(data);
			
			if(data.result == "ok") {
				location.href = 'adminStudyList.do'
			} else {
				alert(data.resultMsg);
			}
			
		},
		error : function(xhr, status, error) {
			console.log(xhr);
			alert("error\nxhr : " + xhr + ", status : " + status
					+ ", error : " + error);
		}
	});
};

function calcelClass(studyId) {

	$.ajax({
		type : "post",
		url : "/calcelClass.do",
		dataType : "json",
		data : {
			studyId : studyId
		},
		success : function(data) {
			console.log(data);
			
			if(data.result == "ok") {
				location.href = 'adminStudyList.do?pageNo=1'
			} else {
				alert(data.resultMsg);
			}
			
		},
		error : function(xhr, status, error) {
			console.log(xhr);
			alert("error\nxhr : " + xhr + ", status : " + status
					+ ", error : " + error);
		}
	});
};
</script>

</head>
<body>
	<div id="classWrap">
	<form id="classForm" method="post">
		<div id="class">

			<div id="title">
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- Indicators -->
				</div>
				<div class="reviewImg">
					<img style="width: 100%; height: 350px;"
						src="${photoBean.photoFileName}" alt="realReview">
				</div>
				<div id="title" class="title">${ClassBean.studyName}</div>
			</div>
			<hr />
			<!-- end of title -->
			<div id="studyintro">
				<div id="studyTitle" class="studyTitle">스터디 소개</div>
				<div id="StudyContent" class="StudyContent">
					${ClassBean.studyInfo}</div>
				<hr />

			</div>
			<!-- end of studyintro -->

			<div id="studyRefer">
				<div id="studyTitle" class="studyTitle">참고 사항</div>
				<div id="StudyContent" class="StudyContent">
					${ClassBean.studyReference}</div>
				<hr />
			</div>
			<!-- end of studyintro -->


			<div id="detail">
				<div id="detailTitle" class="detailTitle">상세정보</div>
				<div id="detailContent class="detailContent">
					<table>
						<tr>
							<td id="num" class="num">인원 : ${ClassBean.studyAmount}</td>
							<td class="fee">가격 : ${ClassBean.studyPrice}</td>
						</tr>

						<tr>
							<td id="schedule" class="schedule">일정 :
								${ClassBean.studyStartDate} ~ ${ClassBean.studyEndDate}</td>
							<td id="time" class="time">시간 : ${ClassBean.studyStartTime}
								~ ${ClassBean.studyEndTime}</td>
						</tr>
					</table>
				</div>

				<div id="map"
					style="margin-left: 5%; margin-right: 5%; width: 90%; height: 400px;"></div>

				<input type="hidden" id="Alt" value="${Alt}" /> <input
					type="hidden" id="Att" value="${Att}" />

				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new daum.maps.LatLng($("#Alt").val(),
								$("#Att").val()), // 지도의 중심좌표
						level : 3
					// 지도의 확대 레벨
					};

					var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

					// 마커를 표시할 위치입니다 
					var position = new daum.maps.LatLng($("#Alt").val(), $(
							"#Att").val());

					// 마커를 생성합니다
					var marker = new daum.maps.Marker({
						position : position
					});

					// 마커를 지도에 표시합니다.
					marker.setMap(map);

					// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
					var iwContent = '<div style="padding:5px;">스터디 위치 입니다.</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

					// 인포윈도우를 생성합니다
					var infowindow = new daum.maps.InfoWindow({
						content : iwContent
					});

					// 마커에 마우스오버 이벤트를 등록합니다
					daum.maps.event.addListener(marker, 'mouseover',
							function() {
								// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
								infowindow.open(map, marker);
							});

					// 마커에 마우스아웃 이벤트를 등록합니다
					daum.maps.event.addListener(marker, 'mouseout', function() {
						// 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
						infowindow.close();
					});
				</script>

			</div>
			<hr />
			<br>
			<!-- end of detail -->

			<div id="leaderintro">
				<div id="leaderTitle" class="leaderTitle">
					리더 소개 <img class="profile">
				</div>
				<div id="leaderContent" class="leaderContent">
					${ClassBean.studyInfo}</div>
			</div>
			<br>
			<hr />
			<!-- end of leaderintro -->
		</div>

		<div id="side">
			<label id="sideTitle" class="sideTitle">
				${ClassBean.studyName} </label>
			<div class="sideWrap">
				<ul class="sideSchedule">
					<li><input type="radio" class="choiceBtn" value="N"> <label
						for="choiceBtn"> <span class="mock-radio"></span> <span
							id="choiceText" class="choiceText">${diff}주</span>
					</label>
						<div class="titleLevel">
							<div class="levelText1">분야명</div>
							<div id="levelText" class="levelText2">
								${ClassBean.studyProgressName}</div>
						</div></li>
				</ul>
				<div class="sideCostWrap">
					<span id="sideCostInit" class="sideCostInit">참가비</span> <span
						class="sideCost">${ClassBean.studyPrice}원</span>
				</div>

				<br> &nbsp;&nbsp; 
				<input id="actionBtn" type="button"
					value="승인하기"
					onclick="updateClass('${ClassBean.studyId}'); return false;">&nbsp;&nbsp;
				<input id="actionBtn" type="button" value="취소하기"
					onclick="calcelClass('${ClassBean.studyId}'); return false;">
			</div>
		</div>
		</form>
		<!-- end of side -->
	</div>
</body>
</html>