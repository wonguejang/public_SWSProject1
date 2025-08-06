<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="${pageContext.request.contextPath}/resources/summoner_chart.js"></script>
	<script src="${pageContext.request.contextPath}/resources/summoner_chart2.js"></script>
	<script src="${pageContext.request.contextPath}/resources/damageChart.js"></script>
	<script src="${pageContext.request.contextPath}/resources/damageChart2.js"></script>
	<meta charset="UTF-8">
	<title>소환사 상세</title>
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
		#main > #summoner_info{
			display: flex;
			justify-content: center;
			align-items: center;
			height: 250px;
		}
		#main > #summoner_info > div:first-child{
			position:relative;
			width: 1040px;
			display : flex;
			justify-content : left;
			align-items : center;
			height : 200px;
		}
		#summoner_info_inner > div:first-child > img { 
			position:relative;
			justify-content: left;
			height: 190px;
			width: 190px;
			border-radius: 10%;
			border:1px solid red;
		}
		#summoner_info_inner > div:nth-child(2) {
			position:relative;
			width:500px;
			height:190px;
			text-align:left;
			padding:40px 20px;
		}
		#info {
			color:white;
		}
		#info > div:first-child {
			position:static;
			font-size: 15px;
			border-color:rgba(0,0,0,0);
		}
		#info > div:nth-child(2) {
			position:static;
			height: 40px;
			margin: 5px 0px;
			font-size: 30px;
		}
		#info > div:nth-child(2) > svg:first-child { 		/* 즐겨찾기 */
			width: 40px;
			color: white;
			cursor: pointer;
		}
		#info > div:nth-child(2) > svg:first-child:hover {
			cursor: pointer;
		}
		#info > div:nth-child(3) {
			position:static;
			font: 30px;
			height: 35px;
		}
		#summoner_info_inner > div:nth-child(3) {
			position:relative;
			width:150px;
			height:190px;
			text-align:right;
			padding:40px 20px;
		}
		#update_read > div:first-child {
			position:static;
			font: 15px;
			color: white;
			/* border-color:rgba(0,0,0,0); */
		}
		#update_read > div:nth-child(2) {
			position:static;
			height: 35px;
			margin: 5px 0px;
			color: white; 			
		}
		#update_read > div:nth-child(3) > button{
			background-color: white;
			border-radius: 10px;
			width: 80px;
			height: 45px;
			
		}
		#content_container {
			display: flex;
			justify-content: center;
			align-items: center;
			height: auto;
			top:20px;
		}
		
		/* content-container 3분할 */
		#content_container > div:first-child{
			position:relative;
			width: 340px;
			display : flex;
			justify-content : left;
			height : 400px;
			background-color:  rgb(53 57 69);
			border-top-left-radius:10px;
			border-bottom-left-radius:10px;
		}
		#content_container > div:nth-child(2){
			position:relative;
			width: 340px;
			display : flex;
			justify-content : left;
			height : 400px;
			background-color: rgb(53 57 69);
			z-index: 2; 
		}
		#content_container > div:nth-child(3){
			position:relative;
			width: 340px;
			display : flex;
			justify-content : left;
			height : 400px;
			background-color: rgb(53 57 69);
			border-bottom-right-radius:10px;
			border-top-right-radius:10px;
			z-index: 1;
		}
		
		#champion > div:first-child {
		    position: relative;
		    width: 180px;
		    height: 160px;
		    margin-right: 0;
		    margin-bottom: 0;			
		}
		#champion > div:nth-child(2) {
			position:relative;
			width: 340px;
			height: 160px;
		}
		
		/* 챔피언 사진 */
		#champion > div:first-child > div:first-child img{
		    position: relative;
			width: 120px;
			height: 120px;
			margin: 30px 20px 13px 20px;
			border-radius: 20px;
			border: 5px solid gold;
			background-size: cover;
		}
		/* 룬 */
		#champion > div:first-child > div:nth-child(2) {
			margin:0px;
			margin-left:6px;  
			width: 163px;
			height: 200px;
		}
		/* 메인룬 */
		#rune_main img {
			margin:2px;
			width: 33px;
			height: 33px;
			border-radius:50%;
			border: 2px solid gold;
			filter: grayscale(100%);
		}
		.main_rune img {
			margin:2px;
			width: 28px;
			height: 28px;
			border-radius:50%;
			border: 2px solid gold;
			filter: grayscale(100%);
		}
		
		/* 서브룬 */
		#rune {
			font-size:15px;
			color:rgb(174, 144, 86);
			text-align:center;
			width: 180px;
			height: 30px;
		}
		#subrune img {
			margin:2px;
			width: 28px;
			height: 28px;
			border-radius:50%;
			border: 2px solid gold;
			filter: grayscale(100%);
		}
		#subrune > div > div {
		  	display: flex;
		  	justify-content: center; 
		  	gap: 0px; 
		}
		
		/* 파편 */
		#Rune_Shard img {
			margin:1px;
			width: 22px;
			height: 22px;
			border-radius:50%;
			border: 1px solid gold;
			filter: grayscale(100%);
		}
		#Rune_Shard > div > div {
		  	display: flex;
		  	justify-content: center; 
		  	gap: 0px; 
		}
		#Rune_Shard >div:first-child {
			margin-top: 5px;
		}
	
		/* 챔피언 이름 */
		#champion > div:nth-child(2) > div:first-child {
			position:relative;
			height:40px;
			width: 160px;
			margin:0px;
			font-size: 30px;
			color:white;
		}
		/* 챔피언 승률 픽률 밴율 div */
		#champion > div:nth-child(2) > div:nth-child(2) {
			position:relative;
			width: 160px;
			height:74px;
			margin:0px;
			font-size: 16px;
		}
		#champion > div:nth-child(2) > div:first-child > p:first-child {
			width: 160px; 
			height: 60px;
			margin: 53px 0px 0px 10px;
		}
		#champion > div:nth-child(2) > div:nth-child(2) > p:first-child {
			position:relative;
		    display:flex;
			width: 160px;
			height: 30px;
			margin:0px;
			color: gold;
		}
		#champion > div:nth-child(2) > div:nth-child(2) > p:nth-child(2) {
			position:relative;
			height: 30px;
		    display:flex;
			width: 160px;
			margin:0px;
			color: white;
		}
		
		/* skill & item build */ 
		#build {  /* 전체틀 */
			display:flex;
			flex-direction: column;
		}
		
		/* item_build */
		#build > div:first-child {
			margin-top:30px;
		    display: flex;
		    flex-direction:row;
		    width: 340px;
		    height: 175px;
		    border: 2px solid rgb(110, 115, 130);
		    padding-top:10px;
		    padding-left:5px;
		    box-shadow: inset 0 0 0 1px rgb(85, 90, 105);
		    border-radius: 10px;
		}
		#item_build span {
			color: rgb(174, 144, 86);
			font-size: 13px;
		}
		#item_build span:first-child {
			margin-right:5px;
		}
		#item_build span:nth-child(2) {
			margin-left : 1px;
			margin-right : 2px;
		}
		#item_build span:nth-child(3) {
			margin-right:3px;
		}
		#item_build img {
			margin: 10px 0px 0px 5px;
			border-radius:5px;
			width: 25px;
			height: 25px;
		}
		#item_build_inner_text span{
			color:white;
			margin-left:5px;
		}
		
		/* skill_build */  /* 그리드 이용 */
		.skill_build {
			margin-top:20px;
			display: grid;
			grid-template-columns: repeat(17, 1fr);
			gap: 9px;
			width: 660px;
			height: 155px;
			border: 2px solid #aaa;
			padding: 10px;
			border-radius: 10px;
			background-color: rgb(53, 57, 69);
		}
		
		.slot {
			display: grid;
			grid-template-rows: repeat(4, 1fr); 
			gap: 2px;
			background-color: transparent;
		}
		.skill_cell {
			display: flex;
			justify-content: center;
			align-items: center;
			font-weight: bold;
			color: white;
			border-radius: 4px;
			font-size: 14px;
			/* 스킬 체크박스(연함) */
			background-color: rgba(255, 255, 255, 0.05); 
		}
			/* 스킬 체크박스(진함) -> 체크시 */
		.skill_cell.active {
			background-color: gold;
			color: black;
		}	
		.skill_build ima{
			width:20px;
		}
		/* 체크설명 안하고 넘어갈뻔 -> q w e r 뒤에 active넣으면 됨. 예시로 해둠*/ 
		
		
		
		/* matchs data */
		#content_container2 {
			display: flex;
			justify-content: center;
			align-items: center;
			height: auto;
			top: 20px;
		}

		#matchs_container {
			min-width: 1040px;
			max-width: 1040px;
			display: flex; /* 왼쪽/오른쪽 배치용 */
		}
		
		
		/* 최근 경기 미니 전광판 */
    	#matchs_inner {
      		position: relative;
      		display: flex;
      		height: auto;
      		width: 700px;
      		padding: 10px;
    	}
		#recent_matches_mini {
			padding:10px;
			width: 1040px;
			height: 120px;
			display:flex;
			background-color: rgb(53, 57, 69);
			border-radius: 20px;
		}
		#recent_matches_mini > div:first-child {
	  		width: 200px;  /* 왼쪽 div 크기 */
  			border-top-left-radius: 20px;
  			border-bottom-left-radius: 20px;
  			background-color: rgba(255, 255, 255, 0.05); 
		}
		#recent_matches_mini > div:nth-child(2) {
  			flex: 1;  /* 오른쪽 div 크기 */
			border-top-right-radius: 20px; 
			border-bottom-right-radius: 20px; 
			background-color: rgba(255, 255, 255, 0.05); 
		}
		#recent_matches_mini > div:first-child > div:first-child{
			background-color: rgb(16 19 28);
			width: 200px;
			height: 100px;
			border-radius: 20px;
		}
		#on_mini_matches {
			display:flex;
			justify-content:center;
			align-items:center;
			width: 200px;
			height: 40px;
			color: rgb(61 105 255);
		}
		#down_mini_matches {
			display: flex;
  			align-items: center;
  			gap: 8px;
		}
		
		#summoner_chart{
			margin-top: 10px;
		}
		#summoner_chart2 {
 		 	margin-left: 30px;
		}
		#down_mini_matches > div:last-child {
  			display: flex;
  			flex-direction: column; /* 텍스트를 세로로 쌓기 */
  			justify-content: center; /* 세로 가운데 정렬 */
  			text-align: center; /* 텍스트 수평 가운데 정렬 */
  			line-height: 0.9;
  			color: white;
  			font-size: 14px;
		}
		#match_mini_title {
		    width: 100%;
		}
		#most {
		    padding: 10px;
		    color: rgb(130 135 153);
		    font-size: 13px;
		}
		
		.champion_list {
		    display: flex;
		    justify-content: space-between;
		    gap: 5px; /* 아이템 사이 간격 */
		    width: 100%;
		    padding: 0 10px;
		}
		
		.champion_block {
		    display: flex;
		    align-items: center;
		    width: 32%;
		}
		
		.champion_img > img {
		    width: 50px;
		    height: 50px;
		    margin-right: 15px;
		    border-radius: 10px;
		}
		
		.champion_info {
		    display: flex;
		    flex-direction: column;
		    justify-content: center;
		    text-align: center;
		    line-height: 0.7;
		    color: white;
		    font-size: 12px;
		    margin-bottom: 5px;
		}
		.champion_info > span:first-child {
			font-size: 14px;
		}
		#recent_matches {
			height:auto;
		}
		
		
		/* 최근 경기 조회 */
		#matches_detail {
			background-color: rgb(0 0 59 /0.8);
			border-left: 5px solid rgb(58 55 253 / 0.18);
			border-right: 5px solid rgb(58 55 253 / 0.18);
		}
		
		#matches_detail canvas {
		    width: 120px !important;
		    height: 120px !important;
		}
		#matches_detail > div.detail_inner {
	    	display: none;
		}
		.detail_inner {
		    display: flex;
		    gap: 10px;
		    align-items: stretch;
		    height: 130px;
		}
			
		.match_result {
			margin: 15px 0 0 25px;
			font-size: 15px;
			width: 100px;
		}
		.detail_info {
			width: 250px;
			height: auto;
		}
		.damage_container {
			display: flex;
			height:auto;
			margin-left: 50px;		
		}
		.match_result_inner div:first-child {
			display: flex;
			justify-content: left;
		}
		.match_result_inner div:nth-child(2) {
			display: flex;
			align-items: center;
			gap:1px;
			height: 25px;
		}
		.match_result_inner div:nth-child(2) p:first-child{
			color: white;
		}
		.match_result_inner div:nth-child(2) p:nth-child(2){
			color: rgb(130 135 153);
		}
		.match_result_inner div:nth-child(3) {
			color: rgb(130 135 153);
		}
		
		.detail_info > div:first-child{
			font-size:0px;
			display:flex;
			margin-top:15px;
			height:70px;
		}
		.match-champion img{
			width: 70px;
			height: 70px;
			border-radius: 10px;
		}
		.match-spell {
			margin-left:2px;
			width: 35px;
		}
		.match-spell img {
			height:35px;
			width:35px;
			border-radius: 5px;
		}
		.match-rune{
			width: 35px;		
		}
		.match-rune > img{
			height:35px;
			width: 35px;
			border-radius: 50%;
		}
		.match-kda {
			flex: 1;
			flex-direction:column;
			font-size:15px;
			display: flex;
			justify-content:center;
			align-items: center;
			color:white;
		}
		.match-kda span:first-child {
			color:white;
		}
		.match-kda span:nth-child(2) {
			color: rgb(130 135 153);
		}
		.match_item_build {
		    display: flex;
		}
		.match_item_build img {
			margin-top:5px;
		    flex: 1;
		    width: 30px;
		    height: 30px;
		    
		}
		.match_item_build img:not(:last-child) {
		    margin-right: 8px;
		}
		
		
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
		#mainHome > svg {
			color : white;
			width : 131px;
			height : 20px;
		}
		.main_rune.on {
         margin:2px;
         width: 28px;
         height: 28px;
         border-radius:50%;
         border: 2px solid gold;
         filter: none !important;
	      }
		.on {
	         margin:2px;
	         width: 28px;
	         height: 28px;
	         border-radius:50%;
	         border: 2px solid gold;
	         filter: none !important;
	    }
		#Rune_Shard img.shardOn  {
	         margin:1px;
	         width: 22px;
	         height: 22px;
	         border-radius:50%;
	         border: 1px solid gold;
	         filter: none !important;
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
	<!-- 아래는 승률 50% 이상이면 파랑 미만이면 빨강 -->
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
	                                        alert('검색 실패 없는 내용입니다.');
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
	    $(document).ready(function () {
	    	$('.champion_info').each(function () {
	        	const firstSpan = $(this).find('span').first();
	        	const value = parseFloat(firstSpan.text());
	
	        	if (!isNaN(value)) {
	          		if (value >= 50) {
	            		firstSpan.css('color', 'blue');
	          		} else {
	            	firstSpan.css('color', 'red');
	          		}
	        	}
	      	});
	   	});
	</script>
	<!-- 아래는 승리면 파랑 패배면 빨강 -->
	<script>
	   	$(function(){
	       	$('.match_result_inner div:first-child').each(function () {
	            const resultText = $(this).text().trim();
	            if (resultText === "승리") {
	                $(this).css('color', 'blue');
	            } else if (resultText === "패배") {
	                $(this).css('color', 'red');
	            }
	       	});
	   	});
	</script>
	<!-- Match_Detail -->
	<script>
	    window.cnt = 0;
	    let throttle = false;
	
	    window.addEventListener('scroll', () => {
	        if (throttle) return;
	        if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 100) {
	            const allDetails = document.querySelectorAll('#matches_detail > div.detail_inner');
	            if (window.cnt < allDetails.length) {
	                allDetails[window.cnt].style.display = 'flex';
	                window.cnt++;
	                throttle = true;
	                setTimeout(() => throttle = false, 300); // 0.3초 간 딜레이
	            }
	        }
	    });
	</script>
	<script>
	    const redData = [
	        { nickname: "${totalDetail[0][0].matchId}", damage: ${totalDetail[0][0].playerDamage} },
	        { nickname: "${totalDetail[0][1].matchId}", damage: ${totalDetail[0][1].playerDamage} },
	        { nickname: "${totalDetail[0][2].matchId}", damage: ${totalDetail[0][2].playerDamage} },
	        { nickname: "${totalDetail[0][3].matchId}", damage: ${totalDetail[0][3].playerDamage} },
	        { nickname: "${totalDetail[0][4].matchId}", damage: ${totalDetail[0][4].playerDamage} }
	    ];
	    const blueData = [
	        { nickname: "${totalDetail[0][5].matchId}", damage: ${totalDetail[0][5].playerDamage} },
	        { nickname: "${totalDetail[0][6].matchId}", damage: ${totalDetail[0][6].playerDamage} },
	        { nickname: "${totalDetail[0][7].matchId}", damage: ${totalDetail[0][7].playerDamage} },
	        { nickname: "${totalDetail[0][8].matchId}", damage: ${totalDetail[0][8].playerDamage} },
	        { nickname: "${totalDetail[0][9].matchId}", damage: ${totalDetail[0][9].playerDamage} }
	    ];
	    createRedChart(document.getElementById('redChart').getContext('2d'), redData);
	    createBlueChart(document.getElementById('blueChart').getContext('2d'), blueData);
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
	    window.addEventListener('DOMContentLoaded', () => {
	        const runeOnList = [
	            "${RuneBuildOn.runeUrL_1}",
	            "${RuneBuildOn.runeUrL_2}",
	            "${RuneBuildOn.runeUrL_3}",
	            "${RuneBuildOn.runeUrL_4}",
	            "${RuneBuildOn.runeUrL_5}",
	            "${RuneBuildOn.runeUrL_6}"
	        ];
	
	        document.querySelectorAll('img').forEach(img => {
	            if (runeOnList.includes(img.src)) {
	                img.classList.add('on');
	            }
	        });
	    });
	</script>
	<script>
	   window.addEventListener('DOMContentLoaded', () => {
	       const shardOnMap = {
	           OFFENSE: "${ShardBuildOn.shardUrl1}",
	           FLEX: "${ShardBuildOn.shardUrl2}",
	           DEFENSE: "${ShardBuildOn.shardUrl3}"
	       };
	   
	       Object.entries(shardOnMap).forEach(([id, url]) => {
	           const container = document.getElementById(id);
	           if (!container) return;
	           container.querySelectorAll('img').forEach(img => {
	               if (img.src === url) {
	                   img.classList.add('shardOn');
	               }
	           });
	       });
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
				<div></div> <!-- 세로 bar -->
				<a href = "champinoDetail">챔피언 상세</a>
				<a href = "${pageContext.request.contextPath}/summonerInfo">소환사 상세</a>
				<a href = "summonerRank">소환사 랭킹</a>
				<div>
					<ul class = "menu-container">
						<li>
						<a href = "/projectboard/BUILD_BOARD3">커뮤니티</a>
							<ul class = "sub-menu">
								<li><a href = "BUILD_BOARD3">빌드 연구소</a></li>
								<li><a href = "/projectboard/list">자유 게시판</a></li>
								<li><a href = "/projectboard/patch/patchlist">패치 게시판</a></li>
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
		<div id = "summoner_info">
			<div id= "summoner_info_inner">
				<div>
					<img src="${summonericon}"/>
				</div>
				<div id= "info">
					<div>
						<span>${info.ranks}</span>
						<span class="not-italic text-psbk-sub">l</span>
						<span>${info.leaguePoints}LP</span>
					</div>
					<div>${info.summonerId}
						<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="100%" height="100%"><path fill="white" d="M9.125 17.45 12 15.725l2.875 1.75-.75-3.275L16.65 12l-3.325-.3L12 8.6l-1.325 3.075-3.325.3 2.525 2.2ZM12 18.8l-4.2 2.55q-.375.225-.775.188-.4-.038-.675-.263-.3-.225-.462-.587-.163-.363-.063-.788l1.125-4.75-3.725-3.225q-.325-.3-.413-.675-.087-.375.013-.725.125-.375.413-.625.287-.25.737-.3l4.9-.425 1.9-4.5q.175-.4.513-.6.337-.2.712-.2.375 0 .713.2.337.2.512.6l1.9 4.5 4.9.425q.45.05.738.3.287.25.412.625.1.35.013.725-.088.375-.413.675L17.05 15.15l1.125 4.75q.1.425-.062.788-.163.362-.463.587-.275.225-.675.263-.4.037-.775-.188Zm0-5.5Z"></path></svg>
					</div>
					<div style="font-size:12px; position:absolute; bottom:10px; color: rgba(193, 197, 202, 0.5);">무언가 기능이 들어갈수도 있고 없을수도 있고...</div>
				</div>
				<div id= "update_read">
					<div style="font-size:10px; color:rgb(193 197 202);">조회수:8회</div>
					<div style="font-size:10px; color:rgb(193 197 202);">최근업데이트<br/>
					2분전</div>
					<div><!-- <button>새로고침</button> --></div>
				</div>
			</div>
		</div>
		<div>
			<div id = "content_container">
				<div id = "champion">
					<div>
						<div><img id="챔피언사진" src="${summonerChampionImage}"/></div>
						<div id="rune">
							<div>메인룬</div>
							<div>
								<div id="rune_main">
									<div><img class="main_rune" src="${mainrunebackground.mainrune1}"/><img class="main_rune" src="${mainrunebackground.mainrune2}"/><img class="main_rune" src="${mainrunebackground.mainrune3}"/></div>
								</div>
							</div>
							<div class="main_rune"><img src="${mainrunebackground.subrune1}"/><img src="${mainrunebackground.subrune2}"/><img src="${mainrunebackground.subrune3}"/></div>
							<div class="main_rune"><img src="${mainrunebackground.subrune4}"/><img src="${mainrunebackground.subrune5}"/><img src="${mainrunebackground.subrune6}"/></div>
							<div class="main_rune"><img src="${mainrunebackground.subrune7}"/><img src="${mainrunebackground.subrune8}"/><img src="${mainrunebackground.subrune9}"/></div>
						</div>
					</div>
					<div>
						<div>
							<p id="챔피언이름">${ChampionKoreaName}</p>
						</div>
						<div>
							<p>
								<a style="margin-left:10px; width:50px;">승률</a>
								<a style="margin-left:10px; width:50px;">픽률</a>
								<a style="margin-left:10px; width:50px;">벤률</a>
							</p>
							<p>
								<a style="margin-left:10px; width:50px;">${info.winrate}</a>
								<a style="margin-left:10px; width:50px;">3.1</a>
								<a style="margin-left:10px; width:50px;">2.6</a>
							</p>
						</div>
							<div id="rune">서브룬</div>
						<div id="subrune">
							<div>
								<div class="sub_rune"><img src="${subrunebackground.subrune1}"/><img src="${subrunebackground.subrune2}"/><img src="${subrunebackground.subrune3}"/></div>
							</div>
							<div>
								<div class="sub_rune"><img src="${subrunebackground.subrune4}"/><img src="${subrunebackground.subrune5}"/><img src="${subrunebackground.subrune6}"/></div>
							</div>
							<div>
								<div class="sub_rune"><img src="${subrunebackground.subrune7}"/><img src="${subrunebackground.subrune8}"/><img src="${subrunebackground.subrune9}"/></div>
							</div>
						</div>
						<div id="Rune_Shard">
							<div>
								<div id = "OFFENSE"><img src="${shardbackground.nth4}"/><img src="${shardbackground.nth2}"/><img src="${shardbackground.nth3}"/></div>
							</div>
							<div>
								<div id = "FLEX"><img src="${shardbackground.nth4}"/><img src="${shardbackground.nth5}"/><img src="${shardbackground.nth1}"/></div>
							</div>
							<div>
								<div id = "DEFENSE"><img src="${shardbackground.nth6}"/><img src="${shardbackground.nth7}"/><img src="${shardbackground.nth1}"/></div>
							</div>
						</div>
					</div>
				</div>
				<div id="build">
					<div id="item_build">
						<div>
							<span style="color:gold;">1코어</span><span>승률</span><span>채택률</span>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem1}"/><span >${itembuildRate.winRate1}</span><span >${itembuildRate.pickRate1}</span></div>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem2_1}"/><span >${itembuildRate.winRate2}</span><span >${itembuildRate.pickRate2}</span></div>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem3_1}"/><span >${itembuildRate.winRate1}</span><span >${itembuildRate.pickRate1}</span></div>
						</div>
						<div>
							<span style="color:gold;">2코어</span><span>승률</span><span>채택률</span>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem2}"/><span >${itembuildRate.winRate2}</span><span >${itembuildRate.pickRate2}</span></div>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem2_2}"/><span >${itembuildRate.winRate5}</span><span >${itembuildRate.pickRate5}</span></div>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem3_2}"/><span >${itembuildRate.winRate3}</span><span >${itembuildRate.pickRate3}</span></div>
						</div>
						<div>	
							<span style="color:gold;">3코어</span><span>승률</span><span>채택률</span>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem3}"/><span >${itembuildRate.winRate3}</span><span >${itembuildRate.pickRate3}</span></div>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem2_3}"/><span >${itembuildRate.winRate6}</span><span >${itembuildRate.pickRate6}</span></div>
							<div id="item_build_inner_text"><img src="${itembuild.cbiItem3_3}"/><span >${itembuildRate.winRate4}</span><span >${itembuildRate.pickRate4}</span></div>
						</div>
					</div>
					<div class="skill_build">
						<div class="slot" style="color: gold;">
							<div class="skill_cell q active">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w active">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e active">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q active">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q active">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r active">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q active">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q active">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w active">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w active">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w active">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r active">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e active">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e active">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e active">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w active">W</div>
							<div class="skill_cell e">E</div>
							<div class="skill_cell r">R</div>
						</div>
						<div class="slot">
							<div class="skill_cell q">Q</div>
							<div class="skill_cell w">W</div>
							<div class="skill_cell e active">E</div>
							<div class="skill_cell r">R</div>
						</div>
					</div>
				</div>
				<div>
					<div id="chart_js">
						<canvas id="summoner_chart" width="340" height="200"></canvas>
					</div>
				</div>
			</div>
			<div id="content_container2">
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
					<div id="matchs">
						<div id="matchs_inner">
							<div id="recent_matches_mini">
								<div>
									<div>
										<div id="on_mini_matches">20전 11승 9패</div>
										<div id="down_mini_matches">
											<div><canvas id="summoner_chart2" width="45;" height="45;"></canvas></div>
											<div>
												<span> 3.71 KDA </span><br/>
												<span> 5.5/ 3.3 / 6.6 </span>
											</div>
										</div>
									</div>
								</div>
								<div id="match_mini_title">
								    <div id="most">모스트 3챔피언</div>
								    <div class="champion_list">
								        <div class="champion_block">
								            <div class="champion_img"><img class="champImage" src="http://ddragon.leagueoflegends.com/cdn/15.14.1/img/champion/${main3champ[0].playerChamp}.png"/></div>
								            <div class="champion_info">
								                <span>${main3champ[0].winRate}%</span><br/>
								                <span>${main3champ[0].winCnt}승 ${main3champ[0].loseCnt}패</span><br/>
								                <span>${main3champ[0].kda} KDA</span>
								            </div>
								        </div>
								        <div class="champion_block">
								            <div class="champion_img"><img class="champImage" src="http://ddragon.leagueoflegends.com/cdn/15.14.1/img/champion/${main3champ[1].playerChamp}.png"/></div>
								            <div class="champion_info">
								                <span>${main3champ[1].winRate}%</span><br/>
								                <span>${main3champ[1].winCnt}승 ${main3champ[1].loseCnt}패</span><br/>
								                <span>${main3champ[1].kda} KDA</span>
								            </div>
								        </div>
								        <div class="champion_block">
								            <div class="champion_img"><img class="champImage" src="http://ddragon.leagueoflegends.com/cdn/15.14.1/img/champion/${main3champ[2].playerChamp}.png"/></div>
								            <div class="champion_info">
								                <span>${main3champ[2].winRate}%</span><br/>
								                <span>${main3champ[2].winCnt}승 ${main3champ[2].loseCnt}패</span><br/>
								                <span>${main3champ[2].kda} KDA</span>
								            </div>
								        </div>
								    </div>
								</div>
							<div>
						</div>
					</div>
				</div>
				<div id="recent_matches">
					<div>
						<div>
							<div id="matches_detail">
				                <c:forEach var="matchList" items="${totalDetail}" varStatus="status">
				                    <div class="detail_inner">
				                        <div class="match_result">
				                            <div class="match_result_inner">
				                                <div>${matchList.get(10).winOrLosses}</div>
				                                <div><p>솔랭</p><p>${matchList.get(10).playTime}</p></div>
				                                <div>${matchList.get(10).endTime}</div>
				                            </div>
				                            <div></div>
				                        </div>
				                        <div class="detail_info">
				                            <div>
				                                <div class="match-champion"><img src="${matchList.get(10).championUrl}"></div>
				                                <div class="match-spell">
				                                    <img src="https://cdn.lol.ps/assets/img/spells/11_40.webp">
				                                    <img src="https://cdn.lol.ps/assets/img/spells/4_40.webp">
				                                </div>
				                                <div class="match-rune">
				                                    <img src="https://cdn.lol.ps/assets/img/runes2/8010_40.webp">
				                                    <img src="https://cdn.lol.ps/assets/img/runes2/8300_40.webp">
				                                </div>
				                                <div class="match-kda">
				                                    <span>${matchList.get(10).playerKills}/${matchList.get(10).playerDeaths}/${matchList.get(10).playerAssists}</span>
				                                    <span>Perfect KDA</span>
				                                </div>
				                            </div>
				                            <div class="match_item_build">
				                                <img src="https://ddragon.leagueoflegends.com/cdn/15.9.1/img/item/${matchList.get(10).matchItem1}.png">
				                                <img src="https://ddragon.leagueoflegends.com/cdn/15.9.1/img/item/${matchList.get(10).matchItem2}.png">
				                                <img src="https://ddragon.leagueoflegends.com/cdn/15.9.1/img/item/${matchList.get(10).matchItem3}.png">
				                                <img src="https://ddragon.leagueoflegends.com/cdn/15.9.1/img/item/${matchList.get(10).matchItem4}.png">
				                                <img src="https://ddragon.leagueoflegends.com/cdn/15.9.1/img/item/${matchList.get(10).matchItem5}.png">
				                                <img src="https://ddragon.leagueoflegends.com/cdn/15.9.1/img/item/${matchList.get(10).matchItem6}.png">
				                                <img src="https://ddragon.leagueoflegends.com/cdn/15.9.1/img/item/${matchList.get(10).matchItem7}.png">
				                            </div>
				                        </div>
				                        <div class="damage_container">
										    <canvas id="redChart${status.index}"></canvas>
										    <canvas id="blueChart${status.index}"></canvas>
										    <script>
										        const redData${status.index} = [
										            {nickname: "${totalDetail[status.index][0].mdSummonerId}", damage: ${totalDetail[status.index][0].playerDamage}},
										            {nickname: "${totalDetail[status.index][1].mdSummonerId}", damage: ${totalDetail[status.index][1].playerDamage}},
										            {nickname: "${totalDetail[status.index][2].mdSummonerId}", damage: ${totalDetail[status.index][2].playerDamage}},
										            {nickname: "${totalDetail[status.index][3].mdSummonerId}", damage: ${totalDetail[status.index][3].playerDamage}},
										            {nickname: "${totalDetail[status.index][4].mdSummonerId}", damage: ${totalDetail[status.index][4].playerDamage}}
										        ];
										        const blueData${status.index} = [
										            {nickname: "${totalDetail[status.index][5].mdSummonerId}", damage: ${totalDetail[status.index][5].playerDamage}},
										            {nickname: "${totalDetail[status.index][6].mdSummonerId}", damage: ${totalDetail[status.index][6].playerDamage}},
										            {nickname: "${totalDetail[status.index][7].mdSummonerId}", damage: ${totalDetail[status.index][7].playerDamage}},
										            {nickname: "${totalDetail[status.index][8].mdSummonerId}", damage: ${totalDetail[status.index][8].playerDamage}},
										            {nickname: "${totalDetail[status.index][9].mdSummonerId}", damage: ${totalDetail[status.index][9].playerDamage}}
										        ];
										        createRedChart(document.getElementById('redChart${status.index}').getContext('2d'), redData${status.index});
										        createBlueChart(document.getElementById('blueChart${status.index}').getContext('2d'), blueData${status.index});
										    </script>
										</div>
				                    </div>
				                </c:forEach>
				            </div>
						</div>
					</div>
				</div>
			</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="js/summoner_chart.js"></script>
	<script src="js/summoner_chart2.js"></script>
	<script src="js/damageChart.js"></script>
	<script src="js/damageChart2.js"></script>
	<script src="/js/chartFunctions.js"></script>
	<script src="/js/summonerInfo.js"></script>
</body>
</html>