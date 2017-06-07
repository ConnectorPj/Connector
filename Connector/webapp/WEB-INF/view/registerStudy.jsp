<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<link href="/resources/css/registerStudy.css" rel="stylesheet"
	type="text/css">
<link href="/resources/js/common/jquery/jquery.minical.css"
	rel="stylesheet" type="text/css">
<script language="javascript" src="PopupCalendar.js"></script>
<script type="text/javascript">

function fnMove(seq){
    var offset = $("#div" + seq).offset().top-100;
    $('html, body').animate({scrollTop : offset}, 400);
}

</script>

<style>
ul, li {
	list-style: none;
}

.demo-3 i {
	position: absolute;
	right: 30px;
	bottom: 10px;
}

.container {
	margin: 150px auto;
}
</style>
</head>
<body>
	<form id="registerStudyForm">
		<div class="div_reg" id="div1">
			<h1>스터디 등록하기</h1>
			<hr size="3" width="200px" color="#eaeaea" margin-bottom="30px">
			<br />
			<h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

			<br />
			<h3>카테고리를 선택해주세요.</h3>


			<div id="css_tabs">
				<!-- 라디오 버튼 -->
				<input id="tab1" type="radio" name="tab" checked="checked" /> <input
					id="tab2" type="radio" name="tab" /> <input id="tab3" type="radio"
					name="tab" /> <input id="tab4" type="radio" name="tab" />
				<!-- 라벨 : 화면에 표시되는 탭 제목 -->
				<label for="tab1">WEB</label> <label for="tab2">SYSTEM</label> <label
					for="tab3">MOBILE</label> <label for="tab4">IoT</label>

				<!-- 탭 내용 : 탭 제목을 선택했을 때 표시되는 본문 -->
				<div class="tab1_content">
					<h3>WEB</h3>
					<br />
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="htmlcheckbox" autocomplete="off">
							#&nbsp;HTML
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="jspcheckbox" autocomplete="off">
							#&nbsp;JSP
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="jscheckbox" autocomplete="off">
							#&nbsp;JAVA SCRIPT
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="springcheckbox"
							autocomplete="off"> #&nbsp;SPRING
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="phpcheckbox" autocomplete="off">
							#&nbsp;PHP
						</label>



					</div>
				</div>
				<div class="tab2_content">
					<h3>SYSTEM</h3>
					<br />
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="javacheckbox" autocomplete="off">
							#&nbsp;자바
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="ccheckbox" autocomplete="off">
							#&nbsp;C
						</label><label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="cscheckbox" autocomplete="off">
							#&nbsp;C#
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="cppcheckbox" autocomplete="off">
							#&nbsp;C++
						</label>



					</div>
				</div>
				<div class="tab3_content">
					<h3>MOBILE</h3>
					<br />
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="androidcheckbox"
							autocomplete="off"> #&nbsp;안드로이드
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="ioscheckbox" autocomplete="off">
							#&nbsp;iOS
						</label>



					</div>
				</div>
				<div class="tab4_content">
					<h3>IoT</h3>
					<br />
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="aduinocheckbox"
							autocomplete="off"> #&nbsp;아두이노
						</label> <label class="btn btn-default"> <input type="checkbox"
							name="studyProgramLanguage" id="rasberrycheckbox"
							autocomplete="off"> #&nbsp;라즈베리파이
						</label>


					</div>
				</div>
			</div>

		</div>

		<div style="text-align: center;">
			<button class="button1" onclick="fnMove('1');">
				<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
			</button>
			<button class="button1" onclick="fnMove('2');">
				<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
			</button>
		</div>


		<div class="div_reg" style="padding-top: 30px;" id="div2">

			<h2 style="margin-top: 20px;">코:넥터 스터디 기본정보를 입력해주세요.</h2>

			<br />
			<h3>스터디 대상을 선택해주세요.</h3>
			<div class="subdiv">
				<div class="btn-group" style="margin: 50px auto 100px;"
					data-toggle="buttons">
					<label class="btn btn-default"> <input type="checkbox"
						name="students" id="elements" autocomplete="off"> 초등학생
					</label> <label class="btn btn-default"> <input type="checkbox"
						name="students" id="middle" autocomplete="off"> 중학생
					</label> <label class="btn btn-default"> <input type="checkbox"
						name="students" id="high" autocomplete="off"> 고등학생
					</label> <label class="btn btn-default"> <input type="checkbox"
						name="students" id="prepare" autocomplete="off"> 입시생
					</label> <label class="btn btn-default"> <input type="checkbox"
						name="students" id="colleage" autocomplete="off"> 대학생
					</label> <label class="btn btn-default"> <input type="checkbox"
						name="students" id="adult" autocomplete="off"> 일반인
					</label> <label class="btn btn-default"> <input type="checkbox"
						name="students" id="worker" autocomplete="off"> 직장인
					</label>



				</div>


			</div>



		</div>
		<div style="text-align: center;">
			<button class="button1" onclick="fnMove('1');">
				<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
			</button>
			<button class="button1" onclick="fnMove('3');">
				<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
			</button>
		</div>


		<div class="div_reg clear_after"
			style="padding-top: 50px; margin-bottom: 100px;" id="div3">

			<h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>
			<br /> <br />
			<h3>스터디 이름을 설정해주세요.</h3>
			<div class="subdiv">
				<input type="text" class="inputStyle" id="studyName">
			</div>
			<br /> <br />
			<div style="width: 70%; display: inline-block">
				<h3>스터디 인원과 금액을 설정해주세요.</h3>
				<div>
					<h4>최대 인원 :</h4>
					<br /> <select class="day">
						<option>3 명</option>
						<option>4 명</option>
						<option>5 명</option>
						<option>6 명</option>
						<option>7 명</option>
						<option>8 명</option>
					</select>
				</div>
				<div>
					<h4>금액 :</h4>
					<br /> <input type="text" class="inputOption" id="studyPrice">

				</div>
			</div>
		</div>
		<div style="text-align: center;">
			<button class="button1" onclick="fnMove('2');">
				<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
			</button>
			<button class="button1" onclick="fnMove('4');">
				<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
			</button>
		</div>
		<div class="div_reg clear_after"
			style="padding-top: 30px; margin-bottom: 100px;" id="div4">

			<h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

			<br />
			<h3>스터디 일정을 선택해주세요.</h3>
			<div style="margin: 0 auto 0;">
				<h4>
					주<select class="day">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>6</option>
						<option>7</option>
					</select>회
				</h4>

			</div>
			<div style="margin: 0 auto 0;">
				<h4>
					총 <select class="day">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>6</option>
						<option>7</option>
						<option>8</option>
						<option>9</option>
						<option>10</option>
						<option>11</option>
						<option>12</option>
					</select>개월 과정
				</h4>

			</div>

			<br />
			<div class="subTimediv">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default" style="width: 40px;"> <input
						type="checkbox" name="studyTime" id="monday" autocomplete="off">
						월
					</label> <label class="btn btn-default" style="width: 40px;"> <input
						type="checkbox" name="studyTime" id="tuesday" autocomplete="off">
						화
					</label><label class="btn btn-default" style="width: 40px;"> <input
						type="checkbox" name="studyTime" id="Wednesday" autocomplete="off">
						수
					</label> <label class="btn btn-default" style="width: 40px;"> <input
						type="checkbox" name="studyTime" id="thursday" autocomplete="off">
						목
					</label> <label class="btn btn-default" style="width: 40px;"> <input
						type="checkbox" name="studyTime" id=friday autocomplete="off">
						금
					</label> <label class="btn btn-default" style="width: 40px;"> <input
						type="checkbox" name="studyTime" id="saturday" autocomplete="off">
						토
					</label> <label class="btn btn-default" style="width: 40px;"> <input
						type="checkbox" name="studyTime" id="sunday" autocomplete="off">
						일
					</label>



				</div>
				<div>

					<div class="startTime clear_after">

						<h4>시작시간</h4>
						<div class="toggle-button toggle-button--aava">
							<input id="startTime" type="checkbox"> <label
								for="startTime" data-on-text="오전" data-off-text="오후"></label>
						</div>
						<div class="timegood">
							<select class="time">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
								<option>6</option>
								<option>7</option>
								<option>8</option>
								<option>9</option>
								<option>10</option>
								<option>11</option>
								<option>12</option>
							</select> : <select class="time">
								<option>00</option>
								<option>10</option>
								<option>20</option>
								<option>30</option>
								<option>40</option>
								<option>50</option>
							</select><br />
						</div>
					</div>




					<div class="endTime clear_after">

						<h4>종료시간</h4>
						<div class="toggle-button toggle-button--aava">
							<input id="endTime" type="checkbox"> <label for="endTime"
								data-on-text="오전" data-off-text="오후"></label>
						</div>

						<div class="timegood">
							<select class="time">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
								<option>6</option>
								<option>7</option>
								<option>8</option>
								<option>9</option>
								<option>10</option>
								<option>11</option>
								<option>12</option>
							</select> : <select class="time">
								<option>00</option>
								<option>10</option>
								<option>20</option>
								<option>30</option>
								<option>40</option>
								<option>50</option>
							</select><br />

						</div>
					</div>

				</div>
			</div>

		</div>

		<div style="text-align: center;">
			<button class="button1" onclick="fnMove('3');">
				<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
			</button>
			<button class="button1" onclick="fnMove('5');">
				<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
			</button>
		</div>



		<div class="div_reg clear_after"
			style="padding-top: 30px; margin-bottom: 100px;" id="div5">

			<h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

			<br />
			<h3>스터디 시작 날짜를 선택해주세요.</h3>
			<div class="col-lg-4">
				<form class="demo-3">
					<input type='text' class="form-control"> <i
						class="fa fa-calendar trigger-icon"></i>
				</form>
			</div>
		</div>

		<div style="text-align: center;">
			<button class="button1" onclick="fnMove('4');">
				<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
			</button>
			<button class="button1" onclick="fnMove('6');">
				<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
			</button>
		</div>



		<div class="div_reg clear_after"
			style="padding-top: 30px; margin-bottom: 100px;" id="div6">

			<h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

			<br />
			<h3>스터디 장소를 선택해주세요.</h3>

		</div>

		<div style="text-align: center;">
			<button class="button1" onclick="fnMove('5');">
				<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
			</button>
			<button class="button1" onclick="fnMove('7');">
				<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
			</button>
		</div>
		<div class="div_reg clear_after"
			style="padding-top: 30px; margin-bottom: 100px;" id="div7">

			<h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

			<br />
			<h3>스터디 소개를 해주세요.</h3>
			<div class="subdiv">
				<textarea class="inputStyleDetail" id="studyInfo" rows="10"
					cols="20"></textarea>
			</div>
			<br />
			<h5>커리큘럼을 소개해주세요.</h5>
			<div class="subdiv">
				<textarea class="inputStyleDetail" id="studyCur" rows="10" cols="20"></textarea>
			</div>
			<h5>강의를 표현할 사진을 첨부해주세요.</h5>
			<div class="subdiv">
				<div class="filebox preview-image">
					<input class="upload-name" value="파일선택" disabled="disabled">
					<label for="input-file">업로드</label> <input type="file"
						id="input-file" class="upload-hidden">
				</div>


			</div>




		</div>





		<div style="text-align: center;">
			<button class="button1" style="width: 200px;"
				onclick="location.href = '/registersuccess.do' ">
				<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>

			</button>

		</div>

	</form>




	<script src="/resources/js/common/jquery/jquery.minical.js"></script>
	<script>
	$("form.demo-1 :text").minical();
	$("form.demo-2 :text").minical({
	        inline: true
	      });
		  $("form.demo-3 :text").minical({
	        trigger: "i.trigger-icon"
	      });
</script>

<script type="text/javascript">

$(document).ready(function(){
	   var fileTarget = $('.filebox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            // 파일명 추출
	            var filename = $(this)[0].files[0].name;
	        } 

	        else {
	            // Old IE 파일명 추출
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        };

	        $(this).siblings('.upload-name').val(filename);
	    });

	    //preview image 
	    var imgTarget = $('.preview-image .upload-hidden');

	    imgTarget.on('change', function(){
	        var parent = $(this).parent();
	        parent.children('.upload-display').remove();

	        if(window.FileReader){
	            //image 파일만
	            if (!$(this)[0].files[0].type.match(/image\//)) return;
	            
	            var reader = new FileReader();
	            reader.onload = function(e){
	                var src = e.target.result;
	                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
	            }
	            reader.readAsDataURL($(this)[0].files[0]);
	        }

	        else {
	            $(this)[0].select();
	            $(this)[0].blur();
	            var imgSrc = document.selection.createRange().text;
	            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

	            var img = $(this).siblings('.upload-display').find('img');
	            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
	        }
	    });
	});

</script>
</body>
</html>