<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!-- 카카오톡 -->
	<script>
    	Kakao.init("d839f4c00a687864bf8ac19702b5951a"); // 앱 키
    	console.log("Kakao 초기화 상태:", Kakao.isInitialized());
   
    	// ✅ 버튼에서 직접 호출할 수 있게 글로벌 함수 정의
    	function kakaoLogin() {
       	Kakao.Auth.login({
        	scope: 'profile_nickname,profile_image,account_email',
         	success: function (authObj) {
           	console.log("카카오 로그인 성공:", authObj);
   
           	Kakao.API.request({
            url: "/v2/user/me",
            success: function (res) {
            	console.log("카카오 사용자 정보:", res);
   
               	const kakao_account = res.kakao_account;
               	const email = kakao_account.email;
               	const nickname = kakao_account.profile?.nickname;
   
               	if (!email || !nickname) {
                	alert("이메일 또는 닉네임 정보를 받아올 수 없습니다.");
                	return;
               	}
   
               	// ✅ 서버로 로그인 처리 요청
               	fetch("/projectboard/kakaoLogin", {
                	method: "POST",
                 	headers: {
                   		"Content-Type": "application/x-www-form-urlencoded"
                 	},
                 	body: "email=" + encodeURIComponent(email) + "&nickname=" + encodeURIComponent(nickname)
               	})
               	.then(response => response.text())
               	.then(result => {
                	if (result === "success") {
                   		// ✅ 로그인 성공 처리
                   	alert(nickname + "님 로그인 성공!");
                   	location.href = "/projectboard/";
                	} else {
                		alert("서버 로그인 처리 실패");
                	}
              	})
               	.catch(err => {
                	console.error("서버 전송 에러:", err);
                 	alert("서버 요청 중 오류가 발생했습니다.");
               	});
           	},
            fail: function (error) {
            	console.error("사용자 정보 요청 실패:", error);
               	alert("카카오 사용자 정보를 가져오지 못했습니다.");
            }
          });
       	},
        fail: function (err) {
        	console.error("카카오 로그인 실패:", err);
           	alert("카카오 로그인 실패");
        }
      });
     }
   </script>
	<!-- 구글 -->
	<script>
		function googleLogin() {
	    	const clientId = '597583037743-pr3mrvadj6qdhtj1v5oo0imcqk5rk5o3.apps.googleusercontent.com';
		    const redirectUri = 'http://localhost:9090/projectboard/google/callback';
		    const responseType = 'code';
		    const scope = 'email profile';
		    const accessType = 'offline';

		    const googleAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth?client_id=" + clientId
		      + "&redirect_uri=" + encodeURIComponent(redirectUri)
		      + "&response_type=" + responseType
		      + "&scope=" + encodeURIComponent(scope)
		      + "&access_type=" + accessType;
	
		    window.open(googleAuthUrl, "_blank", "width=500,height=600");
	 	}

	  	// 부모창에서 메시지 수신
		window.addEventListener("message", function(event) {
	    	if (event.data === "google-login-success") {
		      alert("Google 로그인 성공!");
		      location.href = "/projectboard/"; // ✅ 홈으로 강제 이동
	    	}
	    });
	</script>

	<style>
		.border {
			border: 1px solid red;
		}
		body {
			margin:0;
			padding : 0;
		}
		#main_back {
			width: 1918px;
  			height: 951px;
		}
		#back_img {
			margin: 0;
	        padding: 0;
	        font-family: 'Spoqa Han Sans Neo', sans-serif;
	        background: url("https://cdn.lol.ps/member/static/prod/80ffddd04aa2fd7eb08c93b558d5df687e14f89a/_app/immutable/assets/headerbg.B7yfBbtG.webp") no-repeat center center fixed;
	        background-size: cover;
	        color: rgb(255, 255, 255);
	        height:950px;
	        display: flex;
		    justify-content: center;
		    align-items: center;
		}
		#content_align {
			display: flex;
		    justify-content: center;
		    align-items: center;
		    width: 528px;
		    height: 670px;
		    flex-direction: column;	
		    background-color: rgba(255, 255, 255, 0.2);
    		border-radius: 16px;
		}
		#content_img  {
			width: 480px;
   			height: 110px;
			display: flex;
            justify-content: center;
            align-items: center;
		}
		#content_header {
			width: 480px;
  		    height: 150px;
		}
		#content_input {
			width: 480px;
   			height: 350px;
		}
		#content_header > div {
			font-size: 24px;
		    line-height: 32px;
		    font-weight: 700;
		    text-align: center;
		}
		#content_header > div:nth-child(2) > div:nth-child(1) {
			font-size: 14px;
		    font-weight: 500;
		    line-height: 20px;
		    position: relative;
    		top: 32px;
		}
		#content_header > div:nth-child(2) > div:nth-child(2) {
			display: flex;
   		    justify-content: center;
    	    position: relative;
    		top: 43px;
		}
		#logo1 {
			width: 40px;
  		    height: 40px;
  		    background-color: rgb(255 255 255);
		    border-radius: 4px;
		    margin-top: 6px;
		    margin-left: 4px;
		}
		#logo2 {
			width: 40px;
  		    height: 40px;
  		    background-color: rgb(255 255 255);
		    border-radius: 4px;
		    margin-top: 6px;
		    margin-left: 4px;
		}
		#content_input {
			display: flex;
						flex-direction: column;
		}
		#content_input > div:nth-child(2) > span {
			display: flex;
		    justify-content: center;
		    color: rgb(218 223 231);
		    font-weight: 500;
		    position: relative;
			top: 0px;
		}
		#email_input, #password_input {
			width: 352px;
			height: 39px;
			border-radius: 8px;
			position: relative;
			top: 69px;
			border: 1px solid black;
		}
		#input {
			display: flex;
			flex-direction: column;
			justify-content: center;
		    align-items: center;
		    position: relative;
		    top: -38px;
		}
		#login_button {
		    color: rgb(255 255 255);
		    font-weight: 700;
		    font-size: 18px;
		    line-height: 24px;
		    background-color: rgb(33 58 150);
		    width: 352px;
		    height: 48px;
		    border-radius: 8px;
		    display: block;
		    margin: auto;
		    border:none;
		    position: absolute;
  		    right: 770px;
            top: 620px;
		}
		#bottom {
			display: flex;
			justify-content: space-around;
			position: absolute;
		    top: 700px;
		    left: 766px;	
		    width: 400px;
		}
		#bottom a {
		    text-decoration: none;
		    color: white;
		    transition: color 0.2s ease;
	    }

		#bottom a:hover {
		    color: lightblue;
		}
		.login_title {
			position: absolute; 
 		    left:914px;
		}
		a {
		   border: none !important;
		   outline: none !important;
		   box-shadow: none !important;
		   background: none !important;
		}
		
	</style>
</head>
<body>
	<c:if test="${not empty joinSuccess}">
        <script>
          alert("${joinSuccess}");
        </script>
    </c:if>
	<div id="main_back">
		<div id="back_img">
			<div id="content_align">
				<div id="content_img">
					<svg width="128" height="76" viewBox="0 0 128 76" fill="none" xmlns="http://www.w3.org/2000/svg" class="relative h-[74.91px] w-20 flex-shrink-0 flex-grow-0 desktop:w-32" preserveAspectRatio="xMidYMid meet"><path fill-rule="evenodd" clip-rule="evenodd" d="M33.4175 5.71024V30.4005H57.4434C59.1494 28.6956 61.5065 27.6411 64.1111 27.6411C66.7154 27.6411 69.0733 28.6956 70.7789 30.4005H94.8043V5.71024H33.4175Z" fill="#2F3130"></path><mask id="mask0_3_1854" maskUnits="userSpaceOnUse" x="53" y="1" width="23" height="22" style="mask-type: luminance;"><path fill-rule="evenodd" clip-rule="evenodd" d="M53.1992 1.04425H75.023V22.8317H53.1992V1.04425Z" fill="white"></path></mask><g mask="url(#mask0_3_1854)"><path fill-rule="evenodd" clip-rule="evenodd" d="M75.023 11.9378C75.023 17.9542 70.1374 22.8317 64.1109 22.8317C58.0844 22.8317 53.1992 17.9542 53.1992 11.9378C53.1992 5.92132 58.0844 1.04388 64.1109 1.04388C70.1374 1.04388 75.023 5.92132 75.023 11.9378" fill="#727272"></path></g><path fill-rule="evenodd" clip-rule="evenodd" d="M70.868 11.9378C70.868 15.6632 67.8434 18.6838 64.1112 18.6838C60.3795 18.6838 57.3539 15.6632 57.3539 11.9378C57.3539 8.2123 60.3795 5.19223 64.1112 5.19223C67.8434 5.19223 70.868 8.2123 70.868 11.9378" fill="#2F3130"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M90.3267 6.60976L69.5637 31.5137C66.1835 34.8887 66.2516 45.3374 73.8435 45.3374H117.488C123.15 45.3374 126.322 38.8265 122.828 34.38L101.006 6.60976C98.2885 3.15205 93.0433 3.15205 90.3267 6.60976" fill="#727272"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M128 45.7673C128 61.0826 115.564 73.4982 100.223 73.4982C84.8818 73.4982 72.4455 61.0826 72.4455 45.7673C72.4455 30.4519 84.8818 18.0363 100.223 18.0363C115.564 18.0363 128 30.4519 128 45.7673" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M123.02 45.7673C123.02 58.3366 112.813 68.526 100.223 68.526C87.6324 68.526 77.4259 58.3366 77.4259 45.7673C77.4259 33.1975 87.6324 23.0081 100.223 23.0081C112.813 23.0081 123.02 33.1975 123.02 45.7673" fill="#282828"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M82.4698 47.5553C81.4807 47.5553 80.6787 46.7547 80.6787 45.7673C80.6787 35.0088 89.446 26.2557 100.222 26.2557C101.212 26.2557 102.014 27.0563 102.014 28.0438C102.014 29.0313 101.212 29.8319 100.222 29.8319C91.4211 29.8319 84.2609 36.9806 84.2609 45.7673C84.2609 46.7547 83.4589 47.5553 82.4698 47.5553" fill="#444444"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M37.6739 6.60976L58.4365 31.5137C61.8172 34.8887 61.7491 45.3374 54.1572 45.3374H10.5118C4.85115 45.3374 1.67826 38.8265 5.1722 34.38L26.9946 6.60976C29.7122 3.15205 34.9569 3.15205 37.6739 6.60976" fill="#727272"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M0.000106812 45.7673C0.000106812 61.0826 12.4364 73.4982 27.7774 73.4982C43.1184 73.4982 55.5548 61.0826 55.5548 45.7673C55.5548 30.4519 43.1184 18.0363 27.7774 18.0363C12.4364 18.0363 0.000106812 30.4519 0.000106812 45.7673" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M4.98068 45.7673C4.98068 58.3366 15.1871 68.526 27.7775 68.526C40.3678 68.526 50.5747 58.3366 50.5747 45.7673C50.5747 33.1975 40.3678 23.0081 27.7775 23.0081C15.1871 23.0081 4.98068 33.1975 4.98068 45.7673" fill="#282828"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M10.0246 47.5553C9.0355 47.5553 8.23354 46.7547 8.23354 45.7673C8.23354 35.0088 17.0009 26.2557 27.7773 26.2557C28.7664 26.2557 29.5684 27.0563 29.5684 28.0438C29.5684 29.0313 28.7664 29.8319 27.7773 29.8319C18.976 29.8319 11.8157 36.9806 11.8157 45.7673C11.8157 46.7547 11.0137 47.5553 10.0246 47.5553" fill="#444444"></path></svg>
				</div>
				<div id="content_header">
					<div>
						<span>SWS Member 로그인</span>
					</div>
					<div>
						<div>
							<span>간편하게 시작하기</span>
						</div>
						<div>
							<div id="logo1" onclick="googleLogin()" style="cursor: pointer;">
								<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAKKADAAQAAAABAAAAKAAAAAB65masAAAFF0lEQVRYCe1XXUxcRRQ+5+6F3WV3U1vYtNooVWK1IW3StAsNQuhfhFIhGLu0Vm37YAzqS7UvtauxqZWkidFHn4x/T4BYFYglLAVMKdJVE4xJY6xRa6lQoJB2f2Dv7j2eu7iwe+/d36zoA/Myc37mnG/OzDkzA7DSViLw30YAs3VP9fUFk4HxJwCwConKuF9PAGsASQaCcUAYR8KfwCB0FxntfdjZ6c/GV8YAZ+oqikPBsAuIDhGQLT2nOIcIH6HJcLaoa3gsvTkLWmkDJKczf3LmjzMAdJwjZMzEyZIuzgkA7xZWFbyJpwdCS/zEo7QAzu6rKJEkqZ0ItiY2lb4EAb8xW7DJ+tXIRKpZvKDkbbrGURoMhi7lClzEG1JlIEC7k3tekBqSKUXOW0geYp21yfQykfFZlAUQni9yX/k0nXliIiU6ttM0dcN3ns+bPZGOwkfEMOsMgoC8EFISgCHQvSx4jOkqjnx+dH4UXKF75MMoL1WfEOD0n/43uGwkP3MIHSDmuewXhn7Wc+Stc6zzB/EUAr2syJXIZQJOmaObJHdObHx0fnTVaOzqFeWlhl4UscHeM9K/xEs8mt5bVsOLXcvb+kliLX2JLkCpL++dOY/9RKDvPgBZpYLgRxTr7L3Dg/omc8vVZDGR08A3wGHT9kmwPXsNBJsU59EgCEeXC5ziWBUeAKnfWAth+esoKvKJ4P1iA4SuWwEF+N7e69kelS1Hr4kgyvL+WMdoCYHt6WtgKr8FolV6K1a2HGNNBEPu/C6+Y+NAKkC4REyIe6R1qUDtafGOp9JJJBfNuLXnFctfsXJNmeFseyBWYXFM+O3iOMmAMz/roh6eAyUAcQC1WwykDxDpZhJcORHxzmkWpwGYE09ZGiGuGeqpGoAEeF2tFKEJuSj+uw1lnFJ70ADkrNEHiLRDPTnnNAqa55cmSfjJ/htf/nGNSXrft2m1o+2RWk9T+4U4oYoQDFCrYsWRsiw8AyQ/F8f8hxBN+ZoKoCkz0kVjDcjyIogZ2Qiv390GP0hFSqnxeA528P8j+7a7xTvAAahWW2Agv/S5rBvVfM0Wi7sa3EEw3FYUfwythiOz1RFwCs0lxFHe5jygjLNpj7f4y/XAKbZIgC49mxqAiO3h32XbYFvgQXhpthKmZFPcvDDJHzvanJoIxCnpEA3nyBYC+QMdUYRlkA3dejINQEXpdGDba+/5N8+HtVc1LxUKiKirvLVpl55BPd6+FrL7wr5unluqJ+ftvXrPw6aBBDI9NkBZ64G3ZaJT+tIFLp/JDkLB9V1Tu+6DdW+bc9UdomYM3v+i+ebxYiFUqGtOMGCj+6TlSz2hJkmiSjv7j5l8E97LXN2TvqojT37gJz/AEBKMERJ/SbGEo/UQV4RqPreR4ouyFcwTzSD6N0ddRHr+4V3qc1mq4pgxREKAik5Fx+HiYCjo4exI+i+JsZdiiGC83QjGmcaIHoMbIzOWX3y1IOFnPilAxYrjs6dKIYxuPnfKRZ6TJvq3gHmy+W4+Wap6TlpHkxlNCVCZXHH+YIk0H25Ptd3JHMXKEIUbwtymIyNHz/TH8vXGulmsVrz8ZOuvGwTcweftHCf2vFqeCc3b+rnRkrclHXCK3bQiGAtAOZdSKOjienMomgCxct0x/zvZUZeIwtnhpvYrujoJmBkDjNqp73yhYDwwU0+yXMl3YBkbWs+yNXwMOJHhFi99kl9GVxlbL39m3HyHa+7ZqK2VfiUC/+cI/A0ELKgWQBN9wAAAAABJRU5ErkJggg=="/>
							</div>
							<div id="logo2" onclick="kakaoLogin()" style="cursor: pointer;">
								<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/KakaoTalk_logo.svg/960px-KakaoTalk_logo.svg.png" alt="카카오톡 로고" style="width: 40px; height: 40px;"/>
							</div>
						</div>
					</div>
				</div>
				<div id="content_input">
					<form action="login" method="post">
						<div>
							<hr style="width: 90%; height: 1px; background-color: #bbb; border: none; margin: 20px auto;">
						</div>
						<span class="login_title">이메일 로그인</span>
						<div id="input">
							<input type="text" name="user_id" placeholder=" Email address" id="email_input">
							<input type="password" name="user_pw" placeholder=" Password" id="password_input">
						</div>
						<button type="submit" id="login_button">로그인</button>
						<c:if test="${not empty error}">
						    <div style="color: red; text-align: center; margin-top: 10px;">
						    ${error}
						    </div>
						</c:if>
					</form>
					<c:if test="${not empty error}">
					    <script>
					    	alert("${error}");
					  	</script>
					</c:if>
				</div>
				<div id="bottom">
					<a href="reset-password">비밀번호 찾기</a>
					<span class="import_any">ㅣ</span>
					<a href="signUp">이메일 회원가입</a>
				</div>
			</div>
		</div>		
	</div>
</body>
</html>