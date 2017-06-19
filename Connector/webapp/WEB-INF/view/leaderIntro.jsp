<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<title>Document</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="/resources/css/leaderIntro.css" rel="stylesheet"
	type="text/css">

<!-- <style>

</style> -->


<script type="text/javascript">
	// Modal Function
	function checkinputJoinpassword() {

		var inputJoinpassword = document.getElementById("inputJoinpassword").value;
		var exptext = /^.*(?=.{6,15})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		if (exptext.test(inputJoinpassword) == false) {

			document.getElementById("resultinputJoinpasswordconfirm").textContent = "비밀번호 형식이 올바르지 않습니다.";
			document.getElementById("inputJoinpassword").focus();
			return false;

		} else {
			document.getElementById("resultinputJoinpasswordconfirm").textContent = "";
			document.getElementById("inputJoinpasswordconfirm").disabled = false;

			return true;

		}
	};

	function checkinputJoinpasswordconfirm() {
		if ($("#inputJoinpassword").val() == $("#inputJoinpasswordconfirm")
				.val()) {
			document.getElementById("resultinputJoinpasswordconfirm").textContent = "비밀번호가 일치합니다.";

			return true;

		} else {
			document.getElementById("resultinputJoinpasswordconfirm").textContent = "비밀번호가 일치하지 않습니다.";

			return false;
		}
	};

	function checkinputJoinEmail() {
		var inputJoinEmail = document.getElementById("inputJoinEmail").value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (exptext.test(inputJoinEmail) == false) {
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			document.getElementById("resultinputJoinEmail").textContent = "메일형식이 올바르지 않습니다.";
			document.getElementById("inputJoinEmail").focus();
			return false;
		} else {
			document.getElementById("resultinputJoinEmail").textContent = "";
			return true;
		}
	};

	function teacherCheckIdJSP() {

		$.ajax({
			url : '/teacherCheckId.do',
			type : 'post',
			data : {
				"teacherId" : $("#inputJoinEmail").val()
			},
			success : function(data) {
				$("#resultinputJoinEmail").html(data.resultMsg);
			},
			error : function(error) {
				alert(error.statusText);
			}
		});
	};

	function insertTeacher() {

		if ($("#inputJoinName").val() == null
				|| $("#inputJoinName").val() == "") {
			document.getElementById("inputJoinName").focus();
			$('#inputJoinName').attr('placeholder', '이름을 입력하지 않으셨습니다.');
			return;
		}

		else if ($("#inputJoinEmail").val() == null
				|| $("#inputJoinEmail").val() == "" || !checkinputJoinEmail()) {
			document.getElementById("inputJoinEmail").focus();
			$('#inputJoinEmail').attr('placeholder', '메일을 올바르게 작성해주세요.');
			return;
		}

		else if ($("#inputJoinpassword").val() == null
				|| $("#inputJoinpassword").val() == ""
				|| !checkinputJoinpasswordconfirm()) {
			document.getElementById("inputJoinpassword").focus();
			$('#inputJoinpassword').attr('placeholder', '비밀번호을 입력하지 않으셨습니다.');
			return;
		}

		else if ($("#inputJoinCareer").val() == null
				|| $("#inputJoinCareer").val() == "") {
			document.getElementById("inputJoinCareer").focus();
			$('#inputJoinCareer').attr('placeholder', '경력을 입력하세요.');
			return;
		}

		else if ($("#inputJoinRegistration").val() == null
				|| $("#inputJoinRegistration").val() == "") {
			document.getElementById("inputJoinRegistration").focus();
			$('#inputJoinRegistration').attr('placeholder',
					'주민등록번호 앞자리를 입력하세요.');
			return;
		}

		else if ($("#inputJoinPhone").val() == null
				|| $("#inputJoinPhone").val() == "") {
			document.getElementById("inputJoinPhone").focus();
			$('#inputJoinPhone').attr('placeholder', '핸드폰 번호를  입력하세요.');
			return;
		}

		else if ($(":input:radio[id='inputGender']:checked").val() != "F"
				&& $(":input:radio[id='inputGender2']:checked").val() != "M") {
			alert("성별을 선택해주세요.");
			return;
		}

		else if ($(":input:radio[id='agreeJSP2']:checked").val() != "1") {
			alert("개인정보 활용 제공에 동의해주세요.");
			return;
		}

		else {

			$.ajax({
				type : "post",
				url : "/insertTeacherProc.do",
				data : $("#teacherFormJSP").serialize(),
				async : false,
				dataType : "json",
				success : function(data) {
					console.log(data);

					if (data.result == "ok") {
						alert(data.resultMsg);
						location.replace("/main.do");

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
	}
</script>

</head>



<body>

	<section>

		<div class="to">
			<h4 style="padding: 150px 0 0 15%; color: #fff; font-size: 2em;">코:넥터의
				리더가되어</h4>
			<h4 style="margin: 0 0 10px 15%; color: #fff; font-size: 2em;">코딩의
				즐거움을 선사하세요!</h4>
			<button class="btn_study2" id="btn2">Apply Now</button>
		</div>

		<div class="service">
			<div class="service_list">


				<br />
				<div class="bo">
					<h2>코:넥터 리더의 장점</h2>
				</div>

				<div class="about">

					<div class="about_fi">
						<article>
							<div class="about_img">
								<img src="/resources/images/leader1.png" alt="service01" />
							</div>
							<h4>다양한 지원</h4>
							<p>
								내가 편한 지역, 편한 시간에<br /> 스터디를 개설해 안정적인 부수입을<br /> 확보할 수 있습니다.<br />
							</p>
						</article>
					</div>

					<div class="about_se">
						<article>
							<div class="about_img2">
								<img src="/resources/images/leader2.png" alt="service02" />
							</div>
							<h4>안정적인 부수입</h4>
							<p>
								학생들과의 유쾌한 교류에만 집중하세요.<br /> 스터디원 모집 및 장소 예약<br /> 유용한 팁 등을지원해
								드립니다. <br />
							</p>
						</article>
					</div>

					<div class="about_sa">
						<article>
							<div class="about_img3">
								<img src="/resources/images/leader3.png" alt="service03" />
							</div>
							<h4>프로그래밍 언어 감 유지</h4>
							<p>
								다양한 사람들과 교류하며<br /> 프로그래밍 실력을 유지할 수 있습니다.<br />
							</p>
						</article>
					</div>

				</div>


				<br /> <br /> <br />


				<div class="sec-leader">
					<div class="sec-leader-img1">
						<img src="/resources/images/leader4.png" alt="service04" />
					</div>
					<div class="sec-leader-img2">
						<h3 style="text-align: center">리더와 함께하는 코:넥터</h3>
						<h4>
							먼저 리더 지원서를 확인 및 작성해 주세요.<br />개설 가능한 지역 및 시간대에 대해<br> 7일
							이내로 안내를 드리겠습니다!<br /> <br />7일 이후에도 메일이 오지 않는다면<br />
							developer.connector@gmail.com 으로 연락주세요.
						</h4>
					</div>
				</div>

				<br /> <br />
				<br />
				<br />
				<br />
				<br />

				<div class="sec-leader2">
					<div class="sec-leader2-img1">
						<h2>지금 바로 리더 신청하기</h2>
						<br />
						<button class="btn_study3" id="btn3">APPLY NOW</button>
					</div>
					<div class="sec-leader2-img2">
						<img src="/resources/images/leader5.png" alt="sercive05" />
					</div>
				</div>
			</div>
		</div>


	</section>
	<div id="myJoinModal2" class="modal">

		<div class="modal-content">
			<span class="closeJoin2">&times;</span>
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
					<small> ─────────── </small>또&nbsp;&nbsp;는<small>
						─────────── </small>
				</h6>
				<form id="teacherFormJSP">
					<div style="text-align: center;">
						<input type="text" class="form-control" name="teacherName"
							id="inputJoinName" placeholder="이름" /><br /> <input
							type="email" class="form-control" name="teacherId"
							id="inputJoinEmail" onkeyup="checkinputJoinEmail()"
							placeholder="이메일" />
						<p id="resultinputJoinEmail"
							style="font-size: 0.4em; color: #aaa;"></p>

						<input type="password" name="teacherPw" id="inputJoinpassword"
							onkeyup="checkinputJoinpassword()" class="form-control input-sm"
							placeholder="비밀번호">
						<p id="resultinputJoinpassword"
							style="font-size: 0.4em; color: #aaa;">

							<input type="password" name="password_confirmation"
								onkeyup="checkinputJoinpasswordconfirm()"
								id="inputJoinpasswordconfirm" class="form-control input-sm"
								placeholder="비밀번호 확인"><br /> <br /> <br /> <br />
						<p id="resultinputJoinpasswordconfirm"
							style="font-size: 0.4em; color: #aaa;"></p>

						<input type="text" class="form-control" name="teacherCareer"
							id="inputJoinCareer" placeholder="경력" /><br /> <input
							type="text" class="form-control" name="teacherBirthnum"
							id="inputJoinRegistration" placeholder="주민등록번호 앞자리" /><br /> <input
							type="text" class="form-control" name="teacherCellphone"
							id="inputJoinPhone" placeholder="핸드폰번호" /><br /> <input
							type="radio" id="inputGender" name="teacherGender" value="F">여자
						&nbsp;&nbsp;&nbsp; <input type="radio" id="inputGender2"
							name="teacherGender" value="M">남자
					</div>



				</form>
				<h6 style="text-align: center;">
					<small>더코세의 이용약관과 개인정보 보호정책에 동의합니다.&nbsp;&nbsp;&nbsp;<input
						type="radio" name="cho" id="agreeJSP2" value="1" /></small>
				</h6>

				<button type="button" class="button button-orange"
					onclick="insertTeacher();">가입 완료</button>
			</div>

		</div>
	</div>

	<!-- Login Modal Script -->
	<script type="text/javascript">
		// Get the modal
		var modalJoin2 = document.getElementById("myJoinModal2");

		// Get the button that opens the modal
		var btnJoin2 = document.getElementById("btn2");
		var btnJoin3 = document.getElementById("btn3");

		// Get the <span> element that closes the modal
		var spanJoin2 = document.getElementsByClassName("closeJoin2")[0];

		// When the user clicks on the button, open the modal 
		btnJoin2.onclick = function() {
			modalJoin2.style.display = "block";
		}
		btnJoin3.onclick = function() {
			modalJoin2.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		spanJoin2.onclick = function() {
			modalJoin2.style.display = "none";
		}
	</script>


</body>

</html>