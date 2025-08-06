<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>패치노트 게시판</title>
    <style>
        @import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
      	* {
           box-sizing: border-box;
      	}
      	.border {
        	border: 1px solid red;
        }
      	body {
           margin: 0;
       	   font-family: 'Spoqa Han Sans Neo', sans-serif;
           background-color: rgb(16, 19, 28);
           width:auto;
      }
      #header_div {
         width: 100%;
           height: 40px;
            background-color: rgb(33, 59, 150);
      }
      #header_inner {
         display: flex;
          JUSTIFY-CONTENT: space-between;
          margin: 0 auto;
          width: 1280px;
          height: 100%;
      }
      #header_inner > div:nth-child(1) { /*헤더 왼쪽 */
         display:flex;
         justify-content : space-between;
         width:1030px;   
         align-items: center;
      }
      #header_inner > div:nth-child(1) > svg:first-child { /*   로고 */
          color: white;   
          width: 132px;
          height: 20px;
      }
      #header_inner > div:nth-child(1) > div:nth-child(2) {    /* 세로    bar */
          margin: 0 8px 0 7px;
          width: 1px;
          height: 18px;
          opacity: 0.2;
          background-color: white;
      }
      #header_inner > div:nth-child(1) > a {
          font-weight : 500;
         color : rgb(218, 223, 213);
         font-size : 16px;
         line-height : 24px;
         padding : 8px;
         border-radius : 8px;
         display: flex;
         align-items: center;
      }
      #header_inner > div:nth-child(1) > a:hover {
         background-color : rgb(29,45,105);
      }
      #header_inner > div:nth-child(2) { /*헤더 오른쪽  */
         width:130px;   
      }
      #header_inner > div:nth-child(2) > a:first-child {
          color: rgb(218, 223, 213);
          display: flex;
          align-items: center;
          justify-content: center;
      }
      #header_inner > div:nth-child(2) > a:hover {
         background-color : rgb(29,45,105);
      }
      #header_inner > div:nth-child(2) > a {
          font-weight : 500;
         color : rgb(218, 223, 213);
         font-size : 16px;
         line-height : 24px;
         padding : 8px;
         border-radius : 8px;
      }
      a {
          text-decoration: none;
      }
      
      #menu_container {
         position : relative;
      }
      #menu_container:hover #sub_menu {
         display : block;
      }
      #menu_container > li > a {
         list-style : none;
         color : white;
         background-color : rgb(33, 59, 150);   
         position : relative;
         left : -15px;               
      }
      #menu_cotainer > li, ul {
         list-style: none;
      }
      #sub_menu {
         display : none;
         position : absolute;
         color : white;
         background-color : black;
         width: 143px;
         padding-left: 0px;
         left: 19px;
         top: 27px;
      }
      #sub_menu > li a {
         color : white;
         display: block;
          padding: 10px 20px;
          font-size: 14px;
          text-decoration: none;
      }
      #main {
         width:100%;
         height:230px;
         background-image : url("https://cdn.lol.ps/static/prod/7a79ecd0389b0d567263b3ee03ac817a638624f8/_app/immutable/assets/headerbg.2b1e421b.webp");
         background-repeat : no-repeat;
         background-size : cover;
         position: absolute;
         z-index : -1;
      }
      #search_bar {
         width:1080px;   
         height:230px;
      }
      #search_bar_inner {
         position: relative;
          top: 33px;
          left: 432px;
          width: 520px;
          
      }
      #search_bar > #search_bar_inner > div:nth-child(1) > input {
         width:480px;
         height:40px;   
         border-radius: 8px;   
         padding-left: 30px;
         font-size: 16px;
          line-height: 24px;
          font-weight: 500;
          border: none;
      }
      #search_bar > #search_bar_inner > div:nth-child(1) > svg {
         position: absolute;
          margin-left: -33px;
          margin-top: 8px;
          width: 25px;
          height: 25px;
          color: rgb(50, 84, 206);
      }
      #text_contain {
         display: flex;
          position: absolute;
          top: 200px;
          left: 30px;
          width: 100%;
          height: 200px;
      }
      #head_name {
         position: relative;
          width: 316px;
          height: 120px;
          left: 433px;
          top: -29px
      }
      #text_contain > #head_name > h1 {
         font-size: 20px;
          font-weight: 300;
          line-height: 25px;
          color: rgb(126, 155, 255);      
      }
      #text_contain > #head_name > h2 {
         font-size: 16px;
          line-height: 24px;
          font-weight: 700;
          padding: 8px;
          display: flex;
          justify-content: space-between;
      }
      #text_contain > #head_name > h2 > a {
         color: white;
      }
      #bod_box {
         position: absolute;
          top: 450px;
          width: 100%;
          height: 1240px;
      }
      
      #out_boad {
      display: inline-block;
       left: 500px;
       width: 840px;
       height: 1240px;
       position: relative;
       top: 250px;
      }
	   #min_search {
	      display : flex;
	      justify-content : flex-end;
	      color: white;
	       width: 800px;
	       height: 40px;
	   }
	   #min_search > div {
	      display: flex;
	       align-items: center;
	   }
	   #min_search > div:nth-child(1) > select {
	      color : rgb(218 223 231);
	      font-weight: 400;
	      width : 140px;
	      height : 30px;
	      font-size: 14px;
	      line-height: 20px;
	      border-style: solid;
	      border-color: .e5e7eb;
	      border-radius : 4px;
	      background-color: rgb(16 19 28);
	      }
	      #min_search > div:nth-child(2) > form > input {
	      background-color: rgb(16 19 28);
	      border-color: .e5e7eb;
	      padding: 8px;
	      border-radius: 8px;
	      width : 240px;
	      height : 30px;
	      opacity: 1;
	         color: .9ca3af;
	      }
	   #min_searh2 > form > svg {
	      position: absolute;
	       right: -1px;
	       top: 8px;
	       width: 30px;
	       height: 23px;
	       border-width: 0;
	       border-style: solid;
	       border-color: .e5e7eb;
	       padding-right: 12px;
	   }
	    .content_boad {
	          position: absolute;
	          margin-top: 20px;
	          width: 920px;
	          height : 1080px;
	          left: -31px;
      }
      .board_top {
         color: rgb(218 223 231);
         font-weight: 700;
         font-size: 12px;
          line-height: 14px;
          text-align : center;
          display: flex;
          justify-content: space-around;
          margin-top: 10px;
      }
      .board_top > span:nth-child(1) {
         position: relative;
         left: -59px;
      }
      .board_top > span:nth-child(2) {
         position: relative;
         left: -95px;
      }
      .board_top > span:nth-child(3) {
          position: absolute;
          right: 533px;
      }
      .board_top > span:nth-child(4) {
         position: absolute;
              right: 347px;
      }
      .board_top > span:nth-child(5) {
          position: relative;
          left: 257px;
      }
      .board_top > span:nth-child(6) {
          position: relative;
          left: 192px;
      }
      .board_main {
         position: relative;
         display: flex;
         align-items: center;
         width: 100%;
         justify-content: space-around;
         top: 5px;
         height : 48px;
         padding-left : 8px;
         padding-right : 8px;
         text-align : center;
         border-top : 1px solid gray;
         border-bottom : 1px solid gray;
      }
      .board_main > div:nth-child(1) {
         display: flex;
         align-items: center;
      }
      .board_main > div > svg {
         width : 23px;
         height : 23px;
         color : rgb(50, 84, 206);
      }
      .board_main > div {
         color: rgb(218 223 231);
      }
      .writeBtn {
	      position: relative;
		  right: 434px;
		  border-radius: 8px;
		  color: white;
		  background-color: rgb(33, 59, 150);
		  font-weight: 700;
		  text-align: center;
		  height: 40px;
		  font-size: 20px;      
      }
      #mainHome > svg {
			color : white;
			width : 131px;
			height : 20px;
	}
	/* 실시간 채팅창 */
	#matchs_container{
		position: absolute;
		top: 360px;
		left: 100px;
		z-index: 9999;
	}
	#chat_container {
	  	position: relative;
	  	display: flex;
	  	height: 15000px;
	  	width: 320px;
	  	padding: 10px;
	 	}
	/* 실시간 채팅창 */
	#chat-box {
		position: sticky;
		top: 100px; 
		width: 300px;
		height: 265px;
		background-image: url("${pageContext.request.contextPath}/resources/images/chat.png");
		margin-top: 10px;
	}
	#chat-scroll {
    	height: 185px;
    	overflow-y: auto;
    	margin-top: 40px;
    	margin-left: 20px;
    	margin-right: 20px;
    	color: white;
	}
	#chat {
    	position: relative;
	}
	#chat-input {
    	display: flex;
    	margin: 10px 20px;
    	gap: 10px;
	}
	
	#message {
    	flex: 1;
    	padding: 5px;
    	border: none;
    	border-radius: 4px;
	}
	
	#sendBtn {
    	padding: 5px 10px;
    	border: none;
    	border-radius: 4px;
    	background-color: #4CAF50;
    	color: white;
    	cursor: pointer;
	}
	#SearchResult {
		padding-left: 30px;
		margin-top: 10px;
	}
	#SearchResult a {
	    color: white;
	    text-decoration: none;
	    border: 1px solid white;
	    border-radius: 10px;
	    padding: 0px 10px 0px 10px
	}
			
	#SearchResult a:hover {
		color: #cc3300;
		text-decoration: underline;
		cursor: pointer;
	}
	#swsLogo {
		width: 40px;
		height: auto;
		background-size: cover;
		border-radius: 50%;
	}
	#logoSpan {
		margin-left:10px;
	}
   </style>
   <script>
   		const ws = new WebSocket("${pageContext.request.contextPath}/chat"); 
	
	    ws.onmessage = (e) => {
	        const log = document.getElementById("chatLog");
	        log.innerHTML += e.data + "<br/>";
	        log.scrollTop = log.scrollHeight;
	    };
	
	    function sendMessage() {
	        const msgInput = document.getElementById("msg");
	        if (ws.readyState === WebSocket.OPEN) {
	            ws.send(msgInput.value);
	            msgInput.value = "";
	        } else {
	            alert("웹소켓 연결이 닫혀 있습니다.");
	        }
	    }
	</script>
</head>
<body>
   <div id="header_div">
      <div id="header_inner">
         <div>
         	<a id = "mainHome" href = "${pageContext.request.contextPath}/">
				<img id="swsLogo" src="${pageContext.request.contextPath}/resources/images/swsLogo.png"/> <span id="logoSpan">LOL.SWS</span>
			</a>
            <div></div> <!-- 세로 bar -->
            <a href="${pageContext.request.contextPath}/champinoDetail">챔피언 상세</a>
            <a href="${pageContext.request.contextPath}/summonerInfo">소환사 상세</a>
            <a href="${pageContext.request.contextPath}/summonerRank">소환사 랭킹</a>
            <div>
               <ul id="menu_container">
                  <li>
                  <a href="${pageContext.request.contextPath}/list">커뮤니티</a>
                     <ul id="sub_menu">
                        <li><a href="/projectboard/BUILD_BOARD3">빌드 연구소</a></li>
                        <li><a href="${pageContext.request.contextPath}/list">자유 게시판</a></li>
                        <li><a href="${pageContext.request.contextPath}/patch/patchlist">패치 게시판</a></li>
                     </ul>
                  </li>
               </ul>
            </div>
         </div>
         <div>
            <c:choose>
               <c:when test="${empty sessionScope.id}">
                  <a href = "${pageContext.request.contextPath}/login">로그인</a>
               </c:when>
               <c:otherwise>
                  <a href="${pageContext.request.contextPath}/mypage" style="position: relative; right: 57px;">마이페이지</a>
                  <a href = "${pageContext.request.contextPath}/logout" style="position: relative; top: -32px; left:70px; font-size:17px;">로그아웃</a>
               </c:otherwise>
            </c:choose>
         </div>
      </div>
   </div>
   <!-- 상단바 다음 -->
   <div>
      <div id="main">
      <div id="search_bar">
         <div id="search_bar_inner">
            <div>
               <input type= "search" placeholder="칼 애쉬 검색"/>
               <svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="20px" height="20px"><path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path></svg>
            </div>
         </div>
      </div>
      </div>
   </div>
   <div id="text_contain">
      <div id="head_name">
         <h1>커뮤니티</h1>
         <h2>
            <a href = '/projectboard/BUILD_BOARD3'>빌드 연구소</a>
            <a href = '${pageContext.request.contextPath}/list'>자유 게시판</a>
            <a href = '${pageContext.request.contextPath}/patch/patchlist'>패치 게시판</a>
         </h2>
      </div>
   	</div>
	<div id="matchs_container">
		<div id="chat_container">
		    <div id="chat-box">
		        <div id="chat-scroll">
				    <div id="chatLog" style=" border:1px soild red; height:170px; overflow:auto; margin-top:10px;"></div>
		        </div>
		        <div id="chat-input">
		            <input type="text" id="msg" placeholder="채팅 입력" style=" width: 207px; margin-top:-10px; height:25px"/><button onclick="sendMessage()" style="margin-top:-10px; height:25px">전송</button>
		        </div>
		    </div>
		</div>
	</div>
   <div id="out_boad">
      <div id="min_search">
	  <!-- 게시글 작성 버튼 -->
	  <c:if test="${sessionScope.grade == 1}">   
	      <div>
		     <button type="button" class="writeBtn" onclick="location.href='${pageContext.request.contextPath}/patch/patchwrite'">게시글 작성</button>
		  </div>
  	  </c:if>
	   <!-- 검색 영역 전체를 form으로 묶음 -->
	    <form action="${pageContext.request.contextPath}/patch/search" method="get" style="display: flex; align-items: center; position: relative; right: -97px;">
	      
	       <!-- 카테고리 선택 -->
	       <div>
	          <select name="category" style="height:21px; border-radius: 8px;">
	             <option value="title">제목</option>
	             <option value="title_content">제목+내용</option>
	             <option value="content">내용</option>
	          </select>
	       </div>
	
	       <!-- 검색 입력창 + 제출버튼 -->
	       <div id="min_searh2" style="display: flex; align-items: center;">
	          <input type="text" name="keyword" placeholder="게시물 검색" style="border-radius: 8px;" />
	          <button type="submit" style="background: none; border: none; cursor: pointer;">
	             <svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="23px" height="23px">
	                <path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path>
	             </svg>
	          </button>
	       </div>
    	</form>
	</div>
	<!-- 게시글 -->
   		<div class = 'content_boad' >
             <div class = "board_top" >
                <span>번호</span>
                <span>제목</span>
                <span>작성자</span>
                <span>날짜</span>
                <span>조회</span>
                <span>추천</span><br/>
             </div>
             <c:forEach var="dto" items="${list}">
			    <a class="board_main" href="${pageContext.request.contextPath}/patch/patchdetail?pBno=${dto.pBno}">
			      <div style="width:5%;"><span>${dto.pBno}</span></div> <!-- DB 고유 번호 표시 -->
			      <div style="max-width: 170px; width: 40%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis" title="${dto.pTitle}"><span>${dto.pTitle}</span></div>
			      <div style="max-width: 160px; width: 15%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis" title="${dto.pWriter}""><span>${dto.pWriter}</span></div>
			      <div style="width: 20%;"><span><fmt:formatDate value="${dto.pDate}" pattern="yyyy-MM-dd"/></span></div>
			      <div style="width: 10%;"><span id="view-count-${dto.pBno}">${dto.pCheck}</span></div>
			      <div style="width: 10%;"><span id="like-count-${dto.pBno}">${dto.pRating}</span></div>
			   </a>
			 </c:forEach>
          </div>
     </div>
         
</body>
</html>