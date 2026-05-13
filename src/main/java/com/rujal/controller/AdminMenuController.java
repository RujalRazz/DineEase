package com.rujal.controller;

import com.rujal.dao.MenuItemDao;
import com.rujal.model.MenuItem;
import com.rujal.util.PaginationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * AdminMenuController handles full CRUD for menu items. Add, Edit, Delete are
 * routed via hidden "action" parameter.
 */
@WebServlet("/adminMenu")
public class AdminMenuController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MenuItemDao menuItemDao = new MenuItemDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminMenuController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Check admin session
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/adminLogin");
			return;
		}

		// ── Pagination ──
		int pageSize = PaginationUtil.ADMIN_PAGE_SIZE;
		int totalCount = menuItemDao.countAllMenuItems();
		int totalPages = PaginationUtil.getTotalPages(totalCount, pageSize);
		int currentPage = PaginationUtil.clampPage(PaginationUtil.parsePage(request.getParameter("page")), totalPages);
		int offset = PaginationUtil.getOffset(currentPage, pageSize);

		List<MenuItem> menuItems = menuItemDao.getMenuItemsPaginated(pageSize, offset);
		List<String> categories = menuItemDao.getDistinctCategories();

		String successMessage = (String) session.getAttribute("successMessage");
		String errorMessage = (String) session.getAttribute("errorMessage");
		session.removeAttribute("successMessage");
		session.removeAttribute("errorMessage");

		request.setAttribute("menuItems", menuItems);
		request.setAttribute("categories", categories);
		request.setAttribute("successMessage", successMessage);
		request.setAttribute("errorMessage", errorMessage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("activeAdmin", "menu");

		request.getRequestDispatcher("/WEB-INF/pages/admin/adminMenu.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Check admin session
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/adminLogin");
			return;
		}

		String action = request.getParameter("action");

		switch (action) {
		case "add":
			handleAdd(request, session);
			break;
		case "edit":
			handleEdit(request, session);
			break;
		case "delete":
			handleDelete(request, session);
			break;
		}

		response.sendRedirect(request.getContextPath() + "/adminMenu");
	}

	private void handleAdd(HttpServletRequest request, HttpSession session) {
		MenuItem item = buildFromRequest(request);
		boolean success = menuItemDao.addMenuItem(item);
		session.setAttribute(success ? "successMessage" : "errorMessage",
				success ? "Menu item added!" : "Failed to add menu item.");
	}

	private void handleEdit(HttpServletRequest request, HttpSession session) {
		MenuItem item = buildFromRequest(request);
		item.setItemId(Integer.parseInt(request.getParameter("item_id")));
		boolean success = menuItemDao.updateMenuItem(item);
		session.setAttribute(success ? "successMessage" : "errorMessage",
				success ? "Menu item updated!" : "Failed to update menu item.");
	}

	private void handleDelete(HttpServletRequest request, HttpSession session) {
		int itemId = Integer.parseInt(request.getParameter("item_id"));
		boolean success = menuItemDao.deleteMenuItem(itemId);
		session.setAttribute(success ? "successMessage" : "errorMessage",
				success ? "Menu item deleted!" : "Failed to delete menu item.");
	}

	private MenuItem buildFromRequest(HttpServletRequest request) {
		MenuItem item = new MenuItem();
		item.setName(request.getParameter("name"));
		item.setDescription(request.getParameter("description"));
		item.setPrice(Double.parseDouble(request.getParameter("price")));
		item.setCategory(request.getParameter("category"));
		item.setImageUrl(request.getParameter("image_url"));
		item.setAvailable("on".equals(request.getParameter("is_available")));
		return item;
	}

}
