<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="utf-8" session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- bootstrap.css -->
<link type="text/css" href="/resources/bootstrap/css/bootstrap-theme.css" rel="stylesheet" />
<link type="text/css" href="/resources/bootstrap/css/bootstrap.css" rel="stylesheet" />
<link type="text/css" href="/resources/css/mainStyle.css" rel="stylesheet">

<link type="text/css" href="/resources/css/applicationStyle.css" rel="stylesheet" />
<!-- jquery.js -->
<script type="text/javascript" src="/resources/js/common/jquery/jquery-3.2.1.js"></script>

<!-- bootstrap.js -->
<script type="text/javascript" src="/resources/bootstrap/js/bootstrap.js"></script>
   
    <title>application</title>
    
</head>
<body>
 
  <section>
  <div class="detail">
      <div class="detail-col1">
        <img src="data:image/jpeg;base64,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" aria-hidden="true" style="width: 100px; height:80px;" />
          
         <div style="color:skyblue; padding:7px 0px;">
              12주
         </div>
         <div>
            (3개월 주1회)
         </div>
      </div>
      <div class="detail-col2">
         <div style="color:skyblue; padding:7px 0px;">
              분당-서현역
         </div>
         <div>
          단기간에 언어 습득
         </div>
      </div>
      <div class="detail-col3">
          <div style="padding:7px 0px;">
             A그룹 (토)
          </div>
          <div>
          	11:00 ~ 13:00
      
         </div>
      </div>
  </div>
  <div class="check">
       <hr />
       
       <div class="container">
        <div class="container-left clear_after">
            <p>어느 일정에 참여하세요?</p> 
        </div>
        
        <div class="container-right">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="participation" value="A" />&nbsp; A그룹 (토)11:00 ~ 13:00
        </div>
      </div>
      
       <hr />
       
       <div class="container">
        <div class="container-left">
            <p>언제부터 참여하시나요?</p>
        </div>
        
        <div class="container-right">
            <p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;첫 스터디 시작일</p>
            &nbsp;&nbsp;<input type="date" id="startDate"/>
            <div style="font-weight: bold;"><img src="/resources/images/!.png" style="width:15px; height:14px;" /> A그룹은 (시작일 선택한 날짜) 부터 첫 스터디를 시작합니다. 일정을 고려해 신중하게 신청해주세요.</div>

        </div>
      </div>
        
       <hr />
       
       <div class="container">
        <div class="container-left">
            <div>힣힣힣님!</div>
            <div>제 스터디 준비를 도와주세요</div>
        </div>
        
        <div class="container-right">
           <div><img class="image-wrap clear_after" src="/resources/images/image.jpg" style=" width:40px; height:40px;" /></div>
           <div id="text-tail"></div>
            <div id="text">스터디를 신청한 목적은 무엇인가요?</div>
            <br />
            <textarea class="form-control col-sm-5 ta" rows="3" placeholder="내용을 입력해주세요." style="resize:none; margin:20px 0 20px;"></textarea>
            
            <div><img class="image-wrap" src="/resources/images/img.jpg" style=" width:40px; height:40px;" /></div>
            
            <div id="text1-tail"></div>
            <div id="text1" class="arrow_box">
                스터디 안내를 드릴 연락처를 알려주세요!
            </div>
            <br />
            <textarea class="form-control col-sm-5 ta" rows="3" placeholder="내용을 입력해주세요." style="resize:none; margin:20px 0 20px;"></textarea>

        </div>
        
        <br />
        </div>
        
       <hr style="margin: 20px 0 0" />
       <button type="submit" class="btn btn-primary btn-lg raised clear_after">&nbsp;다음으로&nbsp;</button>
   </div>
   
   
   </section>
    
</body>
</html>

