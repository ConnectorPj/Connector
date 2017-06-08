<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    
    <title>Document</title>
    
    <link href="/resources/css/reset.css" rel="stylesheet" type="text/css">
    <link href="/resources/css/leaderIntro.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="js/jquery-1.12.4.min.js"></script>
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
	/* Use the Roboto font that is loaded in the <head> */
	font-family: 'Roboto', sans-serif;
}

#naver_id_login img {
	width: 100%;
}

</style>

<body>

	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="/js/bootstrap.min.js"></script>
    
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
						<small> ──────────────── </small>또&nbsp;&nbsp;는<small>
							──────────────── </small>
					</h6>
					<form>
						<div>
							<input type="text" class="form-control" id="inputJoinName"
								placeholder="이름" /><br/>
							<input type="email" class="form-control"
								id="inputJoinEmail" placeholder="이메일" /><br/>
							<input type="password"
								name="password" id="inputJoinpassword"
								class="form-control input-sm" placeholder="비밀번호" tabindex="5">
							<input type="password" name="password_confirmation"
								id="inputJoinpasswordconfirm" class="form-control input-sm"
								placeholder="비밀번호 확인" tabindex="6"><br/><br/><br/>
							<input type="text"
								class="form-control" id="inputJoinCareer" placeholder="경력" /><br/>
							<input type="text"
								class="form-control" id="inputJoinRegistration"
								placeholder="주민등록번호 앞자리" /><br/>
							<input type="text"
								class="form-control" id="inputJoinPhone" placeholder="핸드폰번호" /><br/>
							<input type="text"
								class="form-control" id="inputJoinIntroduction" placeholder="강사소개" /><br/>
							<input type="radio" name="gender" value="F" >여자 
							<input type="radio" name="gender" value="M" >남자 
						</div>
				


					</form>
					<h6 style="text-align: center;">
						<small>더코세의 이용약관과 개인정보 보호정책에 동의합니다.</small>
					</h6>

					<button type="button" class="button button-orange">가입 완료</button>
				</div>

			</div>
			</div>
			<script type="text/javascript"
		src="http://code.jquery.com/jquery-latest.js"></script>

	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

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