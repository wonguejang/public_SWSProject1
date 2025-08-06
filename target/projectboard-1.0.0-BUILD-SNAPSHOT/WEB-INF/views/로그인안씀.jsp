<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding = "UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<form action = "list" method = "post">
		<input type = "text" name = "id"/><br/>
		<input type = "submit" value = "그냥게시판"/>
	</form>
	<form action = "list2" method = "post">
		<input type = "text" name = "id"/><br/>
		<input type = "submit" value = "자유게시판"/>
	</form>
	<form action = "mainHome" method = "post">
		<input type = "text" name = "id"/><br/>
		<input type = "submit" value = "메인홈"/>
	</form>
</body>
</html>
