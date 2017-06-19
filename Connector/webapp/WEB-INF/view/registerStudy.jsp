<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
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

<script type="text/javascript"
   src="//apis.daum.net/maps/maps3.js?apikey=c50d46bc6244185fdb36b57523e93fb4&libraries=services"></script>

<script type="text/javascript">
   var aaa = 1;
   
   function movePre() {
      if (aaa > 1) {
         var offset = $("#div" + (aaa - 1)).offset().top - 100;
         $('html, body').animate({
            scrollTop : offset
         }, 400);
         aaa--;
      }
   }
   function moveNext() {
      if (aaa < 7) {

         var offset = $("#div" + (aaa + 1)).offset().top - 100;
         $('html, body').animate({
            scrollTop : offset
         }, 400);
         aaa++;
      }
   }
   
   function checkInsert() {
       var proChk = document.getElementsByName("studyProgramLanguage"); // 체크박스객체를 담는다
       var str = "";      
      for (var i = 0; i < proChk.length; i++) {
         if (proChk[i].checked == true) {
            str += proChk[i].value;
         }
      }
      if(str == ""){
         alert("프로그램 언어 종류를 선택해 주세요.");
         return;
      }
      
      // 스터디 대상 체크 확인
      var chk = document.getElementsByName("studyJob"); // 체크박스객체를 담는다
       str = "";      
      for (var i = 0; i < chk.length; i++) {
         if (chk[i].checked == true) {
            str+=chk[i].value;
         }
      }
      if(str == ""){
         alert("스터디 대상을 지정해 주세요. ");
         return;
      }

      
      // 스터디 이름 체크
      if($("#studyName").val() == ""){
         alert("스터디 이름을 정해 주세요.");
         return;
      }
      
      // 스터디 금액 체크
      if($("#studyPrice").val() == ""){
         alert("스터디 금액을 정해 주세요.");
         return;
      }
      
      var stChk = document.getElementsByName("studyWeek"); // 체크박스객체를 담는다
       str = "";      
      for (var i = 0; i < stChk.length; i++) {
         if (stChk[i].checked == true) {
            str += stChk[i].value;
         }
      }
      if(str == ""){
         alert("스터디 요일을 정해 주세요.");
         return;
      }
      
      //시작 날짜, 종료 날짜 체크 확인
      if ($("#startDate").val() == "") {
         alert("시작 날짜를 정해 주세요.");
         return;
      }
      if ($("#endtDate").val() == "") {
         alert("스터디 종료 날짜를 정해 주세요.");
         return;
      }
      
      // 장소 체크 확인
      if ($("#result").val() == "") {
         alert("스터디 장소를 선택해 주세요.");
         return;
      } 

      insertClass();
   }

   
</script>

<style>
</style>
</head>
<body>

   <div class="moveBtnDiv">
      <button class="button1" onclick="movePre();">
         <span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>
      </button>
      <button class="button1" onclick="moveNext();">
         <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
      </button>
   </div>

   <form id="registerStudyForm" enctype="multipart/form-data">
      <div class="div_reg" id="div1">
         <h1>스터디 등록하기</h1>
         <hr size="3" width="200px" color="#eaeaea" margin-bottom="30px">
         <br />
         <h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

         <br />
         <h3>카테고리를 선택해주세요.</h3>

         <div id="css_tabs">
            <!-- 라디오 버튼 -->
            <input id="tab1" type="radio" name="studyProgressName" value="웹개발"
               checked /> <input id="tab2" type="radio" name="studyProgressName"
               value="시스템개발" /> <input id="tab3" type="radio"
               name="studyProgressName" value="모바일개발" /> <input id="tab4"
               type="radio" name="studyProgressName" value="IOT" />
            <!-- 라벨 : 화면에 표시되는 탭 제목 -->
            <label for="tab1" id="categoryLabel">WEB</label> <label for="tab2"
               id="categoryLabel">SYSTEM</label> <label for="tab3"
               id="categoryLabel">MOBILE</label> <label for="tab4"
               id="categoryLabel">IoT</label>

            <!-- 탭 내용 : 탭 제목을 선택했을 때 표시되는 본문 -->
            <div class="tab1_content">
               <h3>WEB</h3>
               <br />
               <div class="btn-group" data-toggle="buttons">
                  <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="htmlcheckbox" value="HTML">
                     #&nbsp;HTML
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="jspcheckbox" value="JSP">
                     #&nbsp;JSP
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="jscheckbox" value="JAVASCRIPT">
                     #&nbsp;JAVA SCRIPT
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="springcheckbox" value="SPRING">
                     #&nbsp;SPRING
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="phpcheckbox" value="PHP">
                     #&nbsp;PHP
                  </label>

               </div>
            </div>
            <div class="tab2_content">
               <h3>SYSTEM</h3>
               <br />
               <div class="btn-group" data-toggle="buttons">
                  <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="javacheckbox" value="JAVA">
                     #&nbsp;자바
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="ccheckbox" value="C">
                     #&nbsp;C
                  </label><label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="cscheckbox" value="C#">
                     #&nbsp;C#
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="cppcheckbox" value="C++">
                     #&nbsp;C++
                  </label>

               </div>
            </div>
            <div class="tab3_content">
               <h3>MOBILE</h3>
               <br />
               <div class="btn-group" data-toggle="buttons">
                  <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="androidcheckbox" value="ANDROID">
                     #&nbsp;안드로이드
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="ioscheckbox" value="IOS">
                     #&nbsp;iOS
                  </label>
               </div>
            </div>
            <div class="tab4_content">
               <h3>IoT</h3>
               <br />
               <div class="btn-group" data-toggle="buttons">
                  <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="aduinocheckbox" value="아두이노">
                     #&nbsp;아두이노
                  </label> <label class="btn btn-default"> <input type="checkbox"
                     name="studyProgramLanguage" id="rasberrycheckbox" value="라즈베리파이">
                     #&nbsp;라즈베리파이
                  </label>
               </div>
            </div>
         </div>

      </div>




      <div class="div_reg" style="padding-top: 30px;" id="div2">

         <h2 style="margin-top: 20px;">코:넥터 스터디 기본정보를 입력해주세요.</h2>

         <br />
         <h3>스터디 대상을 선택해주세요.</h3>
         <div class="subdiv">


            <div class="btn-group" data-toggle="buttons">

               <label class="btn btn-default"> <input type="checkbox"
                  name="studyJob" id="elements" value="초등학생" " /> 초등학생
               </label> <label class="btn btn-default"> <input type="checkbox"
                  name="studyJob" id="middle" value="중학생"> 중학생
               </label> <label class="btn btn-default"> <input type="checkbox"
                  name="studyJob" id="high" value="고등학생"> 고등학생
               </label> <label class="btn btn-default"> <input type="checkbox"
                  name="studyJob" id="prepare" value="입시생"> 입시생
               </label> <label class="btn btn-default"> <input type="checkbox"
                  name="studyJob" id="colleage" value="대학생"> 대학생
               </label> <label class="btn btn-default"> <input type="checkbox"
                  name="studyJob" id="adult" value="일반인"> 일반인
               </label> <label class="btn btn-default"> <input type="checkbox"
                  name="studyJob" id="worker" value="직장인"> 직장인
               </label>
            </div>
         </div>
      </div>


      <div class="div_reg clear_after"
         style="padding-top: 50px; margin-bottom: 100px;" id="div3">

         <h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>
         <br /> <br />
         <h3>스터디 이름을 설정해주세요.</h3>
         <div class="subdiv">
            <input type="text" class="inputStyle" id="studyName" name="studyName">
         </div>
         <hr>

         <div style="width: 70%; display: inline-block">
            <h3>스터디 인원과 금액을 설정해주세요.</h3>
            <div>
               <h4>최대 인원 :</h4>
               <br /> <select name="studyAmount" class="studyAmount">
                  <option>3 명</option>
                  <option>4 명</option>
                  <option>5 명</option>
                  <option>6 명</option>
                  <option>7 명</option>
                  <option>8 명</option>
               </select>
            </div>
            <hr>
            <div>
               <h4>금액 :</h4>
               <input type="number" class="inputPrice" id="studyPrice"
                  name="studyPrice" min="0">

            </div>
         </div>
      </div>
      <div class="div_reg clear_after"
         style="padding-top: 30px; margin-bottom: 100px;" id="div4">

         <h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

         <br />
         <h3>스터디 일정을 선택해주세요.</h3>

         <br />
         <div class="subTimediv">
            <div class="btn-group" data-toggle="buttons">
               <label class="btn btn-default" style="width: 40px;"> <input
                  type="checkbox" name="studyWeek" id="monday" value="월"> 월
               </label> <label class="btn btn-default" style="width: 40px;"> <input
                  type="checkbox" name="studyWeek" id="tuesday" value="화"> 화
               </label><label class="btn btn-default" style="width: 40px;"> <input
                  type="checkbox" name="studyWeek" id="Wednesday" value="수">
                  수
               </label> <label class="btn btn-default" style="width: 40px;"> <input
                  type="checkbox" name="studyWeek" id="thursday" value="목">
                  목
               </label> <label class="btn btn-default" style="width: 40px;"> <input
                  type="checkbox" name="studyWeek" id=friday value="금"> 금
               </label> <label class="btn btn-default" style="width: 40px;"> <input
                  type="checkbox" name="studyWeek" id="saturday" value="토">
                  토
               </label> <label class="btn btn-default" style="width: 40px;"> <input
                  type="checkbox" name="studyWeek" id="sunday" value="일"> 일
               </label>

            </div>
            <div>

               <div class="startTime clear_after">

                  <h4>시작시간</h4>
                  <div class="toggle-button toggle-button--aava">
                     <input id="startTimeAmPm" type="checkbox" > <label
                        for="startTimeAmPm" data-on-text="오전" data-off-text="오후"></label>

                  </div>
                  <div class="timegood">
                     <select class="time" id="startTimeHour">
                        <script type="text/javascript">
                           for (var i = 1; i <= 12; i++)
                              document.write("<option>" + i
                                    + "</option>");
                        </script>
                     </select> : <select class="time" id="startTimeMinute">
                        <script type="text/javascript">
                           for (var i = 0; i <= 50; i += 10)
                              document.write("<option>" + i
                                    + "</option>");
                        </script>
                     </select><br />
                  </div>
               </div>

               <div class="endTime clear_after">

                  <h4>종료시간</h4>
                  <div class="toggle-button toggle-button--aava">
                     <input id="endTimeAmPm" type="checkbox" value="오전"> 
                     <label for="endTimeAmPm" data-on-text="오전" data-off-text="오후"></label>
                  </div>

                  <div class="timegood">
                     <select class="time" id="endTimeHour">
                        <script type="text/javascript">
                           for (var i = 1; i <= 12; i++)
                              document.write("<option>" + i
                                    + "</option>");
                        </script>
                     </select> : <select class="time" id="endTimeMinute">
                        <script type="text/javascript">
                           for (var i = 0; i <= 50; i += 10)
                              document.write("<option>" + i
                                    + "</option>");
                        </script>
                     </select><br />
                  </div>
               </div>

               <input type="hidden" id="teacherId" name="teacherId"
                  value="${sessionScope.memberLoginBean.teacherId}" /> <input
                  type="hidden" id="teacherName" name="teacherName"
                  value="${sessionScope.memberLoginBean.teacherName}" /> <input
                  type="hidden" id="startTime" name="studyStartTime" /> <input
                  type="hidden" id="endTime" name="studyEndTime" />

            </div>
            <!-- end of time -->

         </div>

      </div>

      <br> <br>
      <div class="div_reg clear_after"
         style="text-align: center; padding-top: 30px; margin-bottom: 100px;"
         id="div5">

         <h2>수업 시작 날짜와 종료 날짜를 입력해 주세요.</h2>
         <div style="display: inline-block; margin: 100px auto 0; width:100%;">
            <input id="startDate" name="studyStartDate" type="date" class="date"
               style="float: left; margin-right: 50px;"> <input
               id="endtDate" name="studyEndDate" type="date" class="date"
               style="margin-left: 50px;">
         </div>
         
         
         <div style="text-align:center; inline-block; margin: 10px auto 50px;">
            <div style="display: inline-block; margin: 0 auto 50px;">
               <span style=" margin-right: 100px;">시작 날짜</span> <span
                  style="margin-left: 100px;">종료 날짜</span>
            </div>
         </div>
      </div>

      <div class="div_reg clear_after"
         style="padding-top: 30px; margin-bottom: 100px;" id="div6">

         <h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

         <br />
         <h3>스터디 장소를 선택해주세요.</h3>
         <div class="map_wrap">
            <div id="map"
               style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

            <div id="menu_wrap" class="bg_white">
               <div class="option">
                  <div>
                     키워드 : <input type="text" value="당산역" id="keyword" size="15">
                     <button onclick="searchPlaces(); return false; ">검색하기</button>
                  </div>
               </div>
               <hr>
               <ul id="placesList"></ul>
               <div id="pagination"></div>
            </div>
            <input type="hidden" id="result" name="studyLocation" />
            <div id="resultMessage"></div>

         </div>

      </div>

      <div class="div_reg clear_after"
         style="padding-top: 30px; margin-bottom: 100px;" id="div7">

         <h2>코:넥터 스터디 기본정보를 입력해주세요.</h2>

         <br />
         <h3>스터디 소개를 해주세요.</h3>
         <div class="subdiv">
            <textarea class="inputStyleDetail" id="studyInfo" name="studyInfo"
               rows="10" cols="20"></textarea>
         </div>
         <br />
         <h3>커리큘럼을 소개해주세요.</h3>
         <div class="subdiv">
            <textarea class="inputStyleDetail" id="studyReference;"
               name="studyReference" rows="10" cols="20"></textarea>
         </div>
         <h5>강의를 표현할 사진을 첨부해주세요.</h5>
         <div class="subdiv">
            <div class="filebox preview-image">
               <input class="upload-name" value="파일선택" disabled="disabled">
               <label for="input-file">업로드</label> <input type="file" name="file1"
                  id="input-file" class="upload-hidden">
            </div>
         </div>

      </div>

      <script type="text/javascript">
         function insertClass() {

            var studyForm = document.getElementById("registerStudyForm");
            studyForm.action = "/registerstudyProc.do";
            studyForm.method = "post";

            //studyTime 합치기.(몇시부터 몇시까지 진행되는 과정인지. ex) 12:00 ~ 13:00
            
            var startTimeChk = document.getElementById("startTimeAmPm");
           
            var startTimeAmPm ="";
            
            if(startTimeChk.checked == true){
            	startTimeAmPm = "오전";
            }else{
            	startTimeAmPm = "오후";
            }
            
            var startTimeHour = $("#startTimeHour").val();
            var startTimeMinute = $("#startTimeMinute").val();

            var startTime = startTimeAmPm + " " + startTimeHour + ":"
                  + startTimeMinute;
            document.getElementById("startTime").value = startTime;
            
            //여기startTimeAmPm
            var endTimeChk = document.getElementById("endTimeAmPm");
            var endTimeAmPm ="";
            
            if(endTimeChk.checked == true){
            	endTimeAmPm = "오전";
            }else{
          	  endTimeAmPm = "오후";
            }
            
            var endTimeHour = $("#endTimeHour").val();
            var endTimeMinute = $("#endTimeMinute").val();
            var endTime = endTimeAmPm + " " + endTimeHour + ":"
                  + endTimeMinute;
            document.getElementById("endTime").value = endTime;

             studyForm.submit(); 

         };
      </script>

      <div style="text-align: center;">
         <button class="button1" style="width: 200px;"
            onclick="checkInsert(); return false;">
            <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>

         </button>

      </div>
      <!-- 여기 -->
   </form>

   <script>
      //마커를 담을 배열입니다
      var markers = [];

      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
         level : 3
      // 지도의 확대 레벨
      };

      //지도를 생성합니다    
      var map = new daum.maps.Map(mapContainer, mapOption);

      //장소 검색 객체를 생성합니다
      var ps = new daum.maps.services.Places();

      // 지도를 클릭한 위치에 표출할 마커입니다
      var SelectMarker = new daum.maps.Marker({
         // 지도 중심좌표에 마커를 생성합니다 
         position : map.getCenter()
      });
      // 지도에 마커를 표시합니다
      SelectMarker.setMap(map);

      var SelectLatlng;
      daum.maps.event.addListener(map, 'click', function(mouseEvent) {
         // 클릭한 위도, 경도 정보를 가져옵니다 
         SelectLatlng = mouseEvent.latLng;
         // 마커 위치를 클릭한 위치로 옮깁니다
         SelectMarker.setPosition(SelectLatlng);
         //마커에 클릭이벤트를 등록합니다
      });
      daum.maps.event.addListener(SelectMarker, 'click', function() {
         if (confirm("선택한 장소가 맞습니까?")) {
            var message = SelectLatlng.getLat() + ','
                  + SelectLatlng.getLng();
            var resultDiv = document.getElementById('resultMessage');
            resultDiv.innerHTML = "장소가 선택 되었습니다.";
            $("#result").val(message);
         }
      });

      //키워드로 장소를 검색합니다
      searchPlaces();

      //키워드 검색을 요청하는 함수입니다
      function searchPlaces() {
         var keyword = document.getElementById('keyword').value;

         if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
         }

         // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
         ps.keywordSearch(keyword, placesSearchCB);
      }

      //장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesSearchCB(status, data, pagination) {
         if (status === daum.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data.places);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);

         } else if (status === daum.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

         } else if (status === daum.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

         }
      }

      //검색 결과 목록과 마커를 표출하는 함수입니다
      function displayPlaces(places) {
         var listEl = document.getElementById('placesList'), menuEl = document
               .getElementById('menu_wrap'), fragment = document
               .createDocumentFragment(), bounds = new daum.maps.LatLngBounds(), listStr = '';

         // 검색 결과 목록에 추가된 항목들을 제거합니다
         removeAllChildNods(listEl);

         // 지도에 표시되고 있는 마커를 제거합니다
         removeMarker();

         for (var i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new daum.maps.LatLng(places[i].latitude,
                  places[i].longitude), marker = addMarker(placePosition,
                  i), itemEl = getListItem(i, places[i], marker); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function(marker, title) {

               daum.maps.event.addListener(marker, 'click', function() {

                  if (confirm("선택한 장소가 맞습니까?")) {
                     var latlng = marker.getPosition();
                     var message = latlng.getLat() + ','
                           + latlng.getLng();
                     var resultDiv = document
                           .getElementById('resultMessage');
                     resultDiv.innerHTML ="장소가 선택 되었습니다.";
                     $("#result").val(message);
                  }

               });

            })(marker, places[i].title);

            fragment.appendChild(itemEl);
         }

         // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
         listEl.appendChild(fragment);
         menuEl.scrollTop = 0;

         // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
         map.setBounds(bounds);
      }

      //검색결과 항목을 Element로 반환하는 함수입니다
      function getListItem(index, places) {
         var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
               + (index + 1)
               + '"></span>'
               + '<div class="info">'
               + '   <h5>' + places.title + '</h5>';

         if (places.newAddress) {
            itemStr += '    <span>' + places.newAddress + '</span>'
                  + '   <span class="jibun gray">' + places.address
                  + '</span>';
         } else {
            itemStr += '    <span>' + places.address + '</span>';
         }

         itemStr += '  <span class="tel">' + places.phone + '</span>'
               + '</div>';

         el.innerHTML = itemStr;
         el.className = 'item';

         return el;
      }

      //마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, idx, title) {
         var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
         imageSize = new daum.maps.Size(36, 37), // 마커 이미지의 크기
         imgOptions = {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset : new daum.maps.Point(13, 37)
         // 마커 좌표에 일치시킬 이미지 내에서의 좌표
         }, markerImage = new daum.maps.MarkerImage(imageSrc, imageSize,
               imgOptions), marker = new daum.maps.Marker({
            position : position, // 마커의 위치
            image : markerImage
         });

         marker.setMap(map); // 지도 위에 마커를 표출합니다
         markers.push(marker); // 배열에 생성된 마커를 추가합니다

         return marker;
      }

      //지도 위에 표시되고 있는 마커를 모두 제거합니다
      function removeMarker() {
         for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
         }
         markers = [];
      }

      //검색결과 목록 하단에 페이지번호를 표시는 함수입니다
      function displayPagination(pagination) {
         var paginationEl = document.getElementById('pagination'), fragment = document
               .createDocumentFragment(), i;

         // 기존에 추가된 페이지번호를 삭제합니다
         while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild(paginationEl.lastChild);
         }

         for (i = 1; i <= pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i === pagination.current) {
               el.className = 'on';
            } else {
               el.onclick = (function(i) {
                  return function() {
                     pagination.gotoPage(i);
                  }
               })(i);
            }

            fragment.appendChild(el);
         }
         paginationEl.appendChild(fragment);
      }

      // 검색결과 목록의 자식 Element를 제거하는 함수입니다
      function removeAllChildNods(el) {
         while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
         }
      }
   </script>


   <script src="/resources/js/common/jquery/jquery.minical.js"></script>
   <script>
      $("form.demo-1 :text").minical();
      $("form.demo-2 :text").minical({
         inline : true
      });
      $("form.demo-3 :text").minical({
         trigger : "i.trigger-icon"
      });
   </script>

   <script type="text/javascript">
      $(document)
            .ready(
                  function() {
                     var fileTarget = $('.filebox .upload-hidden');

                     fileTarget.on('change', function() {
                        if (window.FileReader) {
                           // 파일명 추출
                           var filename = $(this)[0].files[0].name;
                        } else {
                           // Old IE 파일명 추출
                           var filename = $(this).val().split('/')
                                 .pop().split('\\').pop();
                        }

                        $(this).siblings('.upload-name').val(filename);
                     });

                     //preview image 
                     var imgTarget = $('.preview-image .upload-hidden');

                     imgTarget
                           .on(
                                 'change',
                                 function() {
                                    var parent = $(this).parent();
                                    parent.children(
                                          '.upload-display')
                                          .remove();

                                    if (window.FileReader) {
                                       //image 파일만
                                       if (!$(this)[0].files[0].type
                                             .match(/image\//))
                                          return;

                                       var reader = new FileReader();
                                       reader.onload = function(e) {
                                          var src = e.target.result;
                                          parent
                                                .prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="' + src + '" class="upload-thumb"></div></div>');
                                       }
                                       reader
                                             .readAsDataURL($(this)[0].files[0]);
                                    } else {
                                       $(this)[0].select();
                                       $(this)[0].blur();
                                       var imgSrc = document.selection
                                             .createRange().text;
                                       parent
                                             .prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

                                       var img = $(this).siblings(
                                             '.upload-display')
                                             .find('img');
                                       img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
                                             + imgSrc + "\")";
                                    }
                                 });
                  });
   </script>


</body>
</html>