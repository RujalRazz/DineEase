package com.rujal.controller;

import com.rujal.dao.BookingDao;
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
 * AdminBookingController handles admin booking management. Supports viewing all
 * bookings with details, updating status, and deleting bookings.
 */
@WebServlet("/adminBookings")
public class AdminBookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookingDao bookingDao = new BookingDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminBookingController() {
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

		int pageSize = PaginationUtil.ADMIN_PAGE_SIZE;
		int totalCount = bookingDao.countAllBookings();
		int totalPages = PaginationUtil.getTotalPages(totalCount, pageSize);
		int currentPage = PaginationUtil.clampPage(PaginationUtil.parsePage(request.getParameter("page")), totalPages);
		int offset = PaginationUtil.getOffset(currentPage, pageSize);

		List<Object[]> bookings = bookingDao.getBookingsWithDetailsPaginated(pageSize, offset);

		String successMessage = (String) session.getAttribute("successMessage");
		String errorMessage = (String) session.getAttribute("errorMessage");
		session.removeAttribute("successMessage");
		session.removeAttribute("errorMessage");

		request.setAttribute("bookings", bookings);
		request.setAttribute("successMessage", successMessage);
		request.setAttribute("errorMessage", errorMessage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("activeAdmin", "bookings");

		request.getRequestDispatcher("/WEB-INF/pages/admin/adminBookings.jsp").forward(request, response);
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
			// Update booking status
			int bookingId = Integer.parseInt(request.getParameter("booking_id"));
			String status = request.getParameter("status");
			boolean success = bookingDao.updateStatus(bookingId, status);
			session.setAttribute(success ? "successMessage" : "errorMessage",
					success ? "Booking status updated!" : "Failed to update status.");

		} else if ("delete".equals(action)) {
			// Delete booking
			int bookingId = Integer.parseInt(request.getParameter("booking_id"));
			boolean success = bookingDao.deleteBooking(bookingId);
			session.setAttribute(success ? "successMessage" : "errorMessage",
					success ? "Booking deleted!" : "Failed to delete booking.");
		}

		response.sendRedirect(request.getContextPath() + "/adminBookings");
	}

}
