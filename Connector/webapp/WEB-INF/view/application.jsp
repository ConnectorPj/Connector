<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" href="/resources/css/mainStyle.css"
	rel="stylesheet">

<link type="text/css" href="/resources/css/applicationStyle.css"
	rel="stylesheet" />

<title>application</title>

</head>
<body>

	<section>
		<div style="display: block;">
			<form id="purchaseForm">
				<input type="hidden" name="studyId" value="${classBean.studyId}">
				<input type="hidden" name="customerId" id="customerId">
				<div class="detail">
					<div class="detail-col1">
						<img
							src="${photoBean.photoFileName}"
							aria-hidden="true" style="width: 100px; height: 80px;" />

						<div>${classBean.studyStartDate}~${classBean.studyEndDate}</div>
					</div>
					<div class="detail-col2">
						<div>${classBean.studyName}</div>
					</div>
					<div class="detail-col3">
						<div>${classBean.studyStartTime}~${classBean.studyEndTime}</div>
					</div>
				</div>
				<hr />




				<div class="container-left">
					<div>${classBean.teacherName}님!</div>
					<div>제 스터디 준비를 도와주세요</div>
				</div>

				<div class="container-right">
					<div id="text">스터디를 신청한 목적은 무엇인가요?</div>
					<br />
					<div style="width: 100%; text-align: right;">
						<textarea class="inputContent" rows="3" placeholder="내용을 입력해주세요."
							style="resize: none; margin: 20px 0 20px;" name="customerContent"></textarea>
					</div>

					<div id="text1" class="arrow_box">스터디 안내를 드릴 연락처를 알려주세요!</div>
					<br />
					<div style="width: 100%; text-align: right;">

						<textarea class="inputContent" rows="3" placeholder="내용을 입력해주세요."
							style="resize: none; margin: 20px 0 20px;"
							name="customerCellPhone" required="required"></textarea>
					</div>

				</div>
			</form>

			<br />
			<div>
				<div id="section-left">
					<div id="title" style="margin-left: 5px">참가비 결제</div>
					<div id="scheduled amount"
						style="margin-left: 5px; margin-top: 30px; width: auto">
						<div id="amount">${classBean.studyPrice}원</div>
						결제 예정 금액
					</div>
					<hr style="background-color: #999999; height: 1px; width: 96%;" />

					<div id="textPay">제가 참여 신청을 수락하는 경우에만 참여비가 결제됩니다. -강사</div>
				</div>



				<hr id="row2" style="background-color: #999999; height: 1px;" />

				<div id="section-right">

					<div id="title1" style="maring-left: 40px; float: left;">결제
						방법</div>

					<div id="div-card">
						<input id="card" type="radio" value="card" />&nbsp; 체크/신용카드
					</div>
				</div>
				<button class="submitBtn" style="margin-top: 70px;" id="actionBtn"
					onclick="insertPurchase();">신청하기</button>
			</div>

		</div>
	</section>

	<script type="text/javascript">
		function insertPurchase() {
			var purchaseForm = document.getElementById("purchaseForm");
			purchaseForm.action = "/applicationProc.do";
			purchaseForm.method = "post";

			var customerId = $("#memberId").val();
			document.getElementById("customerId").value = customerId;
			purchaseForm.submit();
		}
	</script>
</body>
</html>
