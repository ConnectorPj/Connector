<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- bootstrap.css -->
<link type="text/css"
	href="/resources/bootstrap/css/bootstrap-theme.css" rel="stylesheet" />
<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">
<link type="text/css" href="/resources/css/payorderStyle.css"
	rel="stylesheet">
<link type="text/css" href="/resources/css/adminPageCss.css"
	rel="stylesheet">
<title>수업 진행 내역</title>

<script type="text/javascript">
	$(function() {
		$.ajax({
					type : "post",
					url : "/selectTeacherListAjax.do",
					dataType : "json",
					success : function(data) {
						console.log(data);

						if (data.result == "ok") {
							var num = 1;
							//리스트 출력
							$
									.each(
											data.TeacherList,
											function(i, teacherBean) {
												var str = "";
												str += "<tr>";
												str += "<td>" + num++ + "</td>";
												str += "<td>"
														+ teacherBean.teacherName
														+ "</td>";
												str += "<td><a href='adminRegTeacherAjax.do?teacherId="
														+ teacherBean.teacherId
														+ '&memberId='
														+ teacherBean.teacherId
														+ "'><input type='button' value='등록하기'/></a></td>";
												str += "</tr>";

												$("#memberListBody")
														.append(str);
											});
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
						<li><a href="adminPage.do">관리자 홈</a></li>
						<li><a href="adminTeacherList.do" class="on">강사 목록</a></li>
						<li><a href="adminRegTeacherAjax.do">강사 등록</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li> >
							<li>관리자</li>>
							<li>강사 목록</li>
						</ul>
					</div>
					<h2>강사 목록</h2>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>강사 Name</th>
									<th>등록하기</th>
								</tr>
							</thead>
							<tbody id="memberListBody">
							</tbody>
						</table>
					</div>

					<div class="page">
						<ul>
							<li><a href="adminTeacherList.do?pageNo=1" class="on">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>


	</section>
	<!--메인끝 -->

</body>
</html>