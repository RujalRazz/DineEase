<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.User"%>
<%@ page import="com.rujal.model.Restaurant"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css" />
<style>
.admin-main {
	margin-left: 260px;
	flex: 1;
	padding: 36px 40px;
	min-height: 100vh;
}

.admin-topbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 36px;
}

.topbar-left h1 {
	font-size: 24px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 4px;
}

.topbar-left p {
	font-size: 13px;
	color: #aaa;
}

.topbar-date {
	font-size: 13px;
	color: #999;
	background: #fff;
	padding: 8px 16px;
	border-radius: 50px;
	border: 1px solid #f0e8e4;
}

.stats-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	margin-bottom: 36px;
}

.stat-card {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.stat-top {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.stat-label {
	font-size: 12px;
	font-weight: 600;
	color: #aaa;
	text-transform: uppercase;
	letter-spacing: 0.8px;
}

.stat-icon {
	width: 38px;
	height: 38px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
}

.stat-icon-red {
	background: #fce8e4;
}

.stat-icon-green {
	background: #e8f5f0;
}

.stat-icon-blue {
	background: #e8f0fc;
}

.stat-icon-amber {
	background: #fdf3e3;
}

.stat-value {
	font-size: 28px;
	font-weight: 800;
	color: #2c1a10;
	letter-spacing: -1px;
}

.stat-sub {
	font-size: 12px;
	color: #aaa;
}

.stat-sub span {
	color: #27ae60;
	font-weight: 600;
}

.section-heading {
	font-size: 16px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 16px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.section-heading a {
	font-size: 13px;
	color: #c0392b;
	text-decoration: none;
	font-weight: 500;
}

.two-col {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 24px;
	margin-bottom: 36px;
}

/* ── Table Card ── */
.table-card {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
}

table {
	width: 100%;
	border-collapse: collapse;
}

thead th {
	text-align: left;
	font-size: 11px;
	font-weight: 700;
	color: #bbb;
	text-transform: uppercase;
	letter-spacing: 0.8px;
	padding-bottom: 12px;
	border-bottom: 1px solid #f5f0ec;
}

tbody tr {
	border-bottom: 1px solid #f5f0ec;
	transition: background 0.15s;
}

tbody tr:last-child {
	border-bottom: none;
}

tbody tr:hover {
	background: #fdf6f2;
}

tbody td {
	padding: 12px 0;
	font-size: 13px;
	color: #444;
}

.td-name {
	font-weight: 600;
	color: #2c1a10;
}

.badge {
	display: inline-block;
	padding: 3px 10px;
	border-radius: 50px;
	font-size: 11px;
	font-weight: 600;
}

.badge-confirmed {
	background: #e8f5f0;
	color: #27ae60;
}

.badge-pending {
	background: #fdf3e3;
	color: #f39c12;
}

.badge-cancelled {
	background: #fce8e4;
	color: #c0392b;
}

/* ── Price range dots ── */
.price-dots {
	display: flex;
	gap: 3px;
}

.price-dot {
	width: 7px;
	height: 7px;
	border-radius: 50%;
	background: #e8e0dc;
}

.price-dot.filled {
	background: #c0392b;
}

/* ── Quick actions ── */
.quick-actions {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 16px;
	margin-bottom: 36px;
}

.action-btn {
	background: #fff;
	border: 1.5px solid #f0e8e4;
	border-radius: 14px;
	padding: 20px;
	text-align: center;
	cursor: pointer;
	text-decoration: none;
	transition: all 0.2s;
	display: block;
}

.action-btn:hover {
	border-color: #c0392b;
	background: #fff5f3;
	transform: translateY(-2px);
}

.action-icon {
	font-size: 28px;
	margin-bottom: 8px;
	display: block;
}

.action-label {
	font-size: 13px;
	font-weight: 600;
	color: #2c1a10;
	display: block;
}

.action-sub {
	font-size: 11px;
	color: #aaa;
	margin-top: 3px;
	display: block;
}
</style>

</head>
<body>
	<%
	request.setAttribute("activeAdmin", "dashboard");
	%>
	<jsp:include page="/WEB-INF/components/adminNavBar.jsp" />
	<main class="admin-main">

		<%-- Top bar with greeting and date --%>
		<div class="admin-topbar">
			<div class="topbar-left">
				<h1>Dashboard</h1>
				<p>
					Welcome back,
					<%=session.getAttribute("admin") != null ? ((com.rujal.model.Admin) session.getAttribute("admin")).getUsername()
		: "Admin"%>
					👋
				</p>
			</div>
			<div class="topbar-date">
				&#128197;
				<%=new java.text.SimpleDateFormat("EEE, dd MMM yyyy").format(new java.util.Date())%>
			</div>
		</div>

		<%-- ── Stats Cards ── --%>
		<div class="stats-grid">

			<div class="stat-card">
				<div class="stat-top">
					<div class="stat-label">Total Users</div>
					<div class="stat-icon stat-icon-red">&#128101;</div>
				</div>
				<div class="stat-value"><%=request.getAttribute("userCount")%></div>
				<div class="stat-sub">
					<span>+<%=request.getAttribute("userCountThisMonth")%></span>
					this month
				</div>
			</div>

			<%-- Total Restaurants --%>
			<div class="stat-card">
				<div class="stat-top">
					<div class="stat-label">Restaurants</div>
					<div class="stat-icon stat-icon-green">&#127860;</div>
				</div>
				<div class="stat-value"><%=request.getAttribute("restaurantCount")%></div>
				<div class="stat-sub">
					<span>+<%=request.getAttribute("restaurantCountMonth")%></span>
					this month
				</div>
			</div>

			<%-- Total Bookings --%>
			<div class="stat-card">
				<div class="stat-top">
					<div class="stat-label">Bookings</div>
					<div class="stat-icon stat-icon-blue">&#128197;</div>
				</div>
				<div class="stat-value"><%=request.getAttribute("bookingCount")%></div>
				<div class="stat-sub">
					<span>+<%=request.getAttribute("bookingCountThisWeek")%></span>
					this week
				</div>
			</div>

			<%-- Total Orders --%>
			<div class="stat-card">
				<div class="stat-top">
					<div class="stat-label">Orders</div>
					<div class="stat-icon stat-icon-amber">&#128722;</div>
				</div>
				<div class="stat-value"><%=request.getAttribute("orderCount")%></div>
				<div class="stat-sub">
					<span>+<%=request.getAttribute("orderCountToday")%></span> today
				</div>
			</div>
		</div>

		<div class="section-heading">Quick Actions</div>
		<div class="quick-actions">

			<a href="${pageContext.request.contextPath}/adminRestaurants"
				class="action-btn"> <span class="action-icon">&#127860;</span> <span
				class="action-label">Manage Restaurants</span> <span
				class="action-sub">Add, edit or remove restaurants</span>
			</a> <a href="${pageContext.request.contextPath}/adminCities"
				class="action-btn"> <span class="action-icon">&#127758;</span> <span
				class="action-label">Manage Cities</span> <span class="action-sub">Add
					or remove cities</span>
			</a> <a href="${pageContext.request.contextPath}/adminBookings"
				class="action-btn"> <span class="action-icon">&#128197;</span> <span
				class="action-label">View Bookings</span> <span class="action-sub">See
					all restaurant bookings</span>
			</a> <a href="${pageContext.request.contextPath}/adminOrders"
				class="action-btn"> <span class="action-icon">&#128722;</span> <span
				class="action-label">View Orders</span> <span class="action-sub">Track
					all food orders</span>
			</a> <a href="${pageContext.request.contextPath}/adminLogout"
				class="action-btn"> <span class="action-icon">&#128682;</span> <span
				class="action-label">Logout</span> <span class="action-sub">End
					admin session</span>
			</a>

		</div>


		<div class="two-col">

			<%-- LEFT: Recent Users table --%>
			<div class="table-card">
				<div class="section-heading">Recent Users</div>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<User> recentUsers = (List<User>) request.getAttribute("recentUsers");
						if (recentUsers == null || recentUsers.isEmpty()) {
						%>
						<tr>
							<td class="td-name">—</td>
							<td>No users yet</td>
							<td>—</td>
						</tr>
						<%
						} else {
						for (User u : recentUsers) {
						%>
						<tr>
							<td class="td-name"><%=u.getFirst_name()%> <%=u.getLast_name()%>
							</td>
							<td><%=u.getEmail()%></td>
							<td><%=u.getPhone_number()%></td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</div>

			<%-- RIGHT: Recent Restaurants table --%>
			<div class="table-card">
				<div class="section-heading">
					Recent Restaurants <a
						href="${pageContext.request.contextPath}/adminRestaurants">View
						All</a>
				</div>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>City</th>
							<th>Price</th>
							<th>Rating</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Restaurant> recentRestaurants = (List<Restaurant>) request.getAttribute("recentRestaurants");
						if (recentRestaurants == null || recentRestaurants.isEmpty()) {
						%>
						<tr>
							<td class="td-name">—</td>
							<td>No restaurants yet</td>
							<td>—</td>
							<td>—</td>
						</tr>
						<%
						} else {
						for (Restaurant r : recentRestaurants) {
						%>
						<tr>
							<td class="td-name"><%=r.getName()%></td>
							<td><%=r.getCityId()%></td>
							<td>
								<div class="price-dots">
									<div
										class="price-dot <%=r.getPriceRange() >= 1 ? "filled" : ""%>"></div>
									<div
										class="price-dot <%=r.getPriceRange() >= 2 ? "filled" : ""%>"></div>
									<div
										class="price-dot <%=r.getPriceRange() >= 3 ? "filled" : ""%>"></div>
								</div>
							</td>
							<td>&#9733; <%=r.getRating()%></td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</div>

		</div>
	</main>

</body>
</html>