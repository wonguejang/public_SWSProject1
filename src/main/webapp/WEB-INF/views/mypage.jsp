<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
	<title>마이페이지</title>
    <style>
        * {
        	box-sizing: border-box;
   	    }
		@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);

	    body {
        	margin: 0;
      		padding: 0;
	  	    font-family: 'Spoqa Han Sans Neo', sans-serif;
      		background: url('https://cdn.lol.ps/member/static/prod/80ffddd04aa2fd7eb08c93b558d5df687e14f89a/_app/immutable/assets/headerbg.B7yfBbtG.webp') no-repeat center center fixed;
      		background-size: cover;
      		display: flex;
      		justify-content: center;
      		align-items: center;
      		height: 100vh;
    	}
      #reset_container {
  	      background: rgba(255, 255, 255, 0.2);
          padding: 50px 40px;
     	  border-radius: 20px;
      	  width: 450px;
      	  color: white;
      	  text-align: center;
      }

      #set_container h2 {
          margin-bottom: 16px;
      	  font-size: 28px;
      }

      #set_container p {
      	  font-size: 16px;
          margin-bottom: 28px;
      }

      #name_input {
          width: 100%;
          padding: 16px;
      	  margin-bottom: 28px;
          border: none;
          border-radius: 10px;
          font-size: 18px;
      }

      #set_button {
	      width: 100%;
 	  	  padding: 16px;
	 	  background-color: #2d55ff;
	      color: white;
	      border: none;
	      border-radius: 10px;
	      font-size: 18px;
	      font-weight: bold;
	      cursor: pointer;
      }
      #logo {
 		  position: relative;
   		  left: 170px;
		  top: -50px;
      }
      #name_id {
    	  font-size:24px;
    	  font-weight:700;
    	  text-align: left;
    	  position: relative;
    	  top: 22px;
      }

  </style>
</head>
<body>
	<c:if test="${not empty nicknameSuccess}">
       <script>
           alert("${nicknameSuccess}");
       </script>
    </c:if>
	<div>
		<div id="logo">
			<svg width="128" height="76" viewBox="0 0 128 76" fill="none" xmlns="http://www.w3.org/2000/svg" class="relative h-[74.91px] w-20 flex-shrink-0 flex-grow-0 desktop:w-32" preserveAspectRatio="xMidYMid meet"><path fill-rule="evenodd" clip-rule="evenodd" d="M33.4175 5.71024V30.4005H57.4434C59.1494 28.6956 61.5065 27.6411 64.1111 27.6411C66.7154 27.6411 69.0733 28.6956 70.7789 30.4005H94.8043V5.71024H33.4175Z" fill="#2F3130"></path><mask id="mask0_3_1854" maskUnits="userSpaceOnUse" x="53" y="1" width="23" height="22" style="mask-type: luminance;"><path fill-rule="evenodd" clip-rule="evenodd" d="M53.1992 1.04425H75.023V22.8317H53.1992V1.04425Z" fill="white"></path></mask><g mask="url(#mask0_3_1854)"><path fill-rule="evenodd" clip-rule="evenodd" d="M75.023 11.9378C75.023 17.9542 70.1374 22.8317 64.1109 22.8317C58.0844 22.8317 53.1992 17.9542 53.1992 11.9378C53.1992 5.92132 58.0844 1.04388 64.1109 1.04388C70.1374 1.04388 75.023 5.92132 75.023 11.9378" fill="#727272"></path></g><path fill-rule="evenodd" clip-rule="evenodd" d="M70.868 11.9378C70.868 15.6632 67.8434 18.6838 64.1112 18.6838C60.3795 18.6838 57.3539 15.6632 57.3539 11.9378C57.3539 8.2123 60.3795 5.19223 64.1112 5.19223C67.8434 5.19223 70.868 8.2123 70.868 11.9378" fill="#2F3130"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M90.3267 6.60976L69.5637 31.5137C66.1835 34.8887 66.2516 45.3374 73.8435 45.3374H117.488C123.15 45.3374 126.322 38.8265 122.828 34.38L101.006 6.60976C98.2885 3.15205 93.0433 3.15205 90.3267 6.60976" fill="#727272"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M128 45.7673C128 61.0826 115.564 73.4982 100.223 73.4982C84.8818 73.4982 72.4455 61.0826 72.4455 45.7673C72.4455 30.4519 84.8818 18.0363 100.223 18.0363C115.564 18.0363 128 30.4519 128 45.7673" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M123.02 45.7673C123.02 58.3366 112.813 68.526 100.223 68.526C87.6324 68.526 77.4259 58.3366 77.4259 45.7673C77.4259 33.1975 87.6324 23.0081 100.223 23.0081C112.813 23.0081 123.02 33.1975 123.02 45.7673" fill="#282828"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M82.4698 47.5553C81.4807 47.5553 80.6787 46.7547 80.6787 45.7673C80.6787 35.0088 89.446 26.2557 100.222 26.2557C101.212 26.2557 102.014 27.0563 102.014 28.0438C102.014 29.0313 101.212 29.8319 100.222 29.8319C91.4211 29.8319 84.2609 36.9806 84.2609 45.7673C84.2609 46.7547 83.4589 47.5553 82.4698 47.5553" fill="#444444"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M37.6739 6.60976L58.4365 31.5137C61.8172 34.8887 61.7491 45.3374 54.1572 45.3374H10.5118C4.85115 45.3374 1.67826 38.8265 5.1722 34.38L26.9946 6.60976C29.7122 3.15205 34.9569 3.15205 37.6739 6.60976" fill="#727272"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M0.000106812 45.7673C0.000106812 61.0826 12.4364 73.4982 27.7774 73.4982C43.1184 73.4982 55.5548 61.0826 55.5548 45.7673C55.5548 30.4519 43.1184 18.0363 27.7774 18.0363C12.4364 18.0363 0.000106812 30.4519 0.000106812 45.7673" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M4.98068 45.7673C4.98068 58.3366 15.1871 68.526 27.7775 68.526C40.3678 68.526 50.5747 58.3366 50.5747 45.7673C50.5747 33.1975 40.3678 23.0081 27.7775 23.0081C15.1871 23.0081 4.98068 33.1975 4.98068 45.7673" fill="#282828"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M10.0246 47.5553C9.0355 47.5553 8.23354 46.7547 8.23354 45.7673C8.23354 35.0088 17.0009 26.2557 27.7773 26.2557C28.7664 26.2557 29.5684 27.0563 29.5684 28.0438C29.5684 29.0313 28.7664 29.8319 27.7773 29.8319C18.976 29.8319 11.8157 36.9806 11.8157 45.7673C11.8157 46.7547 11.0137 47.5553 10.0246 47.5553" fill="#444444"></path></svg>
		</div>  
	 	<div id="set_container" style="background: rgba(255, 255, 255, 0.2); padding: 50px 40px; border-radius: 20px; width: 450px; color: white; text-align: center;">
		   	<h2>닉네임 설정</h2>
		    <p id="name_id">닉네임 입력창</p>
		    <form action="${pageContext.request.contextPath}/setNickname" method="post">
			    <input type="text" id="name_input" name="user_name" required>
			  	<button type="submit" id="set_button">설정 완료</button>
			</form>
		</div>
	</div>
</body>
</html>
    