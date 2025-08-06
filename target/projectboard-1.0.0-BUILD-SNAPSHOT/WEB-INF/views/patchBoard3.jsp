<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>패치노트 게시글 작성</title>
	<!-- CSS -->
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
	<!-- JS -->
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
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
		}	 
		ul li {
			list-style : none;
		}
		a {
			text-decoration : none;
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
		.header_inner > div:nth-child(1) > a{	/* 상단 왼쪽 메뉴 항목 */
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
			width : 130px;
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
		.header_inner > div:nth-child(2) > a:first-child {
			color : white;
		    display: flex;
		    align-items: center;
		    justify-content: center;
	 	    width: 90px;
		    height: 40px;
		    border-radius: 8px;
		    margin-top : 0px;
		}
		
		.header_inner > div:nth-child(2) > a:first-child:hover{
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
		.search_bar >.search_bar_inner > div:nth-child(1) {
			position : relative;
			top : -70px;
		    width: 500px;
		    height: 55px;
		    background-color: white;
		    border-radius : 8px;
		}
		.search_bar > .search_bar_inner > div:nth-child(1) > input {
			border : none;
			outline : none;
			width : 100%;
			height : 100%;
			padding-left: 30px;
			font-size : 23px;
			border-radius : 8px;
			color : rgb(53,57,69);
		}
		.search_bar > .search_bar_inner > div:nth-child(1) > svg {
			position: absolute;
		    margin-left: -55px;
		    margin-top: 4px;
		    width: 50px;
		    height: 50px;
		    color: rgb(50, 84, 206);
		}
		.post {
		    display: flex;
		    position: relative;
		    justify-content : center;
		    top: 300px;
			height : 953px;
		}
		.post_create {
			width : 1470px;
			background-color : rgb(16 19 28);
			border : 1px solid #e5e7eb;
			border-radius : 20px;
			margin-top : 20px;
		}
		.post_create > h1 {
		    position: absolute;
    		left: 300px;
			color : rgb(229, 231, 235);
		}	
		.post_create > hr {
			margin-top : 100px;
			margin-right : 20px;
			margin-left : 20px;
		}
		.content {
			padding : 20px;
			
		}
		.toastui-editor-defaultUI,
		.toastui-editor-defaultUI * {
			background-color: rgb(34, 47, 62) !important;
		    color: rgb(255, 255, 255) !important;
		    border-color: rgb(80, 80, 80) !important;
		}
		
		.toastui-editor-toolbar {
		    background-color: rgb(45, 45, 45) !important;
		    color : rgb(156 163 175) !important;
		}
		
		.toastui-editor-contents pre {
		    background-color: rgb(40, 40, 40) !important;
		    color : rgb(156 163 175) !important;
		}
		.head_input {
			padding-left : 30px;
		}
		.head_input > input {
			width: 900px;
		    height: 40px;
		    font-size: 25px;
		    padding-left: 20px;
		    background-color: rgb(16 19 28);
		    color: rgb(218 223 231);
		    border: 1px solid;
		    border-radius: 10px;
		}
		.post_create > div:last-child {
			display: flex;
		    justify-content: center;
		    align-items: center;
		    padding-top	: 10px;
		}
		.post_commit {
			background-color : rgb(33 58 150);
			padding-left : 20px;
			padding-right : 20px;
			border-radius : 8px;
			color : rgb(218 223 231);
			font-weight : 700;
			font-size : 35px;
			line-height : 24px;
			height : 70px;
		}
		.post_category {
		    height: 285px;
		}
		.post_category > div:nth-child(1) {
			display : flex;
		}
		.post_category > div:nth-child(1) > div {
			display : flex;
			padding-left : 20px;
			gap : 8px;
		}
		.champs, .items, .runes, .spells {
			background-color : rgb(50 84 206);
			color : rgb(255 255 255);
	        border-color : rgb(50 84 206);
	        border-radius : 8px;
	        font-weight : 700;
	        font-size : 28px;
	        line-height : 24px;
	        padding-top : 4px;
	        padding-bottom : 4px;
	        padding-left : 8px;
	        padding-right : 8px;
		}
		.champs:hover, .items:hover, .runes:hover, .spells:hover {
			background-color : rgb(202 214 254);
		}
		.post_category > div:nth-child(1) > input {
		    position: relative;
		    left: 800px;
		    width: 300px;
		    color : rgb(50 84 206);
		    font-size : 16px;
		    line-height : 24px;
		    background-color : rgb(16 19 28);
		    padding-left : 16px;
		    padding-right : 16px;
		    padding-top : 4px;
		    padding-bottom : 4px;
		    border : 1px solid rgb(50 84 206);
		    border-radius : 4px;
		}
		.content_outer {
			display : grid;
			grid-template-columns: repeat(6, minmax(0, 1fr));
			overflow : auto;
			width : 1400px;
			height : 250px;
			border : 1px solid rgb(79, 87, 112);
			border-radius : 16px;
			padding : 16px;
			margin-left : 33px;
			gap : 8px;
			
		}
		.content_inner {
			display : flex;
			flex-direction : column;
			width : 100%;
			height : 55px;
			border-radius : 8px;
		}
		.content_inner > div {
			display: flex;
		    justify-content: center;
		    align-items: center;
		    gap : 5px;
		    height : 52px;
		}
		.content_inner > div > img{
			width : 40px;
		}
		.content_inner > div > p {
			color : rgb(218 223 231);
			font-weight : 500;
			font-size : 20px;
			line-height : 20px;
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
	               <c:when test = "${empty sessionScope.loginUser}">
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
	<div class = "main">
		<div class = "search_bar">
			<div class = "search_bar_inner">
				<div>
					<input type = "search" placeholder = "소환사명으로 검색"/>
					<svg fill="none" viewBox="0 0 24 24" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="20px" height="20px"><path fill="currentColor" d="M18.5746 20.5752L13.225 15.2496C12.6746 15.6168 12.083 15.896 11.4502 16.0872C10.8166 16.2792 10.1414 16.3752 9.42461 16.3752C7.5246 16.3752 5.9038 15.7128 4.5622 14.388C3.2206 13.0624 2.5498 11.4496 2.5498 9.5496C2.5498 7.6496 3.2206 6.0288 4.5622 4.6872C5.9038 3.3456 7.5246 2.6748 9.42461 2.6748C11.3414 2.6748 12.9582 3.3456 14.275 4.6872C15.5918 6.0288 16.2502 7.6496 16.2502 9.5496C16.2502 10.2664 16.1626 10.9372 15.9874 11.562C15.8122 12.1876 15.5246 12.7584 15.1246 13.2744L20.4994 18.6996C20.7666 18.9668 20.8958 19.2836 20.887 19.65C20.879 20.0164 20.7414 20.3248 20.4742 20.5752C20.2246 20.8416 19.9122 20.9748 19.537 20.9748C19.1618 20.9748 18.841 20.8416 18.5746 20.5752ZM9.42461 13.6248C10.5582 13.6248 11.5206 13.2292 12.3118 12.438C13.1038 11.646 13.4998 10.6832 13.4998 9.5496C13.4998 8.4 13.1082 7.4252 12.325 6.6252C11.5418 5.8252 10.575 5.4252 9.42461 5.4252C8.29181 5.4252 7.321 5.8252 6.5122 6.6252C5.7042 7.4252 5.3002 8.4 5.3002 9.5496C5.3002 10.7 5.7042 11.6668 6.5122 12.45C7.321 13.2332 8.29181 13.6248 9.42461 13.6248Z"></path></svg>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- 게시글 작성 작업 -->
	<div class = "post">
		<div class = "post_create">
			<h1>패치 게시판 게시물 작성</h1>
			<hr/>
			<form action="${pageContext.request.contextPath}/patch/patchwrite" method="post" onsubmit="return submitPost();">
			<div class = "head_input"> <!-- 셀렉트 하나 인풋 하나  -->
				<input type = "text" name="pTitle" placeholder = "제목을 입력해 주세요"/>
			</div>
			<div>	<!-- 본 게시글 작성 폼 -->
				<div class = "editor_area"></div>
			</div>
				<input type="hidden" name="pContent" id="hiddenContent" />
			<div>	<!-- 작성완료 버튼 -->
				<button class = "post_commit">작성 완료</button>
			</div>
			</form>
		</div>
	</div>
	
	
	<script>
        const editor = new toastui.Editor({
            el: document.querySelector('.editor_area'), // 에디터를 적용할 요소 (컨테이너)
            height: '700px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
            initialEditType: 'markdown',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
            previewStyle: 'none' ,               // 마크다운 프리뷰 스타일 (tab || vertical)
            initialValue: '내용을 입력해 주세요.',    // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
       	    toolbarItems: [
            	['heading', 'bold', 'italic', 'strike'],
                ['hr', 'quote'],
                ['ul', 'ol', 'task'],
                ['table', 'image', 'link'],
                ['code', 'codeblock']
            ],
          	 usageStatistics: false // 통계 수집 끄기 (옵션)
        });
    </script>
	    <script>
		function submitPost() {
			const content = editor.getMarkdown();
			document.getElementById("hiddenContent").value = content;
			return true;
		}
	</script>
    
</body>
</html>