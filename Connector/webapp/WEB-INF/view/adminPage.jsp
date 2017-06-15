<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css"
	href="/resources/bootstrap/css/bootstrap-theme.css" rel="stylesheet" />
<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">
<link type="text/css" href="/resources/css/adminPageCss.css"
	rel="stylesheet">
<style>
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


<head>
<title>관리자 페이지</title>

</head>
<body>
	<!--메인 -->
	<section>
		<div class="sub_wrap">
			<!-- 서브 네비 -->
			<div class="sub_nav">
				<div class="sub_menu">
					<ul>
						<li><a href="adminPage.do" class="on">관리자 홈</a></li>
						<li><a href="adminTeacherList.do?pageNo=1">강사 관리</a></li>
						<li><a href="adminStudentList.do?pageNo=1">회원 관리</a></li>
						<li><a href="adminStudyList.do?pageNo=1">스터디 관리</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li> &gt;
							<li>관리자 메뉴</li>
						</ul>
					</div>
					<h2>관리자 메뉴</h2>
				</div>

				<!-- 서브 내용 -->

				<div class="adminPageMain">
					<div class="mainStudy">
					<button class="menuBtn" onclick="location.href='/adminTeacherList.do?pageNo=1'">강사 관리</button>
					</div>
					<div class="mainStudy">
					<button class="menuBtn" onclick="location.href='/adminStudentList.do?pageNo=1'">회원 관리</button>
					</div>
					<div class="mainStudy">
					<button class="menuBtn" onclick="location.href='/adminStudyList.do?pageNo=1'">스터디 관리</button>
					</div>
				</div>

				<!-- 서브내용 끝. -->
			</div>
		</div>


		<!-- CHATTING -->
		<div class="chatBefore" id="chatBefore"
			style="position: fixed; right: 0; bottom: 0; z-index: 10000; background-color: gray;">
			<span style="font-size: 20px; text-align: center; color: white;">
				1:1 문의 답변하기</span>
		</div>

		<div class="chatRoom" id="chatRoom"
			style="visibility: hidden; position: fixed; right: 0; bottom: 0; z-index: 10000; background-color: gray; width: 330px; height: 400px;">
			<div class="chatTitle" id="chatTitle"
				style="width: 100%; height: 10%; background: gray;">
				<span style="font-size: 20px; color: white;"> 채팅방 관리하기 </span>
				<div class="close" onclick="closeChatList()" title="닫기"></div>
			</div>
			<div id="content"
				style="background-color: #F5F5F5; width: 100%; height: 90%; OVERFLOW-Y: auto; word-wrap: break-word">
				<table style="width: 100%;">
					<tbody id="chatBody"></tbody>
				</table>
			</div>

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
			var arr = new Array();
		
		
			//WebSocketEx는 프로젝트 이름
			//websocket 클래스 이름
			var webSocket = new WebSocket("ws://localhost:8181/websocket");
			/* var messageTextArea = document.getElementById("messageTextArea");*/
		
			//웹 소켓이 연결되었을 때 호출되는 이벤트
			webSocket.onopen = function(message) {
				webSocket.send("#");
				arr.push("0");
			};
			//웹 소켓이 닫혔을 때 호출되는 이벤트
			webSocket.onclose = function(message) {
				div.innerText += "Server Disconnect...\n";
			};
			//웹 소켓이 에러가 났을 때 호출되는 이벤트
			webSocket.onerror = function(message) {
				div.innerText += "error...\n";
			};
			var curId = "";
			//웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
			webSocket.onmessage = function(message) {
				var jsonData = JSON.parse(message.data);
				var message = jsonData.message.split("/");
		
				for (var i = 0; i < arr.length; i++) {
					// 기존에 대화창이 있다면
					
					if (arr[i][0] == message[1]) {
						arr[i].push(message[1] + " : " + message[0]);
						break;
					}
					// 만약 기존에 대화창이 없다면
					if (i == arr.length-1) {
						arr.push(message[1]);
						arr[arr.length - 1] = new Array();
						arr[arr.length - 1].push(message[1]);
						arr[arr.length - 1].push(message[1] + " : " + message[0]);
		
						//댓글 리스트 출력
						var str = "";
						str += "<tr>";
						str += "<td width='70%'>" + message[1] + "</td>";
						str += "<td width='30%'><button type='button' onclick='openChat(" + '"' + message[1] + '"' + ")'>채팅하기</button></td>";
						str += "</tr>";
						$("#chatBody").append(str);
						break;
					}
				}
		
				if (curId == message[1]) {
					div.innerText += message[1] + " : " + message[0] + "\n";
				}
		
			};
			//Send 버튼을 누르면 실행되는 함수
			function openChat(id) {
				div.innerText = "";
				curId = id;
		
				for (var i = 1; i < arr.length; i++) {
					if (arr[i][0] == id) {
						for (var j = 1; j < arr[i].length; j++) {
							$("#message").append(arr[i][j] + "<br/>");
						}
					}
				}
				document.getElementById("chatAfter").style.visibility = "visible";
				document.getElementById("chatRoom").style.visibility = "hidden";
			}
			function closeChat() {
				document.getElementById("chatRoom").style.visibility = "visible";
				document.getElementById("chatAfter").style.visibility = "hidden";
			}
		
			function sendMessage() {
				
				var message = $("#input").val();
				div.innerText += "admin : " + message + "\n";
				
				//웹소켓으로 textMessage객체의 값을 보낸다.
				webSocket.send(message + "/" + curId);
				
				//textMessage객체의 값 초기화
				$("#input").val("");
				
				for (var i = 0; i < arr.length; i++) {
					// 기존에 대화창이 있다면
					if (arr[i][0] == curId) {
						arr[i].push("admin : " + message + "\n");
					}
				}
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
					document.getElementById("chatRoom").style.visibility = "visible";
				});
			});
			function closeChat() {
				document.getElementById("chatBefore").style.visibility = "visible";
				document.getElementById("chatAfter").style.visibility = "hidden";
			}
		
			function closeChatList() {
				document.getElementById("chatBefore").style.visibility = "visible";
				document.getElementById("chatRoom").style.visibility = "hidden";
			}
		</script>

	</section>
	<!--메인끝 -->

</body>
</html>