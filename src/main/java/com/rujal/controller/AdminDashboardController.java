package com.rujal.controller;

import com.rujal.dao.BookingDao;
import com.rujal.dao.OrderDao;
import com.rujal.dao.RestaurantDao;
import com.rujal.dao.UserDao;
import com.rujal.model.Admin;
import com.rujal.model.Restaurant;
import com.rujal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class AdminDashboardController
 */
@WebServlet("/admin-dashboard")
public class AdminDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookingDao bookingDao = new BookingDao();
	private OrderDao orderDao = new OrderDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminDashboardController() {
		super();
		// TODO Auto-generated constructor stub
	}

	private UserDao userDao = new UserDao();
	private RestaurantDao restaurantDao = new RestaurantDao();

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
			response.sendRedirect(request.getContextPath() + "/admin-login");
			return;
		}
		int userCount = userDao.countUsers();
		int userCountThisMonth = userDao.countUsersThisMonth();
		int restaurantCount = restaurantDao.countRestaurants();
		int restaurantCountMonth = restaurantDao.countRestaurantsThisMonth();
		int bookingCount = bookingDao.countBookings();
		int bookingCountThisWeek = bookingDao.countBookingsThisWeek();
		int orderCount = orderDao.countOrders();
		int orderCountToday = orderDao.countOrdersToday();

		List<User> recentUsers = userDao.getRecentUsers();
		List<Restaurant> recentRestaurants = restaurantDao.getRecentRestaurants();

	
		request.setAttribute("userCount", userCount);
		request.setAttribute("userCountThisMonth", userCountThisMonth);
		request.setAttribute("restaurantCount", restaurantCount);
		request.setAttribute("restaurantCountMonth", restaurantCountMonth);
		request.setAttribute("bookingCount", bookingCount);
		request.setAttribute("bookingCountThisWeek", bookingCountThisWeek);
		request.setAttribute("orderCount", orderCount);
		request.setAttribute("orderCountToday", orderCountToday);
		request.setAttribute("recentUsers", recentUsers);
		request.setAttribute("recentRestaurants", recentRestaurants);
		request.setAttribute("activeAdmin", "dashboard");

		request.getRequestDispatcher("/WEB-INF/pages/admin/adminDashboard.jsp").forward(request, response);
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
