<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>빌드 게시판</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
		#header_inner > div:nth-child(2) {
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
			margin-top: 130px;
			margin-left: 340px;
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
			display: flex;
			justify-content: center;
			margin-right: 300px;
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
		/* 게시글 작성 버튼 */
		#insert_board button{
			position: relative;
			width: 130px;
			height: 40px;
			margin-top: 10px;
			border-radius: 10px;
			font-size: 15px;
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
			display: flex;
			align-items: center;
		}
		.select-champion img {
		    width: 30px;
		    transform-origin: 50% 50%;
		    margin-left : 10px;
		    border-radius: 50%;
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
			max-width: 850px;
			flex: 1;
			border-radius: 15px; 
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
		
		.select-champion#0 {
		    display: flex;
		    justify-content: center;
		    width: 100%;
		}
		.select-champion#0 span {
		    display: block;
		}
		/* input_board_search */
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
	<script>
	    $(function() {
	   	    $('#input_board_search').on('input', function() {
	   	        boardCheckSerch = $(this).val();
	   	        renderAll(1);
	   	    });
	   	});
	</script>
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
	<script>
		$(function () {
		    $.ajax({
		        url: './getSelectBox',
		        method: 'GET',
		        dataType: 'json'
		    }).done(championList => {
		        $(".select-championstart").each(function () {
		            $(this).empty();
		
		            const allDiv = $("<div>").addClass("select-champion").attr("id", 0);
		            const span = $("<span>").text("전체").css({ margin: "0 auto" });
		            allDiv.append(span);
		            $(this).append(allDiv);
		
		            championList.forEach(champion => {
		                const div = $("<div>").addClass("select-champion").attr("id", champion.champId);
		                const img = $("<img>").attr("src", champion.champUrl);
		                div.append(img);
		                div.append(document.createTextNode(champion.champName));
		                $(this).append(div);
		            });
		
		            $(this).off("click", ".select-champion");
		            $(this).on("click", ".select-champion", function() {
		                selectId = Number($(this).attr("id"));
		                renderAll(1);
		            });
		        });
		    });
		});
	</script>
	<script>
		let boardCheckSerch = "";
	    const totalPosts = ${totalPosts};
	    const postsPerPage = 15;
	    const totalPages = Math.ceil(totalPosts / postsPerPage);
	    let currentPage = 1;
	    let selectId = 0;
	
	    //selectId == 0 일때 전체 pageList 뽑는 function
	    function getPostsForPage(page) {
	        return $.ajax({
	            url: './getPost',
	            method: 'GET',
	            data: { page: page, size: postsPerPage, boardCheckSerch : boardCheckSerch},
	            dataType: 'json'
	        });
	    }
		
	    //selectId != 0 일때 selectCampIdpageList 뽑는 function
	    function getSelectIdPostsForPage(page, selectId){
	    	return $.ajax({
	    		url: 'getSelectPost',
	    		method: 'GET',
	    		data: { page: page, size: postsPerPage, selectId: selectId , boardCheckSerch: boardCheckSerch},
	    		dataType: 'json'
	    	});
	    }
	    
	    function renderPosts(page) {
	        $('#title_container').find('.cv').remove();
	        const fetch = selectId === 0 ? getPostsForPage(page) : getSelectIdPostsForPage(page, selectId);
	
	        return fetch.done(posts => {
	            posts.forEach(post => {
	                const cv = $('<div class="cv"></div>');
	                cv.append($('<div class="bbno" data-bbno="' + post["bbno"] + '"></div>').text(post["bbno"]));
	                ["btitle", "bwriter", "bdate", "bcheck", "brating"].forEach(key => {
	                    let text = key === "bdate" ? post[key].substring(0, 16) : post[key];
	                    cv.append($('<div></div>').text(text));
	                });
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
						<a href = "/projectboard/list">커뮤니티</a>
							<ul class = "sub-menu">
								<li><a href = "/projectboard/BUILD_BOARD3">빌드 연구소</a></li>
								<li><a href = "/projectboard/list">자유 게시판</a></li>
								<li><a href = "/projectboard/patch/patchlist">패치 게시판</a>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div>
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
					<div id="빌드"><a href = "/projectboard/BUILD_BOARD3" class="menu-container">빌드 게시판</a></div>
					<div id="자유"><a href = "/projectboard/list" class="menu-container">자유 게시판</a></div>
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
				<div id="champ_container">
					<div id="select-box">
						<div id = "asdf">
							<div id="insert_board">
								<button id="board_writeBtn" type="button">게시글 작성</button>
								<script>
									document.getElementById('board_writeBtn').addEventListener('click', function() {
									    const userId = '${sessionScope.id}';
									    if (!userId) {
									        alert('로그인부터 해주세요');
									        location.href = '${pageContext.request.contextPath}/login';
									    } else {
									        location.href = 'writeBuildPost';
									    }
									});
								</script>
							</div>
						</div>
						<div class="select_inner">
							<div class="select-championstart"></div>
						</div>
					</div>
				</div>
				<div id="board_container">
					<div>
						<div id="board_select" style="color:white;">
							<div>
								<select id="Select">
									<option>제목</option>
									<option>제목+내용</option>
									<option>글쓴이</option>
								</select>
							</div>
							<div id="board_search_bar"><input id="input_board_search" type = "search" placeholder = "게시물 검색"/></div>
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
		
</body>
</html>