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
<link type="text/css" href="/resources/css/adminPageCss.css"
	rel="stylesheet">

<head>
<title>관리자 페이지</title>

</head>
<body>
	<!--메인 -->
	<section>
		<div class="sub_wrap">
			<!-- 서브 네비 -->
			<div class="sub_nav">
				<div class="sub_menu">
					<ul>
						<li><a href="adminPage.do" class="on">관리자 홈</a></li>
						<li><a href="adminTeacherList.do">강사 관리</a></li>
						<li><a href="adminStudentList.do">회원 관리</a></li>
						<li><a href="adminRegClass.do">스터디 관리</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li> &gt;
							<li>관리자 메뉴</li>
						</ul>
					</div>
					<h2>관리자 메뉴</h2>
				</div>

				<!-- 서브 내용 -->

				<div class="adminPageMain">
					<div class="mainStudy">
					<button class="menuBtn" onclick="location.href='/adminTeacherList.do'">강사 관리</button>
					</div>
					<div class="mainStudy">
					<button class="menuBtn" onclick="location.href='/adminStudentList.do'">회원 관리</button>
					</div>
					<div class="mainStudy">
					<button class="menuBtn" onclick="location.href='/adminStudyList.do'">스터디 관리</button>
					</div>
				</div>

				<!-- 서브내용 끝. -->
			</div>
		</div>
	</section>
	<!--메인끝 -->

</body>
</html>