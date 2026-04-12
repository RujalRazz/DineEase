<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/styles.css">
</head>
<style>
.page-body {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 16px;
}

.card {
	background: #fff;
	border-radius: 20px;
	padding: 48px 44px;
	width: 100%;
	max-width: 560px;
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.08);
}

.card h1 {
	font-size: 28px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 8px;
	letter-spacing: -0.5px;
}

.card .subtitle {
	font-size: 14px;
	color: #999;
	margin-bottom: 32px;
}

.error-box {
	background: #fff0f0;
	border: 1px solid #f5c6c6;
	color: #c0392b;
	border-radius: 10px;
	padding: 11px 16px;
	font-size: 13px;
	margin-bottom: 20px;
}

row {
	display: flex;
	gap: 16px;
}

.row .form-group {
	flex: 1;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-size: 11px;
	font-weight: 700;
	color: #2c1a10;
	letter-spacing: 0.8px;
	text-transform: uppercase;
	margin-bottom: 8px;
}

.input-wrap {
	position: relative;
}

.input-wrap .icon {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 15px;
	color: #c0392b;
	opacity: 0.6;
}

.input-wrap input {
	padding-left: 38px;
}

.form-group input {
	width: 100%;
	padding: 13px 16px;
	border: none;
	border-radius: 10px;
	font-size: 14px;
	color: #2c1a10;
	background: #fdf0ec;
	outline: none;
	transition: background 0.2s, box-shadow 0.2s;
}

.form-group input::placeholder {
	color: #c9a89e;
}

.form-group input:focus {
	background: #fce4dc;
	box-shadow: 0 0 0 2px rgba(192, 57, 43, 0.2);
}

.hint {
	font-size: 11px;
	color: #aaa;
	margin-top: 6px;
}

.btn {
	width: 100%;
	padding: 15px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: opacity 0.2s, transform 0.1s;
	margin-top: 8px;
}

.btn:hover {
	opacity: 0.92;
	transform: translateY(-1px);
}
</style>
<body>
<% request.setAttribute("activePage", "register"); %>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />
	<div class="page-body">
    <div class="card">

        <h1>Create your account</h1>
        <p class="subtitle">Join the curated world of DineEase. Experience hospitality beyond dining.</p>

       
        <% String errorMessage = (String) request.getAttribute("errorMessage");
           if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="error-box"><%= errorMessage %></div>
        <% } %>

        
        <form action="register" method="post">

            
            <div class="row">
                <div class="form-group">
                    <label for="first_name">First Name</label>
                    <input type="text" id="first_name" name="first_name" placeholder="E.g. Julian" required />
                </div>
                <div class="form-group">
                    <label for="last_name">Last Name</label>
                    <input type="text" id="last_name" name="last_name" placeholder="E.g. Mercier" required />
                </div>
            </div>

            
            <div class="form-group">
                <label for="address">Residential Address</label>
                <div class="input-wrap">
                    <input type="text" id="address" name="address" placeholder="Street, City, Postcode" required />
                </div>
            </div>

            
            <div class="row">
                <div class="form-group">
                    <label for="phone_number">Phone Number</label>
                    <input type="tel" id="phone_number" name="phone_number" placeholder="+977 98XXXXXXXX" required />
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="name@editorial.com" required />
                </div>
            </div>

            
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrap">
                    <input type="password" id="password" name="password" placeholder="••••••••" required />
                </div>
                <p class="hint">Min. 6 characters.</p>
            </div>

         
            <button type="submit" class="btn">Register Account</button>

        </form>

        
        <p class="footer-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Log in here</a>
        </p>

    </div>
</div>
	<jsp:include page="/WEB-INF/components/footer.jsp"/>
	

</body>
</html>