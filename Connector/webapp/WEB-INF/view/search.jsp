<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>검색</title>
<link href="/resources/css/search.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/mainStyle.css" rel="stylesheet"
	type="text/css" />
<link href="/resources/bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
<style>
.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 132px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
}
</style>

<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=c50d46bc6244185fdb36b57523e93fb4&libraries=services""></script>

<script>
	var overlay = null;
	var Map_position = '당산동';
	var positions = [ // 마커의 위치
		new daum.maps.LatLng(37.530919, 126.903601),
	];
	var contents = [];

	$(document).ready(function() {

		$.ajax({
			type : "post",
			url : "searchAjax.do",
			/* 	data: $("#memberForm").serialize(), */
			dataType : "json",
			success : function(data) {

				if (data.result == "ok") {
					var cBean = data.classList;

					// 위치를 먼저 배열에 저장한다.
					/* for (var i = 0; i < cBean.length; i++) {
						positions.push(new daum.maps.LatLng(37.530919, 126.903601));
					            } */
					positions.push(new daum.maps.LatLng(37.533590, 126.901404));

					// 위치 저장후 컨탠츠의 값을 저장한다.
					var content = '<div class="wrap">' +
						'    <div class="info">' +
						'        <div class="title">' +
						'            카카오 스페이스닷원' +
						'            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
						'        </div>' +
						'        <div class="body">' +
						'            <div class="img">' +
						'                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
						'           </div>' +
						'            <div class="desc">' +
						'                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' +
						'                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' +
						'                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' +
						'            </div>' +
						'        </div>' +
						'    </div>' +
						'</div>';
					contents.push(content);
					contents.push(content);
					
					return;
				} else {
					alert(data.resultMsg);
				}

			},
			error : function(xhr, status, error) {
				console.log(xhr);
				alert("error\nxhr : " + xhr + ", status : "
					+ status + ", error : " + error);
			}
		});

	});

	$(document).ready(function() {

		var MARKER_WIDTH = 33, // 기본, 클릭 마커의 너비
			MARKER_HEIGHT = 36, // 기본, 클릭 마커의 높이
			OFFSET_X = 12, // 기본, 클릭 마커의 기준 X좌표
			OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
			OVER_MARKER_WIDTH = 40, // 오버 마커의 너비
			OVER_MARKER_HEIGHT = 42, // 오버 마커의 높이
			OVER_OFFSET_X = 13, // 오버 마커의 기준 X좌표
			OVER_OFFSET_Y = OVER_MARKER_HEIGHT, // 오버 마커의 기준 Y좌표
			SPRITE_MARKER_URL = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markers_sprites2.png', // 스프라이트 마커 이미지 URL
			SPRITE_WIDTH = 126, // 스프라이트 이미지 너비
			SPRITE_HEIGHT = 146, // 스프라이트 이미지 높이
			SPRITE_GAP = 10; // 스프라이트 이미지에서 마커간 간격

		var markerSize = new daum.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
			markerOffset = new daum.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
			overMarkerSize = new daum.maps.Size(OVER_MARKER_WIDTH, OVER_MARKER_HEIGHT), // 오버 마커의 크기
			overMarkerOffset = new daum.maps.Point(OVER_OFFSET_X, OVER_OFFSET_Y), // 오버 마커의 기준 좌표
			spriteImageSize = new daum.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기

		var selectedMarker = null; // 클릭한 마커를 담을 변수

		var mapContainer = document.getElementById('test2'), // 지도를 표시할 div
			mapOption = {
				center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level : 3 // 지도의 확대 레벨
			};

		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
		function addMarker(position, normalOrigin, overOrigin, clickOrigin, i) {

			// 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
			var normalImage = createMarkerImage(markerSize, markerOffset, normalOrigin),
				overImage = createMarkerImage(overMarkerSize, overMarkerOffset, overOrigin);

			// 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
			var marker = new daum.maps.Marker({
				map : map,
				position : position,
				image : normalImage
			});


			// 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
			marker.normalImage = normalImage;
			// 마커에 mouseover 이벤트를 등록합니다
			daum.maps.event.addListener(marker, 'mouseover', function() {

				// 클릭된 마커가 없고, mouseover된 마커가 클릭된 마커가 아니면
				// 마커의 이미지를 오버 이미지로 변경합니다
				if (!selectedMarker || selectedMarker !== marker) {
					marker.setImage(overImage);
				}
			});

			// 마커에 mouseout 이벤트를 등록합니다
			daum.maps.event.addListener(marker, 'mouseout', function() {

				// 클릭된 마커가 없고, mouseout된 마커가 클릭된 마커가 아니면
				// 마커의 이미지를 기본 이미지로 변경합니다
				if (!selectedMarker || selectedMarker !== marker) {
					marker.setImage(normalImage);
				}
			});

			// 마커에 click 이벤트를 등록합니다
			daum.maps.event.addListener(marker, 'click', function() {
				// 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
				// 마커의 이미지를 클릭 이미지로 변경합니다
				if (!selectedMarker || selectedMarker !== marker) {

					// 클릭된 마커 객체가 null이 아니면
					// 클릭된 마커의 이미지를 기본 이미지로 변경하고
					!!selectedMarker && selectedMarker.setImage(selectedMarker.normalImage);

				}

				if (overlay != null) {
					overlay.setMap(null);
				}

				alert(i);
				// 마커 위에 커스텀오버레이를 표시합니다
				// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
				overlay = new daum.maps.CustomOverlay({
					content : contents[i],
					map : map,
					position : position
				});
				//커스텀 모달 띄우기
				overlay.setMap(map);

				// 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
				selectedMarker = marker;


			});
			// MakrerImage 객체를 생성하여 반환하는 함수입니다
			function createMarkerImage(markerSize, offset, spriteOrigin) {
				var markerImage = new daum.maps.MarkerImage(
					SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
					markerSize, // 마커의 크기
					{
						offset : offset, // 마커 이미지에서의 기준 좌표
						spriteOrigin : spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
						spriteSize : spriteImageSize // 스프라이트 이미지의 크기
					}
				);

				return markerImage;
			}
		}
		function changePosition() {
			// 장소 검색 객체를 생성합니다
			var ps = new daum.maps.services.Places();

			// 키워드로 장소를 검색합니다
			ps.keywordSearch(Map_position, placesSearchCB);

			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB(status, data, pagination) {
				if (status === daum.maps.services.Status.OK) {

					// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
					// LatLngBounds 객체에 좌표를 추가합니다
					var bounds = new daum.maps.LatLngBounds();

					// 지도 위에 마커를 표시합니다
					for (var i = 0, len = positions.length; i < len; i++) {
						var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
							originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
							overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
							normalOrigin = new daum.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
							clickOrigin = new daum.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
							overOrigin = new daum.maps.Point(gapX * 2, overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표

						// 마커를 생성하고 지도위에 표시합니다
						addMarker(positions[i], normalOrigin, overOrigin, clickOrigin,i);
						bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude));
					}

					// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
					map.setBounds(bounds);
				}
			}
		}

		$("#Map_Click").click(function() {
			Map_position = $("#Map_Position").val();
			changePosition();
		});
		$("#Map_Position").keypress(function(e) {
			
		});


		$("#bigCategorySelect").change(function() {
			/* if문에  오류 처리*/
			alert($(this).val());
		});


	}); // end of document.ready

	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
	function closeOverlay() {
		overlay.setMap(null);
	}
</script>

</head>

<body>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<div class="total">
		<div id="test1">
			<div class="search">
				<form id="searchForm">
					<div class="searchPlace">
						<label class="textPlace">장소</label>
						<div class="searchText">
							<div class="input-group stylish-input-group">
								<input type="text" id="Map_Position" class="form-control"
									placeholder="지역 혹은 지하철역으로 검색하세요."> <span
									class="input-group-addon">
									<button id="Map_Click" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
						<div class="mySearchPlace"">
							<button type="button" id="mySearchPlaceBtn">내 위치로 검색</button>
						</div>
					</div>
					<hr>

					<div class="searchCategory">
						<label class="textCategory">카테고리</label>
						<div class="bigCategory">
							<select id="bigCategorySelect">
								<option id="title" selected>대분류</option>
								<option id="select_web">웹 개발</option>
								<option id="select_mobile">모바일 개발</option>
								<option id="select_system">시스템 개발</option>
								<option id="select_iot">IOT</option>
							</select>
						</div>
						<div class="smallCategory">
							<select id="smallCategorySelect" disabled>
								<option value="소분류" selected>소분류</option>
								<option value="소분류">JAVA</option>
								<option value="소분류">C</option>
							</select>
						</div>
					</div>
					<hr>

				</form>
			</div>
			<div class="pick">

				<h2 class="title">PICK</h2>
				<div class="title_hr"></div>

				<div class="pick_box">

					<!--  클래스 시간 별로 8개를 출력한다. -->
					<c:forEach var="classBean" items="${classList}" varStatus="status"
						begin="0" end="8">

						<div class="card hovercard" id="pick_Contents"
							OnClick="location.href='/detail.do?studyNo=${classBean.studyNo}'">
							<div class="cardheader"
								style="background-image: url('../resources/images/image.jpg')"></div>
							<div class="avatar">
								<img alt="" src="/resources/images/img.jpg">
							</div>
							<div class="info">
								<div class="title">${classBean.studyName}</div>
								<div class="desc">${classBean.studyPrice}</div>
								<div class="desc">${classBean.studyStartDate}~</div>
								<div class="desc">${classBean.studyEndDate}</div>
							</div>
						</div>

					</c:forEach>

				</div>
			</div>
		</div>

		<div id="test2"></div>
	</div>
</body>
</html>