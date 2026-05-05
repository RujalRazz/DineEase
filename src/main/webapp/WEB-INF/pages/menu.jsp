<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.Restaurant"%>
<%@ page import="com.rujal.model.MenuItem"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<meta charset="UTF-8">
<title>Menu</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css" />
<style>
.page-layout {
	display: flex;
	gap: 24px;
	max-width: 1200px;
	margin: 40px auto;
	padding: 0 40px 80px;
	align-items: flex-start;
}

.menu-content {
	flex: 1;
}

.restaurant-info {
	background: #fff;
	border-radius: 16px;
	padding: 20px 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
	margin-bottom: 28px;
	display: flex;
	align-items: center;
	gap: 16px;
}

.restaurant-img {
	width: 64px;
	height: 64px;
	border-radius: 12px;
	object-fit: cover;
	flex-shrink: 0;
}

.restaurant-name {
	font-size: 17px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 4px;
}

.restaurant-address {
	font-size: 12px;
	color: #999;
}

.restaurant-rating {
	font-size: 12px;
	color: #f39c12;
	font-weight: 600;
	margin-top: 3px;
}

.category-section {
	margin-bottom: 36px;
}

.category-title {
	font-size: 16px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 16px;
	padding-bottom: 10px;
	border-bottom: 2px solid #f0e8e4;
	display: flex;
	align-items: center;
	gap: 8px;
}

.category-icon {
	font-size: 18px;
}

.menu-item {
	background: #fff;
	border-radius: 14px;
	padding: 16px;
	margin-bottom: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	display: flex;
	gap: 16px;
	align-items: center;
	transition: box-shadow 0.2s;
}

.menu-item:hover {
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.menu-item-img {
	width: 80px;
	height: 80px;
	border-radius: 10px;
	object-fit: cover;
	flex-shrink: 0;
}

.menu-item-info {
	flex: 1;
}

.menu-item-name {
	font-size: 15px;
	font-weight: 600;
	color: #2c1a10;
	margin-bottom: 4px;
}

.menu-item-desc {
	font-size: 12px;
	color: #aaa;
	margin-bottom: 8px;
	line-height: 1.5;
}

.menu-item-price {
	font-size: 15px;
	font-weight: 700;
	color: #c0392b;
}

.cart-controls {
	display: flex;
	align-items: center;
	gap: 10px;
	flex-shrink: 0;
}

.qty-btn {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	border: 1.5px solid #e8e0dc;
	background: #fff;
	font-size: 16px;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.2s;
	color: #555;
}

.qty-btn:hover {
	border-color: #c0392b;
	color: #c0392b;
}

.qty-display {
	font-size: 15px;
	font-weight: 700;
	color: #2c1a10;
	min-width: 20px;
	text-align: center;
}

.cart-sidebar {
	width: 320px;
	flex-shrink: 0;
	position: sticky;
	top: 24px;
}

.cart-card {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
}

.cart-title {
	font-size: 16px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 16px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.cart-count {
	background: #c0392b;
	color: #fff;
	font-size: 11px;
	font-weight: 700;
	width: 22px;
	height: 22px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.cart-empty {
	text-align: center;
	padding: 32px 0;
	color: #bbb;
	font-size: 13px;
}

.cart-empty-icon {
	font-size: 36px;
	margin-bottom: 8px;
}

.cart-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	border-bottom: 1px solid #f5f0ec;
	font-size: 13px;
}

.cart-item:last-child {
	border-bottom: none;
}

.cart-item-name {
	color: #2c1a10;
	font-weight: 500;
	flex: 1;
}

.cart-item-qty {
	color: #aaa;
	margin: 0 8px;
}

.cart-item-price {
	color: #c0392b;
	font-weight: 600;
}

.cart-divider {
	height: 1px;
	background: #f0e8e4;
	margin: 16px 0;
}

.cart-total {
	display: flex;
	justify-content: space-between;
	font-size: 15px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 16px;
}

.btn-order {
	width: 100%;
	padding: 13px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: opacity 0.2s;
}

.btn-order:hover {
	opacity: 0.9;
}

.btn-order:disabled {
	background: #e0e0e0;
	color: #aaa;
	cursor: not-allowed;
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
	Map<String, List<MenuItem>> menu = (Map<String, List<MenuItem>>) request.getAttribute("menu");

	// Category icons
	java.util.Map<String, String> categoryIcons = new java.util.LinkedHashMap<>();
	categoryIcons.put("Starters", "🥗");
	categoryIcons.put("Main Course", "🍛");
	categoryIcons.put("Desserts", "🍰");
	categoryIcons.put("Beverages", "🥤");
	%>

	<div class="page-layout">
		<div class="menu-content">
			<div class="restaurant-info">
				<img class="restaurant-img"
					src="<%=restaurant.getImageUrl() != null
		? restaurant.getImageUrl()
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


			<%
			if (menu != null && !menu.isEmpty()) {
				for (Map.Entry<String, List<MenuItem>> entry : menu.entrySet()) {
					String category = entry.getKey();
					List<MenuItem> items = entry.getValue();
					String icon = categoryIcons.getOrDefault(category, "🍽️");
			%>
			<div class="category-section">
				<div class="category-title">
					<span class="category-icon"><%=icon%></span>
					<%=category%>
				</div>

				<%
				for (MenuItem item : items) {
				%>
				<div class="menu-item" id="item-<%=item.getItemId()%>">
					<img class="menu-item-img"
						src="<%=item.getImageUrl() != null
		? item.getImageUrl()
		: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200&q=80"%>"
						alt="<%=item.getName()%>">
					<div class="menu-item-info">
						<div class="menu-item-name"><%=item.getName()%></div>
						<div class="menu-item-desc"><%=item.getDescription()%></div>
						<div class="menu-item-price">
							Rs.
							<%=String.format("%.0f", item.getPrice())%>
						</div>
					</div>

					<div class="cart-controls">
						<button class="qty-btn"
							onclick="updateCart(<%=item.getItemId()%>,
                                    '<%=item.getName().replace("'", "\\'")%>',
                                    <%=item.getPrice()%>, -1)">−</button>
						<span class="qty-display" id="qty-<%=item.getItemId()%>">0</span>
						<button class="qty-btn"
							onclick="updateCart(<%=item.getItemId()%>,
                                    '<%=item.getName().replace("'", "\\'")%>',
                                    <%=item.getPrice()%>, 1)">+</button>
					</div>
				</div>
				<%
				}
				%>
			</div>
			<%
			}
			}
			%>

		</div>


		<div class="cart-sidebar">
			<div class="cart-card">
				<div class="cart-title">
					Your Order <span class="cart-count" id="sidebar-cart-count">0</span>
				</div>

				<div id="sidebar-cart-items">
					<div class="cart-empty" id="cart-empty">
						<div class="cart-empty-icon">&#128722;</div>
						Add items to get started
					</div>
				</div>

				<div class="cart-divider"></div>
				<div class="cart-total">
					<span>Total</span> <span id="cart-total">Rs. 0</span>
				</div>

				<form action="${pageContext.request.contextPath}/order"
					method="post" id="orderForm">
					<input type="hidden" name="restaurant_id"
						value="<%=restaurant.getRestaurantId()%>" /> <input type="hidden"
						name="total_amount" id="form-total" value="0" />

					<div id="cart-form-fields"></div>
					<button type="submit" class="btn-order" id="btn-place-order"
						disabled>Place Order &#8594;</button>
				</form>

			</div>
		</div>

	</div>

	<jsp:include page="/WEB-INF/components/footer.jsp" />

	<script>
    // ── Cart state ──
    // Stores { itemId: { name, price, quantity } }
    const cart = {};

    /**
     * updateCart — adds or removes an item from the cart.
     * Called by + and - buttons on each menu item.
     */
    function updateCart(itemId, name, price, change) {
        if (!cart[itemId]) {
            cart[itemId] = { name, price, quantity: 0 };
        }

        cart[itemId].quantity += change;

        // Remove item from cart if quantity reaches 0
        if (cart[itemId].quantity <= 0) {
            cart[itemId].quantity = 0;
        }

        // Update quantity display next to + - buttons
        document.getElementById('qty-' + itemId).textContent =
            cart[itemId].quantity;

        // Re-render the cart sidebar
        renderCart();
    }

    /**
     * renderCart — updates the cart sidebar UI
     * and rebuilds hidden form fields for order submission.
     */
    function renderCart() {
    	 const cartItemsEl = document.getElementById('sidebar-cart-items');
    	 const cartCountEl = document.getElementById('sidebar-cart-count');
        const cartEmptyEl = document.getElementById('cart-empty');
        const cartTotalEl = document.getElementById('cart-total');
        const formTotalEl = document.getElementById('form-total');
        const formFieldsEl = document.getElementById('cart-form-fields');
        const btnOrderEl = document.getElementById('btn-place-order');

        let totalItems = 0;
        let totalAmount = 0;
        let cartHTML = '';
        let formFieldsHTML = '';

    
        for (const [itemId, item] of Object.entries(cart)) {
            if (item.quantity > 0) {
                const subTotal = item.price * item.quantity;
                totalItems += item.quantity;
                totalAmount += subTotal;

           
                cartHTML += '<div class="cart-item">' +
                                '<span class="cart-item-name">' + item.name + '</span>' +
                                '<span class="cart-item-qty">x' + item.quantity + '</span>' +
                                '<span class="cart-item-price">Rs. ' + subTotal.toFixed(0) + '</span>' +
                            '</div>';

         
                formFieldsHTML += '<input type="hidden" name="item_id" value="' + itemId + '"/>' +
                                  '<input type="hidden" name="quantity" value="' + item.quantity + '"/>' +
                                  '<input type="hidden" name="sub_total" value="' + subTotal.toFixed(2) + '"/>';
            }
        }

        if (totalItems === 0) {
            cartItemsEl.innerHTML = `
                <div class="cart-empty" id="cart-empty">
                    <div class="cart-empty-icon">&#128722;</div>
                    Add items to get started
                </div>`;
            btnOrderEl.disabled = true;
        } else {
            cartItemsEl.innerHTML = cartHTML;
            btnOrderEl.disabled = false;
        }

        cartCountEl.textContent = totalItems;
        cartTotalEl.textContent = 'Rs. ' + totalAmount.toFixed(0);
        formTotalEl.value = totalAmount.toFixed(2);
        formFieldsEl.innerHTML = formFieldsHTML;
    }
</script>

</body>
</html>