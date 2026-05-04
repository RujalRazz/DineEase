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
.about-hero {
	background: linear-gradient(135deg, #2c1a10 0%, #c0392b 100%);
	padding: 80px 48px;
	text-align: center;
	position: relative;
	overflow: hidden;
}

.about-hero::before {
	content: '🍽️';
	position: absolute;
	font-size: 300px;
	opacity: 0.04;
	top: -60px;
	right: -40px;
	line-height: 1;
}

.hero-label {
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 2px;
	text-transform: uppercase;
	color: rgba(255, 255, 255, 0.6);
	margin-bottom: 16px;
}

.hero-title {
	font-size: 48px;
	font-weight: 800;
	color: #fff;
	letter-spacing: -1.5px;
	margin-bottom: 16px;
	line-height: 1.1;
}

.hero-title span {
	color: #f39c12;
}

.hero-subtitle {
	font-size: 16px;
	color: rgba(255, 255, 255, 0.7);
	max-width: 520px;
	margin: 0 auto;
	line-height: 1.7;
}

.section {
	padding: 72px 48px;
}

.section-label {
	font-size: 11px;
	font-weight: 700;
	letter-spacing: 2px;
	text-transform: uppercase;
	color: #c0392b;
	margin-bottom: 12px;
}

.section-title {
	font-size: 32px;
	font-weight: 800;
	color: #2c1a10;
	letter-spacing: -0.8px;
	margin-bottom: 16px;
	line-height: 1.2;
}

.section-body {
	font-size: 15px;
	color: #777;
	line-height: 1.8;
	max-width: 560px;
}

.section-underline {
	width: 40px;
	height: 3px;
	background: #c0392b;
	border-radius: 2px;
	margin-bottom: 24px;
}

.mission-section {
	display: flex;
	align-items: center;
	gap: 64px;
	padding: 72px 48px;
	background: #fff;
}

.mission-content {
	flex: 1;
}

.mission-image {
	flex: 1;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 16px 48px rgba(0, 0, 0, 0.12);
}

.mission-image img {
	width: 100%;
	height: 380px;
	object-fit: cover;
	display: block;
}

.stats-row {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 0;
	background: #2c1a10;
	padding: 48px;
}

.stat-item {
	text-align: center;
	padding: 20px;
	border-right: 1px solid rgba(255, 255, 255, 0.08);
}

.stat-item:last-child {
	border-right: none;
}

.stat-number {
	font-size: 40px;
	font-weight: 800;
	color: #fff;
	letter-spacing: -1px;
	margin-bottom: 6px;
}

.stat-number span {
	color: #c0392b;
}

.stat-desc {
	font-size: 13px;
	color: rgba(255, 255, 255, 0.5);
	font-weight: 500;
}

.values-section {
	padding: 72px 48px;
	background: #fdf6f2;
}

.values-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
	margin-top: 40px;
}

.value-card {
	background: #fff;
	border-radius: 16px;
	padding: 32px 28px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
	transition: transform 0.3s, box-shadow 0.3s;
}

.value-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 32px rgba(0, 0, 0, 0.1);
}

.value-icon {
	font-size: 36px;
	margin-bottom: 16px;
	display: block;
}

.value-title {
	font-size: 17px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 10px;
}

.value-desc {
	font-size: 13px;
	color: #999;
	line-height: 1.7;
}

/* ── Team section ── */
.team-section {
	padding: 72px 48px;
	background: #fff;
}

.team-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 28px;
	margin-top: 40px;
}

.team-card {
	text-align: center;
	background: #fdf6f2;
	border-radius: 16px;
	padding: 32px 20px;
	transition: transform 0.3s;
}

.team-card:hover {
	transform: translateY(-4px);
}

.team-avatar {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 28px;
	font-weight: 800;
	color: #fff;
	margin: 0 auto 16px;
}

.team-name {
	font-size: 16px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 4px;
}

.team-role {
	font-size: 12px;
	color: #c0392b;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.8px;
	margin-bottom: 12px;
}

.team-bio {
	font-size: 13px;
	color: #aaa;
	line-height: 1.6;
}

.cta-section {
	background: linear-gradient(135deg, #fce8e4, #fdf6f2);
	padding: 72px 48px;
	text-align: center;
}

.cta-title {
	font-size: 32px;
	font-weight: 800;
	color: #2c1a10;
	letter-spacing: -0.8px;
	margin-bottom: 12px;
}

.cta-subtitle {
	font-size: 15px;
	color: #aaa;
	margin-bottom: 32px;
	line-height: 1.7;
}

.cta-btns {
	display: flex;
	justify-content: center;
	gap: 16px;
	flex-wrap: wrap;
}

.btn-primary {
	padding: 14px 32px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 15px;
	font-weight: 600;
	text-decoration: none;
	transition: opacity 0.2s, transform 0.1s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-primary:hover {
	opacity: 0.9;
	transform: translateY(-1px);
}

.btn-secondary {
	padding: 14px 32px;
	background: #fff;
	color: #2c1a10;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	font-size: 15px;
	font-weight: 600;
	text-decoration: none;
	transition: border-color 0.2s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-secondary:hover {
	border-color: #c0392b;
	color: #c0392b;
}
</style>
</head>

<body>
<% request.setAttribute("activePage", "about"); %>
<jsp:include page="/WEB-INF/components/navbar.jsp"/>
<section class="about-hero">
    <p class="hero-label">Our Story</p>
    <h1 class="hero-title">
        Redefining Dining in<br>
        <span>Nepal</span>
    </h1>
    <p class="hero-subtitle">
        DineEase was born from a simple belief — that great food and
        effortless reservations should always go hand in hand.
    </p>
</section>
<div class="mission-section">
    <div class="mission-content">
        <p class="section-label">Our Mission</p>
        <div class="section-underline"></div>
        <h2 class="section-title">
            Connecting People<br>With Exceptional Food
        </h2>
        <p class="section-body">
            DineEase is Nepal's premier restaurant reservation and food ordering
            platform. We partner with the finest restaurants across Kathmandu,
            Pokhara, Lalitpur, and beyond — bringing curated dining experiences
            directly to your fingertips.
        </p>
        <br>
        <p class="section-body">
            Whether you are planning a quiet dinner for two, a family celebration,
            or ordering your favourite meal to your doorstep — DineEase makes it
            seamless, beautiful, and effortless.
        </p>
    </div>
    <div class="mission-image">
        <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=700&q=80"
             alt="Fine dining experience">
    </div>
</div>
<div class="stats-row">
    <div class="stat-item">
        <div class="stat-number">10<span>K+</span></div>
        <div class="stat-desc">Happy Customers</div>
    </div>
    <div class="stat-item">
        <div class="stat-number">500<span>+</span></div>
        <div class="stat-desc">Restaurant Partners</div>
    </div>
    <div class="stat-item">
        <div class="stat-number">5<span></span></div>
        <div class="stat-desc">Cities Covered</div>
    </div>
    <div class="stat-item">
        <div class="stat-number">4.8<span>★</span></div>
        <div class="stat-desc">Average Rating</div>
    </div>
</div>
<section class="values-section">
    <div style="max-width:560px">
        <p class="section-label">What We Stand For</p>
        <div class="section-underline"></div>
        <h2 class="section-title">Our Core Values</h2>
    </div>
    <div class="values-grid">
        <div class="value-card">
            <span class="value-icon">&#127869;</span>
            <div class="value-title">Culinary Excellence</div>
            <div class="value-desc">
                We partner only with restaurants that meet our editorial
                standard of quality, authenticity, and exceptional service.
            </div>
        </div>
        <div class="value-card">
            <span class="value-icon">&#128274;</span>
            <div class="value-title">Trust & Security</div>
            <div class="value-desc">
                Your data and transactions are always protected.
                We take privacy seriously and never compromise on security.
            </div>
        </div>
        <div class="value-card">
            <span class="value-icon">&#9889;</span>
            <div class="value-title">Seamless Experience</div>
            <div class="value-desc">
                From discovery to delivery — every step of your DineEase
                journey is designed to be fast, intuitive, and enjoyable.
            </div>
        </div>
        <div class="value-card">
            <span class="value-icon">&#127758;</span>
            <div class="value-title">Local First</div>
            <div class="value-desc">
                We champion Nepal's vibrant food culture and support local
                restaurant owners by giving them a world-class digital presence.
            </div>
        </div>
        <div class="value-card">
            <span class="value-icon">&#128101;</span>
            <div class="value-title">Community Driven</div>
            <div class="value-desc">
                DineEase is built for the community. We listen, adapt,
                and grow based on the feedback of our diners and partners.
            </div>
        </div>
        <div class="value-card">
            <span class="value-icon">&#127775;</span>
            <div class="value-title">Continuous Innovation</div>
            <div class="value-desc">
                We are always improving. New features, better recommendations,
                and smarter tools are always on the way.
            </div>
        </div>
    </div>
</section>

<section class="team-section">
    <div style="text-align:center; margin-bottom:0;">
        <p class="section-label" style="text-align:center">The People Behind DineEase</p>
        <div class="section-underline" style="margin:12px auto 0;"></div>
        <h2 class="section-title" style="text-align:center; margin-top:12px;">
            Meet Our Team
        </h2>
    </div>
    <div class="team-grid">
        <div class="team-card">
            <div class="team-avatar">R</div>
            <div class="team-name">Rujal Sharma Rajopadhyaya</div>
            <div class="team-role">Founder & Developer</div>
            <div class="team-bio">
                Built DineEase from the ground up using Java, JSP, and MySQL.
                Passionate about combining great food with great technology.
            </div>
        </div>
        <div class="team-card">
            <div class="team-avatar">&#127869;</div>
            <div class="team-name">Our Restaurant Partners</div>
            <div class="team-role">Culinary Partners</div>
            <div class="team-bio">
                Many restaurants across Nepal who trust DineEase to connect
                them with food lovers every single day.
            </div>
        </div>
        <div class="team-card">
            <div class="team-avatar">&#128101;</div>
            <div class="team-name">Our Community</div>
            <div class="team-role">The Heart of DineEase</div>
            <div class="team-bio">
                10,000+ diners who have made DineEase their go-to platform
                for reservations and food delivery across Nepal.
            </div>
        </div>
    </div>
</section>
<section class="cta-section">
    <h2 class="cta-title">Ready to Experience DineEase?</h2>
    <p class="cta-subtitle">
        Join thousands of food lovers who have already discovered Nepal's
        finest dining experiences through DineEase.
    </p>
    <div class="cta-btns">
        <a href="${pageContext.request.contextPath}/register" class="btn-primary">
            &#127381; Get Started Free
        </a>
        <a href="${pageContext.request.contextPath}/restaurants" class="btn-secondary">
            &#127860; Explore Restaurants
        </a>
    </div>
</section>

<jsp:include page="/WEB-INF/components/footer.jsp"/>

</body>
</html>