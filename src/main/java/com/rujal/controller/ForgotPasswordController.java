package com.rujal.controller;

import com.rujal.dao.UserDao;
import com.rujal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class ForgotPasswordController
 */
@WebServlet({ "/forgotPassword", "/resetPassword" })
public class ForgotPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao = new UserDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ForgotPasswordController() {
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
		String path = request.getServletPath();

		if ("/forgotPassword".equals(path)) {

			request.getRequestDispatcher("/WEB-INF/pages/forgotPassword.jsp").forward(request, response);

		} else if ("/resetPassword".equals(path)) {

			HttpSession session = request.getSession(false);

			if (session == null || session.getAttribute("resetEmail") == null) {

				response.sendRedirect(request.getContextPath() + "/forgotPassword");
				return;
			}

			request.setAttribute("resetEmail", session.getAttribute("resetEmail"));
			request.getRequestDispatcher("/WEB-INF/pages/resetPassword.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String path = request.getServletPath();

		if ("/forgotPassword".equals(path)) {

			handleEmailVerification(request, response);

		} else if ("/resetPassword".equals(path)) {

			handlePasswordReset(request, response);
		}
	}

	private void handleEmailVerification(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");

		// Validate email is not empty
		if (email == null || email.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter your email address.");
			request.getRequestDispatcher("/WEB-INF/pages/forgotPassword.jsp").forward(request, response);
			return;
		}

		// Check if email exists in database
		User user = userDao.getUserByEmail(email.trim());

		if (user == null) {
			// Email not found
			request.setAttribute("errorMessage", "No account found with that email address.");
			request.getRequestDispatcher("/WEB-INF/pages/forgotPassword.jsp").forward(request, response);
			return;
		}

		// Email verified — store in session and redirect to reset page
		HttpSession session = request.getSession();
		session.setAttribute("resetEmail", email.trim());

		response.sendRedirect(request.getContextPath() + "/resetPassword");
	}

	private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Verify session still has the reset email
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("resetEmail") == null) {
			response.sendRedirect(request.getContextPath() + "/forgotPassword");
			return;
		}

		String email = (String) session.getAttribute("resetEmail");
		String newPassword = request.getParameter("new_password");
		String confirmPassword = request.getParameter("confirm_password");

		// Validate fields are not empty
		if (newPassword == null || newPassword.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Please enter a new password.");
			request.setAttribute("resetEmail", email);
			request.getRequestDispatcher("/WEB-INF/pages/resetPassword.jsp").forward(request, response);
			return;
		}

		// Validate minimum password length
		if (newPassword.length() < 6) {
			request.setAttribute("errorMessage", "Password must be at least 6 characters.");
			request.setAttribute("resetEmail", email);
			request.getRequestDispatcher("/WEB-INF/pages/resetPassword.jsp").forward(request, response);
			return;
		}

		// Validate passwords match
		if (!newPassword.equals(confirmPassword)) {
			request.setAttribute("errorMessage", "Passwords do not match. Please try again.");
			request.setAttribute("resetEmail", email);
			request.getRequestDispatcher("/WEB-INF/pages/resetPassword.jsp").forward(request, response);
			return;
		}

		// Update password in database
		boolean success = userDao.updatePassword(email, newPassword);

		if (success) {
			// Clear reset session attribute
			session.removeAttribute("resetEmail");

			// Redirect to login with success message
			response.sendRedirect(request.getContextPath()
					+ "/login?message=Password+reset+successful!+Please+login+with+your+new+password.");
		} else {
			request.setAttribute("errorMessage", "Failed to reset password. Please try again.");
			request.setAttribute("resetEmail", email);
			request.getRequestDispatcher("/WEB-INF/pages/resetPassword.jsp").forward(request, response);
		}
	}

}
