<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
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

.inputForm {
	margin-bottom: 3px;
}
</style>
<script type="text/javascript">
		

function insertCustomer() {
	

	
	$.ajax({
		type: "post",
		url: "/insertCustomerProc.do",
		data: $("#customerForm").serialize(),
		dataType: "json",
		success: function(data) {
			console.log(data);
			
			if(data.result == "ok") {
				alert(data.resultMsg);
				location.replace("/login.do");
				return;
			} else {
				alert(data.resultMsg);
			}
			
		},
		error: function(xhr, status, error) {
			console.log(xhr);
			alert("error\nxhr : " + xhr + ", status : " 
					+ status + ", error : " + error);      
		}
	});
	
};
		</script>
</head>
<body>
	


	<div style="background-color: #2c3d46; width: 100%; height: 300px;"></div>
	<div style="position: relative; top: -200px; margin: 0px auto 0px">
		<h1 style="color: #fff; text-align: center">더카니와 함께하는 씨샵!</h1>
		<br />
		<h4 style="color: #fff; text-align: center">에 신청하시려면 로그인이 필요합니다.</h4>
	</div>

	<div class="formDiv">
		<form id="customerForm" enctype="multipart/form-data">
			<h3>10초만에 가입하기</h3>
			<!-- 구글 로그인 연동1 -->
			<div id="customBtn4" class="customGPlusSignIn" onclick="forthApp();">
				<span class="icon" style="margin: 0;"></span> <span class="buttonText" style="padding-left: 10%;">Google</span>
			</div>
			<!-- 네이버 로그인 API -->
			<div id="naver_id_login"></div>
			<h6 style="text-align: center;">
				<small> ──────────────── </small>또&nbsp;&nbsp;는<small>
					──────────────── </small>
			</h6>

			<input type="text" class="form-control inputForm" placeholder="이름 입력"
				name="customerName"required> 
				
				<input type="email"	class="form-control inputForm" placeholder="e-mail"
				name="customerId"required> 
				
				<input type="password" class="form-control inputForm" placeholder="비밀번호 입력 " name="customerPw"required> 
				
				<input type="password" class="form-control inputForm" id="joinInputPassword2"
				placeholder="비밀번호 확인"required>

			<h5>
				<small>코:넥터의 이용약관과 개인정보 보호정책에 동의합니다.&nbsp; <input
					type="radio" name="check" value="동의">동의
				</small>
			</h5>
			<button type="button" class="button button-orange"
				onclick="insertCustomer(); return false;">가입완료</button>
			<h6>
				이미 더카니의 코딩세상의 회원이십니까&nbsp;&nbsp; <a href="/login.do">로그인</a>
			</h6>
		</form>


	</div>
</body>
</html>