package com.rujal.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


/**
 * Servlet implementation class LogoutController
 */
@WebServlet("/logout")
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * LogoutServlet handles user logout.
	 * Invalidates the session and redirects to the login page.
	 */
    public LogoutController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * Handles GET request for logout.
     * Gets the current session, invalidates it, and redirects to login.
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);

        // Invalidate the session if it exists — removes all session attributes including "user"
        if (session != null) {
            session.invalidate();
        }

        // Redirect to login page after logout
        response.sendRedirect(request.getContextPath() + "/login");
	}
}

