<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	function delBucket(studyId) {

		if (confirm("선택하신 수업을 찜목록에서 삭제 하시겠습니까?")) {

			$.ajax({
				type : "post",
				url : "/deleteBucket.do",
				data : {
					customerId : "${sessionScope.memberLoginBean.customerId}",
					studyId : studyId
				},
				dataType : "json",
				success : function(data) {
					console.log(data);

					if (data.result == "ok") {
						location.reload(); //새로고침
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
		}
	};

	$(function() {

		$.ajax({
			type : "post",
			url : "/selectBucketClassAjax.do",
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
									+ classBean.studyLanguage
									+ "</td>";
							str += "<td>"
									+ classBean.teacherName
									+ "</td>";
							str += "<td><img src='/resources/images/like.png' class='imgLike' onclick=delBucket("
									+ '"'
									+ classBean.studyId
									+ '"' + ")></td>";
							str += "</tr>";

						});
					$("#memberListBody").append(str);

					// 페이징
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
		});
	});
</script>

<script type="text/javascript">
	function paging(click) {
		$.ajax({
			type : "POST",
			url : "/selectBucketClassAjax.do",
			data : {
				customerId : "${sessionScope.memberLoginBean.customerId}",
				pageNo : click.id
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
									+ classBean.studyLanguage
									+ "</td>";
							str += "<td>"
									+ classBean.teacherName
									+ "</td>";
							str += "<td><img src='/resources/images/like.png' class='imgLike' onclick=delBucket("
									+ '"'
									+ classBean.studyId
									+ '"' + ")></td>";
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
						<li><a href="payorder.do">마이 클래스</a></li>
						<li><a href="bucketList.do" class="on">마이 찜목록</a></li>
					</ul>
				</div>

				<div class="sub_menu2">
					<ul>
						<li><a href="personalInfoCustomer.do">개인정보</a></li>
						<li><a href="payorder.do">마이 클래스</a></li>
						<li><a href="bucketList.do" class="on">마이 찜목록</a></li>
					</ul>
				</div>
				<div class="sub_title">
					<div class="rout">
						<ul>
							<li>홈</li>>
							<li>마이 찜목록</li>
						</ul>
					</div>
					<h2>마이 찜목록</h2>
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
									<th>좋아요취소</th>
								</tr>
							</thead>
							<tbody id="memberListBody">

							</tbody>
						</table>
					</div>

					<div id="page" class="page"></div>
				</div>
			</div>
		</div>


	</section>
	<!--메인끝 -->

</body>
</html>