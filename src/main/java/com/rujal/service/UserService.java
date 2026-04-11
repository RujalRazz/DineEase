package com.rujal.service;
 
import com.rujal.dao.UserDao;
import com.rujal.model.User;

/**
 * UserService acts as the business logic layer between the controller and DAO.
 * It validates user input and delegates database operations to UserDao.
 */
public class UserService {
	private UserDao userDao = new UserDao();
	/**
     * Handles the registration business logic.
     * Checks for empty fields, validates email format,
     * checks for duplicate email, then registers the user.
     * Returns a message string describing the result.
     */
    public String registerUser(User user) {
    	 if (user.getFirst_name() == null || user.getFirst_name().trim().isEmpty()) {
             return "First name is required.";
         }
         if (user.getLast_name() == null || user.getLast_name().trim().isEmpty()) {
             return "Last name is required.";
         }
         if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
             return "Email is required.";
         }
         if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
             return "Password is required.";
         }
         if (user.getPhone_number() == null || user.getPhone_number().trim().isEmpty()) {
             return "Phone number is required.";
         }
         if (!user.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
             return "Invalid email format.";
         }
         if (user.getPassword().length() < 6) {
             return "Password must be at least 6 characters.";
         }
         User existingUser = userDao.getUserByEmail(user.getEmail());
         if (existingUser != null) {
             return "Email is already registered. Please login.";
         }
         boolean success = userDao.registerUser(user);
         if (success) {
             return "success";
         } else {
             return "Registration failed. Please try again.";
         }
    }
    /**
     * Handles the login business logic.
     * Validates inputs and calls DAO to authenticate the user.
     * Returns the User object if login is successful, null otherwise.
     */
    public User loginUser(String email, String password) {
    	if (email == null || email.trim().isEmpty()) {
            return null;
        }
    	if (password == null || password.trim().isEmpty()) {
            return null;
        }
    	return userDao.loginUser(email, password);
    }
}