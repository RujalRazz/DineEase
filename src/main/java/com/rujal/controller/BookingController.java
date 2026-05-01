package com.rujal.controller;

import com.rujal.dao.BookingDao;
import com.rujal.dao.RestaurantDao;
import com.rujal.model.Booking;
import com.rujal.model.Restaurant;
import com.rujal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * BookingController handles table reservation requests.
 */
@WebServlet("/booking")
public class BookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookingDao bookingDao = new BookingDao();
	private RestaurantDao restaurantDao = new RestaurantDao();
	

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookingController() {
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

        // Get restaurant ID from URL
        String restaurantIdParam = request.getParameter("restaurantId");
        if (restaurantIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/restaurants");
            return;
        }

        // Fetch restaurant details to display on booking page
        int restaurantId = Integer.parseInt(restaurantIdParam);
        Restaurant restaurant = restaurantDao.getRestaurantById(restaurantId);

        if (restaurant == null) {
            response.sendRedirect(request.getContextPath() + "/restaurants");
            return;
        }

        request.setAttribute("restaurant", restaurant);
        request.getRequestDispatcher("/WEB-INF/pages/booking.jsp")
               .forward(request, response);
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

        // Get logged in user
        User user = (User) session.getAttribute("user");

        // Build booking from form data
        Booking booking = new Booking();
        booking.setUserId(user.getUser_id());
        booking.setRestaurantId(Integer.parseInt(request.getParameter("restaurant_id")));
        booking.setBookingDate(request.getParameter("booking_date"));
        booking.setBookingTime(request.getParameter("booking_time"));
        booking.setGuestCount(Integer.parseInt(request.getParameter("guest_count")));
        booking.setSpecialRequest(request.getParameter("special_request"));

        // Save booking to database
        int bookingId = bookingDao.createBooking(booking);

        if (bookingId > 0) {
            // Store booking ID in session for payment page
            session.setAttribute("pendingBookingId", bookingId);
            session.setAttribute("pendingAmount",
                request.getParameter("guest_count") + " guests");

            // Redirect to payment page
            response.sendRedirect(request.getContextPath() +
                "/payment?type=booking&bookingId=" + bookingId);
        } else {
            request.setAttribute("errorMessage", "Booking failed. Please try again.");
            request.setAttribute("restaurant",
                restaurantDao.getRestaurantById(
                    Integer.parseInt(request.getParameter("restaurant_id"))));
            request.getRequestDispatcher("/WEB-INF/pages/booking.jsp")
                   .forward(request, response);
        }
	}

}
