<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rujal.model.Restaurant"%>
<%@ page import="com.rujal.model.City"%>
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
	vertical-align: middle;
}

.td-name {
	font-weight: 600;
	color: #2c1a10;
}

.city-img {
	width: 45px;
	height: 35px;
	object-fit: cover;
	border-radius: 6px;
	border: 1px solid #f5f0ec;
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
	max-width: 500px;
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

.form-group input {
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
	box-sizing: border-box;
}

.form-group input:focus {
	border-color: #c0392b;
	background: #fff;
}

.help-text {
	font-size: 11px;
	color: #999;
	margin-top: 4px;
	display: block;
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
</head>
<body>
	<%
	request.setAttribute("activeAdmin", "cities");
	%>
	<jsp:include page="/WEB-INF/components/adminNavBar.jsp" />

	<%
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
				<h1>Manage Cities</h1>
				<p>Add, edit or remove cities from the system</p>
			</div>
			<%-- Add City button --%>
			<button class="btn-add" onclick="openAddModal()">&#43; Add
				City</button>
		</div>

		<%-- Flash Messages --%>
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

		<%-- City Table --%>
		<div class="table-card">
			<table>
				<thead>
					<tr>
						<th>#</th>
						<th>Image</th>
						<th>City Name</th>
						<th>URL Slug</th>
						<th>Restaurants</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (cities == null || cities.isEmpty()) {
					%>
					<tr>
						<td colspan="6"
							style="text-align: center; padding: 40px; color: #bbb;">No
							cities found. Click "Add City" to get started.</td>
					</tr>
					<%
					} else {
					for (City c : cities) {
					%>
					<tr>
						<td><%=c.getCityId()%></td>
						<td><img src="<%=c.getImageUrl()%>"
							alt="<%=c.getCityName()%>" class="city-img"
							onerror="this.src='https://via.placeholder.com/45x35?text=Img'"></td>
						<td class="td-name"><%=c.getCityName()%></td>
						<td><%=c.getCityValue()%></td>
						<td><%=c.getRestaurantCount()%></td>
						<td>
							<div class="action-btns">
								<%-- Edit button --%>
								<button class="btn-edit"
									onclick="openEditModal(
                                    <%=c.getCityId()%>,
                                    '<%=c.getCityName().replace("'", "\\'")%>',
                                    '<%=c.getCityValue()%>',
                                    '<%=c.getImageUrl() != null ? c.getImageUrl().replace("'", "\\'") : ""%>'
                                )">Edit</button>

								<%-- Delete button --%>
								<button class="btn-delete"
									onclick="openDeleteModal(
                                    <%=c.getCityId()%>,
                                    '<%=c.getCityName().replace("'", "\\'")%>'
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

	<%-- Add City Modal --%>
	<div class="modal-overlay" id="addModal">
		<div class="modal">
			<div class="modal-header">
				<div class="modal-title">Add New City</div>
				<button class="modal-close" onclick="closeModal('addModal')">&#10005;</button>
			</div>

			<form action="${pageContext.request.contextPath}/adminCity"
				method="post">
				<input type="hidden" name="action" value="add" />

				<div class="form-group">
					<label>City Name</label> <input type="text" name="city_name"
						placeholder="e.g. Kathmandu" required />
				</div>

				<div class="form-group">
					<label>URL Slug (City Value)</label> <input type="text"
						name="city_value" placeholder="e.g. kathmandu" required /> <span
						class="help-text">Lowercase, no spaces. Used in the web
						URL.</span>
				</div>

				<div class="form-group">
					<label>Image URL</label> <input type="text" name="image_url"
						placeholder="https://images.unsplash.com/..." required />
				</div>

				<button type="submit" class="btn-submit">Add City</button>
			</form>
		</div>
	</div>

	<%-- Edit City Modal --%>
	<div class="modal-overlay" id="editModal">
		<div class="modal">
			<div class="modal-header">
				<div class="modal-title">Edit City</div>
				<button class="modal-close" onclick="closeModal('editModal')">&#10005;</button>
			</div>

			<form action="${pageContext.request.contextPath}/adminCity"
				method="post">
				<input type="hidden" name="action" value="update" /> <input
					type="hidden" name="city_id" id="edit-id" />

				<div class="form-group">
					<label>City Name</label> <input type="text" name="city_name"
						id="edit-name" required />
				</div>

				<div class="form-group">
					<label>URL Slug (City Value)</label> <input type="text"
						name="city_value" id="edit-value" required /> <span
						class="help-text">Warning: Changing this might alter active
						links to this city.</span>
				</div>

				<div class="form-group">
					<label>Image URL</label> <input type="text" name="image_url"
						id="edit-image" required />
				</div>

				<button type="submit" class="btn-submit">Save Changes</button>
			</form>
		</div>
	</div>

	<%-- Delete City Modal --%>
	<div class="modal-overlay" id="deleteModal">
		<div class="delete-modal">
			<div class="delete-icon">&#128465;</div>
			<h3>Delete City?</h3>
			<p id="delete-message">
				Are you sure you want to delete this city?<br>You can only do
				this if no restaurants are currently assigned to it.
			</p>
			<div class="delete-btns">
				<form action="${pageContext.request.contextPath}/adminCity"
					method="post">
					<input type="hidden" name="action" value="delete" /> <input
						type="hidden" name="city_id" id="delete-id" />
					<div class="delete-btns" style="width: 100%;">
						<button type="submit" class="btn-confirm-delete">Yes,
							Delete</button>
						<button type="button" class="btn-cancel"
							onclick="closeModal('deleteModal')">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
    function openAddModal() {
        document.getElementById('addModal').classList.add('show');
    }

    // Populate data and open the edit modal
    function openEditModal(id, name, value, imageUrl) {
        document.getElementById('edit-id').value    = id;
        document.getElementById('edit-name').value  = name;
        document.getElementById('edit-value').value = value;
        document.getElementById('edit-image').value = imageUrl;

        document.getElementById('editModal').classList.add('show');
    }

    // Pass data to the delete confirmation modal
    function openDeleteModal(id, name) {
        document.getElementById('delete-id').value = id;
        document.getElementById('delete-message').innerHTML =
            'Are you sure you want to delete <strong>' + name +
            '</strong>?<br>You can only do this if no restaurants are currently assigned to it.';
        document.getElementById('deleteModal').classList.add('show');
    }

    function closeModal(modalId) {
        document.getElementById(modalId).classList.remove('show');
    }

    // Close modals when clicking on the outside background overlay
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