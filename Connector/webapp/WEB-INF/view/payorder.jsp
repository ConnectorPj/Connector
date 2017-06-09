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
					$.each(data.ClassList, function(i, classBean) {
						var str = "";
						str += "<tr>";
						str += "<td>" + num++ + "</td>";
						str += "<td>" + classBean.studyId + "</td>";
						str += "<td>" + classBean.studyName + "</td>";

						str += "<td><button type='button' onclick='openModal("
								+ classBean.studyId
								+ ");' class='reviewBtn'>후기쓰기</button></td>";
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
						<li><a href="personalInfoCustomer.do">개인정보</a></li>
						<li><a href="payorder.do" class="on">수업 결제 내역</a></li>
						<li><a href="busketList.do">마이 찜목록</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li> >
							<li>수업 결제 내역</li>
						</ul>
					</div>
					<h2>수업 결제 내역</h2>
				</div>



				<!-- 서브 내용 -->
				<div class="sub_content">
					<div class="notice_table">
						<table>
							<colgroup>
								<col width="5%">
								<col width="30%">
								<col width="20%">
								<col width="5%">
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>스터디 이름</th>
									<th>언어</th>
									<th>후기</th>
								</tr>
							</thead>
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

		<div id="myReviewModal" class="modal">
			<div class="modal-content-review">
				<span class="closeReview" onclick="closeModal();">&times;</span>
				<div>
					<div>
						<h2>리뷰 쓰기</h2>

						<h4 id="teacherName"> 
						</h4>
						<form id="reviewForm">

							<div>
								<fieldset class="rating">
									<input type="radio" id="star5" name="rating" value="5" /><label
										class="full" for="star5" title="Awesome - 5 stars"></label> <input
										type="radio" id="star4half" name="rating" value="4 and a half" /><label
										class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
									<input type="radio" id="star4" name="rating" value="4" /><label
										class="full" for="star4" title="Pretty good - 4 stars"></label>
									<input type="radio" id="star3half" name="rating"
										value="3 and a half" /><label class="half" for="star3half"
										title="Meh - 3.5 stars"></label> <input type="radio"
										id="star3" name="rating" value="3" /><label class="full"
										for="star3" title="Meh - 3 stars"></label> <input type="radio"
										id="star2half" name="rating" value="2 and a half" /><label
										class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
									<input type="radio" id="star2" name="rating" value="2" /><label
										class="full" for="star2" title="Kinda bad - 2 stars"></label>
									<input type="radio" id="star1half" name="rating"
										value="1 and a half" /><label class="half" for="star1half"
										title="Meh - 1.5 stars"></label> <input type="radio"
										id="star1" name="rating" value="1" /><label class="full"
										for="star1" title="Sucks big time - 1 star"></label> <input
										type="radio" id="starhalf" name="rating" value="half" /><label
										class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
								</fieldset>
							</div>


							<div>
								<textarea class="inputReview"></textarea>
							</div>
							<br />
							<div>
								<button class="btnReview">리뷰 쓰기</button>
							</div>
							<br /> <br />

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

				$.ajax({
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
							document.getElementById("teacherName").textContent=cBean.studyName+"강사님의스터디에 대한 평가를 해주세요!";
							
						} else {
							alert("외않되?");
						}
					},
					error : function(xhr, status, error) {
						console.log(xhr);
						alert("error\nxhr : " + xhr + ", status : " + status
								+ ", error : " + error);
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
		$(':radio').change(function() {
			$('.choice').text($(this).val() + ' stars');
		})
	</script>
</body>
</html>