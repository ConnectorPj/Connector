<!doctype html>
<html lang="ko">
<head>
<!-- <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script> -->
</head>
<body>
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("FIZpO6PTmY_KCqzmdq8c",
				"http://jhu1993.cafe24.com/naver_callback.jsp");
		
		alert(naver_id_login.oauthParams.access_token);
		
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		
		function naverSignInCallback() {
			alert(naver_id_login.getProfileData('email'));
			alert(naver_id_login.getProfileData('nickname'));
			alert(naver_id_login.getProfileData('age'));
		}
	</script>
</body>
</html>

