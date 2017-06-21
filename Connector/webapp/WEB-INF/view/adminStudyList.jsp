<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- bootstrap.css -->
<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">
<link type="text/css" href="/resources/css/adminPageCss.css"
	rel="stylesheet">
<title>Co:nnector-관리자</title>

<script type="text/javascript">
	$(function() {

		//등록된 수업
		$.ajax({
			type : "post",
			url : "/selectAdminClassListAjax.do",
			data : {
			//pageNo : "${param.pageNo}"
			},
			dataType : "json",
			success : function(data) {
				console.log(data);

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
									+ classBean.studyName
									+ "</td>";
									str += "<td>"
										+ classBean.teacherName
										+ "</td>";
							str += "<td><a href='adminRegClass.do?studyId="
									+ classBean.studyId
									+ "'><input type='button' class='reviewBtn' value='상세보기'/></a></td>";

							str += "</tr>";
						});
					$("#memberListBody2").append(str);

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
	$(function() {
		$.ajax({
			type : "post",
			url : "/selectAdminClassListAjax2.do",
			dataType : "json",
			success : function(data) {
				console.log(data);

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
									+ classBean.studyName
									+ "</td>";
									str += "<td>"
										+ classBean.teacherName
										+ "</td>";
							str += "<td><a href='adminRegClass.do?studyId="
									+ classBean.studyId
									+ "'><input type='button' class='reviewBtn' value='등록하기'/></a></td>";

							str += "</tr>";
						});
					$("#memberListBody").append(str);

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
</script>
<script type="text/javascript">
	function paging(click) {
		$.ajax({
			type : "POST",
			url : "/selectAdminClassListAjax.do",
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
										+ classBean.studyName
										+ "</td>";
										str += "<td>"
											+ classBean.teacherName
											+ "</td>";
								str += "<td><a href='adminRegClass.do?studyId="
										+ classBean.studyId
										+ "'><input type='button'class='reviewBtn' value='상세보기'/></a></td>";

								str += "</tr>";
							});
					$("#memberListBody2").html(str);

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

	function paging2(click) {
		$.ajax({
			type : "POST",
			url : "/selectAdminClassListAjax2.do",
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
									+ classBean.studyName
									+ "</td>";
							str += "<td>"
									+ classBean.teacherName
									+ "</td>";
							str += "<td><a href='adminRegClass.do?studyId="
									+ classBean.studyId
									+ "'><input type='button'class='reviewBtn' value='등록하기'/></a></td>";

							str += "</tr>";
						});
					$("#memberListBody").html(str);

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
						<li><a href="adminStudyList.do" class="on">스터디 목록 </a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li><a href="/main.do">홈</a></li> >
							<li><a href="/adminPage.do">관리자</a></li> >
							<li>스터디 목록</li>
						</ul>
					</div>
					<h2>스터디 목록</h2>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">
				<h4>등록할 클래스</h4>
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>강의목록</th>
									<th>강사 명</th>
									<th>등록하기</th>
								</tr>
							</thead>
							<tbody id="memberListBody">
							</tbody>
						</table>
					</div>


					<div id="page" class="page"></div>
				</div>

				<!-- 서브 내용 -->
				<div class="sub_content">
				<h4>등록된 클래스</h4>
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>강의목록</th>
									<th>강사 명</th>
									<th>등록하기</th>
								</tr>
							</thead>
							<tbody id="memberListBody2">
							</tbody>
						</table>
					</div>

					<div id="page2" class="page2"></div>
				</div>
			</div>
		</div>


	</section>
	<!--메인끝 -->

</body>
</html>