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
							<!-- Indicators -->
							<ol class="carousel-indicators">
								<li data-target="#carousel-example-generic" data-slide-to="0"
									class="active"></li>
								<li data-target="#carousel-example-generic" data-slide-to="1"></li>
								<li data-target="#carousel-example-generic" data-slide-to="2"></li>
							</ol>

							<!-- Wrapper for slides -->
							<div class="carousel-inner" role="listbox">
								<div class="item active">
									<img src="/resources/images/main_visual01.jpg" alt="...">
									<div class="carousel-caption"></div>
								</div>
								<div class="item">
									<img src="/resources/images/main_visual02.jpg" alt="...">
									<div class="carousel-caption"></div>
								</div>
								<div class="item">
									<img src="/resources/images/main_visual03.jpg" alt="...">
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
									<td id="detailregion" class="detailregion">지역 : 신촌
										&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</td>
									<td id="num" class="num">인원 :</td>
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
							안녕하세요!<br> 뉴질랜드에서 온 이재우(Thomas)라고 합니다. 호주에서 초등학교에 다니고,
							뉴질랜드에서 중학교 고등학교에 다녔습니다. <br> 저는 뉴질랜드에서 학교에 다니고 호주에서 취업했던
							사람입니다! <br> 대학교 전공은 정치 철학과이었지만, 졸업을 하지 않고 좋은 일자리 기회가 생겨 호주에서
							가족사업에서 취직했습니다. <br> 호주와 뉴질랜드의 시골에서 살아서 한국인들과 어울릴 수 있는 경험이 많이
							없었지만, 대한민국 육군 통역병으로 생활하며 다양한 한국 문화를 경험했습니다.<br> 개인적으로 활동적인
							생활을 즐기고, 많은 hobby를 즐기고 있습니다.<br> 많은 경험과 취미를 가지고 있기 때문에 여러
							분야의 주제에 대해서 영어로 회화가 가능하답니다! <br>전에 뉴질랜드에 이민오신 분들에게 도움을 드리고자
							통역을 많이 해드렸고, 귀여운 교포 초등/중/고등학생들에게 영어 회화와 에세이 과외를 해준 경험이 많이 있습니다.<br>
							저에게는 스터디서치에서 진행하는 수업들이 단순히 영어를 가르치는 것을 목적으로 하지 않습니다. <br>
							영어를 배우고자하는 의지를 가진 분들과 영어와 조금 더 친근하게 가까워질 수 있는 환경에서 교류할 수 있다면 저에게
							정말 큰 보람이 될 것 같습니다.<br>
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