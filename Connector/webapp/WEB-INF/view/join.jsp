<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Join-Co:nnector</title>
<style type="text/css">
.formDiv {
	width: 25%;
	margin: 0px auto 0px;
	background-color: #fff;
	position: relative;
	top: -150px;
	text-align: center;
	border: 1px solid #eaeaea;
	border-radius: 10px;
	padding: 10px;
}
</style>

<script type="text/javascript">
	// Modal Function
	function checkPasswordJSP() {

		var passwordJSP = document.getElementById("passwordJSP").value;
		var exptext = /^.*(?=.{6,15})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		if (exptext.test(passwordJSP) == false) {

			document.getElementById("resultPassJSP").textContent = "비밀번호 형식이 올바르지 않습니다.";
			document.getElementById("passwordJSP").focus();
			return false;

		} else {
			document.getElementById("resultPassJSP").textContent = "";

		}
		document.getElementById("password2JSP").disabled = false;

		return true;
	};

	function checkPasswordConfirmJSP() {
		if ($("#passwordJSP").val() == $("#password2JSP").val()) {
			document.getElementById("resultPass2JSP").textContent = "비밀번호가 일치합니다.";

			return true;

		} else {
			document.getElementById("resultPass2JSP").textContent = "비밀번호가 일치하지 않습니다.";

			return false;
		}
	};

	function checkEmailJSP() {
		var emailJSP = document.getElementById("emailJSP").value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (exptext.test(emailJSP) == false) {
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			document.getElementById("resultEmailJSP").textContent = "메일형식이 올바르지 않습니다.";
			document.getElementById("emailJSP").focus();
			return false;
		} else {
			document.getElementById("resultEmailJSP").textContent = "";
			return true;
		}
	};
    function customerCheckIdJSP(){
        
        $.ajax({
           url : '/customerCheckId.do',
           type : 'post',
           data : {
              "customerId": $("#emailJSP").val()   
           },
           success : function(data) {
              $("#resultEmailJSP").html(data.resultMsg);
              if(data.result=="ok"){
              }
           },
           error : function(error) {
              alert(error.statusText);
           }
        });
     };

	function insertCustomerJSP() {

		if ($("#nameJSP").val() == null || $("#nameJSP").val() == "") {

			document.getElementById("nameJSP").focus();

			$('#nameJSP').attr('placeholder', '이름을 입력하지 않으셨습니다.');

			return;

		} else if ($("#emailJSP").val() == null || $("#emailJSP").val() == ""
				|| !checkEmailJSP()) {
			document.getElementById("emailJSP").focus();
			$('#emailJSP').attr('placeholder', '메일을 올바르게 작성해주세요.');

			return;
		} else if ($("#passwordJSP").val() == null || $("#passwordJSP").val() == ""
				|| !checkPasswordConfirmJSP()) {
			document.getElementById("passwordJSP").focus();
			$('#passwordJSP').attr('placeholder', '비밀번호을 입력하지 않으셨습니다.');

			return;
		} else if ($(":input:radio[id='agreeJSP']:checked").val() != "1") {
			alert("개인정보 활용 제공에 동의해주세요.");
			return;

		} else {

			$.ajax({
				type : "post",
				url : "/insertCustomerProc.do",
				data : $("#customerFormJSP").serialize(),
				async : false,
				dataType : "json",
				success : function(data) {
					console.log(data);

					if (data.result == "ok") {
						alert(data.resultMsg);
						location.href="login.do?studyId="+$("#studyId").val();

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


</head>
<body>

<input type="hidden" id="studyId" value="${classBean.studyId}"/>


	<div style="background-color: #2c3d46; width: 100%; height: 300px;"></div>
	<div style="position: relative; top: -200px; margin: 0px auto 0px">
		<h1 style="color: #fff; text-align: center">${classBean.studyName}</h1>
		<br />
		<h4 style="color: #fff; text-align: center">에 신청하시려면 회원가입이 필요합니다.</h4>
	</div>

	<div class="formDiv">
		<form id="customerFormJSP" >
			<h3>10초만에 가입하기</h3>
			<!-- 구글 로그인 연동1 -->
			<div id="customBtn4" class="customGPlusSignIn" onclick="forthApp();">
				<span class="icon" style="margin: 0;"></span> <span
					class="buttonText" style="padding-left: 10%;">Google</span>
			</div>
			<!-- 네이버 로그인 API -->
			<div id="naver_id_login"></div>
			<h6 style="text-align: center;">
				<small> ──────────────── </small>또&nbsp;&nbsp;는<small>
					──────────────── </small>
			</h6>

			<input type="text" class="inputLogin" placeholder="이름 입력"
				name="customerName" id="nameJSP" /> <input type="text"
				class=" inputLogin" placeholder="e-mail" name="customerId" id="emailJSP"
				onkeyup="checkEmailJSP();"  />
			<p id="resultEmailJSP" style="font-size: 0.4em; color: #aaa;"></p>

			<input type="password" class=" inputLogin" placeholder="비밀번호 입력 "
				name="customerPw" id="passwordJSP" onkeyup="checkPasswordJSP();" />
			<p id="resultPassJSP" style="font-size: 0.4em; color: #aaa;"></p>

			<input type="password" class=" inputLogin" id="password2JSP"
			 placeholder="비밀번호 확인"
				onkeyup="checkPasswordConfirmJSP();" disabled />
			<p id="resultPass2JSP" style="font-size: 0.4em; color: #aaa;"></p>

			<h5>
				<small>코:넥터의 이용약관과 개인정보 보호정책에 동의합니다.&nbsp; <input
					type="radio" name="check" value="1" id="agreeJSP" />동의
				</small>
			</h5>
			<button type="button" class="button button-orange"
				onclick="insertCustomerJSP();return false;">가입완료</button>
			<h6>
				이미 더카니의 코딩세상의 회원이십니까&nbsp;&nbsp; <a href="/login.do?studyId=${classBean.studyId}">로그인</a>
			</h6>
		</form>


	</div>
</body>
</html>