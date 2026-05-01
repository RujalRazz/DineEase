<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background: #fdf6f2;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.page-body {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 24px;
}

.payment-card {
	background: #fff;
	border-radius: 20px;
	width: 100%;
	max-width: 460px;
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.card-header {
	background: linear-gradient(135deg, #2c1a10, #c0392b);
	padding: 28px 32px;
	color: #fff;
}

.card-header-label {
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 1.5px;
	text-transform: uppercase;
	color: rgba(255, 255, 255, 0.6);
	margin-bottom: 6px;
}

.card-header-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 4px;
}

.card-header-ref {
	font-size: 12px;
	color: rgba(255, 255, 255, 0.6);
}

.amount-display {
	background: #fdf6f2;
	padding: 20px 32px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #f0e8e4;
}

.amount-label {
	font-size: 13px;
	color: #aaa;
	font-weight: 500;
}

.amount-value {
	font-size: 24px;
	font-weight: 800;
	color: #c0392b;
}

.card-body {
	padding: 28px 32px;
}

.dummy-card {
	background: linear-gradient(135deg, #2c1a10, #5a3a2a);
	border-radius: 14px;
	padding: 20px 24px;
	margin-bottom: 24px;
	color: #fff;
	position: relative;
	overflow: hidden;
}

.dummy-card::before {
	content: '◉';
	position: absolute;
	right: 20px;
	top: 16px;
	font-size: 32px;
	opacity: 0.3;
}

.dummy-card-label {
	font-size: 10px;
	letter-spacing: 1px;
	text-transform: uppercase;
	color: rgba(255, 255, 255, 0.5);
	margin-bottom: 12px;
}

.dummy-card-number {
	font-size: 18px;
	letter-spacing: 4px;
	font-weight: 600;
	margin-bottom: 16px;
	font-family: monospace;
}

.dummy-card-brand {
	font-size: 12px;
	color: rgba(255, 255, 255, 0.5);
	text-align: right;
}

.form-group {
	margin-bottom: 18px;
}

.form-group label {
	display: block;
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 0.8px;
	text-transform: uppercase;
	color: #2c1a10;
	margin-bottom: 7px;
}

.form-group input {
	width: 100%;
	padding: 12px 14px;
	border: 1.5px solid #e8e0dc;
	border-radius: 10px;
	font-size: 14px;
	color: #2c1a10;
	background: #fafafa;
	outline: none;
	font-family: monospace;
	letter-spacing: 2px;
	transition: border-color 0.2s;
}

.form-group input:focus {
	border-color: #c0392b;
	background: #fff;
}

.btn-pay {
	width: 100%;
	padding: 15px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 16px;
	font-weight: 700;
	cursor: pointer;
	transition: opacity 0.2s, transform 0.1s;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	margin-top: 8px;
}

.btn-pay:hover {
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
    <div class="payment-card">


        <div class="card-header">
            <div class="card-header-label">Secure Payment</div>
            <div class="card-header-title"><%= typeLabel %></div>
            <div class="card-header-ref">
                Reference #<%= referenceId != null ? referenceId : "—" %>
            </div>
        </div>


        <div class="amount-display">
            <span class="amount-label">Amount Due</span>
            <span class="amount-value">
                Rs. <%= amount != null && !amount.isEmpty() ?
                    String.format("%.0f", Double.parseDouble(amount)) : "—" %>
            </span>
        </div>

    
        <div class="card-body">

            
            <div class="dummy-card">
                <div class="dummy-card-label">Payment Card</div>
                <div class="dummy-card-number" id="card-display">
                    •••• •••• •••• ••••
                </div>
                <div class="dummy-card-brand">DineEase Pay</div>
            </div>

        
            <form action="${pageContext.request.contextPath}/payment" method="post">
                <input type="hidden" name="payment_type" value="<%= paymentType %>"/>
                <input type="hidden" name="reference_id" value="<%= referenceId %>"/>
                <input type="hidden" name="amount" value="<%= amount %>"/>

             
                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" name="card_number"
                           placeholder="0000  0000  0000  0000"
                           maxlength="19"
                           oninput="formatCardNumber(this)"
                           autocomplete="off"/>
                </div>


                <div class="form-group">
                    <label>CVV</label>
                    <input type="password" name="cvv"
                           placeholder="•••"
                           maxlength="3"
                           autocomplete="off"/>
                </div>

            
                <button type="submit" class="btn-pay">
                    &#128274; Pay Now
                </button>

            </form>


    

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/components/footer.jsp"/>

<script>

    function formatCardNumber(input) {
        let value = input.value.replace(/\D/g, '');
        value = value.replace(/(.{4})/g, '$1  ').trim();
        input.value = value;


        const display = value || '•••• •••• •••• ••••';
        document.getElementById('card-display').textContent =
            value.length > 0 ? value : '•••• •••• •••• ••••';
    }
</script>

</body>
</html>