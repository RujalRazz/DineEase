<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.City" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
.hero {
	position: relative;
	width: 100%;
	min-height: 680px;
	background:
		url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1400&q=80')
		center/cover no-repeat;
	display: flex; 
	align-items : center;
	justify-content: space-evenly; 
	padding : 60px 48px;
	overflow: hidden;
	padding: 60px 48px;
	align-items: center
}

.hero::before {
	content: '';
	position: absolute;
	inset: 0;
	background: linear-gradient(to right, rgba(255, 240, 235, 0.92) 0%,
		rgba(255, 240, 235, 0.7) 40%, rgba(0, 0, 0, 0.1) 100%);
}

.hero-content {
	position: relative;
	z-index: 2;
	flex: 1;
	max-width: 480px;
}

.hero-badge {
	display: inline-block;
	background: #4ecdc4;
	color: #fff;
	font-size: 10px;
	font-weight: 700;
	letter-spacing: 1.5px;
	text-transform: uppercase;
	padding: 5px 12px;
	border-radius: 50px;
	margin-bottom: 20px;
}

.hero-title {
	font-size: 62px;
	font-weight: 800;
	color: #2c1a10;
	line-height: 1.05;
	letter-spacing: -2px;
	margin-bottom: 16px;
}

.hero-subtitle {
	font-size: 18px;
	color: #5a3a2a;
	margin-bottom: 32px;
}

.search-bar {
	display: flex;
	align-items: center;
	background: #fff;
	border-radius: 50px;
	padding: 6px 6px 6px 20px;
	gap: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	max-width: 440px;
	margin-bottom: 28px;
}

.search-bar .pin-icon {
	color: #c0392b;
	font-size: 16px;
}

.search-bar select {
	flex: 1;
	border: none;
	outline: none;
	font-size: 14px;
	color: #555;
	background: transparent;
	cursor: pointer;
}

.find-btn {
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	padding: 12px 24px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	white-space: nowrap;
	transition: opacity 0.2s;
}

.find-btn:hover {
	opacity: 0.9;
}

.trending-card {
	position: relative;
	transform: rotate(15deg);
	z-index: 2;
	background: #fff;
	border-radius: 20px;
	width: 400px;
	flex-shrink: 0;
	box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
	overflow: hidden;
	align-self: center;
}

.trending-card img {
	width: 100%;
	height: 180px;
	object-fit: cover;
}

.trending-body {
	padding: 16px 20px 20px;
}

.trending-label {
	font-size: 10px;
	font-weight: 700;
	letter-spacing: 1.5px;
	color: #c0392b;
	text-transform: uppercase;
	margin-bottom: 6px;
}

.trending-row {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 4px;
}

.trending-name {
	font-size: 18px;
	font-weight: 700;
	color: #2c1a10;
}

.trending-rating {
	font-size: 13px;
	font-weight: 600;
	color: #f39c12;
}

.trending-cuisine {
	font-size: 13px;
	color: #999;
	margin-bottom: 14px;
}

.trending-tags {
	display: flex;
	gap: 8px;
}

.tag {
	font-size: 10px;
	font-weight: 700;
	letter-spacing: 0.8px;
	text-transform: uppercase;
	padding: 5px 10px;
	border-radius: 50px;
	curser: pointer;
}

.tag-city {
	background: #e8f5f4;
	color: #2a9d8f;
}

.tag-reserve {
	background: #fce8e4;
	color: #c0392b;
	border: none;
	transition: background 0.2s;
}

.tag-reserve:hover {
	background: #f5c6bb;
}

.section {
	padding: 56px 48px;
}

.section-header {
	margin-bottom: 32px;
}

.section-title {
	font-size: 28px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 8px;
}

.section-underline {
	width: 40px;
	height: 3px;
	background: #c0392b;
	border-radius: 2px;
}

.city-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	grid-auto-rows: 220px;
	gap: 20px;
}

.city-card {
	height: 220px;
	border-radius: 16px;
	overflow: hidden;
	position: relative;
	cursor: pointer;
	transition: transform 0.3s, box-shadow 0.3s;
}

.city-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 32px rgba(0, 0, 0, 0.18);
}

.city-card img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.4s;
	display: block;
}

.city-card:hover img {
	transform: scale(1.05);
}

.city-card-overlay {
	position: absolute;
	inset: 0;
	background: linear-gradient(to top, rgba(0, 0, 0, 0.65) 0%,
		rgba(0, 0, 0, 0.1) 60%);
}

.city-card-info {
	position: absolute;
	bottom: 20px;
	left: 20px;
}

.city-card-name {
	font-size: 22px;
	font-weight: 700;
	color: #fff;
	margin-bottom: 4px;
}

.city-card-count {
	font-size: 13px;
	color: rgba(255, 255, 255, 0.8);
}

.explore-more-card {
	background: linear-gradient(135deg, #2c1a10, #c0392b);
	display: flex !important;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

.explore-more-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 32px rgba(192, 57, 43, 0.35);
}

.explore-more-inner {
	text-align: center;
	color: #fff;
}

.explore-icon {
	font-size: 36px;
	margin-bottom: 12px;
}

.explore-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 6px;
}

.explore-sub {
	font-size: 13px;
	color: rgba(255, 255, 255, 0.75);
	margin-bottom: 14px;
}

.explore-arrow {
	display: inline-block;
	font-size: 20px;
	background: rgba(255, 255, 255, 0.2);
	width: 36px;
	height: 36px;
	border-radius: 50%;
	line-height: 36px;
	transition: background 0.2s;
}

.explore-more-card:hover .explore-arrow {
	background: rgba(255, 255, 255, 0.35);
}

.model-overlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, 0.5);
	z-index: 999;
	align-items: center;
	justify-content: center;
}

.model-overlay.show {
	display: flex;
}

.model {
	background: #fff;
	border-radius: 20px;
	padding: 40px 36px;
	max-width: 380px;
	width: 90%;
	text-align: center;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
}

.model-icon {
	font-size: 40px;
	margin-bottom: 16px;
}

.model h3 {
	font-size: 20px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 8px;
}

.model p {
	font-size: 14px;
	color: #888;
	margin-bottom: 24px;
	line-height: 1.6;
}

.model-btns {
	display: flex;
	gap: 12px;
}

.model-btn-login {
	flex: 1;
	padding: 12px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	text-decoration: none;
	display: flex;
	align-items: center;
	justify-content: center;
}

.model-btn-cancel {
	flex: 1;
	padding: 12px;
	background: #f5f5f5;
	color: #555;
	border: none;
	border-radius: 50px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
}

.model-btn-cancel:hover {
	background: #eee;
}
</style>
</head>
<body>
	<%
	boolean isLoggedIn = session.getAttribute("user") != null;
	%>
	<%
	request.setAttribute("activePage", "home");
	%>
	<jsp:include page="/WEB-INF/components/navbar.jsp" />
	<section class="hero">
		<div class="hero-content">
			<span class="hero-badge">Nepal's Premium Dining Network</span>
			<h1 class="hero-title">DineEase</h1>
			<p class="hero-subtitle">Your favorite food, delivered or
				reserved.</p>
			<div class="search-bar">
				<span class="pin-icon">&#128205;</span> <select id="citySelect">
					<option value="">Select your city</option>
					<option value="all">All</option>
					<% 
						List<com.rujal.model.City> cities = (List<com.rujal.model.City>) request.getAttribute("cities");
					if (cities != null) {
			            for (City city : cities) {
					%>
					<option value="<%=city.getCityId()%>">
            <%=city.getCityName()%>
        </option>
        <%
			            }
					}
        %>
					
				</select>
				<button class="find-btn" onclick="handleFindRestaurants()">Find
					Restaurants</button>
			</div>
		</div>
		<div class="trending-card">
			<img
				src="https://images.unsplash.com/photo-1555126634-323283e090fa?w=400&q=80"
				alt="Himalayan Bistro">
			<div class="trending-body">
				<p class="trending-label">Trending Now</p>
				<div class="trending-row">
					<h3 class="trending-name">The Himalayan Bistro</h3>
					<span class="trending-rating">&#9733; 4.9</span>
				</div>
				<p class="trending-cuisine">Artisan Newari Cuisine &amp; Fusion</p>
				<div class="trending-tags">
					<span class="tag tag-city">Kathmandu</span>
					<button class="tag tag-reserve" onclick="handleReserve()">Reserve
						Table</button>
				</div>
			</div>
		</div>
	</section>
	<section class="section">
		<div class="section-header">
			<h2 class="section-title">Explore by City</h2>
			<div class="section-underline"></div>
		</div>
		<div class="city-grid" id="cityGrid"></div>

		<!-- This pages will be set to hidden initially and will cloned by js -->
		<div style="display: none;">
			<jsp:include page="/WEB-INF/components/cityCard.jsp" />
			<jsp:include page="/WEB-INF/components/exploreMoreCard.jsp" />
		</div>
	</section>

	<div class="model-overlay" id="loginModel">
		<div class="model">
			<div class="model-icon">&#127869;</div>
			<h3>Login Required</h3>
			<p>You need to be logged in to explore restaurants and make
				reservations.</p>
			<div class="model-btns">
				<a href="${pageContext.request.contextPath}/login"
					class="model-btn-login">Login</a>
				<button class="model-btn-cancel" onclick="closeModel()">Cancel</button>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/components/footer.jsp" />

	<script>
		const isLoggedIn =
	<%=isLoggedIn%>
		;
		const contextPath = '${pageContext.request.contextPath}';
		const CITIES = [
	        <%
	            if (cities != null) {
	                for (int i = 0; i < cities.size(); i++) {
	                    com.rujal.model.City city = cities.get(i);
	        %>
	        {
	            name:  "<%= city.getCityName() %>",
	            count: "<%= city.getRestaurantCount() %>" + " Restaurants",
	            value: "<%= city.getCityValue() %>",
	            image: "<%= city.getImageUrl() %>"
	        }<%= i < cities.size() - 1 ? "," : "" %>
	        <%
	                }
	            }
	        %>
	    ];
		 function buildCityGrid() {
			    const grid = document.getElementById('cityGrid');
			    const cardTemplate = document.getElementById('card-template');
			    const exploreTemplate = document.getElementById('explore-more-template');
			    CITIES.forEach(city => {
			        const card = cardTemplate.cloneNode(true);
			        card.removeAttribute('id');
			        card.style.display = '';
			        card.querySelector('.card-img').src = city.image;
			        card.querySelector('.card-img').alt = city.name;
			        card.querySelector('.city-card-name').textContent = city.name;
			        card.querySelector('.city-card-count').textContent = city.count;
			        card.onclick = () => handleCityClick(city.value);
			        grid.appendChild(card);

			    });
			    const exploreCard = exploreTemplate.cloneNode(true);
		        exploreCard.removeAttribute('id');
		        exploreCard.style.display = '';
		        grid.appendChild(exploreCard);
		    }
		 buildCityGrid();
		 function handleFindRestaurants() {
		        if (!isLoggedIn) {
		            showModel();
		        } 
		        else {
		            const city = document.getElementById('citySelect').value;
		            if (city) {
		                window.location.href = contextPath + '/restaurants?city=' + city;
		            } 
		            else {
		                alert('Please select a city first.');
		            }
		        }
		    }
		 function handleCityClick(city) {
		        if (!isLoggedIn) {
		            showModel();
		        } 
		        else {
		            window.location.href = contextPath + '/restaurants?city=' + city;
		        }
		    }
		 function handleReserve() {
		        if (!isLoggedIn) {
		            showModel();
		        } 
		        else {
		            window.location.href = contextPath + '/restaurants';
		        }
		    }
		 function handleExploreMore() {
		        if (!isLoggedIn) {
		            showModel();
		        } 
		        else {
		            window.location.href = contextPath + '/restaurants?city=all';
		        }
		    }
		 function showModel() {
		        document.getElementById('loginModel').classList.add('show');
		    }
		 function closeModel() {
		        document.getElementById('loginModel').classList.remove('show');
		    }
		 document.getElementById('loginModel').addEventListener('click', function(e) {
		        if (e.target === this) closeModel();
		    });
		
	</script>

</body>

</html>