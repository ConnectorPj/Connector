<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css"
	href="/resources/bootstrap/css/bootstrap-theme.css" rel="stylesheet" />

<link type="text/css" href="/resources/css/paymentStyle.css"
	rel="stylesheet">

<title>payment</title>
</head>
<body>
	<section>

		<div id="section-left">
			<div id="title" style="margin-left: 5px">참가비 결제</div>
			<div id="scheduled amount"
				style="margin-left: 5px; margin-top: 30px; width: auto">
				<div id="amount">240,000 원</div>
				결제 예정 금액
			</div>
			<hr style="background-color: #999999; height: 1px; width: 96%;" />

			<div>
				<img class="image-wrap" src="/resources/images/image.jpg"
					style="width: 40px; height: 40px;" />
			</div>
			<div id="text-tail"></div>
			<div id="text">제가 참여 신청을 수락하는 경우에만 참여비가 결제됩니다. -강사</div>
		</div>

		<hr id="col1" />

		<div id="section-right">
			<div id="nicepay">
				<div id="nicepay-left">
					<img src="/resources/images/image.jpg" width="30px" /> &nbsp;
					NICEPAY
				</div>
				<div id="nicepay-right">NICEPAY에서 제공하는 안전 결제 서비스입니다. 결제 카드 정보는
					안전한 나이스페이 전자결제 서비스에 직접 등록되며, 코넥터 서버에 별도로 저장되지 않습니다.</div>
			</div>

			<div id="input-group">
				<div id="input">적립금 사용 &nbsp;&nbsp;&nbsp;</div>
				<input id="inputMoney" type="text" placeholder="0원"
					style="font-size: 14px; font-weight: 1;" />
				<div id="input-button">
					<button href="#" class="btn btn-primary btn-lg raised apply">적용하기</button>
				</div>
			</div>

			<div id="usable">
				<div id="usable-text">사용 가능 적립금:</div>
				<div id="money" style="color: deepskyblue">0원</div>
			</div>

			<hr id="row2" style="background-color: #999999; height: 1px;" />

			<div id="section-right">

				<div id="title1" style="maring-left: 40px; float: left;">결제 방법
				</div>

				<div id="div-card">
					<input id="card" type="radio" value="card" />&nbsp; 체크/신용카드
				</div>
			</div>

			<button href="applicationSuccess.do"
				class="btn btn-primary btn-lg raised end" style="margin-top: 70px;">다음으로</button>

		</div>

	</section>

</body>
</html>