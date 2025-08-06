<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="com.wg.dto.Board.FreeBoardDto"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script>
		$(function () {
			//게시글 상세보기 bno(게시글번호), page(페이지번호)
			$(document).on("click", ".board_main", function() {
				let bno = $(this).find(".bno").text();  // string
				location.href = "${pageContext.request.contextPath}/BoardDetail?bno=" + bno + "&page=${pageNum}";
			});
			//게시글 작성
			$("#write_btn").click(function() {
				location.href = "${pageContext.request.contextPath}/boardWrite";
			});		
		});
		
		/* 전체 검색 검색어에 내용이 있는지 체크 */	    
	    function checkInput() {
	    	let input = document.getElementById('champInput');
	        let btn = document.getElementById('searchBtn');
	        
	        if(input.value.trim() === ""){
	        	alert("검색어를 입력 하세요!");
	        	return false;
	        }
	        return true;
      	}
		/* 게시글 검색 */
		$(document).on('click', '#search_board', function(e) {
		  	e.preventDefault();
			
			let category = $("select[name = 'category']").val();
			let boardSearch = $("input[name = 'board_search_content']").val();
			
			$.ajax({
				type : 'get',
				url : 'searchBoardList',
				data : {'category':category, 'boardSearch':boardSearch},
				success : function(response) {
					console.log("응답 : " + response);
					
					$('.content_boad').find('.board_main').remove();
					
					$.each(response, function(i, dto){
						console.log(dto);
						let appendSearchBoardList = `<a class = "board_main" >
											       <!-- 여기서 계속 추가됨 -->
													<div class = "bno"><span>\${dto.fBno}</span></div>
													<div><span>\${dto.fTitle}</span></div>
													<div><span>\${dto.fWriter}</span></div>
													<div><span>\${dto.fFormattedDate}</span></div>
													<div><span>\${dto.fCheck}</span></div>
													<div><span>\${dto.fLike}</span></div>
									 		   </a>`;	
					$('.content_boad').append(appendSearchBoardList);
					
					});
				},
				error : function(r, e, s) {
					alert("게시글 검색 에러!");
				}
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
			width: 160px;
		    display: flex;
		    align-items: center;
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
		    margin-top : 0px;			
		}
		.sub-menu{
			display : none;
		    position: absolute;
		    text-align: center;
		    color: white;
		    background-color: rgb(25, 49, 105);
		    width: 92px;
		    padding-left: 0px;
		    left: 4px;
		    top: 23px;
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
		    top: -16px;
		    line-height: 40px;
		    border-radius: 8px
		}
		.sub-menu > li, a{
			color : white;
		    margin-bottom: 5px;
		    margin-top: 5px;
		}
		.login {
			color : white;
		    display: flex;
		    align-items: center;
		    justify-content: center;
	 	    width: 90px;
		    height: 40px;
		    border-radius: 8px;
		    margin-top : 0px;
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
		.header_inner > div:nth-child(2) > a:first-child:hover{
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
		.second_name {
			display : flex;
			gap : 40px;
		}
		.second_name > a{
			color : white;
		}
		.bod_box {
			position: absolute;
		    top: 390px;
		    width: 100%;
		    height: 1240px;
		}
		.head_name {
	        position: relative;
		    width: 500px;
		    height: 120px;
		    left: 450px;
		    top: 60px;
		}
		.text_contain {
			display: flex;
		    position: absolute;
		    top: 200px;
		    left: 0px;
		    width: 100%;
		    height: 200px
		}
		.out_boad {
			display: inline-block;
		    position: absolute;
		    top: 70px;
		    left: 450px;
		    
		}
		
		.min_search {
			display : flex;
			justify-content : flex-end;
			color: white;
		    width: 1000px;
		    height: 40px;
		}
		.min_search > div {
			display: flex;
		    align-items: center;
		}
		.min_search > div:nth-child(1) > select {
			color : rgb(218 223 231);
			font-weight: 400;
			width : 140px;
			height : 30px;
			font-size: 14px;
    		line-height: 20px;
    		border-style: solid;
    		border-color: rgb(229, 231, 235);
    		border-radius : 4px;
    		background-color: rgb(16 19 28);
    	}
    	#board_search {
			background-color: rgb(16 19 28);
			border-color: rgb(229, 231, 235);
			padding : 8px;
			border-radius : 8px;
			width : 240px;
			height : 30px;
			opacity: 1;
    		color: white;
    	}
		.min_searh2 > button > svg {
			position: absolute;
		    right: 5px;
		    top: 8px;
		    width: 30px;
		    height: 23px;
		    border-width: 0;
		    border-style: solid;
		    border-color: rgb(229, 231, 235);
		    padding-right: 12px;
		    color : white;
		}
		.content_boad {
		    position: absolute;
		    margin-top: 20px;
		    width: 1000px;
		    height : 1080px;
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
  				left: -43px;
		}
		.board_top > span:nth-child(2) {
			position: relative;
  				left: 60px;
		}
		.board_top > span:nth-child(3) {
		    position: absolute;
			right: 360px;
		}
		.board_top > span:nth-child(4) {
			position: absolute;
  				right: 250px;
		}
		.board_top > span:nth-child(5) {
		    position: relative;
  				left: 345px;
		}
		.board_top > span:nth-child(6) {
		    position: relative;
  				left: 235px;
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
		    width: 100px;
		    justify-content: center;
		}
		.board_main > div:nth-child(2) {
			display: flex;
		    align-items: center;
		    width: 480px;
		    justify-content: center;
		}
		.board_main > div:nth-child(3) {
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    width: 100px;
		    margin-left: -30px;
		}
		.board_main > div:nth-child(4) {
		    display: flex;
		    align-items: center;
		    width: 100px;
		    margin-right: -17px;
		    justify-content: center;
		}
		.board_main > div:nth-child(5) {
			display: flex;
		    align-items: center;
		    width: 100px;
		    justify-content: center;
		    position: relative;
		    left: 25px;	
		}
		.board_main > div:nth-child(6) {
			display: flex;
		    align-items: center;
		    width: 100px;
		    justify-content: center;
		    position: relative;
		    left: 13px;	
		}
		.board_main > div > svg {
			width : 23px;
			height : 23px;
			color : rgb(50, 84, 206);
		}
		.board_main > div {
			color: rgb(218 223 231);
		}
		#write_btn {
	       position: absolute;
		   top: 8px;
		   right: 400px;
		}
		#write_btn2 {
		    font-size: 15px;
		    color: white;
		    background: black;
		    border: 1px solid white;
		    border-radius: 8px;
		}
		#div_pagination{
		    font-size: 25px;
		    color: white;
		    position: absolute;
		    width: 100%;
		    text-align: center;
		    bottom: 430px;
		}
		#mainHome > svg {
			color : white;
			width : 131px;
			height : 20px;
		}
		/* 실시간 채팅창 */
		#matchs_container{
			position: absolute;
			top: 80px;
			left: 120px;
			z-index: 9999;
		}
		#chat_container {
		  	position: relative;
		  	display: flex;
		  	height: 1500px;
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
</head>
<body style = "width : auto;">
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
				<div id = "menuList">
					<ul class = "menu-container">
						<li>
						<a href = "/projectboard/BUILD_BOARD3" id = "menu-hover">커뮤니티</a>
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
					<c:when test = "${empty sessionScope.id}"> <!-- 세션에 id가 있는지 확인 -->
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
	<div class = "text_contain">
		<div class = 'head_name'> <!-- h1 으로 커뮤니티 쓰고 h -->
			<h1>커뮤니티</h1>
			<h2 class = 'second_name'>
				<a href = '/projectboard/BUILD_BOARD3'>빌드 게시판</a>
				<a href = '/projectboard/list'>자유게시판</a>
				<a href = '${pageContext.request.contextPath}/patch/patchlist'>패치 게시판</a>
			</h2>
		</div>
	</div>
	<!-- 게시판 만들기 -->
	<div class = 'bod_box' > 	<!-- 전체를 감싸서 위치를 잡을 녀석 -->
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
		<!-- 게시글들 -->
		<div class = 'out_boad' >
			<div id = "write_btn">
				<form>
					<c:if test="${not empty sessionScope.id}">
					    <button type="button" id="write_btn2">게시글 작성</button>
					</c:if>
				</form>
			</div>
			<div class = "min_search">
				<div >
					<select name ='category'>
						<option value = '제목'>제목</option>
						<option value = '제목+내용'>제목+내용</option>
						<option value = '내용'>내용</option>
					</select>
				</div>
				<div class = "min_searh2" >
					<input type = "text" id = "board_search" name = "board_search_content" placeholder = "게시물 검색"/>
					<button id = "search_board" type="button" style="background: none; border: none; cursor: pointer;">
						<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="23px" height="23px" class=""><path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path></svg>
					</button>
				</div>
			</div>
			<div class = 'content_boad' >
			 	<div class = "board_top" >
			 		<span>번호</span>
			 		<span>제목</span>
			 		<span>작성자</span>
			 		<span>날짜</span>
			 		<span>조회</span>
			 		<span>추천</span><br/>
			 	</div>
			 	<c:forEach var = "dto" items = "${listBoard}">
			 		<a class = "board_main" >
						<!-- 여기서 계속 추가됨 -->
						<div class = "bno"><span>${dto.fBno}</span></div>
						<div><span>${dto.fTitle}</span></div>
						<div><span>${dto.fWriter}</span></div>
						<div><span><fmt:formatDate value = "${dto.fDate}" pattern= "yyyy-MM-dd"/></span></div>
						<div><span>${dto.fCheck}</span></div>
						<div><span>${dto.fLike}</span></div>
			 		</a>
		 		</c:forEach>
		 		<div id="div_pagination">
					<span>
						<c:if test = "${startPageNum > 1}">
							<a href="list?page=${startPageNum -1}">이전</a>
						</c:if>
						
						<c:forEach var = "i" begin = "${startPageNum}" end = "${endPageNum}">
							<c:choose>
								<c:when test = "${i != pageNum}">
									<a href="list?page=${i}">${i}</a>
								</c:when>
								<c:otherwise>
									<span>${i}</span>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test = "${endPageNum < lastPageNum}">
							<a href="list?page=${endPageNum + 1}">다음</a>
						</c:if>
					</span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>