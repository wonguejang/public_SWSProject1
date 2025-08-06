<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>소환사 랭킹</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script>
		let g_page = 1;
		/* 랭킹 그리기 */
		function add_new_rankList() {
			$.ajax({
				type : 'post',
				url : 'rankList',
				data : {"page" : g_page++}, //페이지 번호 보내서 10명씩 가져오기
				success : function(response) {
					for(let i = 0; i <= response.length-1; i++) {
						let dto = response[i];
						console.log(response);
						let sum = dto.win + dto.lose;
						
						let str = `<div class = "board_main" >
					 		<div class = "board_maincontent1" >
					 			<div >
									\${dto.rnum}
					 			</div>
					 			<div >
									<img src = "\${dto.userIcon}"/>
									<span class="summoner_search" style="cursor:pointer;">\${dto.summonerId}</span>
				 				</div>
				 			</div>
				 			<div class = "board_maincontent2" >
					 			<div >
									<img src = "https://cdn.lol.ps/static/prod/8a15f01fe550732646aac9d405e18a56265e5f6a/_app/immutable/assets/emblem-challenger.b3537afb.webp"/>
									<span>\${dto.rating}</span>
									LP
					 			</div>
					 			<div class = "win_rate" >
									<div>	<!-- 승률퍼센트, 게임수 -->
										<p>\${dto.winRate}%</p>
										<p>\${sum}게임</p>
									</div>
									<div class = "bar_chart"> <!-- 그래프칸 -->
										<div class = "chart" style = "width : \${dto.winRate}%"> <!-- 막대그래프 -->
											
										</div>
										<div> <!-- 좌우 승패 -->
											<p>\${dto.win}승</p>
											<p>\${dto.lose}패</p>
										</div>
									</div>
					 			</div>
				 			</div>
				 		</div>`;
 				$(".content_boad").append(str);
					}
					
				},
				error : function(e,r,s) {
					alert("에러");
					consol.log(r,e,s);
				}
			});
		}	
		/* 무한 스크롤을 사용해 랭킹 추가로 보여주기 */
		$(window).scroll(function(){
			  var scrT = $(window).scrollTop();
			  console.log(scrT); //스크롤 값 확인용
			  if(scrT == $(document).height() - $(window).height()){
				add_new_rankList();
			  }
		});
		
		/* 초기랭킹 그리기 (10명) */
		$(function() {
			add_new_rankList();
		});
		
		/* 검색어에 내용이 있는지 체크 */	    
	    function checkInput() {
	    	let input = document.getElementById('champInput');
	        let btn = document.getElementById('searchBtn');
	        
	        if(input.value.trim() === ""){
	        	alert("검색어를 입력 하세요!");
	        	return false;
	        }
	        return true;
      	}
		
		$(function() {
			/* 랭킹 소환사 아이디 클릭시 소환사 상세로 이동 */
			$(document).on('click', '.summoner_search', function() {
				let content = $(this).text();
				let encodedContent = encodeURIComponent(content);
				location.href = "summonerInfo?id="+encodedContent;
			});
			/* 갱신 버튼 */
			$(document).on('click', '.rankingUpdate', function() {
				let yes_or_no = confirm("api 갱신에 5분정도 걸립니다.");
				if(!yes_or_no) return;
				//로딩 div 띄우기
				$('#loader').show();
				
				location.href = 'rankingUpdate'; /* 여기서 컨트롤러 이동 */
			});
		});
	</script>
	<!-- 웹 소캣 -->
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
	<style>
		@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
		* {
			box-sizing : border-box;
		} 
		body {
			margin : 0; 
			background-color : rgb(16,19,28);
			font-family: 'Spoqa Han Sans Neo', sans-serif;
		}	 
		ul li {
			list-style : none;
		}
		a {
			text-decoration: none;
		    color: rgb(218, 223, 231);
		    font-size: 17px;
		    font-weight: 500;
		    line-height: 23px;
		    display: flex;
		    align-items: center;
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
		.header_inner > div:nth-child(1) > svg:first-child {	/* 로고 */
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
		#header_inner > div:nth-child(1) > a{	/* 상단 왼쪽 메뉴 항목 */
			font-weight : 500;
			color : rgb(218, 223, 213);
			font-size : 16px;
			line-height : 24px;
			padding : 8px;
			border-radius : 8px;
		}
		.header_inner > div:nth-child(1) > a:hover {
			background-color : rgb(29,45,105);
		}
		.header_inner > div:nth-child(2) { /* 해더 오른쪽 */ 
			display: flex;
		    width: 180px;
		    gap: 20px;
		}
		.menu-container {
			position : relative;
		}
		.menu-container:hover .sub-menu {
			display : block;
		}
		.menu-container > li > a {
		    text-align: center;
		    width: 94px;
		    height: 40px;
			list-style: none;
		    color: white;
		    background-color: rgb(33, 59, 150);
		    position: absolute;
		    left: 2px;				
		}
		.sub-menu{
		    display: none;
		    position: absolute;
		    color: white;
		    background-color: rgb(25, 49, 105);
		    width: 94px;
		    padding-left: 0px;
		    left: 3px;
		    top: 11px;
		}
		
		#menuList {
			width: 94px;
    		height: 40px;
   		    border-radius: 8px;
		}
		#menu-hover:hover{
			background-color: rgb(29, 45, 105);
		}
		
		#menu-hover{
	       font-weight: 500;
		    font-size: 16px;
		    top: -29px;
		    line-height: 40px;
		    border-radius: 8px;
		}
		
		.sub-menu > li {
		    margin: 3px;
		    margin-bottom: 10px;
		    padding: 0px;
		}
		.sub-menu > li a{
			color : white;
		}
		.sub-menu > li:hover {
			background-color :  rgb(25,49,105);
		}
		.login {	/* 상단 왼쪽 메뉴 항목 */
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
			height : 400px;
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
			top : -70px;
		    width: 500px;
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
		h1 {
			color : white;
		}
		.bod_box {
			position: absolute;
		    top: 450px;
		    width: 100%;
		    height: 1240px;
		}
		.rankingUpdate {
			position: absolute;
		    right: 50px;
		    top: -40px;
		    font-size: 30px;
		    font-weight: 700;
		    border-radius: 8px;
		    width: 100px;
		    height: 50px;
		    color: rgb(61 105 255);
		    line-height: 20px;
		    background-color: rgb(32 42 72);
		}
		.head_name {
		    position: relative;
		    width: 500px;
		    height: 120px;
		    left: 440px;
		    top: 80px;
		}
		.text_contain {
			display: flex;
		    position: absolute;
		    top: 200px;
		    left: 0px;
		    width: 100%;
		    height: 200px
		}
		.border {
			border : 1px solid red;
		}
		.out_boad {
		    display: flex;
		    justify-content: center;
    		align-items: center;
		}
		.content_boad {
		   	position: absolute;
		    top: 30px;
		    width: 1000px;
		    height: 1080px;
		}
		.board_top {
			display : flex;
			justify-content : space-between;
			border-bottom : 2px solid grey;
			color : rgb(130, 135, 153);
			font-size : 27px;
			font-weight : 700;
			line-height : 20px;	
			padding-bottom: 15px;
		}
		.board_topcontent1 {
			display : flex;
		    gap: 180px;
		    padding-left: 100px;
		}
		.board_topcontent2 {
			display : flex;
			gap : 180px;
			padding-right : 120px;
		}
		
		/* 여기 이하 작업중 */
		.board_main {
			position: relative;
		    display: flex;
			align-items: center;
			width: 100%;
			top: 5px;
			height : 48px;
			padding-left : 8px;
			padding-right : 8px;
			text-align : center;
			border-bottom : 1.5px solid grey;
		}
		.board_main > div:nth-child(1) {
			display : flex;
			flex : 1;
			justify-content : flex-start;
			padding-left: 100px;
			gap: 125px;
		}
		.board_main > div:nth-child(2) {
			display : flex;
			flex : 1;
			justify-content : flex-end;
			gap : 30px;
		}
		.board_main > div {
			color: rgb(218 223 231);
		}
		.board_maincontent1 {
			display: flex;
		    flex: 1;
		    justify-content: flex-start;
		    align-items: center;
		    padding-left: 100px;
		    gap: 240px;
		}
		.board_maincontent1 > div {
			display: flex;
		    align-items: center;
		    gap: 20px;
		    margin-left: -30px;
		}
		.board_maincontent1 > div:nth-child(1) {
			font-weight: 600;
		    font-size: 22px;
		    margin-left: 8px;
		    width: 39.3438px;
		}
		.board_maincontent1 > div:nth-child(2) > img {
			width : 30px;
			margin : 5px;
			margin-left : 20px;
		}	
		.board_maincontent1 > div:nth-child(2) > svg {
			width : 16px;
		}
		.board_maincontent2 > div {
			display : flex;
			align-items : center;
			gap : 15px;
		    font-size: 16px;
			font-weight: 500;
			margin-right : 70px;
		}
		.board_maincontent2 > div:nth-child(1) > img {
			width : 40px;
			height : 40px;
		}
		.win_rate > div:nth-child(1) > p {
			font-size : 18px;
			margin : 0px;
			width : 64.2656px;
		}
		.win_rate > div:nth-child(1) > p:nth-child(2) {
			font-size : 10px;
		}
		.bar_chart > div:nth-child(2) {
			display : flex;
			justify-content : space-between;
		}
		.bar_chart > div:nth-child(2) > p {
			font-size : 10px;
			margin : 0px;
		}
		.bar_chart {
			position: relative;
			bottom: 5px;
			width : 100%;
			height : 10px;
			background-color : rgb(230, 236, 243);
			
		}
		.chart {
/* 			width : 56%;
 */			height : 10px;
			padding : 0px;
			background-color : rgb(0, 180, 128);
		}
		
		#mainHome > svg {
			color : white;
			width : 131px;
			height : 20px;
		}
		/* 실시간 채팅창 */
		#matchs_container{
			position: absolute;
			top: 480px;
			left: 100px;
			z-index: 9999;
		}
		#chat_container {
		  		position: relative;
		  		display: flex;
		  		/* height: 10000px; */
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
		/* api사용해 갱신시 로딩창 */
		.loader {
			border: 20px solid rgb(243, 243, 243); /* 연한 회색 바깥 테두리 */
		  	border-top: 20px solid rgb(52, 152, 219); /* 파란색 위쪽 테두리 */
		  	border-radius: 50%;
		  	width: 200px;
		  	height: 200px;
		  	animation: spin 1s linear infinite; /* 계속 회전 */
		  	position: fixed;
		  	top: 50%;
		  	left: 50%;
		  	transform: translate(-50%, -50%); /* 화면 가운데 */
		  	z-index: 9999;
		  	display: none; /* 처음엔 숨김 */
		}
		@keyframes spin {
		    0% {
		    	transform: rotate(0deg);
		  	}
		  	100% {
		    	transform: rotate(360deg);
		  	}
		}
	</style>
</head>
<body style = "width : auto;">
	<!-- 로딩창 -->
	<div class="loader" id="loader"></div>
	
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
						<a href = "/projectboard/BUILD_BOARD3" id = "menu-hover">커뮤니티</a>
							<ul class = "sub-menu">
								<li><a href = "/projectboard/BUILD_BOARD3">빌드 연구소</a></li>
								<li><a href = "list">자유 게시판</a></li>
								<li><a href = "/projectboard/patch/patchlist">패치 게시판</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div>
				<c:choose>
					<c:when test = "${empty sessionScope.id}"> <!-- 세션에 id가 있는지 확인후 보여주기 -->
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
						<input type = "search" id = "champInput" name = "champName" placeholder = "챔피언으로 검색"/>
						<button type = "submit" id = "searchBtn" style = "background: none; border: none; padding: 0; position : absolute;">
							<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="20px" height="20px"><path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path></svg>
						</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
	<!-- 수정 -->
	<div class = "text_contain">
		<div class = 'head_name'> <!-- h1 으로 커뮤니티 쓰고 h -->
			<h1>소환사 랭킹</h1>
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
	<!-- 게시판 만들기 -->
	<div class = 'bod_box'> 	<!-- 전체를 감싸서 위치를 잡을 녀석 -->
		<div>
			<button class = "rankingUpdate">갱신</button>
		</div>
		<!-- 게시글들 -->
		<div class = 'out_boad'>
			<div class = 'content_boad'>
			 	<div class = "board_top">
			 		<div class = "board_topcontent1">
			 			<div>순위</div>
			 			<div>소환사</div>
			 		</div>
			 		<div class = "board_topcontent2">
			 			<div>티어</div>
			 			<div>승률</div>
			 		</div>
			 	</div>
			</div>
		</div>
	</div>
</body>
</html>