<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>리얼후기</title>

<link href="/resources/css/realReview.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/mainStyle.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/review/review.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$( ".score li" ).click(function() {
    	$(this).parent().children("li").removeClass("star off");
    	$(this).addClass("star on").prevAll("li").addClass("star on");
     	return false;
	});
	

	$('.selectLevel').on('click', function(e) {
		//클릭했을 때 액션이 있다면 여기에 스크립트 작성
	}).mouseenter(function(e) {
		var _this = $(this);
		_this.addClass('hover');
	}).mouseleave(function(e) {
		var _this = $(this);
		_this.removeClass('hover');
	});
</script>

</head>

<body>
	<div class="realReviewWrap">
        <div class="realReview">
            <div class="reviewImg"><img src="/resources/images/main.png" alt="realReview"></div>
        <div class="reviewLevelSelect">
            <label class="selectTitle">카테고리별</label>
            <ul class="levelList">
                <li class="level"><a class="selectLevel" href="/realreview.do?selectLevel=웹개발">웹개발<span class="reviewCount"> (${reviewCountWeb})</span></a>
                </li>
                <li class="level"><a class="selectLevel" href="/realreview.do?selectLevel=모바일개발">모바일개발<span class="reviewCount"> (${reviewCountMobile})</span></a>
                </li>
                <li class="level"><a class="selectLevel" href="/realreview.do?selectLevel=시스템개발">시스템개발<span class="reviewCount"> (${reviewCountSystem})</span></a>
                </li>
                <li class="level"><a class="selectLevel" href="/realreview.do?selectLevel=IoT">IoT<span class="reviewCount"> (${reviewCountIoT})</span></a>
                </li>
            </ul>
        </div>
        
            <div class="reviewListWrap">
                <div class="reviewListTitle">${reviewListTitle} 후기<span class="reviewCount"> (${reviewCount})</span>
                </div>
                <hr>
                <c:forEach var="bean" items="${reviewList}" varStatus="status">
                <ul class="reviewList">
                    <li class="review">
                        <div class="writerPhoto"><img src="/resources/images/profile.jpg"></div>
                        <div class="reviewContentWrap">
                            <div class="writerName">${bean.customerName}<span class="writtenAt">${bean.reviewRegdate}</span>
                            </div>

                            <ul class="score">
                                <li class="star on"></li>
                                <li class="star on"></li>
                                <li class="star on"></li>
                                <li class="star on"></li>
                                <li class="star off"></li>
                            </ul>
                            <div class="reviewContent"><span class="reviewLevel">${bean.studyProgramlanguage}</span>
                            <span>${bean.reviewContent}</span>
                            </div>
                            <div class="reviewContentFooter">
                            	<a class="leader" href="#">
                            		<span class="leaderName">${bean.teacherName}<img src="/resources/images/profile.jpg"></span>
                            	</a>
                            </div>
                       </div>
                   </li>
                </ul>
                </c:forEach>
                <hr>
                
            </div>
        </div>  
    </div>
</body>
</html>