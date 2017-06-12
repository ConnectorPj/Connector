<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:import url="/WEB-INF/view/layout/header.jsp"></c:import>



<title><decorator:title default="Spring 테스트웹" /></title>

<style type="text/css">
header, section, footer {
	margin: 0;
	padding: 0;
	width: 100%;
	height: auto;
}

header {
	border-bottom: 1px solid #ddd;
	height: 70px;
	position: fixed;
	z-index: 99;
	background-color: #fff;
}

header .head {
	width: 1200px;
	margin: 0px auto 0px;
	height: 70px;
}

header .head:after {content ="";
	display: block;
	clear: both;
}

header .head h1 {
	float: left;
	width: 200px;
	margin: 0;
	padding: 0;
}

header .head h1 img {
	padding: 10px;
	z-index: 99;
	height: 70px;
}

/* 구글 버튼*/
#customBtn, #customBtn2, #customBtn3, #customBtn4 {
	display: inline-block;
	background: white;
	color: #444;
	margin: 1% 0;
	width: 100%;
	border-radius: 5px;
	border: thin solid #888;
	white-space: nowrap;
}

#customBtn:hover, #customBtn2:hover, #customBtn3:hover, #customBtn4:hover
	{
	cursor: pointer;
	box-shadow: 1px 1px 1px black;
}

span.label {
	font-family: serif;
	font-weight: normal;
}

span.icon {
	margin-left: 3%;
	background: url('/resources/images/g-logo.png') transparent 50% 50%/100%
		100% no-repeat;
	display: inline-block;
	vertical-align: middle;
	width: 42px;
	height: 42px;
	background: url('/resources/images/g-logo.png') transparent 50% 50%/100%
		100% no-repeat;
}

span.buttonText {
	display: inline-block;
	vertical-align: middle;
	text-align: center;
	padding-left: 31%;
	padding-right: 42px;
	font-size: 14px;
	font-weight: bold;
	/* Use the Roboto font that is loaded in the <head> */
	font-family: 'Roboto', sans-serif;
}

#naver_id_login img {
	width: 100%;
}
</style>


<!-- 2017. 05. 22 작성자 : 정홍의 -->
<!-- 구글 로그인 필수 js파일 -->
<!-- 구글 로그인용 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Roboto"
	rel="stylesheet" type="text/css">
<!-- 구글 로그인 필수 js파일 -->
<script src="https://apis.google.com/js/api:client.js"></script>
<!-- 2017.05.26 네이버 로그인 작성자 : 정홍의 -->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!--  구글 로그인 테스트  -->
<!--  참고 사이트 :  google developer -->
<!--  https://developers.google.com/identity/sign-in/web/devconsole-project -->

<script type="text/javascript">
	// Modal Function
	function checkPassword() {

		var password = document.getElementById("password").value;
		var exptext = /^.*(?=.{6,15})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		if (exptext.test(password) == false) {

			document.getElementById("resultPass").textContent = "비밀번호 형식이 올바르지 않습니다.";
			document.getElementById("password").focus();
			return false;

		} else {
			document.getElementById("resultPass").textContent = "";

		}
		document.getElementById("password2").disabled = false;

		return true;
	};

	function checkPasswordConfirm() {
		if ($("#password").val() == $("#password2").val()) {
			document.getElementById("resultPass2").textContent = "비밀번호가 일치합니다.";

			return true;

		} else {
			document.getElementById("resultPass2").textContent = "비밀번호가 일치하지 않습니다.";

			return false;
		}
	};

	function checkEmail() {
		var email = document.getElementById("email").value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (exptext.test(email) == false) {
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			document.getElementById("resultEmail").textContent = "메일형식이 올바르지 않습니다.";
			document.getElementById("email").focus();
			return false;
		} else {
			document.getElementById("resultEmail").textContent = "";
			customerCheckId();
			return true;
		}
	};

	function customerCheckId() {

		$.ajax({
			url : '/customerCheckId.do',
			type : 'post',
			data : {
				"customerId" : $("#email").val()
				},
			success : function(data) {
				$("#resultEmail").html(data.resultMsg);
			},
			error : function(error) {
				alert(error.statusText);
			}
		});
	};

	function insertCustomer() {

		if ($("#name").val() == null || $("#name").val() == "") {

			document.getElementById("name").focus();

			$('#name').attr('placeholder', '이름을 입력하지 않으셨습니다.');

			return;

		} else if ($("#email").val() == null || $("#email").val() == ""
				|| !checkEmail()) {
			document.getElementById("email").focus();
			$('#email').attr('placeholder', '메일을 올바르게 작성해주세요.');

			return;
		} else if ($("#password").val() == null || $("#password").val() == ""
				|| !checkPasswordConfirm()) {
			document.getElementById("password").focus();
			$('#password').attr('placeholder', '비밀번호을 입력하지 않으셨습니다.');

			return;
		} else if ($(":input:radio[id='agree']:checked").val() != "1") {
			alert("개인정보 활용 제공에 동의해주세요.");
			return;

		} else {

			$.ajax({
				type : "post",
				url : "/insertCustomerProc.do",
				data : $("#customerForm").serialize(),
				async : false,
				dataType : "json",
				success : function(data) {
					console.log(data);

					if (data.result == "ok") {
						alert(data.resultMsg);
						closeJoinModal();
						openLoginModal();
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
			});

		}
	};
</script>

<script type="text/javascript">
	$(window).scroll(function() {
		var scrollValue = $(document).scrollTop();
		console.log(scrollValue);
	});

	$(document).ready(

	function() {

		$("#btnLoginM").click(function() {

			var st = $(":input:radio[name=customer]:checked").val();

			if (st == 1) {

				$.ajax({
					type : "post",
					url : "/CustomerloginProc.do",
					data : {
						customerId : $("#customerIdM").val(),
						customerPw : $("#customerPwM").val()
					},
					dataType : "json",
					success : function(data) {
						console.log(data);

						if (data.result == "ok") {

							//android 호출
							try {
								var cusId = $("#customerIdM").val();
								window.JSInterface.updateAndToken(cusId);
							} catch (e) {
								console.log(e);
							}

							//로그인 성공
							location.replace("/main.do");
							return;
						} else {
							alert("로그인을 실패하였습니다.");
							$("#customerPwM").focus();
						}

					}
				});

			} else if (st == 2) {

				$.ajax({
					type : "post",
					url : "/TeacherloginProc.do",
					data : {
						teacherId : $("#customerIdM").val(),
						teacherPw : $("#customerPwM").val()
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						if (data.result == "ok") {

							//android 호출
							try {
								var teaId = $("#customerIdM").val();
								window.JSInterface.updateAndToken(teaId);
							} catch (e) {
								console.log(e);
							}

							//로그인 성공
							location.replace("/main.do");
							return;
						} else {
							alert("로그인을 실패하였습니다.");
							$("#customerPwM").focus();
						}

					},
					error : function(xhr, status, error) {
						console.log(xhr);
						alert("error\nxhr : " + xhr

						+ ", status : " + status + ", error : " + error);
					}
				});

			}

		});

	});
</script>


<script type="text/javascript">
	var auth2;
	function startApp() {
		gapi
				.load(
						'auth2',
						function() {
							// 구글 로그인 기능
							auth2 = gapi.auth2
									.init({
										// client_id 는 ~~.apps.google~ 전까지 구글 개발자 콘솔의 개별 아이디!
										client_id : '559372757938-d5eg9qmoefkbp8sispf7c6fjg2lfnk6c.apps.googleusercontent.com',
										// 아마도 single_host_origin은 싱글톤 패턴이기 때문에 한페이지에 한번밖에 사용 불가능 한가?
										// -> 안되서 밑에 secondApp()에 똑같은 함수 구현
										cookiepolicy : 'single_host_origin',
										// 필요시 scope에서 다른걸로 가능
										// 참고 : https://developers.google.com/identity/sign-in/web/incremental-auth
										scope : 'profile'
									});
							// attachClickHandler 에서 성공시 onSuccess로 실피시 onFailure로 이동.
							auth2.attachClickHandler(document
									.getElementById('customBtn'), {},
									onSuccess, onFailure);
						});
	};

	function secondApp() {
		gapi
				.load(
						'auth2',
						function() {
							auth2 = gapi.auth2
									.init({
										// client_id 는 ~~.apps.google~ 전까지 구글 개발자 콘솔의 개별 아이디!
										client_id : '559372757938-d5eg9qmoefkbp8sispf7c6fjg2lfnk6c.apps.googleusercontent.com',
										// 아마도 single_host_origin은 싱글톤 패턴이기 때문에 한페이지에 한번밖에 사용 불가능 한가?
										// -> 안되서 밑에 secondApp()에 똑같은 함수 구현
										cookiepolicy : 'single_host_origin',
										// 필요시 scope에서 다른걸로 가능
										// 참고 : https://developers.google.com/identity/sign-in/web/incremental-auth
										scope : 'profile'
									});
							// attachClickHandler 에서 성공시 onSuccess로 실피시 onFailure로 이동.
							auth2.attachClickHandler(document
									.getElementById('customBtn2'), {},
									onSuccess, onFailure);
						});
	};
	function thirdApp() {
		gapi
				.load(
						'auth2',
						function() {
							auth2 = gapi.auth2
									.init({
										// client_id 는 ~~.apps.google~ 전까지 구글 개발자 콘솔의 개별 아이디!
										client_id : '559372757938-d5eg9qmoefkbp8sispf7c6fjg2lfnk6c.apps.googleusercontent.com',
										// 아마도 single_host_origin은 싱글톤 패턴이기 때문에 한페이지에 한번밖에 사용 불가능 한가?
										// -> 안되서 밑에 secondApp()에 똑같은 함수 구현
										cookiepolicy : 'single_host_origin',
										// 필요시 scope에서 다른걸로 가능
										// 참고 : https://developers.google.com/identity/sign-in/web/incremental-auth
										scope : 'profile'
									});
							// attachClickHandler 에서 성공시 onSuccess로 실피시 onFailure로 이동.
							auth2.attachClickHandler(document
									.getElementById('customBtn3'), {},
									onSuccess, onFailure);
						});
	};
	function forthApp() {
		gapi
				.load(
						'auth2',
						function() {
							auth2 = gapi.auth2
									.init({
										// client_id 는 ~~.apps.google~ 전까지 구글 개발자 콘솔의 개별 아이디!
										client_id : '559372757938-d5eg9qmoefkbp8sispf7c6fjg2lfnk6c.apps.googleusercontent.com',
										// 아마도 single_host_origin은 싱글톤 패턴이기 때문에 한페이지에 한번밖에 사용 불가능 한가?
										// -> 안되서 밑에 secondApp()에 똑같은 함수 구현
										cookiepolicy : 'single_host_origin',
										// 필요시 scope에서 다른걸로 가능
										// 참고 : https://developers.google.com/identity/sign-in/web/incremental-auth
										scope : 'profile'
									});
							// attachClickHandler 에서 성공시 onSuccess로 실피시 onFailure로 이동.
							auth2.attachClickHandler(document
									.getElementById('customBtn4'), {},
									onSuccess, onFailure);
						});
	};
	// 로그인 성공시
	var onSuccess = function(user) {
		// user에 구글로 로그인한 사용자가 들어옴.
		// getBasicProfile() 메소드로 .getName(), getEmail() 등 접근 가능
		var profile = user.getBasicProfile();
		alert(profile.getName());
		console.log('Singed in as ' + user.getBasicProfile().getName());
	}
	// 로그인 실패시
	var onFailure = function(error) {
		// 실패 시 오류페이지로 가는건 어떨까?
		console.log(error);
	}
</script>






<decorator:head />


</head>
<body>







	<!-- 공통 헤더 부분 시작.  -->
	<header style="height: 71px;">
		<div class="head">
			<h1 class="logo">
				<a href="/main.do"><img src="/resources/images/logoWork3.png"
					alt="로고" /></a>
			</h1>


			<div class="menu_box head_font">
				<ul class="menu" style="margin: 0;">

					<li><a href="#">카테고리</a>
						<ul class="menu_list">
							<li class="submenu"><a href="#">웹개발</a>
								<ul class="menu_sublist">
									<li><a href="#"> html </a></li>
									<li><a href="#"> jsp </a></li>
									<li><a href="#"> JavaScript </a></li>
									<li><a href="#"> Spring </a></li>
									<li><a href="#"> php </a></li>
								</ul></li>
							<li class="submenu"><a href="#">모바일개발</a>
								<ul class="menu_sublist">
									<li><a href="#"> 안드로이드 </a></li>
									<li><a href="#">iOS </a></li>
								</ul></li>

							<li class="submenu"><a href="#">시스템개발</a>

								<ul class="menu_sublist">
									<li><a href="#">java </a></li>
									<li><a href="#">C</a></li>
									<li><a href="#">C++</a></li>
									<li><a href="#">C#</a></li>
								</ul></li>
							<li class="submenu"><a href="#">IoT</a>
								<ul class="menu_sublist">
									<li><a href="#"> 아두이노 </a></li>
									<li><a href="#">라즈베리파이 </a></li>

								</ul></li>
						</ul></li>
					<li><a href="realreview.do">리얼후기</a></li>

				</ul>

			</div>

			<div class="login_box">

				<div class="menu">
					<ul class="menu_reg">


						<c:choose>
							<c:when test="${sessionScope.memberLoginBean==null}">
								<li onclick="openLoginModal();" style="cursor:pointer">로그인</li>
								<li onclick="openJoinModal();"style="cursor:pointer" >회원가입</li>
								<li style="width: 150px;"><a href="leaderIntro.do">리더로
										시작하기</a></li>
							</c:when>
							<c:otherwise>

								<c:if test="${sessionScope.code eq 'T'}">
									<li style="width: 150px;"><a href="personalInfoTeacher.do">
											${sessionScope.memberLoginBean.teacherName}님이 로그인중입니다.</a></li>
									<li><a id="logout" href="/logout.do"> 로그아웃</a></li>

								</c:if>


								<c:if test="${sessionScope.code eq 'C' }">
									<li style="width: 150px;"><a href="personalInfoCustomer.do">
											${sessionScope.memberLoginBean.customerName}님이 로그인중입니다.</a></li>
									<li><a id="logout" href="/logout.do"> 로그아웃</a></li>



								</c:if>
							</c:otherwise>
						</c:choose>



					</ul>
				</div>
			</div>

			<!-- Login Modal -->
			<div id="myLoginModal" class="modal">
				<!-- Modal content -->
				<div class="modal-content">
					<span class="closeLogin" onclick="closeLoginModal();">&times;</span>
					<br />

					<div id="customer-radio">
						<!-- 라디오 버튼 -->
						<input id="students" type="radio" name="customer" value="1" checked/>
						<input id="leaders" type="radio" name="customer"
							value="2" />
							 <label for="students">학생</label> <label for="leaders">리더</label>
					</div>






					<input type="email" class="inputLogin" id="customerIdM"
						placeholder="이메일을 입력하세요"> <input type="password"
						class="inputLogin" id="customerPwM" placeholder="암호">

					<button type="button" class="button button-navy" id="btnLoginM">로그인</button>
					<button class="button" onclick="closeLoginModal(); openJoinModal();">회원가입</button>
					<!-- 구글 로그인 연동1 -->
					<div id="customBtn" class="customGPlusSignIn" onclick="startApp();">
						<span class="icon"></span> <span class="buttonText">Google</span>
					</div>
					<!-- 네이버 로그인 API -->
					<div id="naver_id_login"></div>
					<!--  2017.05.26 네이버 로그인 추가 - 정홍의 -->
					<script type="text/javascript">
						var naver_id_login = new naver_id_login(
								"FIZpO6PTmY_KCqzmdq8c",
								"http://localhost:8181/naver_callback.jsp");
						var state = naver_id_login.getUniqState();
						naver_id_login.setButton("white", 2, 40);
						naver_id_login.setDomain("http://localhost:8181");
						naver_id_login.setState(state);
						naver_id_login.setPopup();
						naver_id_login.init_naver_id_login();
					</script>
				</div>

			</div>




			<div id="myJoinModal" class="modal">
				<div class="modal-content">
					<span class="closeJoin" onclick="closeJoinModal();">&times;</span>
					<div>
						<br />
						<!-- 구글 연동 2 -->
						<div id="customBtn2" class="customGPlusSignIn"
							onclick="secondApp();">
							<span class="icon"></span> <span class="buttonText">Google</span>
						</div>
						<!-- 네이버 로그인 API -->
						<div id="naver_id_login"></div>
						<h6 style="text-align: center;">
							<small> ──────────────── </small>또&nbsp;&nbsp;는<small>
								──────────────── </small>
						</h6>
						<form id="customerForm">
							<input type="text" class="inputLogin" placeholder="이름 입력"
								name="customerName" id="name" />
							<p style="font-size: 0.4em; color: #aaa;"></p>
							<input type="text" class=" inputLogin" placeholder="e-mail"
								name="customerId" id="email" onkeyup="checkEmail();"
								/>
							<p id="resultEmail" style="font-size: 0.4em; color: #aaa;"></p>

							<input type="password" class=" inputLogin" placeholder="비밀번호 입력 "
								name="customerPw" id="password" onkeyup="checkPassword();" />
							<p id="resultPass" style="font-size: 0.4em; color: #aaa;"></p>

							<input type="password" class=" inputLogin" id="password2"
								name="customerPw2" placeholder="비밀번호 확인"
								onkeyup="checkPasswordConfirm();" disabled />
							<p id="resultPass2" style="font-size: 0.4em; color: #aaa;"></p>

							<h5>
								<small>코:넥터의 이용약관과 개인정보 보호정책에 동의합니다.&nbsp; <input
									type="radio" name="check" value="1" id="agree" />동의
								</small>
							</h5>
							<button type="button" class="button button-orange"
								onclick="insertCustomer();return false;">가입완료</button>
							<h6>
								이미 더카니의 코딩세상의 회원이십니까&nbsp;&nbsp; <a
									onclick="closeJoinModal(); openLoginModal();">로그인</a>
							</h6>
						</form>

					</div>

				</div>
			</div>

		</div>



	</header>
	<!-- 공통 헤더 부분 끝.  -->


	<div>
		<decorator:body />
	</div>




	<footer>
		<div class="footerCss">

			<div class="footerContent">
				<div class="footerLogo clear_after">
					<img class="footerImg" src="/resources/images/logo_w2.png"> <br />
					<img class="footerTitle" src="/resources/images/logo_w_name.png"><br />
					<h5 style="color: #eee;">KOSTA 148기 FINAL PROJECT</h5>

				</div>


				<div class="footer_list clear_after">
					<div>
						<img style="width: 100px; margin: 10px auto;"
							src="/resources/images/footer_company.png"><br /> <a
							href="#"><p>서비스 안내</p></a>
					</div>

					<div>
						<img style="width: 100px; margin: 10px auto;"
							src="/resources/images/footer_support.png"><br /> <a
							href="#"><p>리더로 지원</p></a> <a href="#"><p>스터디 신청</p></a>

					</div>

					<div>
						<img style="width: 100px; margin: 10px auto;"
							src="/resources/images/footer_customer.png"><br /> <a
							href="#"><p>자주묻는 질문</p></a> <a href="#"><p>1 : 1 문의</p></a>
					</div>

				</div>
			</div>
		</div>

	</footer>







	<!-- Login Modal Script -->
	<script type="text/javascript">
		// Get the modal
		var modalLogin = document.getElementById("myLoginModal");
		var modalJoin = document.getElementById("myJoinModal");

		function openLoginModal() {

			modalLogin.style.display = "block";

		}

		function closeLoginModal() {
			modalLogin.style.display = "none";

		}

		function openJoinModal() {

			modalJoin.style.display = "block";

		}

		function closeJoinModal() {
			modalJoin.style.display = "none";

		}
		// 		var modalLogin = document.getElementById("myLoginModal");

		// 		// Get the button that opens the modal
		// 		var btnLogin = document.getElementById("loginLink");

		// 		// Get the <span> element that closes the modal
		// 		var spanLogin = document.getElementsByClassName("closeLogin")[0];

		// 		// When the user clicks on the button, open the modal 
		// 		btnLogin.onclick = function() {
		// 			modalLogin.style.display = "block";
		// 		}

		// 		// When the user clicks on <span> (x), close the modal
		// 		spanLogin.onclick = function() {
		// 			modalLogin.style.display = "none";
		// 		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modalLogin) {
				modalLogin.style.display = "none";
			}
			if (event.target == modalJoin) {
				modalJoin.style.display = "none";
			}
		}
	</script>


</body>
</html>
