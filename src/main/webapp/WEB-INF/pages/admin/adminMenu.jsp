<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.MenuItem"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu Mangement</title>
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

.td-price {
	font-weight: 700;
	color: #c0392b;
}

.cat-badge {
	display: inline-block;
	padding: 3px 10px;
	border-radius: 50px;
	font-size: 10px;
	font-weight: 700;
}

.cat-starters {
	background: #fdf3e3;
	color: #e67e22;
}

.cat-main {
	background: #e8f5f0;
	color: #27ae60;
}

.cat-desserts {
	background: #fce8e4;
	color: #c0392b;
}

.cat-beverages {
	background: #e8f0fc;
	color: #2980b9;
}

.avail-yes {
	color: #27ae60;
	font-weight: 600;
}

.avail-no {
	color: #c0392b;
	font-weight: 600;
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

/* ── Modal ── */
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
	max-width: 540px;
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
	min-height: 72px;
}

.checkbox-row {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 20px;
}

.checkbox-row input[type="checkbox"] {
	width: 16px;
	height: 16px;
	accent-color: #c0392b;
	cursor: pointer;
}

.checkbox-row label {
	font-size: 13px;
	color: #444;
	font-weight: 500;
	cursor: pointer;
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
	margin-top: 4px;
}

.btn-submit:hover {
	opacity: 0.9;
}

.delete-modal {
	background: #fff;
	border-radius: 20px;
	padding: 36px;
	width: 90%;
	max-width: 380px;
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
</head>
<body>
	<%
	request.setAttribute("activeAdmin", "menu");
	%>
	<jsp:include page="/WEB-INF/components/adminNavBar.jsp" />

	<%
	List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
	String successMessage = (String) request.getAttribute("successMessage");
	String errorMessage = (String) request.getAttribute("errorMessage");
	%>

	<main class="admin-main">

		<div class="admin-topbar">
			<div class="topbar-left">
				<h1>Manage Menu</h1>
				<p>Add, edit or remove menu items</p>
			</div>
			<button class="btn-add" onclick="openAddModal()">&#43; Add
				Menu Item</button>
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
		<div class="filter-toolbar">
			<input type="text" id="searchInput" class="filter-input"
				placeholder="&#128269; Search menu items..." /> <select
				id="categoryFilter" class="filter-select">
				<option value="all">All Categories</option>
				<%
				List<String> categories = (List<String>) request.getAttribute("categories");
				if (categories != null) {
					for (String cat : categories) {
				%>
				<option value="<%=cat.toLowerCase()%>"><%=cat%></option>
				<%
				}
				}
				%>
			</select>
		</div>
		<div class="table-card">
			<table id="dataTable">
				<thead>
					<tr>
						<th data-col="0" data-type="number">#</th>
						<th data-col="1">Name</th>
						<th data-col="2">Category</th>
						<th data-col="3" data-type="number">Price</th>
						<th data-col="4">Description</th>
						<th data-col="5">Available</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (menuItems == null || menuItems.isEmpty()) {
					%>
					<tr>
						<td colspan="7"
							style="text-align: center; padding: 40px; color: #bbb;">No
							menu items found.</td>
					</tr>
					<%
					} else {
					for (MenuItem item : menuItems) {
						String catClass = "";
						switch (item.getCategory()) {
							case "Starters" :
						catClass = "cat-starters";
						break;
							case "Main Course" :
						catClass = "cat-main";
						break;
							case "Desserts" :
						catClass = "cat-desserts";
						break;
							case "Beverages" :
						catClass = "cat-beverages";
						break;
						}
					%>
					<%-- data-category used by JS category filter --%>
					<tr data-category="<%=item.getCategory().toLowerCase()%>">
						<td><%=item.getItemId()%></td>
						<td class="td-name"><%=item.getName()%></td>
						<td><span class="cat-badge <%=catClass%>"> <%=item.getCategory()%>
						</span></td>
						<td class="td-price">Rs. <%=String.format("%.0f", item.getPrice())%>
						</td>
						<td
							style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
							<%=item.getDescription() != null ? item.getDescription() : "—"%>
						</td>
						<td><span
							class="<%=item.isAvailable() ? "avail-yes" : "avail-no"%>">
								<%=item.isAvailable() ? "&#10003; Yes" : "&#10005; No"%>
						</span></td>
						<td>
							<div class="action-btns">
								<button class="btn-edit"
									onclick="openEditModal(
                            <%=item.getItemId()%>,
                            '<%=item.getName().replace("'", "\\'")%>',
                            '<%=item.getDescription() != null ? item.getDescription().replace("'", "\\'") : ""%>',
                            <%=item.getPrice()%>,
                            '<%=item.getCategory()%>',
                            '<%=item.getImageUrl() != null ? item.getImageUrl().replace("'", "\\'") : ""%>',
                            <%=item.isAvailable()%>
                        )">Edit</button>
								<button class="btn-delete"
									onclick="openDeleteModal(
                            <%=item.getItemId()%>,
                            '<%=item.getName().replace("'", "\\'")%>'
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
				<div class="modal-title">Add New Menu Item</div>
				<button class="modal-close" onclick="closeModal('addModal')">&#10005;</button>
			</div>
			<form action="${pageContext.request.contextPath}/adminMenu"
				method="post">
				<input type="hidden" name="action" value="add" />

				<div class="form-row">
					<div class="form-group">
						<label>Item Name</label> <input type="text" name="name"
							placeholder="e.g. Momo Platter" required />
					</div>
					<div class="form-group">
						<label>Category</label> <select name="category" required>
							<option value="">Select Category</option>
							<option value="Starters">Starters</option>
							<option value="Main Course">Main Course</option>
							<option value="Desserts">Desserts</option>
							<option value="Beverages">Beverages</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label>Price (Rs.)</label> <input type="number" name="price"
						step="0.01" min="0" placeholder="e.g. 250" required />
				</div>

				<div class="form-group">
					<label>Description</label>
					<textarea name="description"
						placeholder="Short description of the item..."></textarea>
				</div>

				<div class="form-group">
					<label>Image URL</label> <input type="text" name="image_url"
						placeholder="https://images.unsplash.com/..." />
				</div>

				<div class="checkbox-row">
					<input type="checkbox" id="add-available" name="is_available"
						checked /> <label for="add-available">Available for
						ordering</label>
				</div>

				<button type="submit" class="btn-submit">Add Menu Item</button>
			</form>
		</div>
	</div>
	<div class="modal-overlay" id="editModal">
		<div class="modal">
			<div class="modal-header">
				<div class="modal-title">Edit Menu Item</div>
				<button class="modal-close" onclick="closeModal('editModal')">&#10005;</button>
			</div>
			<form action="${pageContext.request.contextPath}/adminMenu"
				method="post">
				<input type="hidden" name="action" value="edit" /> <input
					type="hidden" name="item_id" id="edit-id" />

				<div class="form-row">
					<div class="form-group">
						<label>Item Name</label> <input type="text" name="name"
							id="edit-name" required />
					</div>
					<div class="form-group">
						<label>Category</label> <select name="category" id="edit-category"
							required>
							<option value="Starters">Starters</option>
							<option value="Main Course">Main Course</option>
							<option value="Desserts">Desserts</option>
							<option value="Beverages">Beverages</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label>Price (Rs.)</label> <input type="number" name="price"
						id="edit-price" step="0.01" min="0" required />
				</div>

				<div class="form-group">
					<label>Description</label>
					<textarea name="description" id="edit-description"></textarea>
				</div>

				<div class="form-group">
					<label>Image URL</label> <input type="text" name="image_url"
						id="edit-image" />
				</div>

				<div class="checkbox-row">
					<input type="checkbox" id="edit-available" name="is_available" />
					<label for="edit-available">Available for ordering</label>
				</div>

				<button type="submit" class="btn-submit">Save Changes</button>
			</form>
		</div>
	</div>
	<div class="modal-overlay" id="deleteModal">
		<div class="delete-modal">
			<div class="delete-icon">&#128465;</div>
			<h3>Delete Menu Item?</h3>
			<p id="delete-message">Are you sure? This action cannot be
				undone.</p>
			<form action="${pageContext.request.contextPath}/adminMenu"
				method="post">
				<input type="hidden" name="action" value="delete" /> <input
					type="hidden" name="item_id" id="delete-id" />
				<div class="delete-btns">
					<button type="submit" class="btn-confirm-delete">Yes,
						Delete</button>
					<button type="button" class="btn-cancel"
						onclick="closeModal('deleteModal')">Cancel</button>
				</div>
			</form>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/js/adminTable.js"></script>
	<script>
	 initCombinedFilter({
	        searchId:     'searchInput',
	        citySelectId: 'categoryFilter',
	        tableId:      'dataTable'
	    });

	    document.getElementById('categoryFilter')
	        ?.addEventListener('change', function() {
	            const val   = this.value.toLowerCase();
	            const rows  = document.querySelectorAll('#dataTable tbody tr');
	            rows.forEach(row => {
	                const cat = (row.getAttribute('data-category') || '').toLowerCase();
	                row.style.display = (!val || val === 'all' || cat === val) ? '' : 'none';
	            });
	        });

	    initColumnSort('dataTable');
    function openAddModal() {
        document.getElementById('addModal').classList.add('show');
    }

    function openEditModal(id, name, description, price, category, imageUrl, isAvailable) {
        document.getElementById('edit-id').value          = id;
        document.getElementById('edit-name').value        = name;
        document.getElementById('edit-description').value = description;
        document.getElementById('edit-price').value       = price;
        document.getElementById('edit-category').value    = category;
        document.getElementById('edit-image').value       = imageUrl;
        document.getElementById('edit-available').checked = isAvailable;
        document.getElementById('editModal').classList.add('show');
    }

    function openDeleteModal(id, name) {
        document.getElementById('delete-id').value = id;
        document.getElementById('delete-message').innerHTML =
            'Are you sure you want to delete <strong>' + name +
            '</strong>? This action cannot be undone.';
        document.getElementById('deleteModal').classList.add('show');
    }

    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('show');
    }

    document.querySelectorAll('.modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', function(e) {
            if (e.target === this) this.classList.remove('show');
        });
    });
</script>

</body>
</html>