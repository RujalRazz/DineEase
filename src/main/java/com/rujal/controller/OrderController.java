package com.rujal.controller;

import com.rujal.dao.MenuItemDao;
import com.rujal.dao.OrderDao;
import com.rujal.model.MenuItem;
import com.rujal.model.Order;
import com.rujal.model.OrderItem;
import com.rujal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * OrderController handles food delivery order placement.
 */
@WebServlet("/order")
public class OrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDao orderDao = new OrderDao();
	private MenuItemDao menuItemDao = new MenuItemDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderController() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Check user is logged in
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		User user = (User) session.getAttribute("user");

		// Get restaurant ID and total from form
		int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
		double totalAmount = Double.parseDouble(request.getParameter("total_amount"));

		// Build Order object
		Order order = new Order();
		order.setUserId(user.getUser_id());
		order.setRestaurantId(restaurantId);
		order.setTotalAmount(totalAmount);

		// Build OrderItems from cart form data
		// Form sends item_id[] and quantity[] arrays
		String[] itemIds = request.getParameterValues("item_id[]");
		String[] quantities = request.getParameterValues("quantity[]");
		String[] subTotals = request.getParameterValues("sub_total[]");

		List<OrderItem> items = new ArrayList<>();

		if (itemIds != null) {
			for (int i = 0; i < itemIds.length; i++) {
				OrderItem item = new OrderItem();
				item.setItemId(Integer.parseInt(itemIds[i]));
				item.setQuantity(Integer.parseInt(quantities[i]));
				item.setSubTotal(Double.parseDouble(subTotals[i]));
				items.add(item);
			}
		}

		// Save order to database
		int orderId = orderDao.createOrder(order, items);

		if (orderId > 0) {
			// Store order details in session for payment page
			session.setAttribute("pendingOrderId", orderId);
			session.setAttribute("pendingAmount", totalAmount);

			// Redirect to payment page
			response.sendRedirect(
					request.getContextPath() + "/payment?type=order&orderId=" + orderId + "&amount=" + totalAmount);
		} else {
			response.sendRedirect(
					request.getContextPath() + "/menu?restaurantId=" + restaurantId + "&error=order_failed");
		}
	}

}
