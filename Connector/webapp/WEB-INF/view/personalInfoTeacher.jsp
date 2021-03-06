<%@page import="com.test.web.common.bean.TeacherBean"%>
<%@page import="org.springframework.web.multipart.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html >
<html>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">
<link type="text/css" href="/resources/css/payorderStyle.css"
	rel="stylesheet">



<script>
	$(function() {
		$.ajax({
			type : "post",
			url : "/photoTeacherRecAjax.do",
			dataType : "json",
			data : {
				memberId : "${sessionScope.memberLoginBean.teacherId}",
				teacherId : "${sessionScope.memberLoginBean.teacherId}"
			},
			success : function(data) {
				console.log(data);

				if (data.result == "ok") {
					var pBean = data.pBean;
					var teaBean = data.teaBean;

					if (pBean != null) {
						$("#profileImg").attr("src", pBean.photoFileName);
					} else {
						$("#profileImg").attr("src",
								"/resources/images/noImage.png");
					}

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
	$(document)
		.ready(
			function() {
				var fileTarget = $('.filebox .upload-hidden');

				fileTarget.on('change', function() {
					if (window.FileReader) {
						// 파일명 추출
						var filename = $(this)[0].files[0].name;
					} else {
						// Old IE 파일명 추출
						var filename = $(this).val().split('/').pop()
								.split('\\').pop();
					}

					$(this).siblings('.upload-name').val(filename);
				});

				//preview image 
				var imgTarget = $('.profilePhoto .upload-hidden');

				imgTarget.on(
					'change',
					function() {
						var parent = $(this).parent();
						//parent.children('.upload-display').remove();

						if (window.FileReader) {
							//image 파일만
							if (!$(this)[0].files[0].type
									.match(/image\//))
								return;

							var reader = new FileReader();
							reader.onload = function(e) {
								//var src = e.target.result;
								$('#profileImg').attr(
										'src',
										e.target.result);
								//parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="' + src + '" class="upload-thumb"></div></div>');
							}
							reader
									.readAsDataURL($(this)[0].files[0]);
						} else {
							$(this)[0].select();
							$(this)[0].blur();
							var imgSrc = document.selection
									.createRange().text;
							//parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

							var img = $(this).siblings(
									'.profilePhoto').find(
									'img');
							img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
									+ imgSrc + "\")";
						}
					});
			});

	function writePhoto() {

		var teacherForm = document.getElementById("teacherForm");
		teacherForm.action = "/teacherInsertProcAjax.do";
		console.log(teacherForm.method);
		teacherForm.method = "post";

		teacherForm.submit();

	};
</script>

<head>
<title>Co:nnector-개인정보</title>

</head>
<body>

	<!--메인 -->
	<section>
		<div class="sub_wrap">
			<!-- 서브 네비 -->
			<div class="sub_nav">
				<div class="sub_menu">
					<ul>
						<li><a href="personalInfoTeacher.do" class="on">개인정보</a></li>
						<li><a href="classlist.do">수업 진행 내역</a></li>
						<c:if test="${sessionScope.memberLoginBean.teacherCheck eq '1' }">
							<li><a href="registerstudy.do">스터디 등록하기</a></li>
						</c:if>
					</ul>
				</div>
				
				<div class="sub_menu2">
					<ul>
						<li><a href="personalInfoTeacher.do" class="on">개인정보</a></li>
						<li><a href="classlist.do">수업 진행 내역</a></li>
						<c:if test="${sessionScope.memberLoginBean.teacherCheck eq '1' }">
							<li><a href="registerstudy.do">스터디 등록하기</a></li>
						</c:if>
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
					<form id="teacherForm" method="post" enctype="multipart/form-data">
						<div class="profile_title">프로필 사진</div>

						<div class="profile_form">

							<div class="profilePhoto filebox">
								<img id="profileImg" src="#" alt="your image" />

								<div class="profile_text">
									회원님의 정면 사진을 올려주세요!<br /> 상대방이 신뢰를 갖고 연락할 확률이 높아질 거예요!<br />
								</div>

								<div class="subdiv">
									<input class="upload-name" value="파일선택" disabled="disabled">
									<label for="input-file">업로드</label> <input type="file"
										name="file1" id="input-file" class="upload-hidden ">
								</div>
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
									<td class="table_att2">${sessionScope.memberLoginBean.teacherId}<input
										id="teacherId" name="teacherId" type="hidden"
										value="${sessionScope.memberLoginBean.teacherId}" /></td>
								</tr>
								<tr>
									<td class="table_att">이름</td>
									<td class="table_att2">${sessionScope.memberLoginBean.teacherName}</td>
								</tr>
								<tr>
									<td class="table_att">성별</td>
									<td class="table_att2"><input type="radio"
										id="teacherGender" name="teacherGender" value="F"
										<c:if test="${fn:toUpperCase(sessionScope.memberLoginBean.teacherGender) eq 'F'}">checked</c:if>>여자
										<input type="radio" id="teacherGender" name="teacherGender"
										value="M"
										<c:if test="${fn:toUpperCase(sessionScope.memberLoginBean.teacherGender) eq 'M'}">checked</c:if>>남자

									</td>
								</tr>
								<tr>
									<td class="table_att">휴대폰 번호</td>
									<td class="table_att2"><input id="teacherCellphone" name="teacherCellphone" class="inputPersonalInfo"
										type="text"
										value="${sessionScope.memberLoginBean.teacherCellphone}" /></td>
								</tr>
								<tr>
									<td class="table_att">소개</td>
									<td class="table_att2"><textarea id="teacherInfo" name="teacherInfo" class="inputPersonalInfo"
											cols="50" rows="10" style="resize: none; height: 85%; width:80%;">${sessionScope.memberLoginBean.teacherInfo}</textarea></td>
								</tr>
								<tr>
									<td></td>
									<td><input type="button" class="table_btn" value="수정하기"
										onclick="writePhoto(); return false;" /></td>
								</tr>

							</table>
						</div>
					</form>
				</div>



			</div>
		</div>
	</section>
	<!--메인끝 -->

</body>
</html>