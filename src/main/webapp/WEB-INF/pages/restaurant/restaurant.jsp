<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.rujal.model.Restaurant"%>
<%@ page import="com.rujal.model.City"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurants – DineEase</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
.page-header {
	padding: 48px 48px 0;
}

.header-label {
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 2px;
	text-transform: uppercase;
	color: #c0392b;
	margin-bottom: 10px;
}

.header-title {
	font-size: 36px;
	font-weight: 800;
	color: #2c1a10;
	letter-spacing: -1px;
	margin-bottom: 10px;
}

.header-subtitle {
	font-size: 14px;
	color: #999;
	max-width: 380px;
	line-height: 1.6;
	margin-bottom: 28px;
}

.filter-bar {
	display: flex;
	align-items: center;
	gap: 10px;
	flex-wrap: wrap;
}

.filter-select {
	padding: 9px 36px 9px 16px;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	font-size: 13px;
	font-weight: 500;
	color: #2c1a10;
	background: #fff;
	cursor: pointer;
	outline: none;
	transition: border-color 0.2s;
	appearance: none;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23c0392b' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 12px center;
}

.filter-select:focus {
	border-color: #c0392b;
}

.filter-select.active-filter {
	border-color: #c0392b;
	background-color: #fff5f3;
	color: #c0392b;
}

.clear-btn {
	font-size: 13px;
	color: #c0392b;
	text-decoration: none;
	font-weight: 600;
	padding: 9px 16px;
	border-radius: 50px;
	border: 1.5px solid #f5c6bb;
	background: #fff5f3;
	cursor: pointer;
	transition: background 0.2s;
}

.clear-btn:hover {
	background: #fce8e4;
}

.divider {
	height: 1px;
	background: #f0e8e4;
	margin: 32px 48px;
}

.restaurant-section {
	padding: 0 48px 56px;
}

.restaurant-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.restaurant-card {
	background: #fff;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
	transition: transform 0.3s, box-shadow 0.3s;
}

.restaurant-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 32px rgba(0, 0, 0, 0.12);
}

.card-img-wrap {
	position: relative;
}

.card-img-wrap img {
	width: 100%;
	height: 200px;
	object-fit: cover;
	display: block;
}

.card-badge {
	position: absolute;
	top: 12px;
	right: 12px;
	font-size: 9px;
	font-weight: 700;
	letter-spacing: 1px;
	text-transform: uppercase;
	padding: 5px 10px;
	border-radius: 50px;
	color: #fff;
	background-color: red;
}

.card-body {
	padding: 18px 20px 20px;
}

.card-top {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 6px;
}

.card-name {
	font-size: 17px;
	font-weight: 700;
	color: #2c1a10;
}

.card-rating {
	font-size: 13px;
	font-weight: 600;
	color: #f39c12;
	white-space: nowrap;
}

.card-address {
	display: flex;
	align-items: flex-start;
	gap: 5px;
	font-size: 12px;
	color: #999;
	margin-bottom: 4px;
	line-height: 1.5;
}

.card-contact {
	display: flex;
	align-items: center;
	gap: 5px;
	font-size: 12px;
	color: #999;
	margin-bottom: 16px;
}

.card-icon {
	font-size: 12px;
	color: #c0392b;
	flex-shrink: 0;
}

.price-dots {
	display: flex;
	gap: 3px;
	margin-bottom: 16px;
}

.price-dot {
	width: 8px;
	height: 8px;
	border-radius: 50%;
	background: #e8e0dc;
}

.price-dot.filled {
	background: #c0392b;
}

.card-btns {
	display: flex;
	gap: 10px;
}

.btn-outline {
	flex: 1;
	padding: 10px;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	background: #fff;
	font-size: 13px;
	font-weight: 600;
	color: #2c1a10;
	cursor: pointer;
	text-align: center;
	transition: border-color 0.2s;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
}

.btn-outline:hover {
	border-color: #c0392b;
	color: #c0392b;
}

.btn-solid {
	flex: 1;
	padding: 10px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	border: none;
	border-radius: 50px;
	font-size: 13px;
	font-weight: 600;
	color: #fff;
	cursor: pointer;
	text-align: center;
	transition: opacity 0.2s;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
}

.btn-solid:hover {
	opacity: 0.9;
}

.empty-state {
	text-align: center;
	padding: 80px 20px;
	color: #bbb;
	grid-column: 1/-1;
}

.empty-icon {
	font-size: 48px;
	margin-bottom: 16px;
}


</style>
</head>
<body>
	<%
	List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
	List<City> cities = (List<City>) request.getAttribute("cities");
	int selectedCity = (Integer) request.getAttribute("selectedCity");
	String selectedPrice = (String) request.getAttribute("selectedPrice");
	if (selectedPrice == null)
		selectedPrice = "";

	String pageTitle = "All Restaurants";
	if (selectedCity > 0 && cities != null) {
		for (City c : cities) {
			if (c.getCityId() == selectedCity) {
		pageTitle = "Fine Dining in " + c.getCityName();
		break;
			}
		}
	}
	%>
	<%
	request.setAttribute("activePage", "restaurants");
	%>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />
	<div class="page-header">
		<p class="header-label">Curated Selection</p>
		<h1 class="header-title"><%=pageTitle%></h1>
		<p class="header-subtitle">Discover an editorial selection of the
			most exceptional culinary experiences, hand-picked for the discerning
			palate.</p>

		<form class="filter-bar" method="get"
			action="${pageContext.request.contextPath}/restaurants"
			id="filterForm">
			<select name="city"
				class="filter-select <%=selectedCity > 0 ? "active-filter" : ""%>"
				onchange="document.getElementById('filterForm').submit()">
				<option value="all">&#128205; All Cities</option>
				<%
				if (cities != null) {
					for (City city : cities) {
				%>
				<option value="<%=city.getCityId()%>"
					<%=city.getCityId() == selectedCity ? "selected" : ""%>>
					<%=city.getCityName()%>
				</option>
				<%
				}
				}
				%>
			</select> <select name="price"
				class="filter-select <%=!selectedPrice.isEmpty() ? "active-filter" : ""%>"
				onchange="document.getElementById('filterForm').submit()">
				<option value="">Price Range</option>
				<option value="asc"
					<%=selectedPrice.equals("asc") ? "selected" : ""%>>Price:
					Low to High</option>
				<option value="desc"
					<%=selectedPrice.equals("desc") ? "selected" : ""%>>
					Price: High to Low</option>
			</select>
			<%
			if (selectedCity > 0 || !selectedPrice.isEmpty()) {
			%>
			<a href="${pageContext.request.contextPath}/restaurants"
				class="clear-btn"> &#10005; Clear Filters </a>
			<%
			}
			%>

		</form>
	</div>
	<jsp:include page="/WEB-INF/components/restaurantCard.jsp" />
	<div class="divider"></div>
	<div class="restaurant-section">
		<div class="restaurant-grid" id="restaurantGrid"></div>
	</div>
	

	<jsp:include page="/WEB-INF/components/footer.jsp" />

	<script>
		const contextPath = '${pageContext.request.contextPath}';
		const RESTAURANTS = [
	        <%if (restaurants != null) {
	for (int i = 0; i < restaurants.size(); i++) {
		Restaurant r = restaurants.get(i);
		String imgUrl = r.getImageUrl() != null
				? r.getImageUrl()
				: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600&q=80";
		String badge = r.getBadge() != null ? r.getBadge() : "";%>
	        {
	            id: <%=r.getRestaurantId()%>,
	            name: "<%=r.getName().replace("\"", "\\\"")%>",
	            address: "<%=r.getAddress().replace("\"", "\\\"")%>",
	            contact: "<%=r.getContact().replace("\"", "\\\"")%>",
	            rating: "<%=r.getRating()%>",
	            priceRange: <%=r.getPriceRange()%>,
	            badge: "<%=badge%>",
	            image: "<%=imgUrl%>"
	        }<%=i < restaurants.size() - 1 ? "," : ""%>
	        <%}
}%>
	    ];
		function buildRestaurantGrid(filterCity) {
	        const grid = document.getElementById('restaurantGrid');
	        const template = document.getElementById('restaurant-card-template');
	        
	        grid.innerHTML = '';
	        const filteredList = (filterCity === 'All') ? RESTAURANTS : RESTAURANTS.filter(r => r.address.toLowerCase().includes(filterCity.toLowerCase()));
	        
	        if (RESTAURANTS.length === 0) {
	            grid.innerHTML = `
	                <div class="empty-state">
	                    <div class="empty-icon">&#127869;</div>
	                    <p>No restaurants found. Try a different city or filter.</p>
	                </div>`;
	            return;
	        }

	        filteredList.forEach(r => {
	        	const card = template.cloneNode(true);
	            card.removeAttribute('id');
	            card.style.display = '';
	            card.querySelector('.rc-img').src = r.image;
	            card.querySelector('.rc-img').alt = r.name;
	            const badge = card.querySelector('.rc-badge');
	            if (r.badge && r.badge !== '') {
	                badge.textContent = r.badge;
	                badge.style.display = '';
	            }
	            card.querySelector('.rc-name').textContent    = r.name;
	            card.querySelector('.rc-rating').textContent  = '★ ' + r.rating;
	            card.querySelector('.rc-address').textContent = r.address;
	            card.querySelector('.rc-contact').textContent = r.contact;
	            if (r.priceRange >= 1) card.querySelector('.rc-dot-1').classList.add('filled');
	            if (r.priceRange >= 2) card.querySelector('.rc-dot-2').classList.add('filled');
	            if (r.priceRange >= 3) card.querySelector('.rc-dot-3').classList.add('filled');

	            card.querySelector('.rc-book').href =
	                contextPath + '/booking?restaurantId=' + r.name;

	            
	            card.querySelector('.rc-menu').href = '#';

	            grid.appendChild(card);
	        });
	        
		}
		function handleCityFilter(city) {
			buildRestaurantGrid(city);
		}
		buildRestaurantGrid('All');
	</script>
</body>
</html>