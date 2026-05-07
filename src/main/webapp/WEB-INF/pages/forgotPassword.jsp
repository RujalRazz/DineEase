<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password – DineEase</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
.page-body {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 16px;
}

/* ── Card ── */
.card {
	background: #fff;
	border-radius: 20px;
	padding: 48px 44px;
	width: 100%;
	max-width: 440px;
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.08);
}

/* ── Icon ── */
.card-icon {
	width: 60px;
	height: 60px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	border-radius: 16px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 26px;
	margin: 0 auto 20px;
}

/* ── Heading ── */
.card h1 {
	font-size: 22px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 8px;
	text-align: center;
}

.card .subtitle {
	font-size: 13px;
	color: #aaa;
	text-align: center;
	margin-bottom: 28px;
	line-height: 1.6;
}

/* ── Error box ── */
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

/* ── Form ── */
.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 0.8px;
	text-transform: uppercase;
	color: #2c1a10;
	margin-bottom: 8px;
}

.input-wrap {
	position: relative;
}

.input-icon {
	position: absolute;
	left: 14px;
	top: 50%;
	transform: translateY(-50%);
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

/* ── Submit button ── */
.btn-submit {
	width: 100%;
	padding: 14px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: opacity 0.2s, transform 0.1s;
	margin-bottom: 20px;
}

.btn-submit:hover {
	opacity: 0.92;
	transform: translateY(-1px);
}

/* ── Back to login ── */
.back-link {
	text-align: center;
	font-size: 13px;
	color: #aaa;
}

.back-link a {
	color: #c0392b;
	font-weight: 600;
	text-decoration: none;
}

.back-link a:hover {
	text-decoration: underline;
}

/* ── Steps indicator ── */
.steps {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	margin-bottom: 28px;
}

.step {
	display: flex;
	align-items: center;
	gap: 6px;
	font-size: 12px;
	font-weight: 600;
	color: #ddd;
}

.step.active {
	color: #c0392b;
}

.step-num {
	width: 24px;
	height: 24px;
	border-radius: 50%;
	background: #f0e8e4;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 11px;
	font-weight: 700;
	color: #bbb;
}

.step.active .step-num {
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
}

.step-divider {
	width: 32px;
	height: 2px;
	background: #f0e8e4;
	border-radius: 2px;
}
</style>
</head>
<body>
	<%
	request.setAttribute("activePage", "");
	%>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />
	<div class="page-body">
		<div class="card">

			<%-- Icon --%>
			<div class="card-icon">&#128274;</div>

			<%-- Heading --%>
			<h1>Forgot Password?</h1>
			<p class="subtitle">Enter the email address associated with your
				account and we will verify it for you.</p>

			<%-- Steps indicator --%>
			<div class="steps">
				<div class="step active">
					<div class="step-num">1</div>
					Verify Email
				</div>
				<div class="step-divider"></div>
				<div class="step">
					<div class="step-num">2</div>
					Reset Password
				</div>
			</div>

			<%-- Error message from controller --%>
			<%
			String errorMessage = (String) request.getAttribute("errorMessage");
			if (errorMessage != null && !errorMessage.isEmpty()) {
			%>
			<div class="error-box"><%=errorMessage%></div>
			<%
			}
			%>

			<%-- Email verification form --%>
			<form action="${pageContext.request.contextPath}/forgotPassword"
				method="post">

				<div class="form-group">
					<label for="email">Email Address</label>
					<div class="input-wrap">
						<span class="input-icon">&#9993;</span> <input type="email"
							id="email" name="email" placeholder="name@example.com" required />
					</div>
				</div>

				<button type="submit" class="btn-submit">Verify Email
					&#8594;</button>

			</form>

			<%-- Back to login --%>
			<p class="back-link">
				Remembered your password? <a
					href="${pageContext.request.contextPath}/login"> Sign in </a>
			</p>

		</div>
	</div>

	<jsp:include page="/WEB-INF/components/footer.jsp" />
</body>
</html>