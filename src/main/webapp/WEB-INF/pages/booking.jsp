<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.Restaurant"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Table</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
.page-wrapper {
	max-width: 680px;
	margin: 48px auto;
	padding: 0 24px 80px;
}

.restaurant-info {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
	margin-bottom: 24px;
	display: flex;
	align-items: center;
	gap: 16px;
}

.restaurant-img {
	width: 72px;
	height: 72px;
	border-radius: 12px;
	object-fit: cover;
	flex-shrink: 0;
}

.restaurant-name {
	font-size: 18px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 4px;
}

.restaurant-address {
	font-size: 13px;
	color: #999;
}

.restaurant-rating {
	font-size: 13px;
	color: #f39c12;
	font-weight: 600;
	margin-top: 4px;
}

.form-card {
	background: #fff;
	border-radius: 16px;
	padding: 32px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
}

.form-title {
	font-size: 20px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 6px;
}

.form-subtitle {
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
	margin-bottom: 20px;
}

.form-row {
	display: flex;
	gap: 16px;
}

.form-row .form-group {
	flex: 1;
}

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
	margin-bottom: 7px;
}

.form-group input, .form-group select, .form-group textarea {
	width: 100%;
	padding: 12px 14px;
	border: 1.5px solid #e8e0dc;
	border-radius: 10px;
	font-size: 14px;
	color: #2c1a10;
	background: #fafafa;
	outline: none;
	transition: border-color 0.2s;
	font-family: 'Segoe UI', sans-serif;
}

.form-group input:focus, .form-group select:focus, .form-group textarea:focus
	{
	border-color: #c0392b;
	background: #fff;
}

.form-group textarea {
	resize: vertical;
	min-height: 80px;
}

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
	transition: opacity 0.2s;
	margin-top: 8px;
}

.btn-submit:hover {
	opacity: 0.9;
}
</style>
</head>
<body>
	<%
	request.setAttribute("activePage", "restaurants");
	%>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />
	<%
	Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
	String errorMessage = (String) request.getAttribute("errorMessage");
	%>
	<div class="page-wrapper">


		<div class="restaurant-info">
			<img class="restaurant-img"
				src="<%=restaurant.getImageUrl() != null ? restaurant.getImageUrl()
		: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200&q=80"%>"
				alt="<%=restaurant.getName()%>">
			<div>
				<div class="restaurant-name"><%=restaurant.getName()%></div>
				<div class="restaurant-address">
					&#128205;
					<%=restaurant.getAddress()%></div>
				<div class="restaurant-rating">
					&#9733;
					<%=restaurant.getRating()%></div>
			</div>
		</div>


		<div class="form-card">
			<div class="form-title">Reserve a Table</div>
			<div class="form-subtitle">Fill in your details to confirm your
				reservation</div>


			<%
			if (errorMessage != null) {
			%>
			<div class="error-box"><%=errorMessage%></div>
			<%
			}
			%>


			<form action="${pageContext.request.contextPath}/booking"
				method="post">


				<input type="hidden" name="restaurant_id"
					value="<%=restaurant.getRestaurantId()%>" />


				<div class="form-row">
					<div class="form-group">
						<label>Booking Date</label> <input type="date" name="booking_date"
							required
							min="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>" />
					</div>
					<div class="form-group">
						<label>Booking Time</label> <input type="time" name="booking_time"
							required />
					</div>
				</div>


				<div class="form-group">
					<label>Number of Guests</label> <select name="guest_count" required>
						<option value="">Select guests</option>
						<option value="1">1 Person</option>
						<option value="2">2 People</option>
						<option value="3">3 People</option>
						<option value="4">4 People</option>
						<option value="5">5 People</option>
						<option value="6">6 People</option>
						<option value="7">7 People</option>
						<option value="8">8+ People</option>
					</select>
				</div>


				<div class="form-group">
					<label>Special Requests (optional)</label>
					<textarea name="special_request"
						placeholder="Allergies, seating preferences, special occasions...">
                </textarea>
				</div>

				<button type="submit" class="btn-submit">Proceed to Payment
					&#8594;</button>

			</form>
		</div>
	</div>

	<jsp:include page="/WEB-INF/components/footer.jsp" />
</body>
</html>