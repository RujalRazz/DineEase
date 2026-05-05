<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.Restaurant"%>
<%@ page import="com.rujal.model.City"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Management</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css" />
</head>
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

.btn-add {
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	padding: 11px 22px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	text-decoration: none;
	display: flex;
	align-items: center;
	gap: 8px;
	transition: opacity 0.2s;
}

.btn-add:hover {
	opacity: 0.9;
}

.flash-success {
	background: #e8f5f0;
	border: 1px solid #b7ebc8;
	color: #276749;
	border-radius: 10px;
	padding: 12px 18px;
	font-size: 13px;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.flash-error {
	background: #fff0f0;
	border: 1px solid #f5c6c6;
	color: #c0392b;
	border-radius: 10px;
	padding: 12px 18px;
	font-size: 13px;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.filter-toolbar {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 20px;
	flex-wrap: wrap;
}

.filter-input {
	padding: 9px 14px;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	font-size: 13px;
	outline: none;
	font-family: 'Segoe UI', sans-serif;
	color: #2c1a10;
	background: #fff;
	transition: border-color 0.2s;
	min-width: 200px;
}

.filter-input:focus {
	border-color: #c0392b;
}

.filter-select {
	padding: 9px 32px 9px 14px;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	font-size: 13px;
	outline: none;
	font-family: 'Segoe UI', sans-serif;
	color: #2c1a10;
	background: #fff;
	cursor: pointer;
	appearance: none;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23c0392b' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 12px center;
	transition: border-color 0.2s;
}

.filter-select:focus {
	border-color: #c0392b;
}

.btn-clear-date {
	padding: 9px 16px;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	background: #fff;
	color: #999;
	font-size: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
}

.btn-clear-date:hover {
	border-color: #c0392b;
	color: #c0392b;
}

thead th[data-col] {
	cursor: pointer;
	user-select: none;
	white-space: nowrap;
}

thead th[data-col]:hover {
	color: #c0392b;
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
	padding: 14px 0;
	font-size: 13px;
	color: #444;
	padding-right: 16px;
}

.td-name {
	font-weight: 600;
	color: #2c1a10;
}

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

.badge {
	display: inline-block;
	padding: 3px 10px;
	border-radius: 50px;
	font-size: 10px;
	font-weight: 700;
	letter-spacing: 0.5px;
}

.badge-trending {
	background: #fce8e4;
	color: #c0392b;
}

.badge-chef {
	background: #e8f5f4;
	color: #2a9d8f;
}

.badge-none {
	background: #f5f5f5;
	color: #bbb;
}

.action-btns {
	display: flex;
	gap: 8px;
}

.btn-edit {
	padding: 6px 14px;
	border: 1.5px solid #c0392b;
	border-radius: 50px;
	background: #fff;
	color: #c0392b;
	font-size: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
}

.btn-edit:hover {
	background: #c0392b;
	color: #fff;
}

.btn-delete {
	padding: 6px 14px;
	border: 1.5px solid #e8e0dc;
	border-radius: 50px;
	background: #fff;
	color: #999;
	font-size: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
}

.btn-delete:hover {
	background: #fce8e4;
	border-color: #c0392b;
	color: #c0392b;
}

.modal-overlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, 0.5);
	z-index: 999;
	align-items: center;
	justify-content: center;
}

.modal-overlay.show {
	display: flex;
}

.modal {
	background: #fff;
	border-radius: 20px;
	padding: 36px;
	width: 90%;
	max-width: 580px;
	max-height: 90vh;
	overflow-y: auto;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
}

.modal-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 24px;
}

.modal-title {
	font-size: 18px;
	font-weight: 700;
	color: #2c1a10;
}

.modal-close {
	width: 32px;
	height: 32px;
	border-radius: 50%;
	border: none;
	background: #f5f5f5;
	font-size: 16px;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #555;
}

.modal-close:hover {
	background: #eee;
}

.form-row {
	display: flex;
	gap: 16px;
	margin-bottom: 18px;
}

.form-row .form-group {
	flex: 1;
}

.form-group {
	margin-bottom: 18px;
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
	padding: 11px 14px;
	border: 1.5px solid #e8e0dc;
	border-radius: 10px;
	font-size: 13px;
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
	padding: 13px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: opacity 0.2s;
	margin-top: 8px;
}

.btn-submit:hover {
	opacity: 0.9;
}

.delete-modal {
	background: #fff;
	border-radius: 20px;
	padding: 36px;
	width: 90%;
	max-width: 400px;
	text-align: center;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
}

.delete-icon {
	font-size: 40px;
	margin-bottom: 16px;
}

.delete-modal h3 {
	font-size: 18px;
	font-weight: 700;
	color: #2c1a10;
	margin-bottom: 8px;
}

.delete-modal p {
	font-size: 13px;
	color: #aaa;
	margin-bottom: 24px;
	line-height: 1.6;
}

.delete-btns {
	display: flex;
	gap: 12px;
}

.btn-confirm-delete {
	flex: 1;
	padding: 12px;
	background: linear-gradient(135deg, #c0392b, #e05a3a);
	color: #fff;
	border: none;
	border-radius: 50px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
}

.btn-cancel {
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

.btn-cancel:hover {
	background: #eee;
}
</style>
<body>
	<%
	request.setAttribute("activeAdmin", "restaurants");
	%>
	<jsp:include page="/WEB-INF/components/adminNavBar.jsp" />
	<%
	List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
	List<City> cities = (List<City>) request.getAttribute("cities");

	String successMessage = (String) session.getAttribute("successMessage");
	String errorMessage = (String) session.getAttribute("errorMessage");

	session.removeAttribute("successMessage");
	session.removeAttribute("errorMessage");
	%>
	<main class="admin-main">

		<%-- Top bar --%>
		<div class="admin-topbar">
			<div class="topbar-left">
				<h1>Manage Restaurants</h1>
				<p>Add, edit or remove restaurants from the system</p>
			</div>
			<%-- Add Restaurant button — opens add modal --%>
			<button class="btn-add" onclick="openAddModal()">&#43; Add
				Restaurant</button>
		</div>

		<%-- Flash success message --%>
		<%
		if (successMessage != null) {
		%>
		<div class="flash-success">
			&#10003;
			<%=successMessage%></div>
		<%
		}
		%>

		<%-- Flash error message --%>
		<%
		if (errorMessage != null) {
		%>
		<div class="flash-error">
			&#9888;
			<%=errorMessage%></div>
		<%
		}
		%>

		<%-- Filter toolbar --%>
		<div class="filter-toolbar">

			<%-- Global search --%>
			<input type="text" id="searchInput" class="filter-input"
				placeholder="&#128269; Search restaurants..." />

			<%-- City filter — populated from database --%>
			<select id="cityFilter" class="filter-select">
				<option value="all">&#128205; All Cities</option>
				<%
				Map<Integer, String> cityFilterMap = (Map<Integer, String>) request.getAttribute("cityFilterMap");
				if (cityFilterMap != null) {
					for (Map.Entry<Integer, String> entry : cityFilterMap.entrySet()) {
				%>
				<option value="<%=entry.getValue().toLowerCase()%>">
					<%=entry.getValue()%>
				</option>
				<%
				}
				}
				%>
			</select>

		</div>

		<%-- Table — id added for JS targeting --%>
		<div class="table-card">
			<table id="dataTable">
				<thead>
					<tr>
						<%-- data-col = column index, data-type = number for numeric sort --%>
						<th data-col="0" data-type="number">#</th>
						<th data-col="1">Name</th>
						<th data-col="2">City</th>
						<th data-col="3">Address</th>
						<th data-col="4">Contact</th>
						<th data-col="5" data-type="number">Rating</th>
						<th data-col="6" data-type="number">Price</th>
						<th data-col="7">Badge</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (restaurants == null || restaurants.isEmpty()) {
					%>
					<tr>
						<td colspan="9"
							style="text-align: center; padding: 40px; color: #bbb;">No
							restaurants found.</td>
					</tr>
					<%
					} else {
					for (Restaurant r : restaurants) {
						String cityName = "—";
						if (cities != null) {
							for (City c : cities) {
						if (c.getCityId() == r.getCityId()) {
							cityName = c.getCityName();
							break;
						}
							}
						}
						String badge = r.getBadge() != null ? r.getBadge() : "none";
					%>
					<%-- data-city used by JS city filter --%>
					<tr data-city="<%=cityName.toLowerCase()%>">
						<td><%=r.getRestaurantId()%></td>
						<td class="td-name"><%=r.getName()%></td>
						<td><%=cityName%></td>
						<td><%=r.getAddress()%></td>
						<td><%=r.getContact()%></td>
						<td>&#9733; <%=r.getRating()%></td>
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
						<td><span
							class="badge <%="TRENDING".equals(badge) ? "badge-trending" : "CHEF'S CHOICE".equals(badge) ? "badge-chef" : "badge-none"%>">
								<%="none".equals(badge) ? "—" : badge%>
						</span></td>
						<td>
							<div class="action-btns">
								<button class="btn-edit"
									onclick="openEditModal(
                                <%=r.getRestaurantId()%>,
                                <%=r.getCityId()%>,
                                '<%=r.getName().replace("'", "\\'")%>',
                                '<%=r.getAddress().replace("'", "\\'")%>',
                                '<%=r.getContact().replace("'", "\\'")%>',
                                '<%=r.getDescription() != null ? r.getDescription().replace("'", "\\'") : ""%>',
                                '<%=r.getImageUrl() != null ? r.getImageUrl().replace("'", "\\'") : ""%>',
                                <%=r.getRating()%>,
                                <%=r.getPriceRange()%>,
                                '<%=badge%>'
                            )">Edit</button>
								<button class="btn-delete"
									onclick="openDeleteModal(
                                <%=r.getRestaurantId()%>,
                                '<%=r.getName().replace("'", "\\'")%>'
                            )">Delete</button>
							</div>
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
	<div class="modal-overlay" id="addModal">
		<div class="modal">
			<div class="modal-header">
				<div class="modal-title">Add New Restaurant</div>
				<button class="modal-close" onclick="closeModal('addModal')">&#10005;</button>
			</div>

			<%-- Form posts to AdminRestaurantController with action=add --%>
			<form action="${pageContext.request.contextPath}/adminRestaurants"
				method="post">
				<input type="hidden" name="action" value="add" />

				<div class="form-row">
					<div class="form-group">
						<label>Restaurant Name</label> <input type="text" name="name"
							placeholder="e.g. The Himalayan Bistro" required />
					</div>
					<div class="form-group">
						<label>City</label> <select name="city_id" required>
							<option value="">Select City</option>
							<%
							if (cities != null) {
								for (City c : cities) {
							%>
							<option value="<%=c.getCityId()%>">
								<%=c.getCityName()%>
							</option>
							<%
							}
							}
							%>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label>Address</label> <input type="text" name="address"
						placeholder="e.g. Thamel, Kathmandu" required />
				</div>

				<div class="form-row">
					<div class="form-group">
						<label>Contact</label> <input type="text" name="contact"
							placeholder="e.g. 9801234567" required />
					</div>
					<div class="form-group">
						<label>Rating (0.0 – 5.0)</label> <input type="number"
							name="rating" step="0.1" min="0" max="5" placeholder="e.g. 4.5"
							required />
					</div>
				</div>

				<div class="form-row">
					<div class="form-group">
						<label>Price Range</label> <select name="price_range" required>
							<option value="1">1 — Budget</option>
							<option value="2">2 — Mid Range</option>
							<option value="3">3 — Fine Dining</option>
						</select>
					</div>
					<div class="form-group">
						<label>Badge</label> <select name="badge">
							<option value="none">— None</option>
							<option value="TRENDING">TRENDING</option>
							<option value="CHEF'S CHOICE">CHEF'S CHOICE</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label>Image URL</label> <input type="text" name="image_url"
						placeholder="https://images.unsplash.com/..." />
				</div>

				<div class="form-group">
					<label>Description</label>
					<textarea name="description"
						placeholder="Short description of the restaurant..."></textarea>
				</div>

				<button type="submit" class="btn-submit">Add Restaurant</button>
			</form>
		</div>
	</div>
	<div class="modal-overlay" id="editModal">
		<div class="modal">
			<div class="modal-header">
				<div class="modal-title">Edit Restaurant</div>
				<button class="modal-close" onclick="closeModal('editModal')">&#10005;</button>
			</div>

			<%-- Form posts to AdminRestaurantController with action=edit --%>
			<form action="${pageContext.request.contextPath}/adminRestaurants"
				method="post">
				<input type="hidden" name="action" value="edit" /> <input
					type="hidden" name="restaurant_id" id="edit-id" />

				<div class="form-row">
					<div class="form-group">
						<label>Restaurant Name</label> <input type="text" name="name"
							id="edit-name" required />
					</div>
					<div class="form-group">
						<label>City</label> <select name="city_id" id="edit-city" required>
							<option value="">Select City</option>
							<%
							if (cities != null) {
								for (City c : cities) {
							%>
							<option value="<%=c.getCityId()%>">
								<%=c.getCityName()%>
							</option>
							<%
							}
							}
							%>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label>Address</label> <input type="text" name="address"
						id="edit-address" required />
				</div>

				<div class="form-row">
					<div class="form-group">
						<label>Contact</label> <input type="text" name="contact"
							id="edit-contact" required />
					</div>
					<div class="form-group">
						<label>Rating (0.0 – 5.0)</label> <input type="number"
							name="rating" id="edit-rating" step="0.1" min="0" max="5"
							required />
					</div>
				</div>

				<div class="form-row">
					<div class="form-group">
						<label>Price Range</label> <select name="price_range"
							id="edit-price">
							<option value="1">1 — Budget</option>
							<option value="2">2 — Mid Range</option>
							<option value="3">3 — Fine Dining</option>
						</select>
					</div>
					<div class="form-group">
						<label>Badge</label> <select name="badge" id="edit-badge">
							<option value="none">— None</option>
							<option value="TRENDING">TRENDING</option>
							<option value="CHEF'S CHOICE">CHEF'S CHOICE</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label>Image URL</label> <input type="text" name="image_url"
						id="edit-image" />
				</div>

				<div class="form-group">
					<label>Description</label>
					<textarea name="description" id="edit-description"></textarea>
				</div>

				<button type="submit" class="btn-submit">Save Changes</button>
			</form>
		</div>
	</div>
	<div class="modal-overlay" id="deleteModal">
		<div class="delete-modal">
			<div class="delete-icon">&#128465;</div>
			<h3>Delete Restaurant?</h3>
			<p id="delete-message">
				Are you sure you want to delete this restaurant?<br>This action
				cannot be undone.
			</p>
			<div class="delete-btns">
				<form action="${pageContext.request.contextPath}/adminRestaurants"
					method="post">
					<input type="hidden" name="action" value="delete" /> <input
						type="hidden" name="restaurant_id" id="delete-id" />
					<div class="delete-btns">
						<button type="submit" class="btn-confirm-delete">Yes,
							Delete</button>
						<button type="button" class="btn-cancel"
							onclick="closeModal('deleteModal')">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/js/adminTable.js"></script>
	<script>
	initCombinedFilter({
        searchId:    'searchInput',
        citySelectId: 'cityFilter',
        tableId:     'dataTable'
    });

    initColumnSort('dataTable');
    function openAddModal() {
        document.getElementById('addModal').classList.add('show');
    }

  
    function openEditModal(id, cityId, name, address, contact,
                           description, imageUrl, rating, priceRange, badge) {
        document.getElementById('edit-id').value          = id;
        document.getElementById('edit-name').value        = name;
        document.getElementById('edit-address').value     = address;
        document.getElementById('edit-contact').value     = contact;
        document.getElementById('edit-description').value = description;
        document.getElementById('edit-image').value       = imageUrl;
        document.getElementById('edit-rating').value      = rating;
        document.getElementById('edit-price').value       = priceRange;
        document.getElementById('edit-badge').value       = badge;

        document.getElementById('edit-city').value = cityId;

        document.getElementById('editModal').classList.add('show');
    }

  
    function openDeleteModal(id, name) {
        document.getElementById('delete-id').value = id;
        document.getElementById('delete-message').innerHTML =
            'Are you sure you want to delete <strong>' + name +
            '</strong>?<br>This action cannot be undone.';
        document.getElementById('deleteModal').classList.add('show');
    }


    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('show');
    }


    document.querySelectorAll('.modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', function(e) {
            if (e.target === this) {
                this.classList.remove('show');
            }
        });
    });
</script>
</body>
</html>