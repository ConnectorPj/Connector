<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Co:nnector-리얼후기</title>

<link href="/resources/css/realReview.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/mainStyle.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/review/review.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript">

//전역 변수
// 전체 리뷰의 갯수
var reviewListTotCount = 0;
// 현재 startRow 값
var reviewStartRow = 0;
var isReviewLoading = false;
var currentProgressname = "";
var isReviewLoadingFirst = true;
var isScrollLoading = true;

$(function() {
	
	$.ajax({
		type : "post",
		url : "/realReviewProc.do",
		data : {
			studyProgressname: "웹개발"
		},
		dataType : "json",
		success : function(data) {
			printLog(data);

			if (data.result == "ok") {
				
				if(isReviewLoadingFirst) {
					showReviewList("웹개발");
					isReviewLoadingFirst = false;
				}
				$("#reviewCountWeb").text(" ("+data.reviewListAll.length+")");
				
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
		url : "/realReviewProc.do",
		data : {
			studyProgressname: "모바일개발"
		},
		dataType : "json",
		success : function(data) {
			printLog(data);

			if (data.result == "ok") {
				$("#reviewCountMobile").text(" ("+data.reviewListAll.length+")");
				
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
		url : "/realReviewProc.do",
		data : {
			studyProgressname: "시스템개발"
		},
		dataType : "json",
		success : function(data) {
			printLog(data);

			if (data.result == "ok") {
				$("#reviewCountSystem").text(" ("+data.reviewListAll.length+")");
				
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
		url : "/realReviewProc.do",
		data : {
			studyProgressname: "IoT"
		},
		dataType : "json",
		success : function(data) {
			printLog(data);

			if (data.result == "ok") {
				$("#reviewCountIoT").text(" ("+data.reviewListAll.length+")");
				
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
	
	//윈도우 스크롤의 마지막을 감지하는 이벤트
	$(window).scroll(function() { 
		var scrollTop = $(window).scrollTop();
		var docHeight = $(document).height();
		var winHeight = $(window).height();
		
		printLog("scrollTop: " + scrollTop 
				+ ", docHeight: " + docHeight
				+ ", winHeight: " + winHeight);
		
		if (($(window).scrollTop() >= $(document).height() - $(window).height() - 20) && isScrollLoading)
		{ 
			showNextReviewList();
			isScrollLoading = false;
		}
	});
});

function showReviewList(studyProgressname) {
	
	for (var x = 0; x < 4; x++) {
		$(".selectLevel").css("color", "#787878");
		$(".selectLevel").css("border-left", "none");
		$(".selectLevel").css("padding-left", "24px");
		$(".selectLevel").css("background", "white");
		$(".selectLevel").css("text-decoration", "none");
	}
	
	var x = document.getElementById(studyProgressname);
	x.style.paddingLeft = "20px";
	x.style.borderLeft = "4px solid #2c3d46";
	x.style.background = "#f8f8f8";
	x.style.color = "#2c3d46"; 

	$("#realReviewInfo").html("");
	reviewListTotCount = 0;
	
	$.ajax({
		type : "post",
		url : "/realReviewProc.do",
		data : {
			studyProgressname: studyProgressname
		},
		dataType : "json",
		success : function(data) {
			printLog(data);

			if (data.result == "ok") {
				currentProgressname = studyProgressname;
				
				//후기
				$("#reviewListTitle").text(studyProgressname + " 후기" + " ( " + data.reviewListAll.length + " )");
				
				//리뷰 리스트 출력
				$.each(data.reviewList, function(i, rBean) {
					
					if(rBean.customerPicture == null) {
						rBean.customerPicture = "/resources/images/userIcon.png";
					}
					
					if(rBean.teacherPicture == null) {
						rBean.teacherPicture = "/resources/images/userIcon.png";
					}
					
					var str = "";
					str += '<ul class="reviewList">';
					str += '<li class="review">';
					str += '<div class="writerPhoto"><img src="'+ rBean.customerPicture +'"></div>';
					str += '<div class="reviewContentWrap">';
					str += '<div class="writerName">'+ rBean.customerName +'<span class="writtenAt">'+ rBean.reviewRegdate +'</span></div>';
					str += '<ul class="score">';
					
					for(var j = 1; j <= 5; j++){
						
						if(j <= rBean.reviewRating) {
							str += '<li class="star"><img src="/resources/images/staron.png"></li>';
							
						}else {
							str += '<li class="star"><img src="/resources/images/staroff.png"></li>';
						}
					}
					
					str += '</ul>';
					str += '<div class="reviewContent"><span class="reviewLevel">'+ rBean.studyProgramlanguage +'</span>';
					str += '<span>'+ rBean.reviewContent +'</span></div>';
					str += '<div class="reviewContentFooter">';
					str += '<a class="leader" href="/detail.do?studyId='+ rBean.studyId +'">'
					str += '<span class="leaderName">'+ rBean.teacherName +'<img src="'+ rBean.teacherPicture +'"></span>';
                    str += '</a>';
                    str += '</div>';
                    str += '</div>';
                    str += '</li>';
                    str += '</ul>';
                    str += '<hr>';
                    
					$("#realReviewInfo").append(str);
				});

				//더 보기 버튼에 대한 처리
				reviewListTotCount = data.reviewListAll.length;
				reviewStartRow = data.reviewList.length;
				
				if( data.reviewListAll.length > data.reviewList.length ) {
					//리뷰 더보기 버튼 화면에 표시
					$("#moreReviewList").show();
					
				} else{
					$("#moreReviewList").hide();
				}

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
};

//다음 리뷰 리스트를 표시한다.
function showNextReviewList() {
	
	if( reviewListTotCount <= reviewStartRow && isReviewLoading) {
		return;
	}
	
	//알고 있어야 되는 정보
	//전체 리뷰의 갯수
	//현재 startRow 를 알고 있어야 한다.
	
	isReviewLoading = true;
	
	$.ajax({
		type: "post",
		url: "/realReviewProc.do",
		data: {
			studyProgressname: currentProgressname,
			startRow : reviewStartRow
		},
		dataType: "json",
		success: function(data) {
			printLog(data);
			
			if(data.result == "ok") {
				//리뷰 리스트 출력
				$.each(data.reviewList, function(i, rBean) {
					
					if(rBean.customerPicture == null) {
						rBean.customerPicture = "/resources/images/userIcon.png";
					}
					
					if(rBean.teacherPicture == null) {
						rBean.teacherPicture = "/resources/images/userIcon.png";
					}
					
					var str = "";
					str += '<ul class="reviewList">';
					str += '<li class="review">';
					str += '<div class="writerPhoto"><img src="'+ rBean.customerPicture +'"></div>';
					str += '<div class="reviewContentWrap">';
					str += '<div class="writerName">'+ rBean.customerName +'<span class="writtenAt">'+ rBean.reviewRegdate +'</span></div>';
					str += '<ul class="score">';
					
					for(var j = 1; j <= 5; j++){
						
						if(j <= rBean.reviewRating) {
							str += '<li class="star"><img src="/resources/images/staron.png"></li>';
							
						}else {
							str += '<li class="star"><img src="/resources/images/staroff.png"></li>';
						}
					}
					
					str += '</ul>';
					str += '<div class="reviewContent"><span class="reviewLevel">'+ rBean.studyProgramlanguage +'</span>';
					str += '<span>'+ rBean.reviewContent +'</span></div>';
					str += '<div class="reviewContentFooter">';
					str += '<a class="leader" href="/detail.do?studyId='+ rBean.studyId +'">'
					str += '<span class="leaderName">'+ rBean.teacherName +'<img src="'+ rBean.teacherPicture +'"></span>';
                    str += '</a>';
                    str += '</div>';
                    str += '</div>';
                    str += '</li>';
                    str += '</ul>';
                    str += '<hr>';
                    
					$("#realReviewInfo").append(str);
				});
				
				//더보기 버튼에 대한 처리
				reviewStartRow += data.reviewList.length*1;
				
				if( reviewListTotCount > reviewStartRow ) {
					//리뷰 더보기 버튼 화면에 표시
					$("#moreReviewList").show();
					
				} else{
					$("#moreReviewList").hide();
				}
				
			} else {
				alert(data.resultMsg);
			}
			
			isReviewLoading = false;
			isScrollLoading = true;
		},
		error: function(xhr, status, error) {
			isReviewLoading = false;
			console.log(xhr);
			alert("error\nxhr : " + xhr + ", status : " 
					+ status + ", error : " + error);      
		}
	});
};

</script>
</head>

<body>

	<div class="realReviewWrap">
        <div class="realReview">
            <div class="reviewImg"><img src="/resources/images/reviewMain.jpg" alt="realReview"></div>
        	
        	<div class="reviewLevelSelect">
            	<label class="selectTitle">카테고리별</label>
           			<ul class="levelList">
		                <li class="level"><a class="selectLevel"  href="#" id="웹개발" onclick="showReviewList(this.id)">웹개발<span class="reviewCount" id="reviewCountWeb"></span></a>
		                </li>
		                <li class="level"><a class="selectLevel" href="#" id="모바일개발" onclick="showReviewList(this.id)">모바일개발<span class="reviewCount" id="reviewCountMobile"> </span></a>
		                </li>
		                <li class="level"><a class="selectLevel" href="#" id="시스템개발" onclick="showReviewList(this.id)">시스템개발<span class="reviewCount" id="reviewCountSystem"> </span></a>
		                </li>
		                <li class="level"><a class="selectLevel" href="#" id="IoT" onclick="showReviewList(this.id)">IoT<span class="reviewCount" id="reviewCountIoT"> </span></a>
		                </li>
            		</ul>
        	</div>
        
            <div class="reviewListWrap">
                <div class="reviewListTitle" id="reviewListTitle"><span class="reviewCount" id="reviewCount"></span>
                </div>
                <hr>
                <div id="realReviewInfo"></div>
                <br/>
                <p style="text-align: center;">
                	<img src="/resources/images/more.png" id="moreReviewList"
				 	onclick="showNextReviewList()" />
                </p>
            </div>
            
        </div>  
    </div>
    
</body>

</html>