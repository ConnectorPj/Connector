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
<title>수업 진행 내역</title>

<script type="text/javascript">
	$(function() {

		$
				.ajax({
					type : "post",
					url : "/selectClassAjax.do",
					dataType : "json",
					data : {
						teacherId : "${sessionScope.memberLoginBean.teacherId}"
					},
					success : function(data) {
						console.log(data);

						if (data.result == "ok") {

							var num = 1;
							//리스트 출력
							$
									.each(
											data.ClassList,
											function(i, classBean) {
												var str = "";
												str += "<tr>";
												str += "<td>" + num++ + "</td>";
												str += "<td>"
														+ classBean.studyId
														+ "</td>";
												str += "<td>"
														+ classBean.studyName
														+ "</td>";
												str += "<td>"
														+ classBean.studyProgramLanguage
														+ "</td>";
												str += "<td>"
														+ classBean.studyLocation
														+ "</td>";
												str += "<td><button type='button' onclick='openMemberModal("
														+ '"'
														+ classBean.studyId
														+ '"'
														+ ");'>신청자 보기</button></td>";
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
	$(function() {

		$.ajax({
			type : "post",
			url : "/selectClassAjax2.do",

			dataType : "json",
			data : {
				teacherId : "${sessionScope.memberLoginBean.teacherId}"
			},
			success : function(data) {
				console.log(data);

				if (data.result == "ok") {
					var num = 1;
					//리스트 출력
					$.each(data.ClassList, function(i, classBean) {
						var str = "";
						str += "<tr>";
						str += "<td>" + num++ + "</td>";
						str += "<td>" + classBean.studyId + "</td>";
						str += "<td>" + classBean.studyName + "</td>";
						str += "<td>" + classBean.studyProgramLanguage
								+ "</td>";
						str += "<td>" + classBean.studyLocation + "</td>";
						str += "<td>대기중</td>";
						str += "</tr>";

						$("#memberListBody").append(str);
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
						<li><a href="personalInfoTeacher.do">개인정보</a></li>
						<li><a href="classlist.do" class="on">수업 진행 내역</a></li>
						<c:if test="${sessionScope.memberLoginBean.teacherCheck eq '1' }">
							<li><a href="registerstudy.do">스터디 등록하기</a></li>
						</c:if>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li>
							<li>수업 진행 내역</li>
						</ul>
					</div>
					<h2>수업 진행 내역</h2>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="5%">
								<col width="5%">
								<col width="30%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>스터디 번호</th>
									<th>스터디 이름</th>
									<th>언어</th>
									<th>장소</th>
									<th>신청자 보기</th>
								</tr>
							</thead>
							</tbody>
							<tbody id="memberListBody">


							</tbody>
						</table>
					</div>


					<div class="page">
						<ul>
							<li><a href="#" class="on">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div id="studyModal" class="modal">
			<div class="modal-content-review">
				<span class="closeStudy" onclick="closeModal();">&times;</span>
				<div>
					<div>
						<h2>신청자 현황</h2>

						<h4 id="studyName"></h4>

						<table>
							<colgroup>
								<col width="5%">
								<col width="5%">
								<col width="30%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>신청자 이름</th>
									<th>스터디 이름</th>
									<th>언어</th>
									<th>장소</th>
									<th>신청자 보기</th>
								</tr>
							</thead>
							<tbody id="studyMemberList">
							</tbody>
						</table>





					</div>

				</div>
			</div>

		</div>

	</section>
	<!--메인끝 -->
	<script type="text/javascript">
		var modalStudy = document.getElementById("studyModal");

		function openMemberModal(bean) {
			var studyId = bean;
			$(function() {

				$
						.ajax({
							type : "post",
							url : "/selectStudyMember.do",
							dataType : "json",
							data : {
								studyId : studyId
							},
							success : function(data) {
								console.log(data);

								if (data.result == "ok") {
									$("#studyMemberList").empty();
									var num = 1;
									//리스트 출력
									$
											.each(
													data.CustomerList,
													function(i, customerBean) {
														var str = "";
														str += "<tr>";
														str += "<td>" + num++
																+ "</td>";
														str += "<td>"
																+ customerBean.customerName
																+ "</td>";
														str += "<td>"
																+ customerBean.customerId
																+ "</td>";
														str += "<td>"
																+ customerBean.customerGender
																+ "</td>";

														str += "<td><button type='button' onclick='insertStudyMember("
																+ '"'
																+ customerBean.customerId
																+ '"'
																+ ","
																+ '"'
																+ studyId
																+ '"'
																+ ");'>수락하기</button></td>";

														str += "</tr>";

														$("#studyMemberList")
																.append(str);
													});

								} else {
									alert(data.resultMsg);
								}
							},
							error : function(xhr, status, error) {
								console.log(xhr);
								alert("error\nxhr : " + xhr + ", status : "
										+ status + ", error : " + error);
							}
						});
			});
			$(function() {

				$
						.ajax({
							type : "post",
							url : "/selectStudyMember2.do",
							dataType : "json",
							data : {
								studyId : studyId
							},
							success : function(data) {
								console.log(data);

								if (data.result == "ok") {
									var num = 1;
									//리스트 출력
									$
											.each(
													data.CustomerList,
													function(i, customerBean) {
														var str = "";
														str += "<tr>";
														str += "<td>" + num++
																+ "</td>";
														str += "<td>"
																+ customerBean.customerName
																+ "</td>";
														str += "<td>"
																+ customerBean.customerId
																+ "</td>";
														str += "<td>"
																+ customerBean.customerGender
																+ "</td>";

														str += "<td>등록완료</td>";

														str += "</tr>";

														$("#studyMemberList")
																.append(str);
													});

								} else {
									alert(data.resultMsg);
								}
							},
							error : function(xhr, status, error) {
								console.log(xhr);
								alert("error\nxhr : " + xhr + ", status : "
										+ status + ", error : " + error);
							}
						});
			});
			modalStudy.style.display = "block";

		}

		// When the user clicks on <span> (x), close the modal

		function closeModal() {
			modalStudy.style.display = "none";
		}

		function insertStudyMember(customerId, studyId) {
			$(function() {

				$.ajax({
					type : "post",
					url : "/updateStudyMember.do",
					dataType : "json",
					data : {
						customerId : customerId,
						studyId : studyId
					},
					success : function(data) {
						console.log(data);

						if (data.result == "ok") {
			alert("수락 하셨습니다.")

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
		}
	</script>
</body>
</html>