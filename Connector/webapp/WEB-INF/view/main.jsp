<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page pageEncoding="utf-8" session="false"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">


<title>Main</title>



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
					<a href="/studyIntro.do"><span class="first-slide visual01"></span></a>
				</div>

				<div class="item">
					<a href="/studyIntro.do"><span class="first-slide visual02"></span></a>
				</div>

				<div class="item">
					<a href="/studyIntro.do"><span class="first-slide visual03"></span></a>
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
					src="/resources/images/web.png" alt="classType01" />
					<div class="img_text"></div>
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do"> <img src="/resources/images/ALL.png"
					alt="classType02" />
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do?StudyProgressName=2"> <img
					src="/resources/images/mobile.png" alt="classType03" />
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do?StudyProgressName=3"> <img
					src="/resources/images/SYSTEM.png" alt="classType04" />
				</a>
			</div>

			<div class="classType_box">
				<a href="/realreview.do"> <img
					src="/resources/images/review.png" alt="classType05" />
				</a>
			</div>

			<div class="classType_box">
				<a href="/search.do?StudyProgressName=4"> <img
					src="/resources/images/iot.png" alt="classType06" />
				</a>
			</div>

		</div>
		<!-- PICK -->
		<div class="pick">
			<h2 class="title">PICK</h2>
			<div class="title_hr"></div>

			<div class="pick_box">

				<!--  클래스 시간 별로 8개를 출력한다. -->
			<c:forEach var="classBean" items="${mainPhoto}" varStatus="status" begin="0" end="8">
					
					<div class="card hovercard"
						OnClick="location.href='/detail.do?studyId=${classBean.studyId}'">
						
						 <div class="cardheader"
							style="background-image: url('${classBean.studyPhoto}')"></div>
						<div class="avatar">
							<img alt="" src="${classBean.teacherPhoto}">
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


		<div id="chatAfter">
			<div class="chatTitle" id="chatTitle">
				<span> 로그인 후 이용해 주세요. </span>
				<div class="close" onclick="closeChat()" title="닫기"></div>
			</div>
			<div class="chatContent">로그인 후 이용 가능합니다.</div>
			<input class="chatAfter_input" type="text"
				placeholder="로그인 후 이용 가능 합니다." disabled>
			<!-- 			<span class="chatAfter_span"> 채팅을 시작해 보세요!</span> -->
		</div>

		<div id="loginAfter">
			<div class="chatTitle" id="chatTitle">
				<span> Let's chat! </span>
				<div class="close" onclick="closeChatAfter()" title="닫기"></div>
			</div>

			<div id="message" class="chatContent"></div>

			<input id="input" type="text" class="chatAfter_input"
				placeholder="궁금한게 있나요? 언제든지 물어봐 주세요.[Enter]">
			<!-- 				<span class="chatAfter_span"> 채팅을 시작해 보세요!</span> -->
		</div>

		<!-- CHATTING -->
		<div class="chatBefore" id="chatBefore">
			<span class="chatText"> &nbsp;&nbsp;채팅을 시작해 보세요!&nbsp;&nbsp;</span>
		</div>

		<script type="text/javascript">
			var div = document.getElementById('message');

			//WebSocketEx는 프로젝트 이름
			//websocket 클래스 이름
			var webSocket = new WebSocket("ws://localhost:8181/websocket");
			/* var messageTextArea = document.getElementById("messageTextArea");*/

			//웹 소켓이 연결되었을 때 호출되는 이벤트
			webSocket.onopen = function(message) {
				webSocket.send($("#loginName").val());
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
				div.innerText += "admin : " + jsonData.message + "\n";
				div.scrollTop = div.scrollHeight;
			};

			//Send 버튼을 누르면 실행되는 함수
			function sendMessage() {
				var message = $("#input").val();
				div.innerText += $("#loginName").val() + " : " + message + "\n";
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

			$(document)
					.ready(
							function() {
								$("#chatBefore")
										.click(
												function() {
													if ($("#loginCheck").val() == "g") {

														document
																.getElementById("chatBefore").style.visibility = "hidden";
														document
																.getElementById("loginAfter").style.visibility = "visible";
													} else {
														document
																.getElementById("chatBefore").style.visibility = "hidden";
														document
																.getElementById("chatAfter").style.visibility = "visible";
													}
												});
							});
			function closeChat() {
				document.getElementById("chatBefore").style.visibility = "visible";
				document.getElementById("chatAfter").style.visibility = "hidden";
			}
			function closeChatAfter() {
				document.getElementById("chatBefore").style.visibility = "visible";
				document.getElementById("loginAfter").style.visibility = "hidden";
			}
		</script>
	</section>
</body>
</html>