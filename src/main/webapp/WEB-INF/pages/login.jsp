<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">


<style type="text/css">
ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background-color: #333333;
}

ul li {
	float: left;
}

ul li a {
	display: block;
	color: white;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

ul li a:hover {
	background-color: #111111;
}

form {
	margin-top: 50px;
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}

label {
	display: block;
}

input[type=text], select {
	width: 100%;
	padding: 12px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input[type=submit] {
	width: 100%;
	background-color: #4CAF50;
	color: white;
	padding: 14px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
	<ul>
		<li><a href="/default.jsp">Home</a></li>
		<li><a href="/news.jsp">News</a></li>
		<li><a href="/contact.jsp">Contact</a></li>
		<li><a href="/about.jsp">About</a></li>
	</ul>
	<form action="POST" method="POST">
		<label for="fname">First Name</label> <input type="text" id="fname"
			name="firstname" placeholder="Your name.."> <label
			for="lname">Last Name</label> <input type="text" id="lname"
			name="lastname" placeholder="Your last name.."> <label
			for="country">Country</label> <select id="country" name="country">
			<option value="australia">Australia</option>
			<option value="canada">Canada</option>
			<option value="usa">USA</option>
		</select> <input type="submit" value="Submit">
	</form>
</body>
</html>