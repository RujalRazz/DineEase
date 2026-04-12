package com.rujal.controller;

import com.rujal.model.User;
import com.rujal.service.UserService;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
 
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * RegisterServlet handles HTTP requests for user registration.
 * It processes form data, creates a User object, and delegates
 * registration logic to UserService.
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private UserService userService = new UserService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * Handles GET requests.
     * Forwards the user to the register.jsp page.
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	}

	/**
     * Handles POST requests from register.jsp form.
     * Flow:
     *   1. Get form data from request
     *   2. Create User object and set fields
     *   3. Call UserService.registerUser()
     *   4. Redirect to login page or show error message
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String firstName   = request.getParameter("first_name");
        String lastName    = request.getParameter("last_name");
        String email       = request.getParameter("email");
        String password    = request.getParameter("password");
        String phoneNumber = request.getParameter("phone_number");
        String address     = request.getParameter("address");
        
        User user = new User();
        user.setFirst_name(firstName);
        user.setLast_name(lastName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone_number(phoneNumber);
        user.setAddress(address);
        
        String result = userService.registerUser(user);
        
        if (result.equals("success")) {
            // Registration successful — redirect to login page
            response.sendRedirect(request.getContextPath() + "/login?message=Registration+successful!+Please+login.");
        } else {
            // Registration failed — send error message back to register page
            request.setAttribute("errorMessage", result);
            request.getRequestDispatcher("WEB-INF/pages/register.jsp").forward(request, response);
        }
	}

}
