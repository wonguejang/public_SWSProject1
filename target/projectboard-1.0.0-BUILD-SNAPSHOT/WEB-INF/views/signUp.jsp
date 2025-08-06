<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>이메일 회원가입</title>
   <style>
      @import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
      * {
      	 box-sizing: border-box;
      }
      .border{
         border: 1px solid red;
      }
      #out_border {
         margin: 0;
         padding: 0;
         font-family: 'Spoqa Han Sans Neo', sans-serif;
         background: url("https://cdn.lol.ps/member/static/prod/80ffddd04aa2fd7eb08c93b558d5df687e14f89a/_app/immutable/assets/headerbg.B7yfBbtG.webp") no-repeat center center fixed;
         background-size: cover;
         color: rgb(255, 255, 255);
         height:953px;
         display: flex;
	     justify-content: center;
	     align-items: center;
      }
      #inner_border {
         display: flex;
         justify-content: center;   
         align-items: center;
      }
      #content_border {
         width: 480px;
         height: 741px;
      }
      #logo {
         display: flex;
          justify-content: center;
          align-items: center;
      }
      #logo > svg {
         width:128px;
         height:75px;
      }
      #content {
		background: rgba(255, 255, 255, 0.2);
        border-radius: 20px;
      }
      #content > h1 {
        font-size: 24px;
        line-height: 32px;
        font-weight: 700;
        text-align: center;		
        padding-top: 27px;
      }
      #content_detail {
          width: 352px;
          height: 521px;
          position: relative;
          left: 70px;
      }
      #content_detail > h2 {
          color: rgb(218 223 231);
          font-weight: 500;
          font-size: 14px;
          line-height: 20px;
          text-align: center;
          height: 20px
      }   
      #email, #password, #password_check {
         padding-top: 0px;
          padding-bottom: 8px;
          padding-left: 12px;
          padding-right: 12px
      }
      #email > p {
         width: 352px;
                  height: 20px;
         color: rgb(218 223 231);
          font-size: 14px;
          line-height: 20px;
          font-weight: 700;
          text-align: left;
          margin-bottom: 4px;
      }
      #email > input {
         width: 318px;
          height: 27px;
          border-radius: 8px;
      }
      #password > p {
         color: rgb(218 223 231);
          font-weight: 700;
          font-size: 14px;
          line-height: 20px;
          text-align: left;
          margin-bottom: 4px;
      }
      #password > input {
         width: 318px;
          height: 27px;
          border-radius: 8px;
      }
      input::placeholder {
         color: rgb(180 195 216);
      }
      #password_check > p {
         color: rgb(218 223 231);
          font-weight: 700;
          font-size: 14px;
          line-height: 20px;
          text-align: left;
          margin-bottom: 4px;
      }
      #password_check > input {
         width: 318px;
          height: 27px;
          border-radius: 8px;
      }
      #check_box {
          width: 352px;
            height: 184px;
      }
      #agree1 {
         display: flex;
         
      }
      #agree1 > input{
         width: 28px;
      }
      #agree1 > div > span {
         color: rgb(218 223 231);
          font-weight: 500;
          font-size: 14px;
          line-height: 20px;
      }
      #agree1 > div > p {
         color: rgb(218 223 231);
          font-size: 12px;
          line-height: 14px;
          margin: 0;
      }
      #agree2 {
         display: flex;
      }
      #agree2 > input {
         width: 24px;
         height: 24px;
      }
      #agree2 > div > a {
          color: rgb(33 58 150);
         font-weight: 700;
      }
      #agree2 > div > span {
         color: rgb(218 223 231);
          font-weight: 500;
      }
      #agree3 {
         display: flex;
      }
      #agree3 > input {
         width: 24px;
         height: 24px;
      }
      #agree3 > div > a {
         color: rgb(33 58 150);
         font-weight: 700;
      }
      #agree3 > div > span {
         color: rgb(218 223 231);
         font-weight: 500;
      }
      #agree4 {
         display: flex;
      }
      #agree4 > input {
          width: 37px;
      }
      #agree4 > div > span {
          color: rgb(218 223 231);
          font-weight: 500;
      }
      #agree4 > div > a {
          color: rgb(33 58 150);   
          font-weight: 700;
      }
      #agree4 > div > span {
          font-weight: 500;
      }
      #signup_button {
          color: rgb(255 255 255);
	      font-weight: 700;
	      font-size: 18px;
	      line-height: 24px;
	      padding-top: 8px;
	      padding-bottom: 8px;
	      background-color: rgb(33 58 150);
	      width: 100%;
	      height: 50px;
	      border-radius: 10px;
	      border:none;
	      position: absolute;
          top: 452px;
      }
       	input[type="check_box"]{
      		border-radius : 8px;
         	}
        #checkIdBtn {
		  background-color: #4a90e2;
		  color: white;
		  border: none;
		  padding: 3px 16px;
		  font-size: 14px;
		  border-radius: 6px;
		  cursor: pointer;
		  transition: all 0.3s ease;
		  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		}
			
		#checkIdBtn:hover {
		  background-color: #357ab7;
		  transform: translateY(-2px);
     	  box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
	     }
         	
   </style>
</head>
<body>
   <div id="out_border">
      <div id="inner_border">
         <div id="content_border">
            <div id="logo">
               <svg width="128" height="76" viewBox="0 0 128 76" fill="none" xmlns="http://www.w3.org/2000/svg" class="relative h-[74.91px] w-20 flex-shrink-0 flex-grow-0 desktop:w-32" preserveAspectRatio="xMidYMid meet"><path fill-rule="evenodd" clip-rule="evenodd" d="M33.4175 5.71024V30.4005H57.4434C59.1494 28.6956 61.5065 27.6411 64.1111 27.6411C66.7154 27.6411 69.0733 28.6956 70.7789 30.4005H94.8043V5.71024H33.4175Z" fill="#2F3130"></path><mask id="mask0_3_1854" maskUnits="userSpaceOnUse" x="53" y="1" width="23" height="22" style="mask-type: luminance;"><path fill-rule="evenodd" clip-rule="evenodd" d="M53.1992 1.04425H75.023V22.8317H53.1992V1.04425Z" fill="white"></path></mask><g mask="url(#mask0_3_1854)"><path fill-rule="evenodd" clip-rule="evenodd" d="M75.023 11.9378C75.023 17.9542 70.1374 22.8317 64.1109 22.8317C58.0844 22.8317 53.1992 17.9542 53.1992 11.9378C53.1992 5.92132 58.0844 1.04388 64.1109 1.04388C70.1374 1.04388 75.023 5.92132 75.023 11.9378" fill="#727272"></path></g><path fill-rule="evenodd" clip-rule="evenodd" d="M70.868 11.9378C70.868 15.6632 67.8434 18.6838 64.1112 18.6838C60.3795 18.6838 57.3539 15.6632 57.3539 11.9378C57.3539 8.2123 60.3795 5.19223 64.1112 5.19223C67.8434 5.19223 70.868 8.2123 70.868 11.9378" fill="#2F3130"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M90.3267 6.60976L69.5637 31.5137C66.1835 34.8887 66.2516 45.3374 73.8435 45.3374H117.488C123.15 45.3374 126.322 38.8265 122.828 34.38L101.006 6.60976C98.2885 3.15205 93.0433 3.15205 90.3267 6.60976" fill="#727272"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M128 45.7673C128 61.0826 115.564 73.4982 100.223 73.4982C84.8818 73.4982 72.4455 61.0826 72.4455 45.7673C72.4455 30.4519 84.8818 18.0363 100.223 18.0363C115.564 18.0363 128 30.4519 128 45.7673" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M123.02 45.7673C123.02 58.3366 112.813 68.526 100.223 68.526C87.6324 68.526 77.4259 58.3366 77.4259 45.7673C77.4259 33.1975 87.6324 23.0081 100.223 23.0081C112.813 23.0081 123.02 33.1975 123.02 45.7673" fill="#282828"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M82.4698 47.5553C81.4807 47.5553 80.6787 46.7547 80.6787 45.7673C80.6787 35.0088 89.446 26.2557 100.222 26.2557C101.212 26.2557 102.014 27.0563 102.014 28.0438C102.014 29.0313 101.212 29.8319 100.222 29.8319C91.4211 29.8319 84.2609 36.9806 84.2609 45.7673C84.2609 46.7547 83.4589 47.5553 82.4698 47.5553" fill="#444444"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M37.6739 6.60976L58.4365 31.5137C61.8172 34.8887 61.7491 45.3374 54.1572 45.3374H10.5118C4.85115 45.3374 1.67826 38.8265 5.1722 34.38L26.9946 6.60976C29.7122 3.15205 34.9569 3.15205 37.6739 6.60976" fill="#727272"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M0.000106812 45.7673C0.000106812 61.0826 12.4364 73.4982 27.7774 73.4982C43.1184 73.4982 55.5548 61.0826 55.5548 45.7673C55.5548 30.4519 43.1184 18.0363 27.7774 18.0363C12.4364 18.0363 0.000106812 30.4519 0.000106812 45.7673" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M4.98068 45.7673C4.98068 58.3366 15.1871 68.526 27.7775 68.526C40.3678 68.526 50.5747 58.3366 50.5747 45.7673C50.5747 33.1975 40.3678 23.0081 27.7775 23.0081C15.1871 23.0081 4.98068 33.1975 4.98068 45.7673" fill="#282828"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M10.0246 47.5553C9.0355 47.5553 8.23354 46.7547 8.23354 45.7673C8.23354 35.0088 17.0009 26.2557 27.7773 26.2557C28.7664 26.2557 29.5684 27.0563 29.5684 28.0438C29.5684 29.0313 28.7664 29.8319 27.7773 29.8319C18.976 29.8319 11.8157 36.9806 11.8157 45.7673C11.8157 46.7547 11.0137 47.5553 10.0246 47.5553" fill="#444444"></path></svg>
            </div>
            <div id="content">
               <h1>이메일 회원가입</h1>
               
               <div id="content_detail">
                  <h2>PS Member 에 이메일 계정으로 회원가입</h2>
				<form id="signUpForm" action="signUpAction" method="post">
                  <div id="input_text">
                    <div id="email">
					   <p>이메일</p>
					   <input type="text" name="user_id" id="user_id" />
					   <input type="button" id="checkIdBtn" value="중복확인">
					   <span id="idCheckResult" style="color: yellow; font-size: 13px;"></span>
					</div>
					
					<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
					<script>
					let isIdChecked = false;       // 중복 확인이 완료되었는지 여부
					  let lastCheckedId = "";        // 마지막으로 중복 확인한 ID

					  // 중복 확인 버튼 클릭 시
					  $('#checkIdBtn').click(function () {
					    var inputId = $('#user_id').val();
					    if (!inputId) {
					      $('#idCheckResult').text('ID를 입력하세요');
					      isIdChecked = false;       // 확인 안 됐음
					      return;
					    }

					    $.ajax({
					      url: 'checkId',   // 컨트롤러 매핑 주소
					      method: 'POST',
					      data: { "user_id": inputId },
					      success: function (result) {
					        if (result === 'available') {
					          $('#idCheckResult').text('사용 가능한 ID입니다.');
					          isIdChecked = true;           // 사용 가능하므로 true로 설정
					          lastCheckedId = inputId;      // 마지막으로 확인한 ID 저장
					        } else {
					          $('#idCheckResult').text('이미 사용 중인 ID입니다.');
					          isIdChecked = false;          // 사용 불가능
					        }
					      },
					      error: function (r) {
					        alert(r.responseText.e);
					      }
					    });
					  });

					  // ✅ 회원가입 폼 제출 시 중복확인 여부 검사
					  $('#signUpForm').submit(function (e) {
					    const currentId = $('#user_id').val();

					    // 중복 확인을 안 했거나, ID를 수정했으면 제출 막기
					    if (!isIdChecked || currentId !== lastCheckedId) {
					      alert("중복입니다.");
					      e.preventDefault();  // ❌ form 제출 방지
					    }
					  });
					</script>

                     <div id="password">   
                        <p>비밀번호</p>
                        <input type="password" name="user_pw" placeholder="영문, 숫자, 특수문자 조합 8~20자리"/>
                     </div>
                     <div id="password_check">
                        <p>비밀번호 확인</p>
                        <input type="password" name="user_pw_check" placeholder="영문, 숫자, 특수문자 조합 8~20자리"/>
                     </div>
                    
                     
                     <div id="check_box">
                        <div id="agree1">
                           <input type="checkbox" name="agree14" required/>
                           <div>
                              <span>만 14세 이상입니다(필수)</span>
                              <p>만 14세 미만 아동의 계정생성은 부모님 혹은 보호자의 승인이 필요합니다.</p>
                           </div>
                        </div>
                        <div id="agree2">
                           <input type="checkbox" name="agreeTerms" required/>
                           <div>
                              <a>이용약관</a>
                              <span>에 동의합니다.(필수)</span>
                           </div>
                        </div>
                        <div id="agree3">
                           <input type="checkbox"/ name="agreePrivacy" required>
                           <div>
                              <a>개인정보 수집 및 이용</a>
                              <span>에 동의합니다(필수)</span>
                           </div>
                        </div>
                        <div id="agree4">
                           <input type="checkbox" name="agreeMarketing"/>
                           <div>
                                 <span>서비스 홍보 및 마케팅 목적의</span>
                                 <a>개인정보 수집 및 이용</a>
                                 <span>에 동의합니다.(선택)</span>
                           </div>
                        </div>
                     </div>
                     <button type="submit" id="signup_button">회원가입</button>
                  </div>
              		</form>
               </div>
               
            </div>
         </div>
      </div>
   
   </div>
</body>
</html>