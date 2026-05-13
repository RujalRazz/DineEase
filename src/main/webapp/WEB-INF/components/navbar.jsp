<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Object loggedInUser = session.getAttribute("user");
%>


<nav class="site-nav">
	<a href="${pageContext.request.contextPath}/index" class="nav-brand">
		<span class="brand-text">DineEase</span>
	</a>

	<button type="button" class="nav-toggle" aria-label="Open navigation"
		aria-expanded="false" aria-controls="primaryNav">
		<span></span> <span></span> <span></span>
	</button>

	<ul class="nav-links" id="primaryNav">
		<li><a href="${pageContext.request.contextPath}/index"
			class="${activePage == 'home' ? 'active' : ''}">Home</a></li>
		<li><a href="${pageContext.request.contextPath}/about-us"
			class="${activePage == 'about' ? 'active' : ''}">About Us</a></li>
		<%
		if (loggedInUser != null) {
		%>
		<%-- Logged in — show these links --%>
		<li><a href="${pageContext.request.contextPath}/restaurants"
			class="${activePage == 'restaurants' ? 'active' : ''}">Restaurants</a></li>
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

	</ul>
</nav>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		const navToggle = document.querySelector('.nav-toggle');
		const navLinks = document.querySelector('.nav-links');

		if (!navToggle || !navLinks) {
			return;
		}

		navToggle.addEventListener('click', function() {
			const isOpen = navLinks.classList.toggle('open');
			navToggle.classList.toggle('open', isOpen);
			navToggle.setAttribute('aria-expanded', isOpen);
		});

		navLinks.querySelectorAll('a').forEach(function(link) {
			link.addEventListener('click', function() {
				navLinks.classList.remove('open');
				navToggle.classList.remove('open');
				navToggle.setAttribute('aria-expanded', 'false');
			});
		});
	});
</script>
