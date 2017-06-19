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
	//전체 리뷰의 갯수
	var reviewListTotCount = 0;
	// 현재 startRow 값
	var reviewStartRow = 0;
	var isReviewLoading = false;
	var currentProgressname = "";
	var isReviewLoadingFirst = true;

	$(function() {
		$.ajax({
			type : "post",
			url : "/realDetailProc.do",
			dataType : "json",
			data : {
				studyId : $("#studyId").val()
			},
			success : function(data) {
				console.log(data);

				if (data.result == "ok") {
					//리뷰 리스트 출력
					$.each(
						data.detailList,
						function(i, rBean) {

							if (rBean.customerPicture == null) {
								rBean.customerPicture = "/resources/images/userIcon.png";
							}

							if (rBean.teacherPicture == null) {
								rBean.teacherPicture = "/resources/images/userIcon.png";
							}

							var str = "";
							str += '<ul class="detailList">';
							str += '<li class="review">';
							str += '<div class="writerPhoto"><img src="' + rBean.customerPicture + '"></div>';
							str += '<div class="reviewContentWrap">';
							str += '<div class="writerName">'
									+ rBean.customerName
									+ '<span class="writtenAt">'
									+ rBean.reviewRegdate
									+ '</span></div>';
							str += '<ul class="score">';

							for (var j = 1; j <= 5; j++) {

								if (j <= rBean.reviewRating) {
									str += '<li class="star"><img src="/resources/images/staron.png"></li>';

								} else {
									str += '<li class="star"><img src="/resources/images/staroff.png"></li>';
								}
							}

							str += '</ul>';
							str += '<div class="reviewContent"><span class="reviewLevel">'
									+ rBean.studyProgramlanguage
									+ '</span>';
							str += '<span>'
									+ rBean.reviewContent
									+ '</span></div>';
							str += '</div>';
							str += '</li>';
							str += '</ul>';
							str += '<hr>';

							$("#realReviewInfo")
									.append(str);
						});

					//더 보기 버튼에 대한 처리
					reviewListTotCount = data.detailListAll.length;
					reviewStartRow = data.detailList.length;

					if (data.detailListAll.length > data.detailList.length) {
						//리뷰 더보기 버튼 화면에 표시
						$("#moreReviewList").show();

					} else {
						$("#moreReviewList").hide();
					}

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

		$.ajax({
			type : "post",
			url : "/buskcetProc.do",
			dataType : "json",
			data : {
				studyId : $("#studyId").val(),
				customerId : $("#memberId").val()
			},
			success : function(data) {
				console.log(data);

				if (data.result == "ok") {
					//리뷰 리스트 출력
					var bBean = data.bBean;
					if (bBean == "null") {
					} else {
						$("#booking").text("찜취소");
						$("#booking").css("background-color", "#2c3d46");
						$("#booking").css("color", "white");

						cond = 2;
						return;
					}

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

	});

	//다음 리뷰 리스트를 표시한다.
	function showNextReviewList() {
		if (reviewListTotCount <= reviewStartRow && isReviewLoading) {
			return;
		}

		//알고 있어야 되는 정보
		//전체 리뷰의 갯수
		//현재 startRow 를 알고 있어야 한다.

		isReviewLoading = true;

		$.ajax({
			type : "post",
			url : "/realDetailProc.do",
			data : {
				studyId : $("#studyId").val(),
				startRow : reviewStartRow
			},
			dataType : "json",
			success : function(data) {
				printLog(data);

				if (data.result == "ok") {
					//리뷰 리스트 출력
					$.each(
						data.detailList,
						function(i, rBean) {

							if (rBean.customerPicture == null) {
								rBean.customerPicture = "/resources/images/userIcon.png";
							}

							if (rBean.teacherPicture == null) {
								rBean.teacherPicture = "/resources/images/userIcon.png";
							}

							var str = "";
							str += '<ul class="detailList">';
							str += '<li class="review">';
							str += '<div class="writerPhoto"><img src="' + rBean.customerPicture + '"></div>';
							str += '<div class="reviewContentWrap">';
							str += '<div class="writerName">'
									+ rBean.customerName
									+ '<span class="writtenAt">'
									+ rBean.reviewRegdate
									+ '</span></div>';
							str += '<ul class="score">';

							for (var j = 1; j <= 5; j++) {

								if (j <= rBean.reviewRating) {
									str += '<li class="star"><img src="/resources/images/staron.png"></li>';

								} else {
									str += '<li class="star"><img src="/resources/images/staroff.png"></li>';
								}
							}

							str += '</ul>';
							str += '<div class="reviewContent"><span class="reviewLevel">'
									+ rBean.studyProgramlanguage
									+ '</span>';
							str += '<span>'
									+ rBean.reviewContent
									+ '</span></div>';
							str += '</div>';
							str += '</li>';
							str += '</ul>';
							str += '<hr>';

							$("#realReviewInfo")
									.append(str);
						});

					//더보기 버튼에 대한 처리
					reviewStartRow += data.detailList.length * 1;

					if (reviewListTotCount > reviewStartRow) {
						//리뷰 더보기 버튼 화면에 표시
						$("#moreReviewList").show();

					} else {
						$("#moreReviewList").hide();
					}

				} else {
					alert(data.resultMsg);
				}

				isReviewLoading = false;
			},
			error : function(xhr, status, error) {
				isReviewLoading = false;
				console.log(xhr);
				alert("error\nxhr : " + xhr + ", status : " + status
						+ ", error : " + error);
			}
		});
	};
</script>
</head>
<body>

	<input type="hidden" id="loginId"
		value="${sessionScope.memberLoginBean}">

	<div id="mobileButton">
		<button id="actionBtnMobile" class="actionBtnMobile">참여 신청하기
		</button>
		<button id="bookingMobile" class="bookingMobile"
			style="background: lightgrey;">찜하기</button>
	</div>
	<div id="classWrap">
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
					<pre>${ClassBean.studyInfo}</pre>
				</div>
				<hr />
			</div>
			<!-- end of studyintro -->

			<div id="studyRefer">
				<div id="studyTitle" class="studyTitle">참고 사항</div>
				<div id="StudyContent" class="StudyContent">
					<pre>${ClassBean.studyReference}</pre>
				</div>
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
							<td id="schedule" class="schedule">일정 : ${diff}주</td>
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
			<br> <input type="hidden" id="studyId"
				value="${ClassBean.studyId}"> <input type="hidden"
				id="teacherId" value="${ClassBean.teacherId}">


			<div id="leaderintro">
				<div id="leaderTitle" class="leaderTitle">
					리더 소개 <img class="profile" src="${tPhotoBean.photoFileName}">
				</div>
				<div id="leaderContent" class="leaderContent">
					<pre>${ClassBean.studyInfo} </pre>
				</div>
			</div>
			<br>
			<hr />
			<!-- end of leaderintro -->

			<div id="reply">
				<div id="replyTitle" class="replyTitle">
					리더에 대한 후기<br> <br> <br>
				</div>
				<div id="realReviewInfo"></div>
				<br />
				<p style="text-align: center;">
					<img src="/resources/images/more.png" id="moreReviewList"
						onclick="showNextReviewList()" style="width: 50px; height: 50px;" />
				</p>
			</div>
			<hr />
			<!-- end of reply -->
		</div>

		<div id="side">
			<label id="sideTitle" class="sideTitle">
				${ClassBean.studyName} </label>
			<div class="sideWrap">
				<ul class="sideSchedule">
					<li class="sideSchedulWrap"><div class="sideSchedulChoice"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
						<span id="choiceText" class="choiceText">${diff}주</span> </div>
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
			</div>
			<button id="actionBtn" class="actionBtn">참여 신청하기</button>
			<button id="booking" class="booking" style="background: lightgrey;">찜하기</button>

			<script type="text/javascript">
				var cond = 1;

				function joinFunc() {
					if (confirm("참가 신청 하시겠습니까?")) {

						if ($("#loginId").val() != "") {
							location.href = "application.do?studyId=" + $("#studyId").val();
						} else {
							location.href = "login.do?studyId=" + $("#studyId").val();
						}
					}
				}

				$("#actionBtn").click(function() {
					joinFunc();
				});
				$("#actionBtnMobile").click(function() {
					joinFunc();
				});

				function book() {
					if (cond == 1) {
						$.ajax({
							type : "post",
							url : "updateBusket.do",
							data : {
								customerId : $("#memberId").val(),
								studyId : $("#studyId").val()
							},
							dataType : "json",
							success : function(data) {
								if (data.result == "ok") {
									$("#booking").text("찜취소");
									$("#booking").css("background-color", "#2c3d46");
									$("#booking").css("color", "white");
									cond = 2;
									return;
								} else {
									alert("찜 목록에 실패 하였습니다.");
								}

							},
							error : function(xhr, status, error) {
								console.log(xhr);
								alert("error\nxhr : " + xhr + ", status : "
										+ status + ", error : " + error);
							}
						});

					} else {
						$.ajax({
							type : "post",
							url : "updateBusket.do",
							data : {
								customerId : $("#memberId").val(),
								studyId : $("#studyId").val()
							},
							dataType : "json",
							success : function(data) {
								if (data.result == "ok") {
									$("#booking").text("찜하기");
									$("#booking").css("background-color",
											"lightgrey");
									$("#booking").css("color", "#2c3d46");
									cond = 1;
									return;
								} else {
									alert("찜 목록에 실패 하였습니다.");
								}
							},
							error : function(xhr, status, error) {
								console.log(xhr);
								alert("error\nxhr : " + xhr + ", status : "
										+ status + ", error : " + error);
							}
						});
					}
				}

				$("#booking").click(function() {
					book();
				});
				$("#bookingMobile").click(function() {
					book();
				});
			</script>
		</div>
		<!-- end of side -->
	</div>
</body>
</html>