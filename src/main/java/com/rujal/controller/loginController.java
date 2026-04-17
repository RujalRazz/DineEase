package com.rujal.controller;

import com.rujal.model.User;
import com.rujal.service.UserService;
 
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
 * LoginServlet handles HTTP requests for user login.
 * It reads credentials from the form, validates through UserService,
 * creates a session on success, and redirects accordingly.
 */
@WebServlet("/login")
public class loginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * Handles GET requests.
     * Forwards the user to the login.jsp page.
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
		
	}

	/**
     * Handles POST requests from login.jsp form.
     * Flow:
     *   1. Get email and password from form
     *   2. Call UserService.loginUser() to authenticate
     *   3. If valid → create session and redirect to homepage
     *   4. If invalid → show error on login page
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email    = request.getParameter("email");
        String password = request.getParameter("password");
        
        User user = userService.loginUser(email, password);
        
        if (user != null) {
        	HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            session.setMaxInactiveInterval(1800);
            response.sendRedirect(request.getContextPath() + "/index");
        }
        else {
      
            request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
	}

}
