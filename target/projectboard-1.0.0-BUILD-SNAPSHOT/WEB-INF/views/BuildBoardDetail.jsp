<%@page import="com.hc.BuildBoardDtoFolder.getBuildPostDto"%>
<%@page import="com.hc.BuildBoardDto.BoardDetailDto"%>
<%@page import="com.hc.dto.BoardDto"%>
<%@page import="com.hc.dao.buildPostDao"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" pageEncoding="UTF-8"%>
<%@ page import="com.hc.dao.buildPostDao"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css">
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
		#header_div {
			background-color : rgb(33, 59, 150);
			width : 100%;
			height : 40px;
		}
		#header_inner {
			display : flex;
			justify-content : space-between;
			margin : 0 auto;
			width : 1280px;
			height : 100%;
		}
		#header_inner > div:nth-child(1) { 	/* 해더 왼쪽 */
			display : flex;
			justify-content : space-around;
			align-items : center;
			width : 1030px; 
		
		}
		#header_inner > div:nth-child(1) > svg:first-child {	/* 로고 */
			color : white;
			width : 131px;
			height : 20px; 
		}
		#header_inner > div:nth-child(1) > div:nth-child(2) {	/* 세로 bar */
			margin : 0 8px 0 7px;
			width : 1px;
			height : 18px;
			opacity : 0.2;
			background-color : white; 
		}
		#header_inner > div:nth-child(1) > svg:nth-child(3) {	/* TFTPS */
			width : 64px;
			height : 15.55px;
			color : white;
			opacity : 0.5;
		}
		#header_inner > div:nth-child(1) > svg:nth-child(3):hover {
			opacity : 1;
		}
		#header_inner > div:nth-child(1) > a{	/* 상단 왼쪽 메뉴 항목 */
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
		#header_inner > div:nth-child(2) { /* 해더 오른쪽 */ 
			width : 180px;
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
		#header_inner > div:nth-child(2) > a:first-child {
			color : white;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    margin-top: 5px;
		}
		#main {
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
		#main > #search_bar {
			display : flex;
			justify-content : center;
			align-items : center;
			height : 156px;
		}
		#main > #search_bar > #search_bar_inner {
			margin-top : 200px;
			width : 1080px;
			padding : 0 30px;
			height : 56px;
		}
		#search_bar >#search_bar_inner > div:nth-child(1) {
			position : relative;
			top : -70px;
		    width: 500px;
		    height: 55px;
		    background-color: white;
		    border-radius : 8px;
		}
		#search_bar > #search_bar_inner > div:nth-child(1) > input {
			border : none;
			outline : none;
			width : 100%;
			height : 100%;
			padding-left: 30px;
			font-size : 23px;
			border-radius : 8px;
			color : rgb(53,57,69);
		}
		#search_bar > #search_bar_inner > div:nth-child(1) > svg {
			position: absolute;
		    margin-left: -55px;
		    margin-top: 4px;
		    width: 50px;
		    height: 50px;
		    color: rgb(50, 84, 206);
		}
		#head_name > h1 {
			color : white;
			position : absolute;
			top : 250px;
			left : 250px;
		}
		#second_name {
			position: absolute;
		    top: 330px;
		    left: 250px;
		}
		#second_name > h2 > a {
			color : white;
			margin-right : 15px;
		}
		#bod_box {
			position : absolute;
			top : 450px;
			left : 180px;
			width : 1080px;
			height : 1240px;
		}
		
		
		
		/* 부제목 */
		#main > #sub_menu {
			display: flex;
			justify-content: center;
			height:244px;
		}
		
		#sub_menu_inner {
			position:relative;
			justify-content:center;
			width: 1340px;
			margin-top: 100px;
			margin-left: 500px;
		}
		#sub_menu_inner > div:first-child{
			width: 200px;
			height: 50px;
			color:rgb(126 155 255);
			font-size: 20px;
			line-height: 50px;
		}
		#sub_menu_inner > div:nth-child(2){
			justify-content: left;
			width: 600px;
			height: 50px;
			color: white;
			font-size: 20px;
			margin-top: 15px;
		}
		
		#자유{
			position:relative;
			float:left;
			width: 150px;
			height: 50px;
			cursor: pointer;
		}
		#빌드{
			position:relative;
			float: left;
			width: 150px;
			height: 50px;
			cursor: pointer;
		}
		#패치{
			position:relative;
			float: left;
			width: 150px;
			height: 50px;
			cursor: pointer;
		}
		a:link {
			color: white;
		}
		a:visited{
			color: white;
		}
		a:hover {
			color: #adb5bd;
			transition: background-color 0.3s ease;
		}
		a:active{
			color: blue;
		}
		#build_container {
			margin-left : 100px;
		}
		#build_container > div:first-child{
			display:flex;			
			width: 1340px;
			height: auto;
		}
		/* 실시간 채팅 컨테이너 */
		/* 실시간 채팅창 */
		#chat_container {
	     		position: relative;
	     		display: flex;
	     		height: auto;
	     		width: 320px;
	     		padding: 10px;
	   	}
	   	/* champ 정렬 컨테이너 */
	   	#champ_container {
			position: relative;
			display: flex;
			height: auto;
			width: 170px;
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
		
		/* 챔피언정렬 선택창 255~311 */
		#select-box {
			position: sticky;
			top: 100px; /* 고정 시작 위치 */
			width: 150px;
			height: 500px; /* 콘텐츠에 따라 자동 높이 조절 (고정 높이 원하면 그대로 두세요) */
			background-color: rgb(31 35 49);
			margin: 10px;
			border-radius: 20px;
			border: 3px solid white;
		}
		#champ {
			position: relative;
			margin-top: 40px;
			margin-left: 20px;
			color: white;
		}		
		#asdf {
			display: flex;
			justify-content: center;
		}
		/* 스크롤바 설정 */
		.select_inner::-webkit-scrollbar {
			width:5px;
		}
		.select_inner::-webkit-scrollbar-thumb {
			width:5px;
			border-radius:2px; 
			border-color: white;
			background-color: white;
		}
		/* ::-webkit-scrollbar-track  <- 스크롤바 외부 설정*/
		
		.select_inner {
			margin-top:10px;
			display:flex;
			justify-items:center;
			width: 140px;
	 			overflow-y: auto;
	 			height: 431px;
	 			border-radius: 10px;
		}
		.select-champion {
			position:relative;
			justify-items:center;
			line-height: 40px;
			color:white;
			border: 1px solid black;
			width: 125px;
			height: 40px;
			background-color: #071A4C;
			border-radius: 10px;
			cursor: pointer;
		}
		.select-champion:hover{
			background-color: white;	
			transition: background-color 0.3s ease;
			color: #000080;
		}
		
		/* 제목 내용 작성자 토글창 및 검색창 컨테이너 */		
		#board_container {
			display:flex;
			justify-content:center;
			border: 1px solid white;
			height: auto;
			background-color: #071A4C;
			border-radius: 15px; 
			flex : 1;
			padding: 30px;
		}
		
		tr, td {
			color: white;
		}
		#board_container > div:first-child {
			width:1000px;
		}
		/* 토글창 */
		#board_select {
			display:flex;
			margin-left: 400px;
			margin-top : 20px;
		}
		#board_select > div:first-child {
			width: 150px;
			height: 50px;
			text-align: left;
		}
		#board_select > div:first-child select {
			width: 150px;
			height: 40px;
			background-color: rgba(0,0,0,0.2);
			border: 2px solid white;
			border-radius: 10px;
			color: white;
		}
		#Select option{
			background-color: #071A4C;
			text-align: center;
		}
		
		#Select option:checked {
	  	 		background-color: lightblue;
	 		}
		
		/* 검색창 */
		#board_select > div:nth-child(2) {
			margin-left: 10px;
			width: 250px;
			height: 40px;
			border: 2px solid white;
			border-radius: 10px;
			text-align: left;
			line-height: 50px;
		}
		#board_search_bar {
			display: flex;
			justify-content: center;
			margin-bottom: 10px;
		}	
		#input_board_search {
			background-color: #071A4C;
			width: 230px;
			border-radius: 10px;
			color: white;
			outline: none;
			border: 0px solid rgba(0,0,0,0);
			spellcheck:"false";
		}
		
		#title_container {
			color : white;
			margin-left:0px;
		}
		#title_container > div {
			display: flex;
		    justify-content: center;
		    text-align: center;
		    align-items: center;
		}
		/* 번호 */
		#title_container > div > div:first-child {
			width: 50px;
		}
		/* 제목 */
		#title_container > div > div:nth-child(2) {
			width: 360px;
		}
		/* 작성자 */
		#title_container > div > div:nth-child(3) {
			width: 130px;
		}
		/* 날짜 */
		#title_container > div > div:nth-child(4) {
			width: 200px;
		}
		/* 조회수 */
		#title_container > div > div:nth-child(5) {
			width: 50px;
		}
		/* 추천수 */
		#title_container > div > div:nth-child(6) {
			width: 50px;
		}
		
		.title {
			margin: 5px 5px 0px 5px;
			position:relative;
			height: 50px;
		}
		.cv {
			margin: 0px 5px 0px 5px;
			position:relative;
			height: 50px;
			border-top: 1px solid white;
			border-bottom: 1px solid white;
		}
		.cv > div:first-child {
	   		text-align: center;         
	  			display: flex;
	   		justify-content: center;    
	   		align-items: center;       
		}
		.cv > div:nth-child(2) {
		    display: flex;
		    align-items: center;   
		    justify-content: flex-start;
		    padding-left: 8px;     
		}
		.cv:hover {
		    background-color: white;
		    color: #000080;
		    cursor: pointer; 
		    transition: background-color 0.05s ease;
		}		
		.page_controls {
		    display: flex;
		    justify-content: center;      
		    gap: 8px;                    
		    align-items: center;     
		    margin-top: 15px;
		    margin-bottom: 10px;   
		}
		
		.page_controls > div {
		    cursor: pointer;
		    user-select: none;
		    padding: 5px 0;
		    text-align: center;
		    border-radius: 4px;
		    font-weight: normal;
		}
		
		.page_controls > div.page_prev,
		.page_controls > div.page_next {
			height:25px;
		    width: 40px;
		    font-size: 15px;
		    border: 1px solid white;
		    background-color: white;
		    line-height: 15px;          
		}
		
		.page_controls > div.page_idx {
		    width: 15px;                 
		    font-size: 15px;
		    background-color: rgba(0, 0, 0, 0);
		    border: none;
		    line-height: 30px;
		    text-align: center;        
		    font-weight: normal;
		    color: white;
		}
		.page_controls > div.page_idx.current {
		    font-weight: bold;
		    text-decoration: underline !important;
		}	
		#content_inner {
			display: flex;
		}
		#content_inner_data {
			display: flex;
			min-height: 400px;
			width: 100%;
			margin-bottom: 10px;
			border:1px solid rgb(118, 118, 118);
			border-radius: 20px;
		}
		#content_inner_data tbody {
			width: 100%;
		}
		#viewer {
			min-height: 277px;
		}
		#content_inner_data > tr {
			width: 100%;
		}
		#titleTr > td{
			border-top-left-radius: 20px !important;
			border-top-right-radius: 20px !important;
			height: 50px;
			background-color: #051636;
		}
		#writerTr {
			height: 50px;
			background-color: #051636;
		}
		#writeDateTr{
			height: 50px;
			background-color: #051636;
		}
		#viewBoxTr > td{
			background-color: #051636;
			border-bottom-left-radius: 20px !important;
			border-bottom-right-radius: 20px !important;
		}
		table {
			border-collapse: collapse;
		}
		td {
			padding-left : 20px;
		}
		
		#loginContainer {
		    display: flex;
		    gap: 10px;
		    align-items: center;
		}
		#editBtn {
			height: 30px;
			width: auto;
			border-radius: 10px;
		}
		#deleteBtn {
			height: 30px;
			width: auto;
			border-radius: 10px;
		}
		#RatingBtn {
		    margin: 0 auto;
		    display: block;
		    height: 30px;
		    width: auto;
		    border-radius: 10px;
		}
		#RatingBtn svg {
		    vertical-align: middle;
		    transform: translateY(1px); 
		}
		.toastui-editor-contents p{
			color: white;
		}
		.toastui-editor-contents img{
			width: 70px;
		}
		#replyContainer {
			display: flex;
			width: 100%;
			min-height: 200px;
			height: auto;
			position: relative;
			flex-direction: column;
		}
		#insertReplyArea {
			width: 100%;
			min-height: 200px;
			position: relative;
		}
		#replyForm {
			width: 100%;
			min-height: 200px;
			position: relative;
		}
		.readReplyInner{
			position: relative;
		}
		.readReplyInner > div {
	    	display: flex;
	    	padding: 10px;
		}
		.readReplyInner > div:first-child {
		    align-items: flex-start;
		}
		.readReplyInner > div:not(:first-child) {
		    align-items: flex-end;
		}
		#insertReplyContent{
			margin-top:10px;
			padding:20px 80px 50px 20px;
			border-radius: 20px;
			width: 100%;
			min-height: 200px;
			background-color: #051636;
			color: white;
			box-sizing: border-box;
		}
		#insertReplyBtn {
			border-radius: 15px;
			height: 40px;
			width: 80px;
			background-color: blue;
			position: absolute;
		    right: 10px;
		    bottom: 10px;
	    	color: white;
		}
		#readReplyContainer {
			background-color: #051636;
			border: 1px solid rgb(118, 118, 118);
			border-radius: 20px;
			min-height: 200px;
			height: auto;
			display: flex;
			padding: 20px;
			flex-direction: column;
			color: white;
		}
		.readReplyInner{
			margin-top: 20px;
			border: 1px solid white;
			border-radius: 20px;
		}
		#readReplyContainer div{
			height: 100px;
			width: 100%;
			display: flex;
		}
		.ReplyComment {
			width: 700px;
			height: auto;
		}
		.ReplyWriter {
			width: 100px;
			text-align: center;
			margin-bottom:10px;
		}
		.ReplyWriteDate {
			width: 100px;
		}
		.edit-reply-btn, .delete-reply-btn {
			position: absolute;
			width: 50px;
			height: 30px;
			border-radius: 10px;		
		}
		.edit-reply-btn {top:5px; right: 10px;}
		.delete-reply-btn {top:5px; right: 60px;}
		#editReplyBtn{
			display: flex;
			position: absolute;
			border-radius: 15px;
			height: 40px;
			width: 80px;
			background-color: blue;
			right: 5px;
			bottom: 0px;
			color: white;
			justify-content: center;
			align-items: center;
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
	    $(function() {
	        $('#search').on('input', function() {
	            const val = $(this).val();
	            if (!val.trim()) {
	                $('#SearchResult').empty();
	                return;
	            }
	            $.ajax({
	                url: './searchSummoner',
	                method: 'GET',
	                data: { id: val },
	                success: function(res) {
	                    if (res) {
	                        $('#SearchResult').html(
	                            '<a href="./summonerInfo?id=' + encodeURIComponent(res) + '">' + res + '</a>'
	                        );
	                    } else {
	                        $('#SearchResult').empty();
	                    }
	                }
	            });
	        });
	
	        $('#search').on('keypress', function(e) {
	            if (e.which === 13) {
	                const val = $(this).val().trim();
	                if (!val) return;
	
	                $.ajax({
	                    url: './checkSummoner',
	                    method: 'GET',
	                    data: { id: val },
	                    success: function(res) {
	                        if (res === true) {
	                            location.href = './summonerInfo?id=' + encodeURIComponent(val);
	                        } else {
	                            $.ajax({
	                                url: './checkChampion',
	                                method: 'GET',
	                                data: { champName: val },
	                                success: function(res2) {
	                                    if (res2 === true) {
	                                    	location.href = '/projectboard/champinoDetail?champName=' + encodeURIComponent(val);
	                                    } else {
	                                        alert('잘못 입력하셨습니다.');
	                                    }
	                                }
	                            });
	                        }
	                    }
	                });
	            }
	        });
	    });
	</script>
	<!-- 현재 페이지에 로그인된 내용 확인 스크립트 + 전역변수로 bno (현재 접속한 post bno)선언 -->
	<script>
	    const inputId = "${sessionScope.user_name}";
	    let bno = ${detail.BBno};
	</script>
	
	<!-- 추천버튼 클릭 ajax 지금은 추천한다고 render하지는 않게했음 > 아직 제약조건(추천한사람이 더이상 추천 못하게 or 취소)을 안걸어뒀음 차후추가 -->
	<script>
		$(function() {
		    $("#RatingBtn").click(function() {
		    	$.ajax({
		    	    url: "updateRating",
		    	    type: "POST",
		    	    data: { bno: ${detail.BBno} },
		    	    success: function(response) {
		    	        if(response === "success") {
		    	            alert("추천 완료");
		    	        } else if(response === "false") {
		    	            alert("이미 추천한 사람입니다");
		    	        } else if(response === "loginFalse") {
		    	            alert("로그인 후 이용해주세요");
		    	        }
		    	    },
		    	    error: function() {
		    	        alert("서버 오류 발생");
		    	    }
		    	});
		    });
		});
	</script>
	
	<!-- 실시간 채팅 스크립트 localhost내용 나중에 서버 배포할때 주소값으로 -->
	<script>
		/* 웹소켓 연결 생성문 */
	    const ws = new WebSocket("chat");
		/* ws.onmessage --> 서버로부터 메세지 수신시(이벤트) 펑션 실시 "chatlog"이름으로 도착한 객체 log로 선언해서 innerHTML에 추가로 담고 엔터 및 log의 내용 최신화를 위해서 스크롤 위로 올려버리기 */
	    ws.onmessage = (e) => {
	        const log = document.getElementById("chatLog");
	        log.innerHTML += e.data + "<br/>";
	        log.scrollTop = log.scrollHeight;
	    };
		/* 메세지 보내기 펑션 */
	    function sendMessage() {
			/* msg라는 이름의 객체를 서버로 던져버리기   ---> (정확한 해석) msg요소를 msgInput 에 넣어서 던질건데 조건이 웹 소컷에 열려있다면.. 이 조건임 전송 완료후 msgInput은 "" < 공백으로 초기화*/
	        const msgInput = document.getElementById("msg");
	        if (ws.readyState === WebSocket.OPEN) {
	            ws.send(msgInput.value);
	            msgInput.value = "";
	        } else {
	            alert("웹소켓 연결이 닫혀 있습니다.");
	        }
	    }
	</script>
	
	<!-- 빌드게시판 디테일 페이지 댓글 하단 부분에 페이지 셀렉트박스를 제외한 게시물읽어오기 및 페이지 네이션 -->
	<!----------------------------------------------------------------------------------------------------------------------------------------------------------->
	<script>
	    const totalPosts = ${totalPosts};
	    const postsPerPage = 15;
	    const totalPages = Math.ceil(totalPosts / postsPerPage);
	    let currentPage = 1;
		let boardCheckSerch = "";
	
	    function getPostsForPage(page) {
	        return $.ajax({
	            url: './getPost',
	            method: 'GET',
	            data: { page: page, size: postsPerPage, boardCheckSerch : boardCheckSerch},
	            dataType: 'json'
	        });
	    }
	
	    function renderPosts(page) {
	        $('#title_container').find('.cv').remove();
	        return getPostsForPage(page).done(posts => {
	            posts.forEach(post => {
	            	const cv = $('<div class="cv"></div>');
	            	cv.append($('<div class="bbno" data-bbno="' + post["bbno"] + '"></div>').text(post["bbno"]));
	            	cv.append($('<div></div>').text(post["btitle"]));
	            	cv.append($('<div></div>').text(post["bwriter"]));
	            	cv.append($('<div></div>').text(post["bdate"].substring(0, 16)));
	            	cv.append($('<div></div>').text(post["bcheck"]));
	            	cv.append($('<div></div>').text(post["brating"]));
	                
	            	cv.click(function () {
	            	    let bbno = $(this).find('.bbno').data('bbno');
	            	    location.href = '/projectboard/detail?bbno=' + bbno;
	            	});
	                
	                $('#title_container').append(cv);
	            });
	        });
	    }
	
	    function renderPageControls(page) {
	        $('.page_controls').remove();
	        const pageControls = $('<div class="page_controls"></div>');
	        if (page > 1) {
	            pageControls.append('<div class="page_prev" style="cursor:pointer;">이전</div>');
	        }
	
	        let startPage, endPage;
	        if (totalPages <= 5) {
	            startPage = 1;
	            endPage = totalPages;
	        } else if (page === 1 || page === 2) {
	            startPage = 1;
	            endPage = 3;
	        } else if (page === totalPages || page === totalPages - 1) {
	            startPage = totalPages - 5;
	            endPage = totalPages;
	        } else {
	            startPage = page - 2;
	            endPage = page + 2;
	        }
	
	        for (let i = startPage; i <= endPage; i++) {
	            const pageDiv = $('<div class="page_idx" style="cursor:pointer; display:inline-block; margin:0 5px;"></div>').text(i);
	            if (i === page) {
	                pageDiv.css({ 'font-weight': 'bold', 'text-decoration': 'underline' });
	            }
	            pageControls.append(pageDiv);
	        }
	
	        if (page < totalPages) {
	            pageControls.append('<div class="page_next" style="cursor:pointer;">다음</div>');
	        }
	
	        $('#board_container > div').append(pageControls);
	
	        $('.page_prev').off('click').on('click', () => {
	            if (currentPage - 10 >= 1) {
	                renderAll(currentPage - 10);
	            }
	            else renderAll(1);
	        });
	
	        $('.page_next').off('click').on('click', () => {
	            if (currentPage + 10 <= totalPages) {
	                renderAll(currentPage + 10);
	            }
	            else renderAll(totalPages);
	        });
	
	        $('.page_idx').off('click').on('click', function () {
	            const pageClicked = parseInt($(this).text());
	            if (pageClicked !== currentPage) {
	                renderAll(pageClicked);
	            }
	        });
	    }
	
	    function renderAll(page) {
	        const scrollPos = $(window).scrollTop();
	        currentPage = page;
	        renderPosts(page).done(() => {
	            renderPageControls(page);
	            $(window).scrollTop(scrollPos);
	        });
	    }
	
	    $(function () {
	        renderAll(1);
	    });
	</script>
	<!----------------------------------------------------------------------------------------------------------------------------------------------------------->
	
	<!-- 댓글을 감히 입력하려해? 어딜 로그인도 안한게!! -->
	<script>
		$(document).ready(function(){
		    $('#replyForm').on('submit', function(e) {
		        e.preventDefault();
		        $.ajax({
		            url: 'checkLogin',
		            method: 'POST',
		            success: function(res) {
		                if (res) {
		                    e.target.submit();
		                } else {
		                    alert('로그인부터');
		                }
		            }
		        });
		    });
		});
	</script>
	
	<!-- 작성된 댓글을 읽어오고 현재 페이지에 작성된 댓글 중 session에 접속한 InputId 값이 댓글writer와 같으면 수정 및 삭제 버튼을 생성하고 그 수정과 삭제버튼의 기능을 추가하는 스크립트 -->
	<script>
		/* 페이지가 전부 load되면 먼저 한번 리플을 전체 읽어오기함 */
	    $(document).ready(function() {
	        renderReplyAll();
	    });
		
		/* 댓글 삭제 혹은 수정 클릭시 작동하는 펑션 */
	    $(document).on("click", ".edit-reply-btn, .delete-reply-btn", function() {
	        const $reply = $(this).closest(".readReplyInner");
	        const rno = $reply.data("bno");
			
	        /* 수정 버튼을 눌렀을때 */
	        /* 1. jquery객체에서 현재 클릭된 버튼이 속한 댓글객체를 찾음 2. 그 객체에서 comment를 가져와서 currentText로 선언해둠 */
	        if ($(this).hasClass("edit-reply-btn")) {
	            const $currentReply = $(this).closest(".readReplyInner");
	            const currentText = $currentReply.find(".ReplyComment").text();
				
	            /* 기존 id=replyForm 인 form 내용물을 전부 clone (배껴옴) */
	            /* 단! form 의 action은 insert에서 edit으로 바꿔주고*/
	            /* textarea에는 currentText를 입력상태로 넣어둠! */
	            const $form = $("#replyForm").clone();
	            $form.attr("action", "editBuildReply");
	            $form.find("textarea[name='comment']").val(currentText);
				
	            /* 히든 속성으로 input할건데 이름이 rno이고 현재 댓글의 번호인 rno를 넣음 */
	            if ($form.find("input[name='rno']").length === 0) {
	                $form.append('<input type="hidden" name="rno" />');
	            }
	            $form.find("input[name='rno']").val(rno);
				
	            /* 마찬가지로 히든속성으로 bno 넣음 */
	            if ($form.find("input[name='bno']").length === 0) {
	                $form.append('<input type="hidden" name="bno" />');
	            }
	            $form.find("input[name='bno']").val(bno);
				
				/* insertReplyBtn이었던 버튼을 찾아서 id를 editReplyBtn로 초기화시킴 */            
	            $form.find("#insertReplyBtn").attr("id", "editReplyBtn").text("댓글 수정");
				
				/* 기존에 생성된 수정 폼이있으면 지우고 새롭게 add함 */
	            $(".edit-reply-form").remove();
	            $form.addClass("edit-reply-form");
	            /* 복제한 수정 폼을 현재 댓글 위치에 삽입 */
	            $currentReply.before($form);
	            
	            /* 이건 삭제버튼 눌렀을때 rno와 bno값 가져가서 삭제하고 댓글 renderAll하는 내용임 */
	        } else if ($(this).hasClass("delete-reply-btn")) {
	            $.post("deleteReply", { rno: rno, bno: bno}, function(response) {
	                renderReplyAll();
	            });
	        }
	    });
	    
	    /* 댓글 수정버튼이 지금 jquery로 생성된 내용물 안에있으니까 action을 바로 실행하면 404오류가 나옵 (ajax에서 form태그 action기능 사용하면안됨) */
	    /* 그래서 수정완료 버튼 눌렀을때 form태그의 action기능을 막고 ajax로 form action기능을 뺏어서 ajax로 실행해서 값을 받는 내용임 콘솔로그 나중에 지우고 */
	    /* 이거 하면서 배운게있는데 form serialize라는 기능이 있어서 form내용 훔쳐올때 그 데이터가 전부 담기는 기능임이거 완전 신기하자나? */
	    /* 중요 :  $form.serialize()); --> 폼 전달내용 가져옴 추가로 onclick이벤트 안에 다른 ajax form 내용있으면 연속적으로 추가해서 action값을 받아오는 내용으로 사용가능 이거 완전 개쩐다니까? */
	    $(document).on("click", "#editReplyBtn", function(e) {
	        e.preventDefault();
	        const $form = $(this).closest("form");
	        console.log("폼 serialize 데이터:", $form.serialize());
	        $.ajax({
	            url: $form.attr("action"),
	            type: "POST",
	            data: $form.serialize(),
	            success: function() {
	                renderReplyAll();
	                $form.remove();
	            },
	            error: function() {
	            }
	        });
	    });
		
	    /* 댓글읽어오기 매서드 + 접속한 인원의 댓글이면 수정 및 삭제 버튼 생성 펑션 --> css적용 위치가 매우 예민하므로 구조 안바뀌게 조심! */
	    function renderReplyAll() {
	    	/* input아이디 컨트롤러에서 읽기 귀찮아서 그냥 선언함 sessionScope 애용합시다.. */
	        const inputId = "${sessionScope.user_name}";
	        $.ajax({
	            url: "getReplies",
	            type: "GET",
	            data: { bno: bno },
	            dataType: "json",
	            success: function(data) {
	                $("#readReplyContainer").empty();
	                data.forEach(function(list) {
	                    const $reply = $("<div>").addClass("readReplyInner").attr("data-bno", list.rno);
	                    const $content = $("<div>").append($("<span>").addClass("ReplyComment").text(list.rContent));
	                    const $writer = $("<div>").append($("<span>").addClass("ReplyWriter").text(list.rWriter));
	                    const $date = $("<div>").append($("<span>").addClass("ReplyWriteDate").text(list.rWritedate));
	
	                    $reply.append($content, $writer, $date);
	
	                    if (list.rWriter === inputId) {
	                        const $btnBox = $("<div>").addClass("reply-btns");
	                        const $editBtn = $("<button>").text("수정").addClass("edit-reply-btn");
	                        const $delBtn = $("<button>").text("삭제").addClass("delete-reply-btn");
	                        $btnBox.append($editBtn, $delBtn);
	                        $reply.append($btnBox);
	                    }
	
	                    $("#readReplyContainer").append($reply);
	                });
	            },
	            error: function() {
	                console.log("댓글 로딩 실패");
	            }
	        });
	    }
	    /* 가장 하단에도 viewer 스크립트가 있는데 이건 페이지가 load되서 viewer객체가 생성되자마자 실행되어야하는 내용이라 body윗단으로 못데려옴 아래는 해당 스크립트 설명임 근데 이제 html단에 주석 넣어두면 html 콘솔에 출력이 되기때문에.. 주석을 여기 둡니다*/
	    /* id=viewer인 객체에 에디터를 생성해서 viewer : true <읽기전용 뷰어모드로 설정하고 해당 페이지에 맞는 내용을 읽어옴 */
	</script>
	<script>
	    $(document).ready(function() {
	        const inputId = "${sessionScope.user_name}";
	        const writer = "${detail.BWriter}";
	
	        if (inputId && inputId === writer) {
	            const editBtn = $('<button id="editBtn">수정</button>').click(() => {
	                location.href = "/projectboard/writeBuildPost?bbno=" + bno;
	            });
	            const deleteBtn = $('<button id="deleteBtn">삭제</button>').click(() => {
	                if (confirm("삭제합니다")) {
	                   location.href = "/projectboard/deleteBuildPost?bno=" + bno;
	                }
	            });
	            $('#EditPostBtn').append(editBtn, deleteBtn);
	        }
	    });
	</script>

</head>
<body>
	<div id = "header_div">
		<div id = "header_inner">
			<div>
				<a id = "mainHome" href = "${pageContext.request.contextPath}/">
					<img id="swsLogo" src="${pageContext.request.contextPath}/resources/images/swsLogo.png"/> <span id="logoSpan">LOL.SWS</span>
				</a>
				<div></div> 
				<a href = "champinoDetail">챔피언 상세</a>
				<a href = "${pageContext.request.contextPath}/summonerInfo">소환사 상세</a>
				<a href = "summonerRank">소환사 랭킹</a>
				<div>
					<ul class = "menu-container">
						<li>
						<a href = "BUILD_BOARD3">커뮤니티</a>
							<ul class = "sub-menu">
								<li><a href = "BUILD_BOARD3">빌드 연구소</a></li>
								<li><a href = "/projectboard/list">자유 게시판</a></li>
								<li><a href = "/projectboard/patch/patchlist">패치 게시판</a>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div id="loginContainer">
				<% if (session.getAttribute("id") != null) { %>
				    <a id="myPage" href="${pageContext.request.contextPath}/mypage">마이페이지</a>
				    <a id="logout" href="buildLogout">로그아웃</a>
				<% } else { %>
				    <a href="/project">로그인</a>
				<% } %>
			</div>
		</div>	
	</div>
	<div id = "main">
		<div id = "search_bar">
			<div id = "search_bar_inner">
				<div>
					<input id="search"  type = "search" placeholder = "칼 애쉬 검색" autocomplete="off"/>
					<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="20px" height="20px"><path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path></svg>
					<div id="SearchResult"></div>
				</div>
			</div>
		</div>
		<div id = "sub_menu">
			<div id = "sub_menu_inner">
				<div>커뮤니티</div>
				<div>
					<div id="자유"><a href = "/projectboard/list" class="menu-container">자유 게시판</a></div>
					<div id="빌드"><a href = "BUILD_BOARD3" class="menu-container">빌드 게시판</a></div>
					<div id="패치"><a href = "/projectboard/patch/patchlist" class="menu-container">패치 게시판</a></div>
				</div>
			</div>
		</div>
		<div id = "build_container">
			<div>
				<div id="chat_container">
					    <div id="chat-box">
					        <div id="chat-scroll">
							    <div id="chatLog" style=" border:1px soild red; height:170px; overflow:auto; margin-top:10px;"></div>
					        </div>
					        <div id="chat-input">
					            <input type="text" id="msg" placeholder="메시지 입력"/><button onclick="sendMessage()">전송</button>
					        </div>
					    </div>
					</div>
				<div id="board_container">
					<div>
						<div id="content">
							<div class="content_inner">
								<table id="content_inner_data">
									<tr id="titleTr">
										<td style="width:1000px;">제목 : ${detail.BTitle} <span id="EditPostBtn" style="float: right;"></span></td>
									</tr>
									<tr id="writerTr">
										<td>작성자 : ${detail.BWriter}</td>
									</tr>
									<tr id="writeDateTr">
										<td>작성일 : ${detail.BDate}</td>
									</tr>
									<tr id="viewBoxTr">
										<td>
										  <div id="viewer"></div>
										</td>
									</tr>
								</table>
								<button id="RatingBtn"><svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" class=""><path fill="currentColor" d="M15.09 18H12.79C12.1611 18.0013 11.5362 17.9 10.94 17.7L9.42999 17.2C9.03675 17.0681 8.62481 17.0005 8.21002 17H6C5.73478 17 5.48044 16.8946 5.29291 16.7071C5.10537 16.5195 5 16.2652 5 16C5 15.7348 5.10537 15.4804 5.29291 15.2929C5.48044 15.1054 5.73478 15 6 15H8.21002C8.8389 14.9987 9.46376 15.1 10.06 15.3L11.57 15.8C11.9632 15.9319 12.3752 15.9995 12.79 16H15.09C15.1902 15.9999 15.2885 15.9729 15.3746 15.9219C15.4608 15.8709 15.5317 15.7977 15.58 15.71L16.5 14.11C16.8282 13.5305 17.0005 12.8759 17 12.21V9.57C17.0014 9.49477 16.9875 9.42004 16.9594 9.35027C16.9312 9.2805 16.8893 9.21713 16.8361 9.16393C16.7829 9.11073 16.7195 9.06877 16.6497 9.04061C16.58 9.01244 16.5052 8.99863 16.43 8.99999H12.72L13.32 6.60997C13.3924 6.21733 13.3612 5.81263 13.2297 5.43566C13.0982 5.05868 12.8709 4.72243 12.57 4.45998L12.36 5.08998C12.0554 6.00629 11.5991 6.86491 11.01 7.62999L8.16998 11H6C5.73478 11 5.48044 10.8946 5.29291 10.7071C5.10537 10.5195 5 10.2652 5 9.99999C5 9.73477 5.10537 9.48043 5.29291 9.2929C5.48044 9.10536 5.73478 8.99999 6 8.99999H7.23999L9.45001 6.37999C9.88447 5.79796 10.2221 5.14961 10.45 4.45998L10.81 3.39C10.8841 3.16629 11.0055 2.96116 11.166 2.78859C11.3264 2.61603 11.5222 2.48008 11.74 2.39C11.959 2.30155 12.1943 2.26026 12.4304 2.26888C12.6664 2.27749 12.898 2.33581 13.11 2.43999C13.9099 2.86963 14.5512 3.54417 14.9399 4.36476C15.3286 5.18536 15.4443 6.10887 15.27 6.99999H16.42C17.1016 6.99999 17.7553 7.27077 18.2372 7.75273C18.7192 8.2347 18.99 8.88839 18.99 9.57V12.21C18.9872 13.2236 18.7219 14.2193 18.22 15.1L17.31 16.7C17.086 17.092 16.7632 17.4183 16.3736 17.6464C15.984 17.8746 15.5415 17.9965 15.09 18Z"></path><path fill="currentColor" d="M5.5 9H4.5C3.67157 9 3 9.67157 3 10.5V15.5C3 16.3284 3.67157 17 4.5 17H5.5C6.32843 17 7 16.3284 7 15.5V10.5C7 9.67157 6.32843 9 5.5 9Z"></path></svg>추천 ${rating}</button>
							</div>
						</div>
						<div id="replyContainer">
						    <form id="replyForm" action="insertBuildReply" method="post">
						        <div id="insertReplyArea">
						            <textarea name="comment" maxlength="650" id="insertReplyContent" placeholder="댓글을 입력하세요" required></textarea>
						            <input type="hidden" name="bno" value="${detail.BBno}">
						        </div>
						        <button id="insertReplyBtn" type="submit">댓글 작성</button>
						    </form>
						</div>
					    <div id="readReplyContainer">
					    </div>
						<div id="title_container">
							<div class="title">
								<div>번호</div>
								<div>제목</div>
								<div>작성자</div>
								<div>날짜</div>
								<div>조회</div>
								<div>추천</div>
							</div>
						</div>
						<div class="page_controls">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
  		const viewer = toastui.Editor.factory({
    		el: document.querySelector('#viewer'),
    		viewer: true,
    		initialValue: `${detail.BContent}`
 		});
	</script>	
</body>
</html>