package com.rujal.controller;

import com.rujal.dao.MenuItemDao;
import com.rujal.dao.RestaurantDao;
import com.rujal.model.MenuItem;
import com.rujal.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * MenuController handles the menu page for a specific restaurant.
 */
@WebServlet("/menu")
public class MenuController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MenuItemDao menuItemDao = new MenuItemDao();
	private RestaurantDao restaurantDao = new RestaurantDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MenuController() {
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
		// Check user is logged in
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		// Get restaurant ID
		String restaurantIdParam = request.getParameter("restaurantId");
		if (restaurantIdParam == null) {
			response.sendRedirect(request.getContextPath() + "/restaurants");
			return;
		}

		int restaurantId = Integer.parseInt(restaurantIdParam);

		// Fetch restaurant and menu
		Restaurant restaurant = restaurantDao.getRestaurantById(restaurantId);
		Map<String, List<MenuItem>> menu = menuItemDao.getMenuGroupedByCategory();

		if (restaurant == null) {
			response.sendRedirect(request.getContextPath() + "/restaurants");
			return;
		}

		request.setAttribute("restaurant", restaurant);
		request.setAttribute("menu", menu);

		request.getRequestDispatcher("/WEB-INF/pages/menu.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
