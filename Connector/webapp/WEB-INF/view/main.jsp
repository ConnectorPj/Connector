<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- bootstrap.css -->
<link type="text/css"
	href="/resources/bootstrap/css/bootstrap-theme.css" rel="stylesheet" />
<link type="text/css" href="/resources/bootstrap/css/bootstrap.css"
	rel="stylesheet" />
<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">

<!-- jquery.js -->
<script type="text/javascript"
	src="/resources/js/common/jquery/jquery-3.2.1.js"></script>

<!-- bootstrap.js -->
<script type="text/javascript"
	src="/resources/bootstrap/js/bootstrap.js"></script>

<title>Main</title>

<style type="text/css">
html, body {
	font-family: 'Noto Sans KR', sans-serif, dotum, '돋움', gulim, '굴림', Arial,
		AppleGothic, verdana, helvetica;
	font-size: 14px;
	letter-spacing: -0.05em;
	line-height: 1.6;
	font-weight: 400;
	color: #333;
	margin: 0;
	overflow-x: hidden;
	!
	important;
}

a {
	color: #333333;
	text-decoration: none;
}

a:link {
	color: #333333;
	text-decoration: none;
	transition: all .3s ease
}

a:visited {
	color: #333333;
	text-decoration: none
}

a:active {
	color: #333333;
	text-decoration: none
}

a:hover {
	color: #666666;
	text-decoration: none
}

.close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}
</style>

</head>
<body>
	<section>
		<!-- main 맨위의 슬라이드 화면  -->
		<div id="myCarousel" class="carousel slide main_visual"
			data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<a href="#"><span class="first-slide visual01"></span></a>
				</div>

				<div class="item">
					<a href="#"><span class="first-slide visual02"></span></a>
				</div>

				<div class="item">
					<a href="#"><span class="first-slide visual03"></span></a>
				</div>
			</div>

			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>

		<!-- 분야별 -->
		<div class="classType">
			<h2 class="title">분야별</h2>
			<div class="title_hr"></div>

			<div class="classType_box">
				<a href="/search.do?StudyProgressName=1"> <img
					src="/resources/images/Main_Img1.jpg" alt="classType01" />
					<div class="img_text">
						<p>#웹 개발</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do"> <img src="/resources/images/Main_Img2.jpg"
					alt="classType02" />
					<div class="img_text">
						<p>#전체보기</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do?StudyProgressName=2"> <img
					src="/resources/images/Main_Img3.jpg" alt="classType03" />
					<div class="img_text">
						<p>#모바일 개발</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do?StudyProgressName=3"> <img
					src="/resources/images/Main_Img4.jpg" alt="classType04" />
					<div class="img_text">
						<p>#시스템 개발</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="/realreview.do"> <img
					src="/resources/images/Main_Img5.jpg" alt="classType05" />
					<div class="img_text">
						<p>#리얼후기</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do?StudyProgressName=4"> <img
					src="/resources/images/Main_Img6.jpg" alt="classType06" />
					<div class="img_text">
						<p>#IOT</p>
					</div>
				</a>
			</div>

		</div>
		<!-- PICK -->
		<div class="pick">
			<h2 class="title">PICK</h2>
			<div class="title_hr"></div>

			<div class="pick_box">

				<!--  클래스 시간 별로 8개를 출력한다. -->
				<c:forEach var="classBean" items="${classList}" varStatus="status"
					begin="0" end="8">

					<div class="card hovercard"
						OnClick="location.href='/detail.do?studyId=${classBean.studyId}'">
						<div class="cardheader"
							style="background-image: url('../resources/images/image.jpg')"></div>
						<div class="avatar">
							<img alt="" src="/resources/images/img.jpg">
						</div>
						<div class="info">
							<div class="title">${classBean.studyName}</div>
							<div class="desc">${classBean.studyPrice}</div>
							<div class="desc">${classBean.studyStartDate}</div>
							<div class="desc">${classBean.studyEndDate}</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- CHATTING -->
		<div class="chatBefore" id="chatBefore"
			style="position: fixed; right: 0; bottom: 0; z-index: 10000; background-color: gray;">
			<span style="font-size: 20px; text-align: center; color: white;">
				채팅을 시작해 보세요!</span>
		</div>

		<div class="chatAfter" id="chatAfter"
			style="visibility: hidden; position: fixed; right: 0; bottom: 0; z-index: 10000; background-color: gray; width: 330px; height: 400px;">
			<div class="chatTitle" id="chatTitle"
				style="width: 100%; height: 10%; background: gray;">
				<span style="font-size: 20px; color: white;"> Let's chat! </span>
				<div class="close" onclick="closeChat()" title="닫기"></div>
			</div>


			<div id="message"
				style="background-color: #F5F5F5; width: 100%; height: 75%; OVERFLOW-Y: auto; word-wrap: break-word"></div>

			<input id="input" type="text"
				placeholder="궁금한게 있나요? 언제든지 물어봐 주세요.[Enter]"
				style="width: 100%; height: 15%;"> <span
				style="font-size: 20px; text-align: center;"> 채팅을 시작해 보세요!</span>
		</div>

		<script type="text/javascript">
			var div = document.getElementById('message');
		
			//WebSocketEx는 프로젝트 이름
			//websocket 클래스 이름
			var webSocket = new WebSocket("ws://localhost:8181/websocket");
			/* var messageTextArea = document.getElementById("messageTextArea");*/
			
			//웹 소켓이 연결되었을 때 호출되는 이벤트
			webSocket.onopen = function(message) {
			 	webSocket.send("user");
			};
			//웹 소켓이 닫혔을 때 호출되는 이벤트
			webSocket.onclose = function(message) {
				div.innerText += "Server Disconnect...\n";
			};
			//웹 소켓이 에러가 났을 때 호출되는 이벤트
			webSocket.onerror = function(message) {
				div.innerText += "error...\n";
			};
			//웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
			webSocket.onmessage = function(message) {
				 var jsonData = JSON.parse(message.data);
				div.innerText += jsonData.message + "\n";
				div.scrollTop = div.scrollHeight; 
			};
			//Send 버튼을 누르면 실행되는 함수
			function sendMessage() {
				var message = $("#input").val();
				//웹소켓으로 textMessage객체의 값을 보낸다.
				webSocket.send(message);
				//textMessage객체의 값 초기화
				$("#input").val("");
			}
			//웹소켓 종료
			function disconnect() {
				webSocket.close();
			}
		
			$("#input").keypress(function(e) {
				var key = e.which || e.keyCode;
				if (key === 13) { // 13 is enter
					sendMessage();
				}
			});
		
			$(document).ready(function() {
				$("#chatBefore").click(function() {
					document.getElementById("chatBefore").style.visibility = "hidden";
					document.getElementById("chatAfter").style.visibility = "visible";
				});
			});
			function closeChat() {
				document.getElementById("chatBefore").style.visibility = "visible";
				document.getElementById("chatAfter").style.visibility = "hidden";
			}
		</script>
	</section>
</body>
</html>