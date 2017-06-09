<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    
    <title>Document</title>
    
    <link href="/resources/css/leaderIntro.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    
<script type="text/javascript">
	// Modal Function
	function checkinputJoinpassword() {

		var inputJoinpassword = document.getElementById("inputJoinpassword").value;
		var exptext = /^.*(?=.{6,15})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		if (exptext.test(inputJoinpassword) == false) {

			document.getElementById("resultinputJoinpasswordconfirm").textContent = "비밀번호 형식이 올바르지 않습니다.";
			document.getElementById("inputJoinpassword").focus();
			return false;

		}
		else {
			document.getElementById("resultinputJoinpasswordconfirm").textContent = "";
			document.getElementById("inputJoinpasswordconfirm").disabled = false;

			return true;


		}
	};

	function checkinputJoinpasswordconfirm() {
		if ($("#inputJoinpassword").val() == $("#inputJoinpasswordconfirm").val()) {
			document.getElementById("resultinputJoinpasswordconfirm").textContent = "비밀번호가 일치합니다.";

			return true;

		}
		else {
			document.getElementById("resultinputJoinpasswordconfirm").textContent = "비밀번호가 일치하지 않습니다.";

			return false;
		}
	};

	function checkinputJoinEmail() {
		var inputJoinEmail = document.getElementById("inputJoinEmail").value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (exptext.test(inputJoinEmail) == false) {
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			document.getElementById("resultinputJoinEmail").textContent = "메일형식이 올바르지 않습니다.";
			document.getElementById("inputJoinEmail").focus();
			return false;
		}
		else {
			document.getElementById("resultinputJoinEmail").textContent = "";
			return true;
		}
	};

    function teacherCheckIdJSP(){
        
        $.ajax({
           url : '/teacherCheckId.do',
           type : 'post',
           data : {
              "teacherId": $("#inputJoinEmail").val()   
           },
           success : function(data) {
              $("#resultinputJoinEmail").html(data.resultMsg);
           },
           error : function(error) {
              alert(error.statusText);
           }
        });
     };

	function insertTeacher() {

 		if ($("#inputJoinName").val() == null || $("#inputJoinName").val() == "") {

 			document.getElementById("inputJoinName").focus();

 			$('#inputJoinName').attr('placeholder', '이름을 입력하지 않으셨습니다.');

 			return;

 		}
 		else if ($("#inputJoinEmail").val() == null || $("#inputJoinEmail").val() == ""
 				|| !checkinputJoinEmail()) {
 			document.getElementById("inputJoinEmail").focus();
 			$('#inputJoinEmail').attr('placeholder', '메일을 올바르게 작성해주세요.');

 			return;
 		}
 		else if ($("#inputJoinpassword").val() == null || $("#inputJoinpassword").val() == ""
				|| !checkinputJoinpasswordconfirm()) {
 			document.getElementById("inputJoinpassword").focus();
 			$('#inputJoinpassword').attr('placeholder', '비밀번호을 입력하지 않으셨습니다.');

 			return;
 		}
 		else if ($(":input:radio[id='agreeJSP2']:checked").val() != "1") {
 			alert("개인정보 활용 제공에 동의해주세요.");
 			return;
 		}
 		
 		else {

			$.ajax({
				type : "post",
				url : "/insertTeacherProc.do",
				data : $("#teacherFormJSP").serialize(),
				async : false,
				dataType : "json",
				success : function(data) {
					console.log(data);

					if (data.result == "ok") {
						alert(data.resultMsg);
						location.replace("/login.do");

						return;
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
	} 


</script>
    
</head>

<style>
    html,
    body {
        font-family: 'Noto Sans KR', sans-serif, dotum, '돋움', gulim, '굴림', Arial, AppleGothic, verdana, helvetica;
        font-size: 14px;
        letter-spacing: -0.05em;
        line-height: 1.6;
        font-weight: 400;
        color: #333;
        margin: 0;
        overflow-x: hidden;
        !important;
    }
    
    a {
        color: #333333;
        text-decoration: none;
    }
    
    a:link {
        color: #333333;
        text-decoration: none;
        transition: all .3s ease
    }
    
    a:visited {
        color: #333333;
        text-decoration: none
    }
    
    a:active {
        color: #333333;
        text-decoration: none
    }
    
    a:hover {
        color: #666666;
        text-decoration: none
    }
    
    .btn_study2{
    width: 200px;
    height: 50px;
    line-height:3px;
    background-color: #fff;
    color: #845;
    font-size: 15px;
    border: 0px;
    border-radius: 5px;
    }
    
    .btn_study3{
    width: 200px;
    height: 50px;
    line-height:3px;
    background-color: #468;
    color: #fff;
    font-size: 15px;
    border: 0px;
    border-radius: 5px;
    }



	/* 구글 버튼*/
#customBtn, #customBtn2, #customBtn3, #customBtn4 {
	display: inline-block;
	background: white;
	color: #444;
	margin: 1% 0;
	width: 100%;
	border-radius: 5px;
	border: thin solid #888;
	white-space: nowrap;
}

#customBtn:hover, #customBtn2:hover, #customBtn3:hover, #customBtn4:hover
	{
	cursor: pointer;
	box-shadow: 1px 1px 1px black;
}

span.label {
	font-family: serif;
	font-weight: normal;
}

span.icon {
	margin-left: 3%;
	background: url('/resources/images/g-logo.png') transparent 50% 50%/100%
		100% no-repeat;
	display: inline-block;
	vertical-align: middle;
	width: 42px;
	height: 42px;
	background: url('/resources/images/g-logo.png') transparent 50% 50%/100%
		100% no-repeat;
}

span.buttonText {
	display: inline-block;
	vertical-align: middle;
	text-align: center;
	padding-left: 31%;
	padding-right: 42px;
	font-size: 14px;
	font-weight: bold;
	<!-- Use the Roboto font that is loaded in the <head> -->
	font-family: 'Roboto', sans-serif;
}

#naver_id_login img {
	width: 100%;
}

</style>

<body>

    <section>
    
    <div class="to">
    	<div class="ma">
	         <h2>지금바로<br/>'더카니의 코딩세상'의<br/>리더가 되세요!</h2><br/>
	         <button class="btn_study2" id="btn2" >Apply Now</button>
	         <h6>호스트 지원 페이지로 이동합니다.</h6>
	    </div>
    </div>
 		
	    <div class="service">
	        <div class="service_list">
	            
	            
	            <br/>
	            <div class="bo">
	                <h2>더코세 리더의 장점</h2>
	            </div>
	                
	            <div class="about">
	               <article>
	                    <div class="li_img">
	                        <img src="/resources/images/img.jpg" alt="service01"/>
	                    </div>
	                    <h4>걍 뭐 이런...</h4>
	                    <p>대충이러케 쓰면<br/>대지않을까요</p>
	                </article>
	                <article>
	                    <div class="li_img">
	                        <img src="/resources/images/img.jpg" alt="service02"/>
	                    </div>
	                    <h4>저런 장점이</h4>
	                        <p>대충이러케 쓰면<br/>대지않을까요</p>
	                </article>
	                <article>
	                    <div class="li_img">
	                        <img src="/resources/images/img.jpg" alt="service02"/>
	                    </div>
	                    <h4>이써염......</h4>
	                    <p>대충이러케 쓰면<br/>대지않을까요</p>
	                </article>
	            </div>
	            
	            
	            <br/><br/><br/>
	            
	            
	                    <div class="le">
	                       <div class="le_le2">
	                            <img src="/resources/images/img.jpg" alt="service04"/>
	                        </div>
	                        <div class="le_le">
	                            <h2>세상행복한 덕코세!</h2>
	                            <h4>먼저 호스트 지원서를 확인 및 작성해 주세요.<br/>개설 가능한 지역 및 시단대, 예상 수입에 대해<br>
	                            7일 이내로 안내를 드리겠습니다!<br/><br/>7일 이후에도 메일이 오지 않는다면<br/>
	                            ABCDEFG@gmail.com으로 연락주세요.</h4>
	                        </div>
	                    </div>
	                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	                    <br/><br/><br/><br/><br/><br/><br/><br/>
	                    
	                    <div class="ri">
	                        <div class="ri_ri">
	                            <h2>지금 바로 리더 신청하기</h2><br/>
	                            <button class="btn_study3" id="btn3" >APPLY NOW</button>
	                            <h6>호스트 지원 페이지로 이동합니다.</h6>
	                        </div>
	                            <div class="ri_ri2">
	                                <img src="/resources/images/img.jpg" alt="sercive05"/>
	                            </div>
	                    </div>
	        </div>
    </div>
    
   
    </section>
    		<div id="myJoinModal2" class="modal">
    
    <div class="modal-content">
				<span class="closeJoin2">&times;</span>
				<div>
					<br />
					<!-- 구글 연동 2 -->
					<div id="customBtn2" class="customGPlusSignIn"
						onclick="secondApp();">
						<span class="icon"></span> <span class="buttonText">Google</span>
					</div>
					<!-- 네이버 로그인 API -->
					<div id="naver_id_login"></div>
					<h6 style="text-align: center;">
						<small> ───────────────────── </small>또&nbsp;&nbsp;는<small>
							───────────────────── </small>
					</h6>
					<form id="teacherFormJSP">
						<div>
							<input type="text" class="form-control" name="teacherName" id="inputJoinName"
								placeholder="이름" /><br/>
								
							<input type="email" class="form-control" name="teacherId"
								id="inputJoinEmail" onkeyup="checkinputJoinEmail()" placeholder="이메일" />
							<p id="resultinputJoinEmail" style="font-size: 0.4em; color: #aaa;"></p>
							
							<input type="password"
								name="password" name="teacherPw" id="inputJoinpassword" onkeyup="checkinputJoinpassword()"
								class="form-control input-sm" placeholder="비밀번호" >
							<p id="resultinputJoinpassword" style="font-size: 0.4em; color: #aaa;">
							
							<input type="password" name="password_confirmation" onkeyup="checkinputJoinpasswordconfirm()"
								id="inputJoinpasswordconfirm" class="form-control input-sm"
								placeholder="비밀번호 확인" ><br/><br/><br/><br/>
							<p id="resultinputJoinpasswordconfirm" style="font-size: 0.4em; color: #aaa;"></p>
							
							<input type="text"
								class="form-control" name="teacherCareer" id="inputJoinCareer" placeholder="경력" /><br/>
							
							<input type="text"
								class="form-control" name="teacherInfo" id="inputJoinRegistration"
								placeholder="주민등록번호 앞자리" /><br/>
							
							<input type="text"
								class="form-control" name="teacherCellphone" id="inputJoinPhone" placeholder="핸드폰번호" /><br/>
							
							<input type="radio" name="teacherGender" value="F" >여자 &nbsp;&nbsp;&nbsp;
							<input type="radio" name="teacherGender" value="M" >남자 
						</div>
				


					</form>
					<h6 style="text-align: center;">
						<small>더코세의 이용약관과 개인정보 보호정책에 동의합니다.&nbsp;&nbsp;&nbsp;<input type="radio" name="cho" id="agreeJSP2" value="1" /></small>
					</h6>

					<button type="button" class="button button-orange" onclick="insertTeacher();">가입 완료</button>
				</div>

			</div>
			</div>

	<!-- Login Modal Script -->
	<script type="text/javascript">
		// Get the modal
		var modalJoin2 = document.getElementById("myJoinModal2");

		// Get the button that opens the modal
		var btnJoin2 = document.getElementById("btn2");
		var btnJoin3 = document.getElementById("btn3");

		// Get the <span> element that closes the modal
		var spanJoin2 = document.getElementsByClassName("closeJoin2")[0];

		// When the user clicks on the button, open the modal 
		btnJoin2.onclick = function() {
			modalJoin2.style.display = "block";
		}
		btnJoin3.onclick = function() {
			modalJoin2.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		spanJoin2.onclick = function() {
			modalJoin2.style.display = "none";
		}
	</script>


</body>

</html>