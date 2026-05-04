<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.Admin"%>
<%--
    Admin Navbar Component, vertical left sidebar navigation.
--%>
<%
Admin adminUser = (Admin) session.getAttribute("admin");
%>

<aside class="admin-sidebar">

	<div class="sidebar-brand">
		<div class="sidebar-brand-icon">&#127859;</div>
		<div class="sidebar-brand-text">
			<div class="sidebar-brand-name">DineEase</div>
			<div class="sidebar-brand-role">Admin Console</div>
		</div>
	</div>

	<div class="sidebar-user">
		<div class="sidebar-user-avatar">
			<%=adminUser != null ? adminUser.getUsername().substring(0, 1).toUpperCase() : "A"%>
		</div>
		<div class="sidebar-user-info">
			<div class="sidebar-user-name">
				<%=adminUser != null ? adminUser.getUsername() : "Admin"%>
			</div>
			<div class="sidebar-user-role">Administrator</div>
		</div>
	</div>
	<div class="sidebar-nav-label">MAIN MENU</div>
	<nav class="sidebar-nav">

		<a href="${pageContext.request.contextPath}/admin-dashboard"
			class="sidebar-nav-item <%= "dashboard".equals(request.getAttribute("activeAdmin")) ? "active" : "" %>">
			<span class="nav-icon">&#9781;</span> <span class="nav-text">Dashboard</span>
		</a> <a href="${pageContext.request.contextPath}/adminRestaurants"
			class="sidebar-nav-item <%= "restaurants".equals(request.getAttribute("activeAdmin")) ? "active" : "" %>">
			<span class="nav-icon">&#127860;</span> <span class="nav-text">Restaurants</span>
		</a> <a href="${pageContext.request.contextPath}/adminBookings"
			class="sidebar-nav-item <%= "bookings".equals(request.getAttribute("activeAdmin")) ? "active" : "" %>">
			<span class="nav-icon">&#128197;</span> <span class="nav-text">Bookings</span>
		</a> <a href="${pageContext.request.contextPath}/adminOrders"
			class="sidebar-nav-item <%= "orders".equals(request.getAttribute("activeAdmin")) ? "active" : "" %>">
			<span class="nav-icon">&#128722;</span> <span class="nav-text">Orders</span>
		</a> <a href="${pageContext.request.contextPath}/adminCities"
			class="sidebar-nav-item <%= "cities".equals(request.getAttribute("activeAdmin")) ? "active" : "" %>">
			<span class="nav-icon">&#127758;</span> <span class="nav-text">Cities</span>
		</a> <a href="${pageContext.request.contextPath}/adminMenu"
			class="sidebar-nav-item <%= "menu".equals(request.getAttribute("activeAdmin")) ? "active" : "" %>">
			<span class="nav-icon">&#127869;</span> <span class="nav-text">Menu
				Items</span>
		</a>

	</nav>

	<a href="${pageContext.request.contextPath}/adminLogout"
		class="sidebar-nav-item sidebar-logout"> <span class="nav-icon">&#128682;</span>
		<span class="nav-text">Logout</span>
	</a>

</aside>
