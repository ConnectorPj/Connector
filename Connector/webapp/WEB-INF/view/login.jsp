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

<title>Insert title here</title>


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
	$(document).ready(

			function() {

				$("#btnLogin").click(
						function() {

							$.ajax({
								type : "post",
								url : "/CustomerloginProc.do",
								data : {
									customerId : $("#customerId").val(),
									customerPw : $("#customerPw").val()
								},
								dataType : "json",
								success : function(data) {
									console.log(data);

									if (data.result == "ok") {

										//android 호출
										try {
											var cusId = $("#customerId").val();
											window.JSInterface
													.updateAndToken(cusId);
										} catch (e) {
											console.log(e);
										}

										//로그인 성공
										location.href = "application.do?studyId="+ $("#studyId").val();
										return;
									} else {
										alert("로그인을 실패하였습니다.");
										$("#customerPw").focus();
									}

								},
								error : function(xhr, status, error) {
									console.log(xhr);
									alert("error\nxhr : " + xhr + ", status : "
											+ status + ", error : " + error);
								}
							});

						});

			});
</script>


</head>
<body>

	<c:if test="${result ne null && result eq 'fail'}">
		<script type="text/javascript">
			alert("로그인에 실패 하였습니다.");
		</script>
	</c:if>


<input type="hidden" id="studyId" value="${classBean.studyId}"/>

	<div style="background-color: #2c3d46; width: 100%; height: 300px;"></div>
	<div style="position: relative; top: -200px; margin: 0px auto 0px">
		<h1 style="color: #fff; text-align: center">${classBean.studyName}</h1>
		<br />
		<h4 style="color: #fff; text-align: center">에 신청하시려면 로그인이 필요합니다.</h4>
	</div>

	<div class="formDiv">
		<form>
			<input type="email" class="inputLogin" id="customerId"
				placeholder="이메일을 입력하세요" required> <input type="password"
				class="inputLogin" id="customerPw" placeholder="암호" required>
		</form>

		<button class="button button-navy" id="btnLogin">로그인</button>
		<a href="/join.do?studyId=${classBean.studyId}"><button
				class="button">회원가입</button></a>
		<!-- 구글 로그인 연동1 -->
		<div id="customBtn3" class="customGPlusSignIn" onclick="thirdApp();">
			<span class="icon" style="margin: 0;"></span> <span
				class="buttonText" style="padding-left: 10%;">Google</span>
		</div>
		<!-- 네이버 로그인 API -->
		<div id="naver_id_login"></div>
	</div>

</body>
</html>