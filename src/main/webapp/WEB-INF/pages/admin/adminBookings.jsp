<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css" />
<style>
.admin-main {
	margin-left: 260px;
	flex: 1;
	padding: 36px 40px;
}

.admin-topbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 32px;
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

.flash-success {
	background: #e8f5f0;
	border: 1px solid #b7ebc8;
	color: #276749;
	border-radius: 10px;
	padding: 12px 18px;
	font-size: 13px;
	margin-bottom: 20px;
}

.flash-error {
	background: #fff0f0;
	border: 1px solid #f5c6c6;
	color: #c0392b;
	border-radius: 10px;
	padding: 12px 18px;
	font-size: 13px;
	margin-bottom: 20px;
}

.table-card {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
	overflow-x: auto;
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
	padding-right: 16px;
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
	padding: 13px 16px 13px 0;
	font-size: 13px;
	color: #444;
}

.td-name {
	font-weight: 600;
	color: #2c1a10;
}

.status-form {
	display: flex;
	align-items: center;
	gap: 8px;
}

.status-select {
	padding: 5px 10px;
	border-radius: 50px;
	border: 1.5px solid #e8e0dc;
	font-size: 12px;
	font-weight: 600;
	outline: none;
	cursor: pointer;
	background: #fafafa;
	color: #2c1a10;
	transition: border-color 0.2s;
}

.status-select:focus {
	border-color: #c0392b;
}

.status-select.status-pending {
	border-color: #f39c12;
	color: #f39c12;
	background: #fdf3e3;
}

.status-select.status-confirmed {
	border-color: #27ae60;
	color: #27ae60;
	background: #e8f5f0;
}

.status-select.status-cancelled {
	border-color: #c0392b;
	color: #c0392b;
	background: #fce8e4;
}

.btn-update {
	padding: 5px 12px;
	border: none;
	border-radius: 50px;
	background: #2c1a10;
	color: #fff;
	font-size: 11px;
	font-weight: 600;
	cursor: pointer;
	transition: background 0.2s;
}

.btn-update:hover {
	background: #c0392b;
}

.btn-delete {
	padding: 5px 12px;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	background: #fff;
	color: #999;
	font-size: 11px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
}

.btn-delete:hover {
	background: #fce8e4;
	border-color: #c0392b;
	color: #c0392b;
}

.action-btns {
	display: flex;
	gap: 8px;
	align-items: center;
	flex-wrap: wrap;
}
</style>

</head>
<body>
	<%
	request.setAttribute("activeAdmin", "bookings");
	%>
	<jsp:include page="/WEB-INF/components/adminNavBar.jsp" />

	<%
	List<Object[]> bookings = (List<Object[]>) request.getAttribute("bookings");
	String successMessage = (String) request.getAttribute("successMessage");
	String errorMessage = (String) request.getAttribute("errorMessage");
	%>
	<main class="admin-main">

		<div class="admin-topbar">
			<div class="topbar-left">
				<h1>Manage Bookings</h1>
				<p>View and manage all table reservations</p>
			</div>
		</div>

		<%
		if (successMessage != null) {
		%>
		<div class="flash-success">
			&#10003;
			<%=successMessage%></div>
		<%
		}
		%>
		<%
		if (errorMessage != null) {
		%>
		<div class="flash-error">
			&#9888;
			<%=errorMessage%></div>
		<%
		}
		%>

		<div class="table-card">
			<table>
				<thead>
					<tr>
						<th>#</th>
						<th>User</th>
						<th>Restaurant</th>
						<th>Date</th>
						<th>Time</th>
						<th>Guests</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (bookings == null || bookings.isEmpty()) {
					%>
					<tr>
						<td colspan="8"
							style="text-align: center; padding: 40px; color: #bbb;">No
							bookings found yet.</td>
					</tr>
					<%
					} else {
					for (Object[] b : bookings) {
						int bookingId = (int) b[0];
						String userName = (String) b[1];
						String restName = (String) b[2];
						String date = (String) b[3];
						String time = (String) b[4];
						int guests = (int) b[5];
						String status = (String) b[6];
						String statusClass = "status-" + status.toLowerCase();
					%>
					<tr>
						<td><%=bookingId%></td>
						<td class="td-name"><%=userName%></td>
						<td><%=restName%></td>
						<td><%=date%></td>
						<td><%=time%></td>
						<td><%=guests%></td>
						<td>

							<form action="${pageContext.request.contextPath}/adminBookings"
								method="post" class="status-form">
								<input type="hidden" name="action" value="updateStatus" /> <input
									type="hidden" name="booking_id" value="<%=bookingId%>" /> <select
									name="status" class="status-select <%=statusClass%>"
									onchange="this.className='status-select status-'+this.value.toLowerCase()">
									<option value="PENDING"
										<%="PENDING".equals(status) ? "selected" : ""%>>
										PENDING</option>
									<option value="CONFIRMED"
										<%="CONFIRMED".equals(status) ? "selected" : ""%>>
										CONFIRMED</option>
									<option value="CANCELLED"
										<%="CANCELLED".equals(status) ? "selected" : ""%>>
										CANCELLED</option>
								</select>
								<button type="submit" class="btn-update">Update</button>
							</form>
						</td>
						<td>

							<form action="${pageContext.request.contextPath}/adminBookings"
								method="post" onsubmit="return confirm('Delete this booking?')">
								<input type="hidden" name="action" value="delete" /> <input
									type="hidden" name="booking_id" value="<%=bookingId%>" />
								<button type="submit" class="btn-delete">Delete</button>
							</form>
						</td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>

	</main>
</body>
</html>