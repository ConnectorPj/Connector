
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- bootstrap.css -->
<link type="text/css"
	href="/resources/bootstrap/css/bootstrap-theme.css" rel="stylesheet" />
<link type="text/css" href="/resources/bootstrap/css/bootstrap.css"
	rel="stylesheet" />
<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">

<!-- jquery.js -->
<script type="text/javascript"
	src="/resources/js/common/jquery/jquery-3.2.1.js"></script>

<!-- bootstrap.js -->
<script type="text/javascript"
	src="/resources/bootstrap/js/bootstrap.js"></script>

<title>Main</title>

<style type="text/css">
html, body {
	font-family: 'Noto Sans KR', sans-serif, dotum, '돋움', gulim, '굴림', Arial,
		AppleGothic, verdana, helvetica;
	font-size: 14px;
	letter-spacing: -0.05em;
	line-height: 1.6;
	font-weight: 400;
	color: #333;
	margin: 0;
	overflow-x: hidden;
	!
	important;
}

a {
	color: #333333;
	text-decoration: none;
}

a:link {
	color: #333333;
	text-decoration: none;
	transition: all .3s ease
}

a:visited {
	color: #333333;
	text-decoration: none
}

a:active {
	color: #333333;
	text-decoration: none
}

a:hover {
	color: #666666;
	text-decoration: none
}
</style>

</head>
<body>
	<section>
		<!-- main 맨위의 슬라이드 화면  -->
		<div id="myCarousel" class="carousel slide main_visual"
			data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<a href="#"><span class="first-slide visual01"></span></a>
				</div>

				<div class="item">
					<a href="#"><span class="first-slide visual02"></span></a>
				</div>

				<div class="item">
					<a href="#"><span class="first-slide visual03"></span></a>
				</div>
			</div>

			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>

		<!-- 분야별 -->
		<div class="classType">
			<h2 class="title">분야별</h2>
			<div class="title_hr"></div>
			
			<div class="classType_box">
				<a href="#"> <img src="/resources/images/Main_Img1.jpg"
					alt="classType01" />
					<div class="img_text">
						<p>#웹 개발</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="#"> <img src="/resources/images/Main_Img2.jpg"
					alt="classType02" />
					<div class="img_text">
						<p>#모바일 개발</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="#"> <img src="/resources/images/Main_Img3.jpg"
					alt="classType03" />
					<div class="img_text">
						<p>#시스템 개발</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="#"> <img src="/resources/images/Main_Img4.jpg"
					alt="classType04" />
					<div class="img_text">
						<p>#IOT</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="#"> <img src="/resources/images/Main_Img5.jpg"
					alt="classType05" />
					<div class="img_text">
						<p>#전체보기</p>
					</div>
				</a>
			</div>

			<div class="classType_box">
				<a href="#"> <img src="/resources/images/Main_Img6.jpg"
					alt="classType06" />
					<div class="img_text">
						<p>#리얼후기</p>
					</div>
				</a>
			</div>

		</div>
		<!-- PICK -->
		<div class="pick">

			<h2 class="title">PICK</h2>
			<div class="title_hr"></div>

			<div class="pick_box">

				<!--  클래스 시간 별로 8개를 출력한다. -->
				<c:forEach var="classBean" items="${classList}" varStatus="status"
					begin="0" end="8">

					<div class="card hovercard"
						OnClick="location.href='/detail.do?studyNo=${classBean.studyNo}'">
						<div class="cardheader"
							style="background-image: url('../resources/images/image.jpg')"></div>
						<div class="avatar">
							<img alt="" src="/resources/images/img.jpg">
						</div>
						<div class="info">
							<div class="title">${classBean.studyName}</div>
							<div class="desc">${classBean.studyPrice}</div>
							<div class="desc">${classBean.studyStartDate}~</div>
							<div class="desc">${classBean.studyEndDate}</div>
						</div>
					</div>
					
				</c:forEach>
			</div>

		</div>

	</section>


</body>
</html>