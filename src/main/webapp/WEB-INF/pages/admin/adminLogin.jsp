<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
body {
	display: flex;
	align-items: center;
	justify-content: center;
}

.wrapper {
	width: 100%;
	max-width: 420px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.top-header {
	width: 100%;
	background: linear-gradient(180deg, #fce4de 0%, #fdf0ec 100%);
	border-radius: 20px 20px 0 0;
	padding: 36px 40px 28px;
	text-align: center;
}

.brand-icon {
	width: 56px;
	height: 56px;
	background: linear-gradient(135deg, #c0392b, #a93226);
	border-radius: 14px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	margin: 0 auto 16px;
	box-shadow: 0 4px 16px rgba(192, 57, 43, 0.3);
}

.brand-title {
	font-size: 18px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 4px;
}

.brand-subtitle {
	font-size: 13px;
	color: #a07060;
	font-weight: 400;
}

.form-card {
	width: 100%;
	background: #ffffff;
	padding: 36px 40px;
}

.error-box {
	background: #fff0f0;
	border: 1px solid #f5c6c6;
	color: #c0392b;
	border-radius: 10px;
	padding: 11px 16px;
	font-size: 13px;
	margin-bottom: 20px;
	text-align: center;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 1.2px;
	text-transform: uppercase;
	color: #2c1a10;
	margin-bottom: 8px;
}

.input-wrap {
	position: relative;
	display: flex;
	align-items: center;
}

.input-icon {
	position: absolute;
	left: 14px;
	font-size: 15px;
	color: #c0392b;
	opacity: 0.6;
}

.form-group input {
	width: 100%;
	padding: 13px 16px 13px 40px;
	border: none;
	border-radius: 10px;
	background: #fdf0ec;
	font-size: 14px;
	color: #2c1a10;
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

.btn-login {
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
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	margin-bottom: 20px;
}

.btn-login:hover {
	opacity: 0.92;
	transform: translateY(-1px);
}

.btn-login:active {
	transform: translateY(0);
}

.forgot {
	text-align: center;
	font-size: 13px;
	color: #c0392b;
	font-weight: 500;
	display: block;
	transition: opacity 0.2s;
}



.security-footer {
	width: 100%;
	background: linear-gradient(180deg, #e8f5f2 0%, #d4ede8 100%);
	border-radius: 0 0 20px 20px;
	padding: 20px 40px 24px;
	text-align: center;
}

.security-text {
	font-size: 13px;
	color: #5a7a74;
	line-height: 1.6;
	margin-bottom: 12px;
}

.security-badges {
	display: flex;
	justify-content: center;
	gap: 24px;
}

.security-badge {
	font-size: 12px;
	font-weight: 600;
	color: #5a7a74;
	display: flex;
	align-items: center;
	gap: 5px;
	letter-spacing: 0.5px;
}

.security-badge span {
	font-size: 13px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="top-header">
			<div class="brand-icon">&#127859;</div>
			<div class="brand-title">DineEase Admin</div>
			<div class="brand-subtitle">Editorial Hospitality Management
				Console</div>
		</div>
		<div class="form-card">

			<%
			String errorMessage = (String) request.getAttribute("errorMessage");
			if (errorMessage != null && !errorMessage.isEmpty()) {
			%>
			<div class="error-box"><%=errorMessage%></div>
			<%
			}
			%>
			<form action="${pageContext.request.contextPath}/admin-login"
				method="post">
				<div class="form-group">
					<label for="email">Admin Email</label>
					<div class="input-wrap">
						<span class="input-icon">&#64;</span> <input type="email"
							id="email" name="email" placeholder="name@dineease.com" required />
					</div>
				</div>
				<div class="form-group">
					<label for="password">Secret Key</label>
					<div class="input-wrap">
						<span class="input-icon">&#128273;</span> <input type="password"
							id="password" name="password" placeholder="••••••••••••" required />
					</div>
				</div>
				<button type="submit" class="btn-login">Secure Login
					&#128274;</button>

			</form>
			<p class="forgot">Please contact higher authorities if forgot your password</p>

		</div>
		<div class="security-footer">
			<p class="security-text">
				Access restricted to authorized personnel only.<br> All
				activity is monitored and logged.
			</p>
	
		</div>

	</div>
</body>
</html>