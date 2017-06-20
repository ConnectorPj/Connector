<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("2cItRRVeC_dIOBAqHJDX",
				"http://jhu1993.cafe24.com/naver_callback.jsp");
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			// naver_id_login.getProfileData('프로필항목명');
			// 프로필 항목은 개발가이드를 참고하시기 바랍니다.
			// getProfileData는 네이버 API설정에서 상세 내역을 확인할 수가 있다. 
			//naver_id_login.getProfileData('Data') -> ex) email, nickname, age, gender ,name(개별설정 필요)
			var naver_user_id = naver_id_login.getProfileData('email');
			// 네이버 아이디를 비밀번호에 저장
			var naver_user_pw = naver_id_login.getProfileData('id');
			var naver_user_name = naver_id_login.getProfileData('name');
			
			
			$.ajax({
				type : "post",
				url : "/loginByNaver.do",
				data : {
					customerId : naver_user_id,
					customerPw : naver_user_pw,
					customerName : naver_user_name
				},
				dataType : "json",
				success : function(data) {
					if (data.result == "ok") {
						//android 호출
						try {
							var cusId = $("#customerIdM").val();
							window.JSInterface.updateAndToken(cusId);
						} catch (e) {
							console.log(e);
						}
						//로그인 성공
						//window.opener -> 팝업창을 부른 부모창 (여기선 main.do)
						window.opener.location.href="/main.do";
						window.close();
						return;
					} else {
						alert("로그인을 실패하였습니다.");
					}

				},
				error : function(xhr, status, error) {
					console.log(xhr);
					alert("error\nxhr : " + xhr

					+ ", status : " + status + ", error : " + error);
				}
			});
		}
	/* 	// 접근 토큰 값 출력
		alert(naver_id_login.oauthParams.access_token); */
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
	</script>
</body>
</html>

