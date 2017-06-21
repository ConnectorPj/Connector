<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Co:nnector-검색</title>

<link href="/resources/css/search.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/search2.css" rel="stylesheet" type="text/css" />
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

.wrap .overlayInfo {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .overlayInfo:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.overlayInfo .overlayTitle {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.overlayInfo .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.overlayInfo .close:hover {
	cursor: pointer;
}

.overlayInfo .body {
	position: relative;
	overflow: hidden;
}

.overlayInfo .overlayDesc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.overlayDesc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.overlayDesc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
}

.overlayInfo .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.overlayInfo:after {
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

.overlayInfo .link {
	color: #5085BB;
}
</style>

<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=be960340572d4ee994f7b6a2c6483c8b&libraries=services,clusterer"></script>
<script>
	var totalCount = 0;
	var currentNum = 0;
	var groupNum = 0;
	var overlay = null;
	var Map_position = '당산동';
	var positions = []; // 마커의 위치
	var showPositions = []; // 화면에 보여줄 위치

	var contents = [];
	var content = "";

	var showContents = []; // 화면에 보여줄 오버레이

	var leftContents = [];
	var showLeftContents = [];

	// 클러스트에 포함될 마커들의 집함
	var markers = [];

	// 기본적인 변수 선언
	var MARKER_WIDTH = 33, // 기본, 클릭 마커의 너비
		MARKER_HEIGHT = 36, // 기본, 클릭 마커의 높이
		OFFSET_X = 12, // 기본, 클릭 마커의 기준 X좌표
		OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
		OVER_MARKER_WIDTH = 80, // 오버 마커의 너비
		OVER_MARKER_HEIGHT = 24, // 오버 마커의 높이
		OVER_OFFSET_X = 13, // 오버 마커의 기준 X좌표
		OVER_OFFSET_Y = OVER_MARKER_HEIGHT, // 오버 마커의 기준 Y좌표
		imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
		SPRITE_WIDTH = 100, // 스프라이트 이미지 너비
		SPRITE_HEIGHT = 100, // 스프라이트 이미지 높이
		SPRITE_GAP = 7; // 스프라이트 이미지에서 마커간 간격

	var markerSize = new daum.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
		markerOffset = new daum.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
		overMarkerSize = new daum.maps.Size(24, 25), // 오버 마커의 크기
		overMarkerOffset = new daum.maps.Point(OVER_OFFSET_X, OVER_OFFSET_Y), // 오버 마커의 기준 좌표
		spriteImageSize = new daum.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기

	// 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다

	// 한번에 보여줄 bean의 갯수

	$(document)
		.ready(
			function() {
				var mapContainer = document.getElementById('test2'), // 지도를 표시할 div
					mapOption = {
						center : new daum.maps.LatLng(36.340007, 127.413235), // 지도의 중심좌표
						level : 12
					// 지도의 확대 레벨
					};

				var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

				// 마커 클러스터러를 생성합니다 
				var clusterer = new daum.maps.MarkerClusterer({
					map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
					averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
					minLevel : 10
				// 클러스터 할 최소 지도 레벨 
				});

				/* function Paging(index){
					var total =  (index+1) * showPagingCount ;
					// 왼쪽 컨텐츠 내용 보여줌
					if( total > showLeftContents.length){
						total = showLeftContents.length;
					}
					
					for (var i = index*showPagingCount, len = total ; i < len; i++) {
						$("#memberListBody").append(showLeftContents[i]);
					}
				} */

				$.ajax({
					type : "post",
					url : "searchAjax.do",
					dataType : "json",
					success : function(data) {
						if (data.result == "ok") {

							contents = new Array();
							leftContents = new Array();

							$.each(data.mainPhoto, function(i,
								ccBean) {
								showData(ccBean);
							});

							initiate();
							// 지도 영역 변화 이벤트를 등록한다

							if ($("#categoryInit").val() == "1") {
								$("#bigCategorySelect")
									.val("1");
								changeCategory();
							} else if ($("#categoryInit").val() == "2") {
								$("#bigCategorySelect")
									.val("2");
								changeCategory();
							} else if ($("#categoryInit").val() == "3") {
								$("#bigCategorySelect")
									.val("3");
								changeCategory();
							} else if ($("#categoryInit").val() == "4") {
								$("#bigCategorySelect")
									.val("4");
								changeCategory();
							}
							$("#bigCategorySelect").change(
								function() {
									if (window.innerWidth < 769) {
										isMobile = 0;
										changeCategoryMobile();
									} else {
										changeCategory();
									}
								});

							if (window.innerWidth < 769) {
								mobileView();
							}

							return;
						} else {
							alert(data.resultMsg);
						}

					},
					error : function(xhr, status, error) {
						console.log(xhr);
						alert("error\nxhr : " + xhr
							+ ", status : " + status
							+ ", error : " + error);
					}
				}); // end of ajax

				function changeCategoryMobile() {
					var mobileContents = [];
					$.ajax({
						type : "post",
						url : "searchListAjax.do",
						data : {
							studyProgressName : $("#bigCategorySelect").val()
						},
						dataType : "json",
						success : function(data) {
							if (data.result == "ok") {
								$.each(data.mainPhoto,
									function(i, ccBean) {
										var content1 = "";
										content1 += '<div class="card hovercard" id="pick_Contents"';
										content1 += 'OnClick=location.href="/detail.do?studyId='
											+ ccBean.studyId + '">';
										content1 += '<div class="cardheader" style= "background-image:url('
											+ ccBean.studyPhoto + ')"></div>';
										content1 += '<div class="avatar"> <img src="' + ccBean.teacherPhoto + '"></div>';
										content1 += '<div class="info"> <div class="title">'
											+ ccBean.studyName + '</div>';
										content1 += '<div class="desc">'
											+ ccBean.studyPrice + '</div>';
										content1 += '<div class="desc">'
											+ ccBean.studyStartDate + '~</div>';
										content1 += '<div class="desc">'
											+ ccBean.studyEndDate
											+ '</div></div></div>';

										mobileContents.push(content1);
									});
								$("#memberListBody").text("");
								for (var i = 0, len = mobileContents.length; i < len; i++) {
									$("#memberListBody").append(mobileContents[i]);
								}
								// 총 갯수 구하기
								$("#totalCount").text(
									mobileContents.length);

								return;
							} else {
								alert(data.resultMsg);
							}

						},
						error : function(xhr, status, error) {
							console.log(xhr);
							alert("error\nxhr : " + xhr
								+ ", status : " + status
								+ ", error : " + error);
						}
					}); // end of ajax
				} //end of changeCategoryMobile;

				function changeCategory() {
					$.ajax({
						type : "post",
						url : "searchListAjax.do",
						data : {
							studyProgressName : $("#bigCategorySelect")
								.val()
						},
						dataType : "json",
						success : function(data) {
							if (data.result == "ok") {
								mapContainer = document
									.getElementById('test2'); // 지도를 표시할 div
								mapOption = {
									center : new daum.maps.LatLng(
										36.340007, 127.413235), // 지도의 중심좌표
									level : 12
								// 지도의 확대 레벨
								};
								map = new daum.maps.Map(mapContainer,
									mapOption); // 지도를 생성합니다

								daum.maps.event.addListener(map,
									'idle', function() {
										initiate();
									});

								showPositions = new Array();
								content = new Array();
								showContents = new Array();
								showLeftContents = new Array();

								positions = new Array(); // 마커의 위치
								contents = new Array();
								leftContents = new Array();

								// 클러스트에 포함될 마커들의 집함
								var markers = [];

								$.each(data.mainPhoto, function(i,
									ccBean) {
									showData(ccBean);
								});

								initiate();
								// 지도 영역 변화 이벤트를 등록한다

							} else {
								alert("데이터 통신 실패")
							}
						},
						error : function(xhr, status, error) {
							console.log(xhr);
							alert("error\nxhr : " + xhr + ", status : "
								+ status + ", error : " + error);
						}
					});
				} //end of changeCategory method;

				daum.maps.event.addListener(map, 'idle', function() {
					initiate();
				});

				function showData(ccBean) {

					// class의 위치를 position에 저장한다.
					var str = ccBean.studyLocation.split(",");
					positions
						.push(new daum.maps.LatLng(str[0], str[1]));

					// overlay로 뿌려줄 content를 저장한다.

					// 위치 저장후 컨탠츠의 값을 저장한다.
					content = '<div class="wrap">'
						+ '<div class="overlayInfo">' + '<div class="overlayTitle">' + ccBean.studyName
						+ '<div class="close" onclick="closeOverlay()" title="닫기"></div>'
						+ '</div>'
						+ '<div class="body">'
						+ '<div class="img">'
						+ '<img src="' + ccBean.studyPhoto + '" width="73" height="70">'
						+ '</div>'
						+ '<div class="overlayDesc">'
						+ '<div class="ellipsis"> 기간 : '
						+ ccBean.studyStartDate + ' ~ ' + ccBean.studyEndDate
						+ '</div>'
						+ '<div class="jibun ellipsis"> 가격 : '
						+ ccBean.studyPrice
						+ '<div><a href="/detail.do?studyId='
						+ ccBean.studyId
						+ '" target="_blank" class="link">수업 상세 보기</a></div>'
						+ '</div>'
						+ '</div>'
						+ '</div>' + '</div>';

					var content1 = "";
					content1 += '<div class="card hovercard" id="pick_Contents"';
					content1 += 'OnClick=location.href="/detail.do?studyId='
						+ ccBean.studyId + '">';
					content1 += '<div class="cardheader" style= "background-image:url('
						+ ccBean.studyPhoto + ')"></div>';
					content1 += '<div class="avatar"> <img src="' + ccBean.teacherPhoto + '"></div>';
					content1 += '<div class="info"> <div class="title">'
						+ ccBean.studyName + '</div>';
					content1 += '<div class="desc">'
						+ ccBean.studyPrice + '</div>';
					content1 += '<div class="desc">'
						+ ccBean.studyStartDate + '~</div>';
					content1 += '<div class="desc">'
						+ ccBean.studyEndDate
						+ '</div></div></div>';

					contents.push(content);
					leftContents.push(content1);
				}
				// 마커를 눌렀을 때 CustomLay를 한번만 호출하기 위한 boolean 값
				var cont = false;

				function initiate() {
					clusterer = new daum.maps.MarkerClusterer({
						map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
						averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
						minLevel : 10
					// 클러스터 할 최소 지도 레벨 
					});
					// 왼쪽 컨텐츠 초기화
					showContents = new Array();
					showLeftContents = new Array();
					showPositions = new Array();
					$("#memberListBody").text("");

					var mapBounds = map.getBounds();
					lb = new daum.maps.LatLngBounds(mapBounds
						.getSouthWest(), mapBounds.getNorthEast());
					for (var i = 0, len = positions.length; i < len; i++) {
						//화면의 위치에 포함 되어 있다면
						if ( (lb.contain(positions[i])) ) {
							showPositions.push(positions[i]);
							showContents.push(contents[i]);
							showLeftContents.push(leftContents[i]);
						}
					}

					showMarkers();
					//여기
					// 총 갯수 구하기
					$("#totalCount").text(showLeftContents.length);

					totalCount = showLeftContents.length;
					currentNum = 0;
					groupNum = totalCount / 10 + 1;

					var until = (currentNum + 1) * 10
					if (until > totalCount) {
						until = totalCount;
					}
					for (var i = (currentNum * 10), len = until; i < len; i++) {

						$("#memberListBody").append(showLeftContents[i]);
					}
					var str2 = "";

					str2 += "<ul>";
					str2 += "<li><a href='#' onclick='paging(this);' id='first'>처음 </a></li>";

					for (var i = 1; i <= groupNum; i++) {
						str2 += "<li><a href='#' onclick='paging(this);' id='"
							+ i + "'>" + i + "</a></li>";
					}

					str2 += "<li><a href='#' onclick='paging(this);' id='last'> 끝 </a></li>";
					str2 += "</ul>";

					$("#page").html(str2);
				}
				function showMarkers() {

					// 지도 상에서 좌표의 위치에 포함된 마커만 나열한다. 검사
					// 그 후에 지도 위에 마커를 표시 합니다.
					markers = new Array();

					// 지도 위에 마커를 표시합니다
					for (var i = 0, len = showPositions.length; i < len; i++) {
						var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
							originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
							overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP)
								* i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
							normalOrigin = new daum.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
							clickOrigin = new daum.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
							overOrigin = new daum.maps.Point(gapX * 2,
								overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표

						// 마커를 생성하고 지도위에 표시합니다
						addMarker(showPositions[i], normalOrigin,
							overOrigin, clickOrigin, i);
					}

					// 클러스터러에 마커들을 추가합니다
					clusterer.addMarkers(markers);
				}
				function addMarker(position, normalOrigin, overOrigin,
					clickOrigin, i) {

					// 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
					var imageSize = new daum.maps.Size(24, 35);
					var normalImage = new daum.maps.MarkerImage(
							imageSrc, imageSize),
						overImage = createMarkerImage(
							overMarkerSize, overMarkerOffset,
							overOrigin);

					// 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
					var marker = new daum.maps.Marker({
						map : map,
						position : position,
					});
					// 데이터에서 좌표 값을 가지고 마커를 표시합니다
					// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
					markers.push(marker);

					// 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
					marker.normalImage = normalImage;

					// 마커에 click 이벤트를 등록합니다 여기
					daum.maps.event.addListener(marker, 'click',
						function() {

							// 지도 중심을 부드럽게 이동시킵니다
							// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
									
							map.panTo(position);
							if (overlay != null) {
								overlay.setMap(null);
							}

							// 마커 위에 커스텀오버레이를 표시합니다
							// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
							overlay = new daum.maps.CustomOverlay({
								content : showContents[i],
								map : map,
								position : position
							});
							//커스텀 모달 띄우기
							//overlay.setMap(map);

						});
					// MakrerImage 객체를 생성하여 반환하는 함수입니다
					function createMarkerImage(markerSize, offset,
						spriteOrigin) {
						var markerImage = new daum.maps.MarkerImage(
							imageSrc, // 스프라이트 마커 이미지 URL
							markerSize, // 마커의 크기
							{
								offset : offset, // 마커 이미지에서의 기준 좌표
								spriteOrigin : spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
								spriteSize : spriteImageSize
							// 스프라이트 이미지의 크기
							});
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
							for (var i = 0, len = data.places.length; i < len; i++) {
								bounds.extend(new daum.maps.LatLng(
									data.places[i].latitude,
									data.places[i].longitude));
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

			}); //end of ready function
	function paging(click) {
		$("#memberListBody").text("");
		var id = click.id;

		if (click.id == "first") {
			id = 1;
		}
		if (click.id == "last") {
			id = Math.ceil(showLeftContents.length / 10)
		}

		totalCount = showLeftContents.length;
		currentNum = (id - 1);
		groupNum = totalCount / 10 + 1;

		var until = (currentNum + 1) * 10
		if (until > totalCount) {
			until = totalCount;
		}
		for (var i = (currentNum * 10), len = until; i < len; i++) {

			$("#memberListBody").append(showLeftContents[i]);
		}

	}

	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
	function closeOverlay() {
		overlay.setMap(null);
	}
	var isMobile = 1;
	$(window).resize(function() {
		if (window.innerWidth < 769 && isMobile == 1) {
			$("#bigCategorySelect").val("0");
			mobileView();
		}
		if (window.innerWidth > 769) {
			isMobile = 1;
		}
	});

	function mobileView() {
		var mobileContents = [];
		$("#memberListBody").text("");

		$.ajax({
			type : "post",
			url : "searchAjax.do",
			dataType : "json",
			success : function(data) {
				if (data.result == "ok") {

					$.each(
						data.mainPhoto,
						function(i, ccBean) {

							var content1 = "";
							content1 += '<div class="card hovercard" id="pick_Contents"';
							content1 += 'OnClick=location.href="/detail.do?studyId=' + ccBean.studyId + '">';
							content1 += '<div class="cardheader" style= "background-image:url(' + ccBean.studyPhoto + ')"></div>';
							content1 += '<div class="avatar"> <img src="' + ccBean.teacherPhoto + '"></div>';
							content1 += '<div class="info"> <div class="title">' + ccBean.studyName + '</div>';
							content1 += '<div class="desc">' + ccBean.studyPrice + '</div>';
							content1 += '<div class="desc">' + ccBean.studyStartDate + '~</div>';
							content1 += '<div class="desc">' + ccBean.studyEndDate + '</div></div></div>';

							mobileContents.push(content1);
						});

					for (var i = 0, len = mobileContents.length; i < len; i++) {
						$("#memberListBody").append(mobileContents[i]);
					}
					// 총 갯수 구하기
					$("#totalCount").text(mobileContents.length);

					return;
				} else {
					alert(data.resultMsg);
				}

			},
			error : function(xhr, status, error) {
				console.log(xhr);
				alert("error\nxhr : " + xhr + ", status : " + status
					+ ", error : " + error);
			}
		}); // end of ajax
	} //end of mobileView
</script>

</head>

<body>
	<div class="total">
		<div id="test1">
			<div class="search">
				<form id="searchForm">
					<div class="searchPlace">
						<label class="textPlace">장소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
						<hr>
					</div>

					<div class="searchCategory">
						<label class="textCategory">카테고리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<div class="bigCategory">
							<select id="bigCategorySelect">
								<option id="title" value="0" selected>대분류</option>
								<option id="select_web" value="1">웹 개발</option>
								<option id="select_mobile" value="2">모바일 개발</option>
								<option id="select_system" value="3">시스템 개발</option>
								<option id="select_iot" value="4">IOT</option>
							</select> <input type="hidden" id="categoryInit"
								value="${cBean.studyProgressName}">
						</div>
					</div>
					<hr>
				</form>
			</div>

			<div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 검색 결과 : <span id="totalCount"></span>
				개
			</div>
			<br>
			<!-- PICK -->
			<div class="pick">
				<div class="pick_box">
					<label id="memberListBody"></label>
				</div>
			</div>
			<div id="page" class="page"></div>

		</div>
		<div id="test2"></div>
	</div>
</body>
</html>