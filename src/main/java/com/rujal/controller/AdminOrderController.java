package com.rujal.controller;

import com.rujal.dao.OrderDao;
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
 * AdminOrderController handles admin order management. Supports viewing all
 * orders with details, updating status, and deleting orders.
 */
@WebServlet("/adminOrders")
public class AdminOrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDao orderDao = new OrderDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminOrderController() {
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

        // Fetch all orders with user and restaurant names
        List<Object[]> orders = orderDao.getAllOrdersWithDetails();
        request.setAttribute("orders", orders);
        request.setAttribute("activeAdmin", "orders");

        // Read and clear flash messages
        request.setAttribute("successMessage",
            session.getAttribute("successMessage"));
        request.setAttribute("errorMessage",
            session.getAttribute("errorMessage"));
        session.removeAttribute("successMessage");
        session.removeAttribute("errorMessage");

        request.getRequestDispatcher("/WEB-INF/pages/admin/adminOrders.jsp")
               .forward(request, response);
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

        if ("updateStatus".equals(action)) {
            // Update order status
            int orderId = Integer.parseInt(request.getParameter("order_id"));
            String status = request.getParameter("status");
            boolean success = orderDao.updateStatus(orderId, status);
            session.setAttribute(success ? "successMessage" : "errorMessage",
                success ? "Order status updated!" : "Failed to update status.");

        } else if ("delete".equals(action)) {
            // Delete order and its items
            int orderId = Integer.parseInt(request.getParameter("order_id"));
            boolean success = orderDao.deleteOrder(orderId);
            session.setAttribute(success ? "successMessage" : "errorMessage",
                success ? "Order deleted!" : "Failed to delete order.");
        }

        response.sendRedirect(request.getContextPath() + "/adminOrders");
	}

}
