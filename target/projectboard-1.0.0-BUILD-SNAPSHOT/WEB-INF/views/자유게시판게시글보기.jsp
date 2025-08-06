<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.wg.dto.Board.ReplyBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.wg.dto.Board.FreeBoardDto"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판 게시글보기</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script>
		let bno = ${bno}; // 보고있는 게시물의 bno
		let id = "${id}";	// 현재 로그인 한 사람의 id
		let idWriter = "${idWriter}";	//작성자
		let page = "${pageNum}";	//페이지번호

		function redraw() {
			$.ajax({
				type : 'post',
				url : '/projectboard/getReplyList',
				data : {'bno':bno},
				dataType : 'json',
				success : function(reply) {
					try{
						console.log(reply);
						console.log("type : " + typeof reply);
						console.log("isArray : " + Array.isArray(reply));
					}catch(e){
						alert("뭔가 오류 : " + e);
					}
					$('.reply_list').empty();	//내용 비우고 다시 그리기
					
					for(let i = 0; i <= reply.length-1; i++){	//반복적으로 그려서 append
						
						let deleteBtnWriter = ``;
						if(reply[i].rWriter === idWriter) { //댓글 작성자와 로그인 한사람이 같은가?
							deleteBtnWriter = `<button class = "btn_reply_delete">댓글 삭제</button>`;
						}
						
						let rawDate = reply[i].rWritedate;
						let simpleDate = rawDate.split(" ")[0];
						console.log(rawDate);
						console.log(simpleDate);
						
						let str = `<div class = "reply_items">
									  <div class = "writer"> 
									  	작성자 : \${reply[i].rWriter} 
									  	<span class = "rno" style = "display : none;">
									  		\${reply[i].rno}
								  		</span> 
								  		\${deleteBtnWriter}
						  		  	  </div>
									  <div class = "reply_content">\${reply[i].rContent}</div>
								   </div>
								   <div id = "writedate">
									  <span>작성일자 : </span>
									  <span>\${simpleDate}</span>
								   </div>
								   <hr/>`;
						$('.reply_list').append(str);
					}
				},
				error : function(r,s,e){
					alert('댓글 불러오기 실패 ' + r.status + " " + r.responseText + " " + e);
				}
			});
		}
		//게시글 삭제/수정 버튼 그리기
		function check_id_for_draw_delete_btn() {
			$.ajax({
				type : 'post',
				url : '/projectboard/buttonUpDate',
				data : {'id' : id, 'bno' : bno},
				success : function(response) { //response가 true이면 -> 작성자랑 로그인한 사람이 같으면
					if(response){
						let str = `<button class = "btn_update_content" type = "button">게시글 수정</button>
 								   <button class = "btn_delete_content" type = "button">게시글 삭제</button>`;
						$('.post_detail').append(str);
					}else {
						console.log("게시글 작성자가 아님");
					}
				},
				error : function(e,r,s) {
					console.log(e, r, s);
				}
			});
		}
		//게시글 추천 비추천
		$(function(){
			redraw();						//댓글 그리기
			check_id_for_draw_delete_btn() 	//게시글 삭제버튼 그리기
			console.log("스크립트 실행됨");
			//게시글 추천
			$(document).on('click', '#btn_like', function() {
				console.log(bno);
				//중복 추천 내용 확인
				$.ajax({
					type : 'post',
					url : 'likeCount',
					data : {"bno" : bno},
					success : function(response){
						let check = response
						if(check.result === 1){
							$(".like").text(check.count);
						}else {
							alert("이미 추천하셨습니다.");
						}
					},
					error : function(e, r, s){
						alert("에러!");
					}
				});
			});
			//게시글 비추천
			$(document).on('click', '#btn_delike', function() {
				console.log(bno);
				$.ajax({
					type : 'post',
					url : 'delikeCount',
					data : {"bno" : bno},
					success : function(response){
						console.log("서버응답 : ", response);
						let check = response
						if(check.result === 1){
							$(".delike").text(check.count);
						}else {
							alert("이미 비추천하셨습니다.");
						}
					},
					error : function(e, r, s){
						alert("에러!");
					}
				});
			});
			//게시글 댓글의 내용이 있는지 체크
			$(document).on('click', '#btn_reply', function() {
				let comment = $('#commentReply').val().trim();
				if(!comment){
					alert("내용을 입력하세요.");
					return;
				}
				//댓글 달기 
				$.ajax({
					type : 'post',
					url : '/projectboard/insertReply',
					data : {"content": comment, "bno": bno},
					success : function(response) { 
						//db에 insert 완료 되면 아래가 실행
						if(response === 'success'){
							alert("댓글 등록 완료");
							$('#commentReply').val('');
							//다시그리기
							redraw();
						}
					},
					error : function() {
						alert("댓글 등록 실패");	
					}
				});
			});
			//게시글 삭제버튼 클릭
			$(document).on('click', '.btn_reply_delete',function() {
				let rno = $(this).siblings('.rno').text();

				let yes_or_no = confirm("댓글을 삭제 하시겠습니까?"); // 댓글 삭제 확인
				if(!yes_or_no) return;
				console.log("rno : "+rno);
				//댓글 삭제 권한이 있는지 확인 후 삭제 또는 거부 (작성자랑 로그인한사람이 같아야 버튼이 나오지만 이중)
				$.ajax({
					type : 'post',
					url : 'deleteReplyFromId',	//아래서 보낸 data id 로 비교하기
					data : {"id" : id, "rno" : rno},
					success : function(response) {
						if(response){
							alert("바깥 ajax(response) : " + response);
							alert("댓글이 삭제 되었습니다.");
							redraw();
						}else {
							alert("댓글 삭제 권한이 없습니다.");
						}
					},
					error : function() {
						aler("에러!");
					}
				});
			});
			//게시글 삭제
			$(document).on('click', '.btn_delete_content', function() {
				let yes_or_no = confirm("게시글을 삭제 하시겠습니까?");//게시글 삭제 확인버튼
				if(!yes_or_no) return;
				//게시글 삭제 권한확인 후 삭제 또는 거부
				$.ajax({
					type : 'post',
					url : '/projectboard/deleteContentById',
					data : {'bno' : bno, 'id' : id},
					success : function(response) {
						if(response){
							alert("게시글이 삭제되었습니다.");
							location.href = "/projectboard/list"
						}else {
							alert("게시글 삭제 권한이 없습니다.");
						}
					},
					error : function(r,e,s) {
						alert("게시글 삭제 에러!");
					}
				});
			});
			//게시글 수정하기 버튼
			$(document).on('click', '.btn_update_content', function() {
				location.href = "updateContentById?bno="+bno;
			});
			//게시글 목록으로 이동
			$(document).on('click', '.listBtn', function() {
				location.href = "list?page="+page;
			});
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
		    display: flex;
		    align-items: center;
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
			height : 300px;
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
		.border {
			border : 1px solid red;
		}
		.out_board {
			display : flex;
			justify-content : center;
			position: absolute;
		    top: 300px;
		    width: 100%;
		    height: 1480px;
		}
		.out_main_board {
			display : flex;
			position: absolute;
			top : 30px;
			left : 560px;
		    margin-top: 20px;
		    width: 950px;
		    height : 1080px;
		    border : 1px solid rgb(79 87 112);
		    border-radius: 16px;
		}
		.main_board {
			position: relative;
			left: 22px;
   			align-items: center;
			width: 900px;
		}
		.listBtn {
		    position: absolute;
   			right: 7px;
		    top: 25px;
		    font-size: 20px;
		    border-radius: 8px;
		    width: 80px;
		    height: 30px;
		    color: rgb(61 105 255);
		    line-height: 20px;
		    background-color: rgb(32 42 72);
		}
		.main_board > h1 {
			color: rgb(218 223 231);
			margin-left: 20px;
   			margin-right: 20px;
		}
		.post_detail {
       		display: flex;
  		    align-items: center;
			gap: 15px;
			padding-left: 15px;
			color : rgb(130 135 153);
			font-size: 14px;
       		line-height: 20px;
       		font-weight: 500;
		}
		.img_set {
			gap : 8px;
		}
		.img_set > svg {
			width : 12px;
			height : 12px;
		}
		.btn_delete_content {
			margin-left: auto;
		    margin-top: 5px;
		    margin-right: 6px;
		    border-radius: 8px;
		    width: 100px;
		    height: 30px;
		    color: rgb(61 105 255);
		    font-size: 15px;
		    line-height: 20px;
		    background-color: rgb(32 42 72);
		}
		.btn_update_content {
		    margin-left: 384px;
		    margin-top: 5px;
		    margin-right: 6px;
			width: 100px;
		    height: 30px;
			border-radius: 8px;
		    color: rgb(61 105 255);
		    font-size: 15px;
		    line-height: 20px;
		    background-color: rgb(32 42 72);	
		}
		hr {
			border: none;
		    border-top: 0.3px solid rgb(204,204,204);
		    opacity: 0.5;
	        margin-top: 15px;
		    margin-bottom: 15px;
		}
		.postcontent {
			min-height: 800px;
			color : rgb(218 223 231);	/* 색 바꿀꺼임 */
		    padding: 20px;
		}
		.pick {
			display: flex;
		    justify-content: center;
		    align-items: center;	
		    gap : 15px;	
		    padding-top: 24px;
		    padding-bottom: 24px;			
		}
		.pick_y, .pick_n {
			display : flex;
			align-items : center;
			font-size : 25px;
			background-color: transparent;
			color : rgb(50 84 206);
			border-color : rgb(50 84 206);
			border-radius : 8px;
			font-weight: 700;
			padding-top: 8px;
			padding-bottom: 8px;
			padding-left: 16px;
			padding-right: 16px;	
		}
		.pick_y > svg {
		    width: 74px;
			height: 35px;
		}
		.pick_n > svg {
			width : 74px;
			height : 35px;
		}
		.comment {
		   	position : absolute;
		    bottom: 100px;
			left: 610px;
			padding-left : 32px;
			padding-right : 32px;
			width : 840px;
			height : 230px;
		}
		.comment_detail {
			width : 776px;
			height : 175px;
		}
		.comment_detail > textarea {
			display : block !important;
			background-color : rgb(18 21 37);
			color : rgb(218 223 231);
			font-size : 14px;
			line-height : 20px;
			width : 100%;
			min-height : 170px;
			resize : vertical;
		}
		.comment_commit {
			display: flex;
		    justify-content: flex-end;
		    width: 776px;
		    height: 50px;
		}
		.comment_commit > button{
		    margin-top: 5px;
			margin-right: 6px;
			border-radius : 8px;
			width : 100px;
			height : 40px;
			color : rgb(61 105 255);
			font-size : 32px;
			font-weight : 700px;
			line-height : 20px;
			background-color : rgb(32 42 72);
		}
		.bod {
			border : 1px solid red;
		}
		.comment_view{
			padding-left : 32px;
			padding-right : 32px;
		}
		.inner_comment_writer{
			margin-bottom : 10px;
		}
		.inner_comment_view{
			 color: rgb(218 223 231);
			 font-size : 14px;
			 line-height : 20px;
		}
		.btn_reply_delete {
			border-radius: 8px;
		    color: rgb(61 105 255);
		    font-size: 15px;
		    line-height: 20px;
		    background-color: rgb(32 42 72);		
		}
		.reply_content {
			color: white;
		    font-size: 20px;
		    margin-left: 10px;
		}
		.writer {
		    color: rgb(218 223 231);
		    width : auto;
		    font-weight : 700;
		    font-size : 20px;
		    margin-left: 10px;
		}
		#writedate {
			margin : 10px;			
		}
		#writedate > span {
		    color: white;
			font-size: 14px;
		}
		.wrap_text {
		    display: inline-block;
		    white-space: normal;
		    word-break: break-word;
		    min-width: 880px;
		    max-width: 870px;
		    max-height: 760px;
		    overflow-y: auto;
		}
		.reply_items {
			color : white; 
		}
		#mainHome > svg {
			color : white;
			width : 131px;
			height : 20px;
		}
		/* 실시간 채팅창 */
		#matchs_container{
			position: absolute;
			top: 35px;
			left: 220px;
			z-index: 9999;
		}
		#chat_container {
		   	position: relative;
		   	display: flex;
		   	height: 15000px;
		   	width: 320px;
		   	padding: 10px;
	 	}
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
<body style = "width : 1920px;">
	<div class = "header_div">
		<!-- 화면의 상단 내용들 -->
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
				<!-- 세션에 아이디가 있는지 확인 -->
				<c:choose>
					<c:when test = "${empty sessionScope.id}"> 
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
						<input type = "search" id = "champInput" name = "champName" placeholder = "소환사명 또는 챔피언 이름으로 검색"/>
						<button type = "submit" id = "searchBtn" style = "background: none; border: none; padding: 0; position : absolute;">
							<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="20px" height="20px"><path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path></svg>
						</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
	<!-- 게시글 보기 -->		
	<div class = "out_board" >
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
		<div class = "out_main_board" >	<!-- 게시글 내용보기 -->
			<div class = "main_board" >	<!-- 게시글 제목자리 -->
				<div>
					<button class = "listBtn" type = "button">목록</button>
				</div>
				<h1>${dto.fTitle}</h1>	
				<div class = "post_detail" >	<!-- 작성일자 조회수 -->
					<span>${dto.fFormattedDate}</span>
					<span class = "img_set">
						<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" class="text-psgr-base"><path fill="currentColor" d="M12.0006 15.9998C13.2506 15.9998 14.3133 15.5625 15.1886 14.6878C16.0633 13.8125 16.5006 12.7498 16.5006 11.4998C16.5006 10.2498 16.0633 9.18714 15.1886 8.3118C14.3133 7.43714 13.2506 6.9998 12.0006 6.9998C10.7506 6.9998 9.68797 7.43714 8.81263 8.3118C7.93797 9.18714 7.50063 10.2498 7.50063 11.4998C7.50063 12.7498 7.93797 13.8125 8.81263 14.6878C9.68797 15.5625 10.7506 15.9998 12.0006 15.9998ZM12.0006 13.8998C11.334 13.8998 10.7673 13.6665 10.3006 13.1998C9.83397 12.7331 9.60063 12.1665 9.60063 11.4998C9.60063 10.8331 9.83397 10.2665 10.3006 9.7998C10.7673 9.33314 11.334 9.0998 12.0006 9.0998C12.6673 9.0998 13.234 9.33314 13.7006 9.7998C14.1673 10.2665 14.4006 10.8331 14.4006 11.4998C14.4006 12.1665 14.1673 12.7331 13.7006 13.1998C13.234 13.6665 12.6673 13.8998 12.0006 13.8998ZM12.0006 19.4498C9.6173 19.4498 7.4383 18.8081 5.46363 17.5248C3.4883 16.2415 1.98397 14.5331 0.950635 12.3998C0.883968 12.2831 0.837968 12.1458 0.812635 11.9878C0.787968 11.8291 0.775635 11.6665 0.775635 11.4998C0.775635 11.3331 0.787968 11.1705 0.812635 11.0118C0.837968 10.8538 0.883968 10.7165 0.950635 10.5998C1.98397 8.46647 3.4883 6.75814 5.46363 5.4748C7.4383 4.19147 9.6173 3.5498 12.0006 3.5498C14.384 3.5498 16.5633 4.19147 18.5386 5.4748C20.5133 6.75814 22.0173 8.46647 23.0506 10.5998C23.1173 10.7165 23.1633 10.8538 23.1886 11.0118C23.2133 11.1705 23.2256 11.3331 23.2256 11.4998C23.2256 11.6665 23.2133 11.8291 23.1886 11.9878C23.1633 12.1458 23.1173 12.2831 23.0506 12.3998C22.0173 14.5331 20.5133 16.2415 18.5386 17.5248C16.5633 18.8081 14.384 19.4498 12.0006 19.4498ZM12.0006 16.9998C13.8673 16.9998 15.584 16.4998 17.1506 15.4998C18.7173 14.4998 19.9173 13.1665 20.7506 11.4998C19.9173 9.83314 18.7173 8.4998 17.1506 7.4998C15.584 6.4998 13.8673 5.9998 12.0006 5.9998C10.134 5.9998 8.4173 6.4998 6.85063 7.4998C5.28397 8.4998 4.08397 9.83314 3.25063 11.4998C4.08397 13.1665 5.28397 14.4998 6.85063 15.4998C8.4173 16.4998 10.134 16.9998 12.0006 16.9998Z"></path></svg>
						 <span>${dto.fCheck}</span>
					</span>
					<span class = "img_set">
						<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" class="text-psgr-base dark:text-dark-psgr-base"><path fill="currentColor" d="M15.09 18H12.79C12.1611 18.0013 11.5362 17.9 10.94 17.7L9.42999 17.2C9.03675 17.0681 8.62481 17.0005 8.21002 17H6C5.73478 17 5.48044 16.8946 5.29291 16.7071C5.10537 16.5195 5 16.2652 5 16C5 15.7348 5.10537 15.4804 5.29291 15.2929C5.48044 15.1054 5.73478 15 6 15H8.21002C8.8389 14.9987 9.46376 15.1 10.06 15.3L11.57 15.8C11.9632 15.9319 12.3752 15.9995 12.79 16H15.09C15.1902 15.9999 15.2885 15.9729 15.3746 15.9219C15.4608 15.8709 15.5317 15.7977 15.58 15.71L16.5 14.11C16.8282 13.5305 17.0005 12.8759 17 12.21V9.57C17.0014 9.49477 16.9875 9.42004 16.9594 9.35027C16.9312 9.2805 16.8893 9.21713 16.8361 9.16393C16.7829 9.11073 16.7195 9.06877 16.6497 9.04061C16.58 9.01244 16.5052 8.99863 16.43 8.99999H12.72L13.32 6.60997C13.3924 6.21733 13.3612 5.81263 13.2297 5.43566C13.0982 5.05868 12.8709 4.72243 12.57 4.45998L12.36 5.08998C12.0554 6.00629 11.5991 6.86491 11.01 7.62999L8.16998 11H6C5.73478 11 5.48044 10.8946 5.29291 10.7071C5.10537 10.5195 5 10.2652 5 9.99999C5 9.73477 5.10537 9.48043 5.29291 9.2929C5.48044 9.10536 5.73478 8.99999 6 8.99999H7.23999L9.45001 6.37999C9.88447 5.79796 10.2221 5.14961 10.45 4.45998L10.81 3.39C10.8841 3.16629 11.0055 2.96116 11.166 2.78859C11.3264 2.61603 11.5222 2.48008 11.74 2.39C11.959 2.30155 12.1943 2.26026 12.4304 2.26888C12.6664 2.27749 12.898 2.33581 13.11 2.43999C13.9099 2.86963 14.5512 3.54417 14.9399 4.36476C15.3286 5.18536 15.4443 6.10887 15.27 6.99999H16.42C17.1016 6.99999 17.7553 7.27077 18.2372 7.75273C18.7192 8.2347 18.99 8.88839 18.99 9.57V12.21C18.9872 13.2236 18.7219 14.2193 18.22 15.1L17.31 16.7C17.086 17.092 16.7632 17.4183 16.3736 17.6464C15.984 17.8746 15.5415 17.9965 15.09 18Z"></path><path fill="currentColor" d="M5.5 9H4.5C3.67157 9 3 9.67157 3 10.5V15.5C3 16.3284 3.67157 17 4.5 17H5.5C6.32843 17 7 16.3284 7 15.5V10.5C7 9.67157 6.32843 9 5.5 9Z"></path></svg>
						<span class = "pick_count">${dto.fLike}</span>
					</span>
				</div>
				<hr/>
				<div class = "postcontent" >	<!-- 본문 내용 -->
					<div class = "wrap_text">${contentHtml}</div>
				</div>
				<hr/>
				<div class = "pick" >	<!-- 추천 비추천 박스2개 -->
					<button class = "pick_y" id = "btn_like">	<!-- 추천 -->
						<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" class=""><path fill="currentColor" d="M15.09 18H12.79C12.1611 18.0013 11.5362 17.9 10.94 17.7L9.42999 17.2C9.03675 17.0681 8.62481 17.0005 8.21002 17H6C5.73478 17 5.48044 16.8946 5.29291 16.7071C5.10537 16.5195 5 16.2652 5 16C5 15.7348 5.10537 15.4804 5.29291 15.2929C5.48044 15.1054 5.73478 15 6 15H8.21002C8.8389 14.9987 9.46376 15.1 10.06 15.3L11.57 15.8C11.9632 15.9319 12.3752 15.9995 12.79 16H15.09C15.1902 15.9999 15.2885 15.9729 15.3746 15.9219C15.4608 15.8709 15.5317 15.7977 15.58 15.71L16.5 14.11C16.8282 13.5305 17.0005 12.8759 17 12.21V9.57C17.0014 9.49477 16.9875 9.42004 16.9594 9.35027C16.9312 9.2805 16.8893 9.21713 16.8361 9.16393C16.7829 9.11073 16.7195 9.06877 16.6497 9.04061C16.58 9.01244 16.5052 8.99863 16.43 8.99999H12.72L13.32 6.60997C13.3924 6.21733 13.3612 5.81263 13.2297 5.43566C13.0982 5.05868 12.8709 4.72243 12.57 4.45998L12.36 5.08998C12.0554 6.00629 11.5991 6.86491 11.01 7.62999L8.16998 11H6C5.73478 11 5.48044 10.8946 5.29291 10.7071C5.10537 10.5195 5 10.2652 5 9.99999C5 9.73477 5.10537 9.48043 5.29291 9.2929C5.48044 9.10536 5.73478 8.99999 6 8.99999H7.23999L9.45001 6.37999C9.88447 5.79796 10.2221 5.14961 10.45 4.45998L10.81 3.39C10.8841 3.16629 11.0055 2.96116 11.166 2.78859C11.3264 2.61603 11.5222 2.48008 11.74 2.39C11.959 2.30155 12.1943 2.26026 12.4304 2.26888C12.6664 2.27749 12.898 2.33581 13.11 2.43999C13.9099 2.86963 14.5512 3.54417 14.9399 4.36476C15.3286 5.18536 15.4443 6.10887 15.27 6.99999H16.42C17.1016 6.99999 17.7553 7.27077 18.2372 7.75273C18.7192 8.2347 18.99 8.88839 18.99 9.57V12.21C18.9872 13.2236 18.7219 14.2193 18.22 15.1L17.31 16.7C17.086 17.092 16.7632 17.4183 16.3736 17.6464C15.984 17.8746 15.5415 17.9965 15.09 18Z"></path><path fill="currentColor" d="M5.5 9H4.5C3.67157 9 3 9.67157 3 10.5V15.5C3 16.3284 3.67157 17 4.5 17H5.5C6.32843 17 7 16.3284 7 15.5V10.5C7 9.67157 6.32843 9 5.5 9Z"></path></svg>
						<span class = "like">0</span>
					</button>
					<button class = "pick_n" id = "btn_delike">	<!-- 비추천 -->
						<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" class=""><path fill="currentColor" d="M15.09 6.00001H12.79C12.1611 5.9987 11.5362 6.10002 10.94 6.3L9.42999 6.8C9.03675 6.93195 8.62481 6.9995 8.21002 7.00001H6C5.73478 7.00001 5.48044 7.10538 5.29291 7.29292C5.10537 7.48046 5 7.73479 5 8.00001C5 8.26523 5.10537 8.51957 5.29291 8.7071C5.48044 8.89464 5.73478 9.00001 6 9.00001H8.21002C8.8389 9.00132 9.46376 8.9 10.06 8.70002L11.57 8.20002C11.9632 8.06807 12.3752 8.00052 12.79 8.00001H15.09C15.1902 8.00012 15.2885 8.02707 15.3746 8.07808C15.4608 8.12908 15.5317 8.20228 15.58 8.29002L16.5 9.89003C16.8282 10.4695 17.0005 11.1241 17 11.79V14.43C17.0014 14.5052 16.9875 14.58 16.9594 14.6497C16.9312 14.7195 16.8893 14.7829 16.8361 14.8361C16.7829 14.8893 16.7195 14.9312 16.6497 14.9594C16.58 14.9876 16.5052 15.0014 16.43 15H12.72L13.32 17.39C13.3924 17.7827 13.3612 18.1874 13.2297 18.5643C13.0982 18.9413 12.8709 19.2776 12.57 19.54L12.36 18.91C12.0554 17.9937 11.5991 17.1351 11.01 16.37L8.16998 13H6C5.73478 13 5.48044 13.1054 5.29291 13.2929C5.10537 13.4805 5 13.7348 5 14C5 14.2652 5.10537 14.5196 5.29291 14.7071C5.48044 14.8946 5.73478 15 6 15H7.23999L9.45001 17.62C9.88447 18.202 10.2221 18.8504 10.45 19.54L10.81 20.61C10.8841 20.8337 11.0055 21.0388 11.166 21.2114C11.3264 21.384 11.5222 21.5199 11.74 21.61C11.959 21.6984 12.1943 21.7397 12.4304 21.7311C12.6664 21.7225 12.898 21.6642 13.11 21.56C13.9099 21.1304 14.5512 20.4558 14.9399 19.6352C15.3286 18.8146 15.4443 17.8911 15.27 17H16.42C17.1016 17 17.7553 16.7292 18.2372 16.2473C18.7192 15.7653 18.99 15.1116 18.99 14.43V11.79C18.9872 10.7764 18.7219 9.7807 18.22 8.90001L17.31 7.3C17.086 6.90803 16.7632 6.58168 16.3736 6.35356C15.984 6.12543 15.5415 6.00353 15.09 6.00001Z"></path><path fill="currentColor" d="M5.5 15H4.5C3.67157 15 3 14.3284 3 13.5V8.5C3 7.67157 3.67157 7 4.5 7H5.5C6.32843 7 7 7.67157 7 8.5V13.5C7 14.3284 6.32843 15 5.5 15Z"></path></svg>
						<span class = "delike">0</span>
					</button>
				</div>
				
			</div>
		</div>
		<div class = "comment" >	<!-- 댓글 달기 박스 -->
		<form>
			<div class = "comment_detail" >
				<textarea id = "commentReply" placeholder = "댓글을 입력하세요.">

				</textarea>
			</div>
			<div class = "comment_commit" >
				<button type = "button" id = "btn_reply" style = "color : white">등록</button>
			</div>
		</form>
			<!-- 댓글 작업중 -->
			<div class = "comment_view">
				<hr/>
				<div class = "reply_list">
				</div>
			</div>
		</div>
	</div>
</body>
</html>