<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<meta charset="UTF-8">
<title>Payment Success</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
.page-body {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 24px;
}

.success-card {
	background: #fff;
	border-radius: 24px;
	padding: 56px 48px;
	max-width: 460px;
	width: 100%;
	text-align: center;
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.1);
}

.success-icon {
	width: 80px;
	height: 80px;
	background: linear-gradient(135deg, #27ae60, #2ecc71);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 36px;
	margin: 0 auto 24px;
	animation: popIn 0.4s ease;
}

@
keyframes popIn { 0% {
	transform: scale(0);
	opacity: 0;
}

70






%
{
transform






:






scale




(






1




.1






)




;
}
100






%
{
transform






:






scale




(






1






)




;
opacity






:






1




;
}
}
.success-title {
	font-size: 26px;
	font-weight: 800;
	color: #2c1a10;
	margin-bottom: 8px;
	letter-spacing: -0.5px;
}

.success-subtitle {
	font-size: 14px;
	color: #aaa;
	line-height: 1.6;
	margin-bottom: 32px;
}

.details-box {
	background: #fdf6f2;
	border-radius: 14px;
	padding: 20px 24px;
	margin-bottom: 32px;
	text-align: left;
}

.detail-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 8px 0;
	border-bottom: 1px solid #f0e8e4;
	font-size: 13px;
}

.detail-row:last-child {
	border-bottom: none;
}

.detail-label {
	color: #aaa;
}

.detail-value {
	font-weight: 600;
	color: #2c1a10;
}

.btn-home {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	padding: 14px 36px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	text-decoration: none;
	transition: opacity 0.2s, transform 0.1s;
}

.btn-home:hover {
	opacity: 0.92;
	transform: translateY(-1px);
}
</style>
</head>
<body>
	<%
	request.setAttribute("activePage", "");
	%>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />
	<%
	String paymentType = (String) request.getAttribute("paymentType");
	String referenceId = (String) request.getAttribute("referenceId");
	String amount = (String) request.getAttribute("amount");
	String typeLabel = "booking".equals(paymentType) ? "Table Reservation" : "Food Delivery Order";
	%>
	<div class="page-body">
		<div class="success-card">


			<div class="success-icon">&#10003;</div>

			<div class="success-title">Payment Successful!</div>
			<div class="success-subtitle">
				Your
				<%=typeLabel.toLowerCase()%>
				has been confirmed.<br> Thank you for choosing DineEase.
			</div>


			<div class="details-box">
				<div class="detail-row">
					<span class="detail-label">Type</span> <span class="detail-value"><%=typeLabel%></span>
				</div>
				<div class="detail-row">
					<span class="detail-label">Reference #</span> <span
						class="detail-value"><%=referenceId%></span>
				</div>
				<div class="detail-row">
					<span class="detail-label">Amount Paid</span> <span
						class="detail-value" style="color: #c0392b;"> Rs. <%=amount != null && !amount.isEmpty() && !"null".equals(amount)
		? String.format("%.0f", Double.parseDouble(amount))
		: "—"%>
					</span>
				</div>
				<div class="detail-row">
					<span class="detail-label">Status</span> <span class="detail-value"
						style="color: #27ae60;">&#10003; Confirmed</span>
				</div>
			</div>

			<a href="${pageContext.request.contextPath}/index" class="btn-home">
				&#127968; Back to Home </a>

		</div>
	</div>

	<jsp:include page="/WEB-INF/components/footer.jsp" />
</body>
</html>