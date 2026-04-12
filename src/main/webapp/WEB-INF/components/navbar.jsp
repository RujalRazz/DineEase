<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Object loggedInUser = session.getAttribute("user");
%>


<nav>
	<a href="${pageContext.request.contextPath}/index" class="nav-brand">
		<span class="brand-text">DineEase</span>
	</a>


	<ul class="nav-links">
		<li><a href="${pageContext.request.contextPath}/index"
			class="${activePage == 'home' ? 'active' : ''}">Home</a></li>
		<%
		if (loggedInUser != null) {
		%>
		<%-- Logged in — show these links --%>
		<li><a href="${pageContext.request.contextPath}/restaurants"
			class="${activePage == 'profile' ? 'active' : ''}">Restaurants</a></li>
		<li><a href="${pageContext.request.contextPath}/about-us"
			class="${activePage == 'bookings' ? 'active' : ''}">About Us</a></li>
		<li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
		<li></li>
		<%
		} else {
		%>
		<%-- Not logged in — show these links --%>
		<li><a href="${pageContext.request.contextPath}/login"
			class="${activePage == 'login' ? 'active' : ''}">Login</a></li>
		<li><a href="${pageContext.request.contextPath}/register"
			class="${activePage == 'register' ? 'active' : ''}">Register</a></li>

		<%
		}
		%>
		<% if (loggedInUser != null) { %>
        <div>
            <a href="#" class="nav-cart">
                <img src="${pageContext.request.contextPath}/assets/cart.svg" alt="cart" />
            </a>
        </div>
    <% } %>
	</ul>
</nav>

