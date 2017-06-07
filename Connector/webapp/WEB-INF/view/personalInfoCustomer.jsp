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
<link type="text/css" href="/resources/css/payorderStyle.css"
	rel="stylesheet">
<head>
<title>개인정보</title>
<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#profileImg').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>

</head>
<body>

	<!--메인 -->
	<section>
		<div class="sub_wrap">
			<!-- 서브 네비 -->
			<div class="sub_nav">
				<div class="sub_menu">
					<ul>
						<li><a href="personalInfoCustomer.do" class="on">개인정보</a></li>
						<li><a href="payorder.do">수업 결제 내역</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li> >
							<li>개인정보</li>
						</ul>
					</div>
					<h2>개인정보</h2>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">

					<div class="profile_title">프로필 사진</div>

					<div class="profile_form">

						<div class="profilePhoto">
							<img id="profileImg" src="/resources/images/noImage.png"
								alt="your image" />

							<div class="profile_text">
								회원님의 정면 사진을 올려주세요!<br /> 상대방이 신뢰를 갖고 연락할 확률이 높아질 거예요!<br />
							</div>
							<input type='file' onchange="readURL(this);"
								class="upload_btn upload-hidden" />
						</div>
					</div>

					<div class="profile_title">계정 정보</div>
					<div class="info_form">
						<table class="info_table">
							<colgroup>
								<col width="30%">
								<col width="*">
							</colgroup>
							<tr>
								<td class="table_att">아이디</td>
								<td class="table_att2">aaaaaa@naver.com</td>
							</tr>
							<tr>
								<td class="table_att">이름</td>
								<td class="table_att2"><input type="text"
									placeholder=" 내용을 입력하세요"></td>
							</tr>
							<tr>
								<td class="table_att">성별</td>
								<td class="table_att2"><select>
										<option>남</option>
										<option>여</option>
								</select></td>
							</tr>
							<tr>
								<td class="table_att">휴대폰 번호</td>
								<td class="table_att2">010-1111-2222</td>
							</tr>
							<tr>
								<td class="table_att">소개</td>
								<td class="table_att2"><textarea cols="50" rows="10"
										style="resize: none;"></textarea></td>
							</tr>
							<tr>
								<td></td>
								<td><input type="button" class="table_btn" value="수정하기" />
								</td>
							</tr>

						</table>
					</div>

				</div>



			</div>
		</div>
	</section>
	<!--메인끝 -->

</body>
</html>