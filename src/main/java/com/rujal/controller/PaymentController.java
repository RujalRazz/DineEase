package com.rujal.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * PaymentController handles the dummy payment page.
 */
@WebServlet("/payment")
public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaymentController() {
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

		// Pass payment type and amount to JSP
		request.setAttribute("paymentType", request.getParameter("type"));
		request.setAttribute("referenceId",
				request.getParameter("bookingId") != null ? request.getParameter("bookingId")
						: request.getParameter("orderId"));
		request.setAttribute("amount", request.getParameter("amount"));

		request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
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

		// Get payment details for success page
		String type = request.getParameter("payment_type");
		String referenceId = request.getParameter("reference_id");
		String amount = request.getParameter("amount");

		// Clear pending session attributes
		session.removeAttribute("pendingBookingId");
		session.removeAttribute("pendingOrderId");
		session.removeAttribute("pendingAmount");

		// Redirect to success page with details
		response.sendRedirect(request.getContextPath() + "/success?type=" + type + "&referenceId=" + referenceId
				+ "&amount=" + amount);
	}

}
