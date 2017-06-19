<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- bootstrap.css -->
<link rel="stylesheet"
	href="/resources/font-awesome/css/font-awesome.min.css">

<link type="text/css"
	href="/resources/bootstrap/css/bootstrap-theme.css" rel="stylesheet" />

<link type="text/css" href="/resources/css/reviewModal.css"
	rel="stylesheet" />
<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">
<link type="text/css" href="/resources/css/payorderStyle.css"
	rel="stylesheet">
<title>수업 결제 내역</title>


<script type="text/javascript">
	$(function() {

		$.ajax({
			type : "post",
			url : "/selectCustomerPurchaseList.do",
			dataType : "json",
			data : {
				customerId : "${sessionScope.memberLoginBean.customerId}"
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
		                str += "<td>" + classBean.studyName + "</td>";
		                str += "<td>" + classBean.studyProgramLanguage + "</td>";
		                str += "<td>" + classBean.teacherName + "</td>";
		                str += "<td><button type='button' onclick='openModal("+'"'
		                	+ classBean.studyId +'"'
		                    + ");' class='reviewBtn'>후기쓰기</button></td>";
		                str += "</tr>";
					});
					$("#memberListBody").append(str);

					var pBean = data.pBean;
					str2 += "<ul>";
					str2 += "<li><a href='#' onclick='paging(this);' id='1'>처음 </a></li>";
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
							+ pBean.totalPageCount + "'> 끝 </a></li>";
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

		$.ajax({
			type : "post",
			url : "/selectCustomerPurchaseList2.do",
			dataType : "json",
			data : {
				customerId : "${sessionScope.memberLoginBean.customerId}"
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
										+ classBean.studyName
										+ "</td>";
								str += "<td>"
										+ classBean.studyProgramLanguage
										+ "</td>";
								str += "<td>"
										+ classBean.teacherName
										+ "</td>";
								str += "<td>대기중</td>";
								str += "</tr>";
							});
					$("#memberListBody2").append(str);

					var pBean = data.pBean;
					str2 += "<ul>";
					str2 += "<li><a href='#' onclick='paging2(this);' id='1'>처음 </a></li>";
					if (pBean.groupNo > 1) {
						str2 += "<li><a href='#' onclick='paging2(this);' id='"
								+ (pBean.pageStartNo - 1)
								+ "'> 이전 </a></li>";
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
								+ "'> 다음 </a></li>";
					}
					str2 += "<li><a href='#' onclick='paging2(this);' id='"
							+ pBean.totalPageCount + "'> 끝 </a></li>";
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

	function btnReviewWrite() {

		var formData = new FormData();

		var reviewRating = document.getElementById("reviewRating").value;
		var reviewContent = document.getElementById("reviewContent").value;
		var teacherName = document.getElementById("teacherName").value;
		var teacherId = document.getElementById("teacherId").value;
		var studyId = document.getElementById("studyId").value;
		var studyProgramLanguage = document
				.getElementById("studyProgramLanguage").value;

		formData.append("reviewRating", reviewRating);
		formData.append("reviewContent", reviewContent);
		formData.append("teacherName", teacherName);
		formData.append("teacherId", teacherId);
		formData.append("studyId", studyId);
		formData.append("studyProgramlanguage", studyProgramLanguage);

		$.ajax({
			url : '/realReviewInsertProc.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(data) {

				alert(data.resultMsg);

				if (data.result == "ok") {
					//화면이동 처리
				} else {
					alert(data.resultMsg);
				}

			},
			error : function() {
				alert("리뷰 작성 성공");
			}
		});

	};//end function
</script>

<script type="text/javascript">
	function paging(click) {
		$
				.ajax({
					type : "POST",
					url : "/selectCustomerPurchaseList.do",
					data : {
						pageNo : click.id,
						customerId : "${sessionScope.memberLoginBean.customerId}"
					},
					datatype : "json",
					success : function(data) {
						if (data.result == "ok") {
							var num = 1;
							var str = "";
							var str2 = "";
							//리스트 출력
							$
									.each(
											data.ClassList,
											function(i, classBean) {
												str += "<tr>";
												str += "<td>" + num++ + "</td>";
												str += "<td>"
														+ classBean.studyName
														+ "</td>";
												str += "<td>"
														+ classBean.studyProgramLanguage
														+ "</td>";
												str += "<td>"
														+ classBean.teacherName
														+ "</td>";
												str += "<td><button type='button' onclick='openModal("
														+ '"'
														+ classBean.studyId
														+ '"'
														+ ");' class='reviewBtn'>후기쓰기</button></td>";
												str += "</tr>";
											});
							$("#memberListBody").html(str);

							var pBean = data.pBean;
							str2 += "<ul>";
							str2 += "<li><a href='#' onclick='paging(this);' id='1'>처음 </a></li>";
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
									+ pBean.totalPageCount + "'> 끝 </a></li>";
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
		$
				.ajax({
					type : "POST",
					url : "/selectCustomerPurchaseList2.do",
					data : {
						pageNo : click.id,
						customerId : "${sessionScope.memberLoginBean.customerId}"
					},
					datatype : "json",
					success : function(data) {
						if (data.result == "ok") {
							var num = 1;
							var str = "";
							var str2 = "";
							//리스트 출력
							$
									.each(
											data.ClassList,
											function(i, classBean) {
												str += "<tr>";
												str += "<td>" + num++ + "</td>";
												str += "<td>"
														+ classBean.studyName
														+ "</td>";
												str += "<td>"
														+ classBean.studyProgramLanguage
														+ "</td>";
												str += "<td>"
														+ classBean.teacherName
														+ "</td>";
												str += "<td>대기중</td>";
												str += "</tr>";
											});
							$("#memberListBody2").html(str);

							var pBean = data.pBean;
							str2 += "<ul>";
							str2 += "<li><a href='#' onclick='paging2(this);' id='1'>처음 </a></li>";
							if (pBean.groupNo > 1) {
								str2 += "<li><a href='#' onclick='paging2(this);' id='"
										+ (pBean.pageStartNo - 1)
										+ "'> 이전 </a></li>";
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
										+ "'> 다음 </a></li>";
							}
							str2 += "<li><a href='#' onclick='paging2(this);' id='"
									+ pBean.totalPageCount + "'> 끝 </a></li>";
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
						<li><a href="personalInfoCustomer.do">개인정보</a></li>
						<li><a href="payorder.do" class="on">마이 클래스</a></li>
						<li><a href="bucketList.do">마이 찜목록</a></li>
					</ul>
				</div>

				<div class="sub_menu2">
					<ul>
						<li><a href="personalInfoCustomer.do">개인정보</a></li>
						<li><a href="payorder.do" class="on">마이 클래스</a></li>
						<li><a href="bucketList.do">마이 찜목록</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li> >
							<li>수업 결제 내역</li>
						</ul>
					</div>
					<h2>마이 클래스</h2>
				</div>



				<!-- 서브 내용 -->
				<div class="sub_content">
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="5%">
								<col width="30%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>스터디 이름</th>
									<th>언어</th>
									<th>강사</th>
									<th>후기쓰기</th>
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
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="5%">
								<col width="30%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>스터디 이름</th>
									<th>언어</th>
									<th>강사</th>
									<th>후기쓰기</th>
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

		<div id="myReviewModal" class="modal">
			<div class="modal-content-review">
				<span class="closeReview" onclick="closeModal();">&times;</span>
				<div>
					<div>
						<h2>리뷰 쓰기</h2>

						<h4 id="studyResult"></h4>
						<form method="post" id="reviewForm">

							<div>
								<fieldset class="rating" id="rating">
									<input type="radio" id="star5" name="rating" value="5" /> <label
										class="full" for="star5" title="Awesome - 5 stars"></label> <input
										type="radio" id="star4" name="rating" value="4" /> <label
										class="full" for="star4" title="Pretty good - 4 stars"></label>
									<input type="radio" id="star3" name="rating" value="3" /> <label
										class="full" for="star3" title="Meh - 3 stars"></label> <input
										type="radio" id="star2" name="rating" value="2" /> <label
										class="full" for="star2" title="Kinda bad - 2 stars"></label>
									<input type="radio" id="star1" name="rating" value="1" /> <label
										class="full" for="star1" title="Sucks big time - 1 star"></label>
								</fieldset>
							</div>


							<div>
								<textarea class="inputReview" id="reviewContent"></textarea>
							</div>
							<br />
							<div>
								<button class="btnReview" onclick="btnReviewWrite()">리뷰
									쓰기</button>
							</div>
							<br /> <br /> <input type="hidden" id="reviewRating"
								name="reviewRating" /> <input type="hidden" id="teacherId"
								name="teacherId" /> <input type="hidden" id="studyId"
								name="studyId" /> <input type="hidden" id="teacherName"
								name="teacherName" /> <input type="hidden"
								id="studyProgramLanguage" name="studyProgramLanguage" />

						</form>

					</div>

				</div>
			</div>

		</div>

	</section>
	<!--메인끝 -->

	<!-- Review Modal -->
	<script type="text/javascript">
		var modalReview = document.getElementById("myReviewModal");
		function openModal(bean) {

			$(function() {

				$
						.ajax({
							type : "post",
							url : "/selectClass.do",
							dataType : "json",
							data : {
								studyId : bean
							},
							success : function(data) {
								console.log(data);

								if (data.result == "ok") {
									var cBean = data.classBean;
									document.getElementById("studyId").value = cBean.studyId;
									document.getElementById("teacherId").value = cBean.teacherId;
									document.getElementById("teacherName").value = cBean.teacherName;
									document
											.getElementById("studyProgramLanguage").value = cBean.studyProgramLanguage;
									document.getElementById("studyResult").textContent = cBean.teacherName
											+ "강사님의스터디에 대한 평가를 해주세요!";

								} else {
								}
							},
							error : function(xhr, status, error) {
								console.log(xhr);
								alert("error\nxhr : " + xhr + ", status : "
										+ status + ", error : " + error);
							}
						});
			});
			modalReview.style.display = "block";

		}

		// When the user clicks on <span> (x), close the modal

		function closeModal() {
			modalReview.style.display = "none";
		}
	</script>

	<script type="text/javascript">
		$(':radio')
				.change(
						function() {
							var reviewRating = $(this).val();
							document.getElementById("reviewRating").value = parseInt(reviewRating);
						})
	</script>
</body>
</html>