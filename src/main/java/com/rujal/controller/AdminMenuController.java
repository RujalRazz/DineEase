package com.rujal.controller;

import com.rujal.dao.MenuItemDao;
import com.rujal.model.MenuItem;
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

		// Fetch all menu items
		List<MenuItem> menuItems = menuItemDao.getAllMenuItems();
		List<String> categories = menuItemDao.getDistinctCategories();
		request.setAttribute("categories", categories);
		request.setAttribute("menuItems", menuItems);
		request.setAttribute("activeAdmin", "menu");

		// Read and clear flash messages
		request.setAttribute("successMessage", session.getAttribute("successMessage"));
		request.setAttribute("errorMessage", session.getAttribute("errorMessage"));
		session.removeAttribute("successMessage");
		session.removeAttribute("errorMessage");

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
