<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/styles.css">


<style type="text/css">
.page-body {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 24px;
}

.login-container {
	display: flex;
	width: 100%;
	max-width: 960px;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
	min-height: 520px;
}

.image-panel {
	flex: 1;
	background: linear-gradient(180deg, rgba(0, 0, 0, 0.1) 0%,
		rgba(0, 0, 0, 0.6) 100%),
		url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80')
		center/cover no-repeat;
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	padding: 36px 32px;
	min-height: 400px;
}

.image-label {
	font-size: 10px;
	font-weight: 700;
	letter-spacing: 2px;
	color: rgba(255, 255, 255, 0.7);
	text-transform: uppercase;
	margin-bottom: 10px;
}

.image-panel h2 {
	font-size: 28px;
	font-weight: 800;
	color: #fff;
	line-height: 1.25;
	margin-bottom: 12px;
	letter-spacing: -0.5px;
}

.image-panel p {
	font-size: 13px;
	color: rgba(255, 255, 255, 0.75);
	line-height: 1.6;
	max-width: 260px;
}

.form-panel {
	flex: 1;
	background: #fff;
	padding: 48px 44px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.form-panel h1 {
	font-size: 26px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 6px;
	letter-spacing: -0.5px;
}

.form-panel .subtitle {
	font-size: 13px;
	color: #aaa;
	margin-bottom: 28px;
}

.error-box {
	background: #fff0f0;
	border: 1px solid #f5c6c6;
	color: #c0392b;
	border-radius: 10px;
	padding: 11px 16px;
	font-size: 13px;
	margin-bottom: 18px;
}

.success-box {
	background: #f0fff4;
	border: 1px solid #b7ebc8;
	color: #276749;
	border-radius: 10px;
	padding: 11px 16px;
	font-size: 13px;
	margin-bottom: 18px;
}

.form-group {
	margin-bottom: 18px;
}

.form-group .label-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 8px;
}

.form-group label {
	font-size: 11px;
	font-weight: 700;
	color: #2c1a10;
	letter-spacing: 0.8px;
	text-transform: uppercase;
}

.forgot-link {
	font-size: 12px;
	color: #c0392b;
	text-decoration: none;
	font-weight: 500;
}

.input-wrap {
	position: relative;
}

.input-wrap .icon {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 14px;
	color: #c0392b;
	opacity: 0.55;
}

.input-wrap input {
	padding-left: 38px;
}

.form-group input[type="email"], .form-group input[type="password"] {
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

.checkbox-row {
	display: flex;
	align-items: center;
	gap: 8px;
	margin-bottom: 22px;
}

.checkbox-row input[type="checkbox"] {
	width: 15px;
	height: 15px;
	accent-color: #c0392b;
	cursor: pointer;
}

.checkbox-row label {
	font-size: 13px;
	color: #666;
	cursor: pointer;
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
}

.btn:hover {
	opacity: 0.92;
	transform: translateY(-1px);
}

.register-link {
	text-align: center;
	margin-top: 18px;
	font-size: 14px;
	color: #888;
}

.register-link a {
	color: #c0392b;
	font-weight: 700;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
	request.setAttribute("activePage", "login");
	%>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />
	<div class="page-body">
		<div class="login-container">

			<%-- Left: food image panel --%>
			<div class="image-panel">
				<p class="image-label">Editorial Hospitality</p>
				<h2>The art of fine dining, curated for you.</h2>
				<p>Experience the world's most exclusive menus with the guidance
					of our digital sommelier.</p>
			</div>

			<%-- Right: login form panel --%>
			<div class="form-panel">
				<h1>Welcome Back</h1>
				<p class="subtitle">Please enter your credentials to access our features.</p>

				<%-- Display success message when redirected from RegisterServlet --%>
				<%
				String successMessage = request.getParameter("message");
				if (successMessage != null && !successMessage.isEmpty()) {
				%>
				<div class="success-box"><%=successMessage%></div>
				<%
				}
				%>

				<%-- Display error message from LoginServlet if login fails --%>
				<%
				String errorMessage = (String) request.getAttribute("errorMessage");
				if (errorMessage != null && !errorMessage.isEmpty()) {
				%>
				<div class="error-box"><%=errorMessage%></div>
				<%
				}
				%>

				<%-- Login form — action uses contextPath to correctly resolve LoginServlet --%>
				<form action="${pageContext.request.contextPath}/login"
					method="post">

					<%-- Email field with icon --%>
					<div class="form-group">
						<label for="email">Email Address</label>
						<div class="input-wrap">
							<input type="email" id="email" name="email"
								placeholder="name@example.com" required />
						</div>
					</div>

					<%-- Password field with forgot password link --%>
					<div class="form-group">
						<div class="label-row">
							<label for="password">Password</label> <a href="#"
								class="forgot-link">Forgot password?</a>
						</div>
						<div class="input-wrap">
							<input type="password" id="password" name="password"
								placeholder="••••••••" required />
						</div>
					</div>

					<%-- Keep me signed in checkbox --%>
					<div class="checkbox-row">
						<input type="checkbox" id="remember" name="remember" /> <label
							for="remember">Keep me signed in</label>
					</div>

					<%-- Submit button --%>
					<button type="submit" class="btn">Login</button>

				</form>

				<%-- Link to register page --%>
				<p class="register-link">
					Don't have an account? <a
						href="${pageContext.request.contextPath}/register">Register</a>
				</p>

			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/components/footer.jsp" />
</body>
</html>