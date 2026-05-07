<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password – DineEase</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/styles.css" />
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
	padding: 36px 32px;
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
	margin-bottom: 8px;
	line-height: 1.6;
}

/* ── Email display badge ── */
.email-badge {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	background: #fdf0ec;
	border-radius: 50px;
	padding: 8px 16px;
	font-size: 13px;
	font-weight: 600;
	color: #c0392b;
	margin: 0 auto 24px;
	width: fit-content;
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

.toggle-pw {
	position: absolute;
	right: 14px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 14px;
	color: #aaa;
	cursor: pointer;
	background: none;
	border: none;
	padding: 0;
}

.toggle-pw:hover {
	color: #c0392b;
}

.form-group input {
	width: 100%;
	padding: 13px 40px 13px 40px;
	border: none;
	border-radius: 10px;
	background: #fdf0ec;
	font-size: 14px;
	color: #2c1a10;
	outline: none;
	transition: background 0.2s, box-shadow 0.2s;
	box-sizing: border-box;
}

.form-group input::placeholder {
	color: #c9a89e;
}

.form-group input:focus {
	background: #fce4dc;
	box-shadow: 0 0 0 2px rgba(192, 57, 43, 0.2);
}

/* ── Password strength bar ── */
.strength-bar {
	height: 4px;
	border-radius: 2px;
	background: #f0e8e4;
	margin-top: 8px;
	overflow: hidden;
}

.strength-fill {
	height: 100%;
	border-radius: 2px;
	width: 0%;
	transition: width 0.3s, background 0.3s;
}

.strength-label {
	font-size: 11px;
	color: #aaa;
	margin-top: 4px;
}

/* ── Match indicator ── */
.match-indicator {
	font-size: 11px;
	margin-top: 6px;
	font-weight: 600;
}

.match-ok {
	color: #27ae60;
}

.match-err {
	color: #c0392b;
}

/* ── Password hint ── */
.hint {
	font-size: 11px;
	color: #bbb;
	margin-top: 6px;
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
	margin-top: 8px;
}

.btn-submit:hover {
	opacity: 0.92;
	transform: translateY(-1px);
}

.btn-submit:disabled {
	background: #e0e0e0;
	color: #bbb;
	cursor: not-allowed;
	transform: none;
}

/* ── Back link ── */
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

/* ── Steps indicator ── */
.steps {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	margin-bottom: 20px;
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

.step.done {
	color: #27ae60;
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

.step.done .step-num {
	background: #27ae60;
	color: #fff;
}

.step-divider {
	width: 32px;
	height: 2px;
	background: #27ae60;
	border-radius: 2px;
}
</style>
</head>
<body>
	<%
	request.setAttribute("activePage", "");
	%>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />

	<%
	String resetEmail = (String) request.getAttribute("resetEmail");
	String errorMessage = (String) request.getAttribute("errorMessage");
	%>

	<div class="page-body">
		<div class="card">

			<%-- Icon --%>
			<div class="card-icon">&#128273;</div>

			<%-- Heading --%>
			<h1>Reset Password</h1>
			<p class="subtitle">Create a new password for your account.</p>

			<%-- Show verified email --%>
			<div class="email-badge">
				&#9993;
				<%=resetEmail%>
			</div>

			<%-- Steps indicator — step 1 done, step 2 active --%>
			<div class="steps">
				<div class="step done">
					<div class="step-num">&#10003;</div>
					Verified
				</div>
				<div class="step-divider"></div>
				<div class="step active">
					<div class="step-num">2</div>
					New Password
				</div>
			</div>

			<%-- Error message --%>
			<%
			if (errorMessage != null && !errorMessage.isEmpty()) {
			%>
			<div class="error-box"><%=errorMessage%></div>
			<%
			}
			%>

			<%-- Password reset form --%>
			<form action="${pageContext.request.contextPath}/resetPassword"
				method="post" id="resetForm">

				<%-- New password field with toggle visibility --%>
				<div class="form-group">
					<label for="new_password">New Password</label>
					<div class="input-wrap">
						<span class="input-icon">&#128274;</span> <input type="password"
							id="new_password" name="new_password" placeholder="••••••••"
							oninput="checkStrength(this.value)" required />
						<button type="button" class="toggle-pw"
							onclick="toggleVisibility('new_password', this)">
							&#128065;</button>
					</div>
					<%-- Password strength bar --%>
					<div class="strength-bar">
						<div class="strength-fill" id="strengthFill"></div>
					</div>
					<div class="strength-label" id="strengthLabel"></div>
					<p class="hint">Min. 6 characters.</p>
				</div>

				<%-- Confirm password field --%>
				<div class="form-group">
					<label for="confirm_password">Confirm Password</label>
					<div class="input-wrap">
						<span class="input-icon">&#128274;</span> <input type="password"
							id="confirm_password" name="confirm_password"
							placeholder="••••••••" oninput="checkMatch()" required />
						<button type="button" class="toggle-pw"
							onclick="toggleVisibility('confirm_password', this)">
							&#128065;</button>
					</div>
					<div class="match-indicator" id="matchIndicator"></div>
				</div>

				<%-- Submit button --%>
				<button type="submit" class="btn-submit" id="submitBtn" disabled>
					&#128274; Reset Password</button>

			</form>

			<%-- Back link --%>
			<p class="back-link">
				<a href="${pageContext.request.contextPath}/forgotPassword">
					&#8592; Back </a>
			</p>

		</div>
	</div>

	<jsp:include page="/WEB-INF/components/footer.jsp" />

	<script>
		// ── Toggle password visibility ──
		function toggleVisibility(inputId, btn) {
			const input = document.getElementById(inputId);
			if (input.type === 'password') {
				input.type = 'text';
				btn.textContent = '🙈';
			} else {
				input.type = 'password';
				btn.textContent = '👁';
			}
		}

		// ── Password strength checker ──
		function checkStrength(password) {
			const fill = document.getElementById('strengthFill');
			const label = document.getElementById('strengthLabel');

			let strength = 0;
			if (password.length >= 6)
				strength++;
			if (password.length >= 10)
				strength++;
			if (/[A-Z]/.test(password))
				strength++;
			if (/[0-9]/.test(password))
				strength++;
			if (/[^A-Za-z0-9]/.test(password))
				strength++;

			const levels = [ {
				width : '0%',
				color : '#e0e0e0',
				label : ''
			}, {
				width : '25%',
				color : '#c0392b',
				label : 'Weak'
			}, {
				width : '50%',
				color : '#e67e22',
				label : 'Fair'
			}, {
				width : '75%',
				color : '#f39c12',
				label : 'Good'
			}, {
				width : '100%',
				color : '#27ae60',
				label : 'Strong'
			} ];

			const level = levels[Math.min(strength, 4)];
			fill.style.width = level.width;
			fill.style.background = level.color;
			label.textContent = level.label;
			label.style.color = level.color;

			// Re-check match after strength update
			checkMatch();
		}

		// ── Password match checker ──
		function checkMatch() {
			const pw1 = document.getElementById('new_password').value;
			const pw2 = document.getElementById('confirm_password').value;
			const indicator = document.getElementById('matchIndicator');
			const submitBtn = document.getElementById('submitBtn');

			if (pw2.length === 0) {
				indicator.textContent = '';
				submitBtn.disabled = true;
				return;
			}

			if (pw1 === pw2 && pw1.length >= 6) {
				indicator.textContent = '✓ Passwords match';
				indicator.className = 'match-indicator match-ok';
				submitBtn.disabled = false;
			} else if (pw1 !== pw2) {
				indicator.textContent = '✗ Passwords do not match';
				indicator.className = 'match-indicator match-err';
				submitBtn.disabled = true;
			} else {
				indicator.textContent = '✗ Minimum 6 characters required';
				indicator.className = 'match-indicator match-err';
				submitBtn.disabled = true;
			}
		}
	</script>

</body>
</html>