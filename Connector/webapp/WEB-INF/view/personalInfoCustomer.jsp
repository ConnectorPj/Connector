<%@page import="com.test.web.common.bean.CustomerBean"%>
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
	$(function() {
		$.ajax({
			type : "post",
			url : "/photoSendAjax.do",
			dataType : "json",
			data : {
				memberId : "${sessionScope.memberLoginBean.customerId}",
				customerId : "${sessionScope.memberLoginBean.customerId}"
			},
			success : function(data) {
				console.log(data);

				if (data.result == "ok") {
					var pBean = data.pBean;
					var CusBean = data.CusBean;
					
					if(pBean != null){
						$("#profileImg").attr("src", pBean.photoFileName);
					}else{
						$("#profileImg").attr("src","/resources/images/noImage.png");
					}
					
					/* $("#viewId").attr("value", CusBean.customerId); */

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
	});

	function readURL(input) {

		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#profileImg').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	function writePhoto() {

		var formData = new FormData();

		formData.append("customerId", $("#customerId").val());
		formData.append("customerCellphone", $("#customerCellphone").val());
		formData.append("customerGender", $("#customerGender").val());
		formData.append("customerProfile", $("#customerProfile").val());
		formData.append("upFile", $("input[name=upFile]")[0].files[0]);

		$.ajax({
			url : 'customerInsertProcAjax.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(data) {

				alert(data.resultMsg);

				if (data.result == "ok") {
					//화면이동 처리
					location.href = 'main.do'
				}
			}
		});
	};
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
						<li><a href="payorder.do">마이 클래스</a></li>
						<li><a href="bucketList.do">마이 찜목록</a></li>
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
							<img id="profileImg" src="#" alt="your image" />

							<div class="profile_text">
								회원님의 정면 사진을 올려주세요!<br /> 상대방이 신뢰를 갖고 연락할 확률이 높아질 거예요!<br />
							</div>
							<input type='file' value="파일선택" onchange="readURL(this);" 
								class="upload_btn upload-hidden" name="upFile"  />
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
								<td class="table_att2" id="viewId">${sessionScope.memberLoginBean.customerId}<input
									id="customerId" name="customerId" type="hidden"
									value="${sessionScope.memberLoginBean.customerId}" /></td>
							</tr>
							<tr>
								<td class="table_att">이름</td>
								<td class="table_att2">${sessionScope.memberLoginBean.customerName}</td>
							</tr>
							<tr>
								<td class="table_att">성별</td>
								<td class="table_att2"><input type="radio"
									id="customerGender" name="customerGender" value="F"
									<c:if test="${fn:toUpperCase(sessionScope.memberLoginBean.customerGender) eq 'F'}">checked</c:if>>여자
									<input type="radio" id="customerGender" name="customerGender"
									value="M"
									<c:if test="${fn:toUpperCase(sessionScope.memberLoginBean.customerGender) eq 'M'}">checked</c:if>>남자

								</td>
							</tr>
							<tr>
								<td class="table_att">휴대폰 번호</td>
								<td class="table_att2"><input id="customerCellphone"
									type="text"
									value="${sessionScope.memberLoginBean.customerCellphone}"/></td>
							</tr>
							<tr>
								<td class="table_att">소개</td>
								<td class="table_att2"><textarea id="customerProfile"
										cols="50" rows="10" style="resize: none;">${sessionScope.memberLoginBean.customerProfile}</textarea></td>
							</tr>
							<tr>
								<td></td>
								<td><input type="button" class="table_btn" value="수정하기"
									onclick="writePhoto(); return false;" /></td>
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