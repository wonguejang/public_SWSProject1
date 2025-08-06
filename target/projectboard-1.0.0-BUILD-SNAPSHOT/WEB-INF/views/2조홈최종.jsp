<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="com.wg.dto.Board.FreeBoardDto"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상우와 전적검색</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<style>
		@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
		* {
			box-sizing : border-box;
		}
		body {
			margin : 0;
			background-color : rgb(16,19,28);
			font-family: 'Spoqa Han Sans Neo', sans-serif;
			position: relative;
    		z-index: -1;
		}	
		ul li {
			list-style : none;
		}
		a {
			text-decoration : none;
		}
		.header_div {
			background-color : rgb(33, 59, 150);
			width : 100%;
			height : 40px;
		}
		.header_inner {
			display : flex;
			justify-content : space-between;
			margin : 0 auto;
			width : 1280px;
			height : 100%;
		}
		.header_inner > div:nth-child(1) { 	/* 해더 왼쪽 */
			display : flex;
			justify-content : space-around;
			align-items : center;
			width : 1030px; 
		
		}
		.header_inner > div:nth-child(2) > svg:first-child {	/* 로고 */
			color : white;
			width : 131px;
			height : 20px;
		}
		
		.header_inner > div:nth-child(1) > div:nth-child(2) {	/* 세로 bar */
			margin : 0 8px 0 7px;
			width : 1px;
			height : 18px;
			opacity : 0.2;
			background-color : white; 
		}
		.header_inner > div:nth-child(1) > svg:nth-child(3) {	/* TFTPS */
			width : 64px;
			height : 15.55px;
			color : white;
			opacity : 0.5;
		}
		.header_inner > div:nth-child(1) > svg:nth-child(3):hover {
			opacity : 1;
		}
		.header_inner > div:nth-child(1) > a{	/* 상단 왼쪽 메뉴 항목 */
			font-weight : 500;
			color : rgb(218, 223, 213);
			font-size : 16px;
			line-height : 24px;
			padding : 8px;
			border-radius : 8px;
			display: flex; 
			align-items: center;
		}
		.header_inner > div:nth-child(1) > a:hover {
			background-color : rgb(29,45,105);
		}
		.header_inner > div:nth-child(2) { /* 해더 오른쪽 */ 
		    display: flex;
		    width: 160px;
		    gap: 20px;
		}
		.menu-container {
			position : relative;
		}
		.menu-container:hover .sub-menu {
			display : block;
		}
		.menu-container > li > a {
			list-style : none;
			color : white;
			background-color : rgb(33, 59, 150);	
			position : relative;
			left : -15px;					
		}
		.menu-container > li > a:hover  {
			background-color: rgb(29, 45, 105);
		}
		.sub-menu{
			display : none;
			position : absolute;
			color : white;
			background-color : rgb(25,49,105);
			width: 81px;
			padding-left: 0px;
			left: 14px;
			top: 22px;
		}
		.sub-menu > li a{
			color : white;
		}
		.login {
			font-weight : 500;
			color : rgb(218, 223, 213);
			font-size : 16px;
			line-height : 24px;
			padding : 7px;
			border-radius : 8px;	
		}
		.login:hover {
			background-color: rgb(29, 45, 105);
		}
		.mypage {
			color: white;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    border-radius: 8px;
		    width: 130px;
		    height: 39px;
		}
		.mypage:hover {
			background-color: rgb(29, 45, 105);
		}
		.logout {
			color: white;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    border-radius: 8px;
		    width: 100px;
		    height: 39px;
		}
		.logout:hover {
			background-color: rgb(29, 45, 105);
		}
		.main {
			position : absolute;
			top : 0;
			left : 0;
			right : 0;
			height : 700px;
			background-image : url("https://cdn.lol.ps/static/prod/7a79ecd0389b0d567263b3ee03ac817a638624f8/_app/immutable/assets/headerbg.2b1e421b.webp");
			background-repeat : no-repeat;
			background-size : cover;
			z-index : -1;
		}
		.main > .search_bar {
			display : flex;
			justify-content : center;
			align-items : center;
			height : 156px;
		}
		.main > .search_bar > .search_bar_inner {
			margin-top : 200px;
			width : 1080px;
			padding : 0 30px;
			height : 56px;
		}
		.search_bar >.search_bar_inner > form > div:nth-child(1) {
			position : relative;
		    width: 1000px;
		    height: 55px;
		    background-color: white;
		    border-radius : 8px;
		}
		.search_bar > .search_bar_inner > form > div:nth-child(1) > input {
			border : none;
			outline : none;
			width : 100%;
			height : 100%;
			padding-left: 30px;
			font-size : 23px;
			border-radius : 8px;
			color : rgb(53,57,69);
		}
		.search_bar > .search_bar_inner > form > div:nth-child(1) > button > svg {
			position: absolute;
		    margin-left: -55px;
		    margin-top: 4px;
		    width: 50px;
		    height: 50px;
		    color: rgb(50, 84, 206);
		}

		/* 스와이퍼 들어올 자리  */
		#champions {
		    position: relative;
    		top: 200px;
		}
		#champions > h2 {
	        font-size: 20px;
        	line-height: 25px;
        	font-weight: 700;
        	padding: 0;
        	color: white;
        	margin-left: 163px;
		}
		
		#champions .swiper-slide {
			width: 180px;
			height: 380px;
		}
		#champions .swiper-slide > img {
			width: 100%;
			height: 100%;
		}
		.swiper-slide > div > img:nth-child(1) { 
			width: 35%;
    		height: 380px; 
    		
   		}
		.frontImg {
			display: block;
		}
		
		.inner_swiper {
			display: none;
		}
		
		/* 마우스 오버 시 - 썸네일 숨기고 상세 보여줌 */
		.swiper-slide:hover .frontImg {
			display: none;
		}
		
		.swiper-slide:hover .inner_swiper {
			display: flex;
			gap: 20px;
		}
		.swiper-slide:hover { width:645px !important;}
		
	 /* .swiper-slide > img:nth-child(2) { display:none; }
		.swiper-slide:hover > img:nth-child(1) { display:none; }
		.swiper-slide:hover > img:nth-child(2) { display:block; }
		.swiper-slide:hover { width:645px !important; height:390px !important; } */
		
		.inner_swiper {
			display : flex;
		}
		.inner_h3 {
			color: white;
    		padding-left: 20px;
			font-size : 40px;
			margin : 10px;
			text-align : center;
		}
		
		.inner_win_rate {
			color: white;
		    text-align: center;
		    padding-top: 40px;
		    padding-bottom: 40px;
		    font-size: 40px;
		}	
		.inner_btn {
			display: flex;
		    align-items: center;
		    justify-content: end;
		    height: 77px;
		    padding-right: 15px;
		}	
		.inner_button {
			color: blue;
		    font-weight: 600;
		    font-size: 17px;
		    border: none;
		    border-radius: 8px;
		}

		.board_div {
			margin : 0 auto;
			color : rgb(218, 223, 231);
			width : 1080px;
			height : 375px;
			display : flex;
		    position: absolute;
		    top: 750px;
 		    left: 500px;
		}
		.board_div h3 {
			color : rgb(61, 105, 255);
			font-weight : 700;
			font-size : 16px;
			line-height : 24px;
			margin-bottom : 10px;
		}
		.board_div > div {
			width : 540px;
			height : 100%;
		}
		.board_div > div > .board_row_left:nth-child(2) {
			border-top : 1px solid rgb(31,35,49);
		}
		.board_div > div > .board_row_left:last-child {
			border-bottom : 1px solid rgb(31,35,49);
		}
		.board_row_left .underline {
			border-bottom : 1px solid rgb(31,35,49);
		}
		.board_row_left {
			display : flex;
			padding : 6px 4px;
		}
		.board_row_left > div:nth-child(1) { 
			width: 70px;
		    font-size: 14px;
		    text-align: center;
		    line-height: 40px;
		}
		.board_row_left > div:nth-child(2) { 
		    font-size: 14px;
		    width: 372px;
		    overflow: hidden;
		    text-overflow: ellipsis;
		    white-space: nowrap;
		    line-height: 43px;
		}
		.board_row_left > div:nth-child(3) { width : 40px; font-size : 12px; }
		.board_row_left > div.blue { 
			background-color: rgb(31, 35, 49);
		    color: rgb(50, 48, 206);
		    font-weight: 700;
		    text-align: center;
		    line-height: 38px;
		    font-size: 20px;
		}
		.board_row_right .underline {
			border-bottom : 1px solid rgb(31,35,49);
		}
		.board_row_right {
			display : flex;
			padding : 6px 4px;
		}
		.board_row_right > div:nth-child(1) { 
			width: 70px;
		    font-size: 14px;
		    text-align: center;
		    line-height: 40px;
		}
		.board_row_right > div:nth-child(2) { 
		    font-size: 14px;
		    width: 372px;
		    overflow: hidden;
		    text-overflow: ellipsis;
		    white-space: nowrap;
		    line-height: 43px;
		}
		.board_row_right > div:nth-child(3) { width : 40px; font-size : 12px; }
		.board_row_right > div.blue { 
			background-color: rgb(31, 35, 49);
		    color: rgb(50, 48, 206);
		    font-weight: 700;
		    text-align: center;
		    line-height: 38px;
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
			top: 745px;
 			left: 150px;
		}
		#chat_container {
		    		position: relative;
		    		display: flex;
		    		height: auto;
		    		width: 320px;
		    		padding: 10px;
		  	}
		/* 실시간 채팅창 */
		#chat-box {
			position: sticky;
/* 			top: 100px;  */
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
	
	<!-- 검색어에 내용이 있는지 확인 -->
	<script>
	    function checkInput() {
	    	let input = document.getElementById('champInput');
	        let btn = document.getElementById('searchBtn');
	        
	        if(input.value.trim() === ""){
	        	alert("검색어를 입력 하세요!");
	        	return false;
	        }
	        return true;
	  	}
	</script>
	<!-- 화면에 나올 메시지들 -->
	 <script>
	 	/* api키가 없으면 띄워줄 메세지 */
	    <c:if test="${not empty api_message}">
	        alert('${api_message}');
	    </c:if>
	    /* 검색결과에 챔피언이 없으면 나오는 메시지 */
	    <c:if test="${not empty search_miss_message}">
	    	alert("${search_miss_message}");
    	</c:if>
    </script>
    <!-- 웹소캣 -->
    <script>
	    const ws = new WebSocket("chat");
	
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
	<div class = "header_div">
		<div class = "header_inner">
			<div>
				<a id = "mainHome" href = "${pageContext.request.contextPath}/">
					<img id="swsLogo" src="${pageContext.request.contextPath}/resources/images/swsLogo.png"/> <span id="logoSpan">LOL.SWS</span>
				</a>
				<div></div> <!-- 세로 bar -->
				<a href = "champinoDetail">챔피언 상세</a>
				<a href = "${pageContext.request.contextPath}/summonerInfo">소환사 상세</a>
				<a href = "summonerRank">소환사 랭킹</a>
				<div>
					<ul class = "menu-container">
						<li>
						<a href = "/projectboard/list">커뮤니티</a>
							<ul class = "sub-menu">
								<li><a href = "/projectboard/BUILD_BOARD3">빌드 연구소</a></li>
								<li><a href = "/projectboard/list">자유 게시판</a></li>
								<li><a href = "/projectboard/patch/patchlist">패치 게시판</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div>
				<c:choose>
					<c:when test = "${empty sessionScope.id}">	<!-- session에 id가 있는지 체크 -->
						<a class = "login" href = "${pageContext.request.contextPath}/login">로그인</a>
					</c:when>
					<c:otherwise>
						<a class = "mypage" href = "${pageContext.request.contextPath}/mypage">마이페이지</a>
						<a class = "logout" href = "${pageContext.request.contextPath}/logout">로그아웃</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>	
	</div>
	<div class = "main">
		<div class = "search_bar">
			<div class = "search_bar_inner">
				<form action = "${pageContext.request.contextPath}/champinoDetail" method = "get" onsubmit="return checkInput()">
					<div>
						<input type = "search" id = "champInput" name = "champName" placeholder = "챔피언 이름으로 검색"/>
						<button type = "submit" id = "searchBtn" style = "background: none; border: none; padding: 0; position : absolute;">
							<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="20px" height="20px"><path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path></svg>
						</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
	<div></div>
	<!-- 스와이퍼 시작 -->
	<div>${rotation.champName}</div>
	<div>${rotation.champUrl}</div>
	<div id="champions">
		<h2>주목해야 할 챔피언 (KR)</h2>
		<div class="swiper">
		  	<div class="swiper-wrapper">
				<c:forEach var="rotation" items = "${rotationChamp}" begin = "0" end = "9">
					<div class="swiper-slide">
					<!-- 이게 기존이미지 -->
						<img class = "frontImg" src="${rotation.champUrl}"/>
					<!-- 여가 기존이미지에 마우스올리면 나올div라고 -->
						<div class = "inner_swiper">
							<img class = "" src = "${rotation.champUrl}"/>
							<div style = "width: 60%;">
								<h3 class = "inner_h3">${rotation.champName}</h3>
								<div>
									<div class = "inner_win_rate"> 
										<div>승리 : ${rotation.win} 게임</div>
										<div>패배 : ${rotation.lose} 게임</div>
										<div>승률 : ${rotation.winRate} %</div>
									</div>
								</div>
								<div class = "inner_btn">
									<button class = "inner_button" type = "button">챔피언 상세정보 →</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
		  	</div>
		  	<div class="swiper-pagination"></div>
		  	<div class="swiper-button-prev"></div>
		  	<div class="swiper-button-next"></div>
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
	<!-- 하단 게시판 두개 -->
	<div class = "board_div">
		<div class = "left_board">	<!-- 왼쪽 게시판 -->
			<h3><a style = "text-decoration: none;" href = "/projectboard/list">자유 게시판 &gt;</a></h3>
			<c:forEach var = "list" items = "${listBoard}">
				<div class = "board_row_left underline">
					<div class = "bno">${list.fBno}</div>
					<div>${list.fTitle}</div>
					<div class = "blue">${list.fCheck}</div>
				</div>
			</c:forEach>
		</div>
		
		<div class = "right_board">	<!-- 오른쪽 게시판 -->
			<h3><a style = "text-decoration: none;" href = "/projectboard/BUILD_BOARD3">빌드 연구소 &gt;</a></h3>
			<c:forEach var = "list" items = "${buildList}">
				<div class = "board_row_right underline">
					<div class = "BBno">${list.BBno}</div>
					<div>${list.BTitle}</div>
					<div class = "blue">${list.BCheck}</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<!-- 스크립트 -->
	
	<script>
		/* 스와이퍼 챔피언 상세내용 보기 버튼 */
		$(function() {
			$('.inner_button').click(function() {
				const champName = $(this).closest('.inner_swiper').find('.inner_h3').text();
				location.href = "champinoDetail?champName="+champName	
			});
		});
	</script>
	
	<!-- 스와이퍼 -->
	<script>
		const swiper = new Swiper('.swiper', {
			speed: 500,
			spaceBetween: 100,
			slidesPerView: 6,
			autoplay: {
			    delay: 2500,   //2500,
			    disableOnInteraction: false,
		  	},
		  	//swiper.autoplay.stop();
		});
		$('.swiper-slide').on('mouseover', function(){
		  swiper.autoplay.stop();
		});
		$('.swiper-slide').on('mouseout', function(){
		  swiper.autoplay.start();
		});
//		const swiper = document.querySelector('.swiper').swiper;
//		// Now you can use all slider methods like
//		swiper.slideNext();
	</script>
	
	<!-- 하단 게시글 클릭시 해당 게시판 게시글 상세보기로 이동 -->
	<script>
		$(function() {
			$(document).on("click", ".board_row_left", function() {
				let bno = $(this).find('.bno').text();
				location.href = '${pageContext.request.contextPath}/BoardDetail?bno='+bno+'&page=1';
			});
			$(document).on("click", ".board_row_right", function() {
				let bno = $(this).find('.BBno').text();
				location.href = '/projectboard/detail?bbno=' + bno;
			});
		});
	</script>
</body>
</html>