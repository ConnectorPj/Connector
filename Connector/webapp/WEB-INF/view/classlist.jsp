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
<title>Co:nnector-개인정보</title>

<script type="text/javascript">
	$(function() {

		$.ajax({
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
					var str = "";
					var str2 = "";
					$.each(
						data.ClassList,
						function(i, classBean) {
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
							str += "<td><button type='button' class ='reviewBtn' onclick='openMemberModal("
									+ '"'
									+ classBean.studyId
									+ '"'
									+ ");'>신청자 보기</button></td>";
							str += "</tr>";

						});
					$("#memberListBody").append(str);

					var pBean = data.pBean;
					str2 += "<ul>";
					str2 += "<li><a href='#' onclick='paging(this);' id='1'><< </a></li>";
					if (pBean.groupNo > 1) {
						str2 += "<li><a href='#' onclick='paging(this);' id='"
								+ (pBean.pageStartNo - 1)
								+ "'> 이전 </a></li>";
					}
					for (var i = pBean.pageStartNo; i <= pBean.pageEndNo; i++) {
						if (pBean.pageNo != i) {
							str2 += "<li><a href='#' onclick='paging(this);' id='"
									+ i + "'>" + i + "</a></li>";
						} else {
							str2 += "<li><a class='on'>" + i
									+ "</a></li>";
						}
					}
					if (pBean.groupNo < pBean.totalGroupCount) {
						str2 += "<li><a href='#' onclick='paging(this);' id='"
								+ (pBean.pageEndNo + 1)
								+ "'> 다음 </a></li>";
					}
					str2 += "<li><a href='#' onclick='paging(this);' id='"
							+ pBean.totalPageCount + "'> >> </a></li>";
					str2 += "</ul>";

					$("#page").html(str2);
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
					var str = "";
					var str2 = "";
					$.each(data.ClassList, function(i, classBean) {
						str += "<tr>";
						str += "<td>" + num++ + "</td>";
						str += "<td>" + classBean.studyId + "</td>";
						str += "<td>" + classBean.studyName + "</td>";
						str += "<td>" + classBean.studyProgramLanguage
								+ "</td>";
						str += "<td>대기중</td>";
						str += "</tr>";
					});
					$("#memberListBody2").append(str);

					var pBean = data.pBean;
					str2 += "<ul>";
					str2 += "<li><a href='#' onclick='paging2(this);' id='1'><< </a></li>";
					if (pBean.groupNo > 1) {
						str2 += "<li><a href='#' onclick='paging2(this);' id='"
								+ (pBean.pageStartNo - 1)
								+ "'> < </a></li>";
					}
					for (var i = pBean.pageStartNo; i <= pBean.pageEndNo; i++) {
						if (pBean.pageNo != i) {
							str2 += "<li><a href='#' onclick='paging2(this);' id='"
									+ i + "'>" + i + "</a></li>";
						} else {
							str2 += "<li><a class='on'>" + i
									+ "</a></li>";
						}
					}
					if (pBean.groupNo < pBean.totalGroupCount) {
						str2 += "<li><a href='#' onclick='paging2(this);' id='"
								+ (pBean.pageEndNo + 1)
								+ "'> > </a></li>";
					}
					str2 += "<li><a href='#' onclick='paging2(this);' id='"
							+ pBean.totalPageCount + "'> >> </a></li>";
					str2 += "</ul>";

					$("#page2").html(str2);
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

<script type="text/javascript">
	function paging(click) {
		$.ajax({
			type : "POST",
			url : "/selectClassAjax.do",
			data : {
				pageNo : click.id,
			},
			datatype : "json",
			success : function(data) {
				if (data.result == "ok") {
					var num = 1;
					var str = "";
					var str2 = "";
					//리스트 출력
					$.each(
						data.ClassList,
						function(i, classBean) {
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
							str += "<td><button type='button' class ='reviewBtn' onclick='openMemberModal("
									+ '"'
									+ classBean.studyId
									+ '"'
									+ ");'>신청자 보기</button></td>";
							str += "</tr>";

						});
					$("#memberListBody").html(str);

					var pBean = data.pBean;
					str2 += "<ul>";
					str2 += "<li><a href='#' onclick='paging(this);' id='1'><< </a></li>";
					if (pBean.groupNo > 1) {
						str2 += "<li><a href='#' onclick='paging(this);' id='"
								+ (pBean.pageStartNo - 1)
								+ "'> < </a></li>";
					}
					for (var i = pBean.pageStartNo; i <= pBean.pageEndNo; i++) {
						if (pBean.pageNo != i) {
							str2 += "<li><a href='#' onclick='paging(this);' id='"
									+ i + "'>" + i + "</a></li>";
						} else {
							str2 += "<li><a class='on'>" + i
									+ "</a></li>";
						}
					}
					if (pBean.groupNo < pBean.totalGroupCount) {
						str2 += "<li><a href='#' onclick='paging(this);' id='"
								+ (pBean.pageEndNo + 1)
								+ "'> > </a></li>";
					}
					str2 += "<li><a href='#' onclick='paging(this);' id='"
							+ pBean.totalPageCount + "'> >> </a></li>";
					str2 += "</ul>";

					$("#page").html(str2);

				} else {
					alert(data.resultMsg);
				}
			},
			error : function(xhr, status, error) {
				console.log(xhr);
				alert("error\nxhr : " + xhr + ", status : " + status
						+ ", error : " + error);
			}
		}); // end of ajax 모달화면뿌리기 
	};

	function paging2(click) {
		$.ajax({
			type : "POST",
			url : "/selectClassAjax2.do",
			data : {
				pageNo : click.id,
			},
			datatype : "json",
			success : function(data) {
				if (data.result == "ok") {
					var num = 1;
					var str = "";
					var str2 = "";
					//리스트 출력
					$.each(data.ClassList, function(i, classBean) {
						str += "<tr>";
						str += "<td>" + num++ + "</td>";
						str += "<td>" + classBean.studyId + "</td>";
						str += "<td>" + classBean.studyName + "</td>";
						str += "<td>" + classBean.studyProgramLanguage
								+ "</td>";
						str += "<td>대기중</td>";
						str += "</tr>";
					});
					$("#memberListBody2").html(str);

					var pBean = data.pBean;
					str2 += "<ul>";
					str2 += "<li><a href='#' onclick='paging2(this);' id='1'><< </a></li>";
					if (pBean.groupNo > 1) {
						str2 += "<li><a href='#' onclick='paging2(this);' id='"
								+ (pBean.pageStartNo - 1)
								+ "'> < </a></li>";
					}
					for (var i = pBean.pageStartNo; i <= pBean.pageEndNo; i++) {
						if (pBean.pageNo != i) {
							str2 += "<li><a href='#' onclick='paging2(this);' id='"
									+ i + "'>" + i + "</a></li>";
						} else {
							str2 += "<li><a class='on'>" + i
									+ "</a></li>";
						}
					}
					if (pBean.groupNo < pBean.totalGroupCount) {
						str2 += "<li><a href='#' onclick='paging2(this);' id='"
								+ (pBean.pageEndNo + 1)
								+ "'> > </a></li>";
					}
					str2 += "<li><a href='#' onclick='paging2(this);' id='"
							+ pBean.totalPageCount + "'> >> </a></li>";
					str2 += "</ul>";

					$("#page2").html(str2);

				} else {
					alert(data.resultMsg);
				}
			},
			error : function(xhr, status, error) {
				console.log(xhr);
				alert("error\nxhr : " + xhr + ", status : " + status
						+ ", error : " + error);
			}
		}); // end of ajax 모달화면뿌리기 
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
						<li><a href="personalInfoTeacher.do">개인정보</a></li>
						<li><a href="classlist.do" class="on">수업 진행 내역</a></li>
						<c:if test="${sessionScope.memberLoginBean.teacherCheck eq '1' }">
							<li><a href="registerstudy.do">스터디 등록하기</a></li>
						</c:if>
					</ul>
				</div>
				
				<div class="sub_menu2">
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
							<li>홈</li> > 
							<li>수업 진행 내역</li>
						</ul>
					</div>
					<h2>수업 진행 내역</h2>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">
				<h4>등록된 클래스</h4>
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="20%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>스터디 번호</th>
									<th>스터디 이름</th>
									<th>언어</th>
									<th>신청자 보기</th>
								</tr>
							</thead>
							</tbody>
							<tbody id="memberListBody">
							</tbody>
						</table>
					</div>


					<div id="page" class="page"></div>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">
				<h4>대기중 클래스</h4>
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="20%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>스터디 번호</th>
									<th>스터디 이름</th>
									<th>언어</th>
									<th>신청자 보기</th>
								</tr>
							</thead>
							</tbody>
							<tbody id="memberListBody2">
							</tbody>
						</table>
					</div>


					<div id="page2" class="page2"></div>
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
						<div class="sub_content_Modal">
							<div class="notice_table_Modal">
								<table style="text-align: center;">
									<colgroup>
										<col width="5%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr style="text-align: center;">
											<th>No.</th>
											<th>이름</th>
											<th>아이디</th>
											<th>성별</th>
											<th>등록</th>
										</tr>
									</thead>
									<tbody id="studyMemberList">
									</tbody>
								</table>



							</div>
						</div>
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

				$.ajax({
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
							$.each(
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

									str += "<td><button type='button' class='reviewBtn' onclick='insertStudyMember("
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

				$.ajax({
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
							$.each(data.CustomerList,
									function(i, customerBean) {
										var str = "";
										str += "<tr>";
										str += "<td>" + num++ + "</td>";
										str += "<td>"
												+ customerBean.customerName
												+ "</td>";
										str += "<td>" + customerBean.customerId
												+ "</td>";
										str += "<td>"
												+ customerBean.customerGender
												+ "</td>";

										str += "<td>등록완료</td>";

										str += "</tr>";

										$("#studyMemberList").append(str);
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
							alert("수락 하셨습니다.");
							closeModal();

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