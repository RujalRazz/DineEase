package com.rujal.controller;

import com.rujal.dao.AdminDao;
import com.rujal.model.Admin;

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
 * AdminLoginController handles admin login requests
 */
@WebServlet("/admin-login")
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminDao adminDao = new AdminDao();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * doGet — loads the admin login page.
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getSession(false) != null &&
	            request.getSession(false).getAttribute("admin") != null) {
	            response.sendRedirect(request.getContextPath() + "/admin-dashboard");
	            return;
	        }
		request.getRequestDispatcher("/WEB-INF/pages/admin/adminLogin.jsp").forward(request, response);
	}

	/**
     * doPost — processes the admin login form.
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
        String password = request.getParameter("password");
        Admin admin = adminDao.loginAdmin(email, password);
        if (admin != null) {
        	HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setMaxInactiveInterval(1800);
            
            response.sendRedirect(request.getContextPath() + "/admin-dashboard");
        }
        else {
        	request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/adminLogin.jsp").forward(request, response);
        }
	}

}
