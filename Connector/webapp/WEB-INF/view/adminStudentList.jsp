<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link type="text/css" href="/resources/css/payorderStyle.css"
	rel="stylesheet">
<head>
<title>수업 진행 내역</title>
<script type="text/javascript">
//회원정보 삭제
function delCustomer(customerId) {
	
	if( confirm("회원정보를 삭제 하시겠습니까?") ) {
		
		
		$.ajax({
			type: "post",
			url: "/deleteCustomer.do",
			data: { 
				customerId: customerId
			},
			dataType: "json",
			success: function(data) {
				console.log(data);
				
				if(data.result == "ok") {
					location.reload(); //새로고침
				} else {
					alert(data.resultMsg);
				}
				
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				alert("error\nxhr : " + xhr + ", status : " 
						+ status + ", error : " + error);      
			}
		});
	}
	
};
	
	$(function() {
		$.ajax({
			type: "post",
			url: "/selectCustomerListAjax.do",
			dataType: "json",
			success: function(data) {
				console.log(data);
				
				
				if(data.result == "ok") {
					var num=1;
					//리스트 출력
					$.each(data.CustomerList, function(i, customerBean) {
						var str = "";
						str += "<tr>";
						str += "<td>" + num++ + "</td>";
						str += "<td>" + customerBean.customerName + "</td>";
						str += "<td><button type='button' onclick=delCustomer('" 
							+ customerBean.customerId + "')>삭제</button></td>";
						str += "</tr>";

						$("#memberListBody").append(str);
					});
					
				} else {
					alert(data.resultMsg);
				}
			},
			error: function(xhr, status, error) {
				console.log(xhr);
				alert("error\nxhr : " + xhr + ", status : " 
						+ status + ", error : " + error);      
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
						<li><a href="adminStudentList.do" class="on">회원목록</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li> >
							<li>관리자</li>>
							<li>회원 목록</li>
						</ul>
					</div>
					<h2>회원 목록</h2>
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
									<th>회원 Name</th>
									<th>수정</th>
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


	</section>
	<!--메인끝 -->

</body>
</html>