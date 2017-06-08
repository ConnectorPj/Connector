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
<link href="/resources/css/classDetail.css" rel="stylesheet"
	type="text/css" />
<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">
<link type="text/css" href="/resources/css/adminPageCss.css"
	rel="stylesheet">
<head>
<title>관리자 강좌 등록 페이지</title>

</head>
<body>
	<!--메인 -->
	<section>
		<div class="sub_wrap">
			<!-- 서브 네비 -->
			<div class="sub_nav">
				<div class="sub_menu">
					<ul>
						<li><a href="adminPage.do">관리자 홈</a></li>
						<li><a href="adminStudyList.do">스터디 목록 </a></li>
						<li><a href="adminRegClass.do" class="on">스터디 등록</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>관리자</li> >
							<li>스터디 목록</li> >
							<li>스터디 등록</li>
						</ul>
					</div>
					<h2>스터디 등록</h2>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">

					<div id="title">
						<div id="carousel-example-generic" class="carousel slide"
							data-ride="carousel">

							<!-- Wrapper for slides -->
							<div class="carousel-inner" role="listbox">
								<div class="item active">
									<img src="/resources/images/main_visual01.jpg" alt="...">
									<div class="carousel-caption"></div>
								</div>
							</div>

						</div>


						<div id="region" class="region">${bean.studyArea}<br>
						</div>

						<div id="title" class="title">${bean.studyName}</div>

					</div>
					<hr />
					<!-- end of title -->
					<div id="studyintro">
						<div id="studyTitle" class="studyTitle">스터디 소개</div>
						<div id="StudyContent" class="StudyContent">
							${bean.studyInfo}</div>
						<hr />
					</div>
					<!-- end of studyintro -->

					<div id="detail">
						<div id="detailTitle" class="detailTitle">상세정보</div>
						<div id="detailContent class="detailContent">
							<table>
								<tr>
									<td id="detailregion" class="detailregion">지역 :  ${bean.studyLocation}
										&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</td>
									<td id="num" class="num">인원 : ${bean.studyAmount}</td>
								</tr>

								<tr>
									<td id="schedule" class="schedule">일정
										:${bean.studyInfo}&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</td>
									<td class="fee">가격 : ${bean.studyPrice}</td>
								</tr>
								<tr>
									<td id="time" class="time">시간 : ${bean.studyTime}</td>
								</tr>
							</table>
						</div>
					</div>
					<hr />
					<br>
					<!-- end of detail -->

					<div id="leaderintro">
						<div id="leaderTitle" class="leaderTitle">
							리더 소개 <img class="profile">
						</div>
						<div id="leaderContent" class="leaderContent">
							${teacherBean.teacherInfo}
						</div>
					</div>
					<br>
					<hr />
					<!-- end of leaderintro -->



					<div class="Reg1">
						<input type="button" class="table_btnRegIn1" value="등록하기" />
					</div>
					<div class="Reg1">
						<input type="button" class="table_btnRegDe1" value="삭제하기" />
					</div>

				</div>



			</div>
		</div>
	</section>
	<!--메인끝 -->

</body>
</html>