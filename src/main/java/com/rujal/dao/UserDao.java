package com.rujal.dao;

import com.rujal.model.User;
import com.rujal.config.DBconfig;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

// Class userDao
/**
 * UserDao handles all database operations for the User model.
 * It includes methods for user registration and validation.
 */
public class UserDao {
	// Writing the logic for registerUser that is used later for registration
	 /**
     * Registers a new user into the database.
     * Uses BCrypt to hash the password before saving for security.
     */
	public boolean registerUser(User user) {
		String sql = "INSERT INTO users (first_name, last_name, email, password, phone_number, address) VALUES (?, ?, ?, ?, ?, ?)";
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, user.getFirst_name());
            ps.setString(2, user.getLast_name());
            ps.setString(3, user.getEmail());
            ps.setString(4, hashedPassword); 
            ps.setString(5, user.getPhone_number());
            ps.setString(6, user.getAddress());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
	}catch (SQLException e) {
        System.err.println("[UserDAO] registerUser failed: " + e.getMessage());
        return false;
    }
}
	// Creating class for loginUser that is used for login 
	/**
     * Validates a user's credentials against the database.
     * Fetches the user by username and compares the provided password with the stored hash.
     */
	public User loginUser(String email, String password) {
	    String sql = "SELECT * FROM users WHERE email = ?";
	    try (
	        Connection conn = DBconfig.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql)
	    ) {
	        ps.setString(1, email);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                String hashedPassword = rs.getString("password");
	                if (BCrypt.checkpw(password, hashedPassword)) {  
	                    return mapResultSetToUser(rs);
	                }
	            }
	        }
	    } catch (SQLException e) {
	        System.err.println("[UserDAO] loginUser failed: " + e.getMessage());
	    }
	    return null;
	}
	// Fetches a single user by their email address.
	public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
 
        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, email);
 
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
 
        } catch (SQLException e) {
            System.err.println("[UserDAO] getUserByEmail failed: " + e.getMessage());
        }
 
        return null; // user not found
    }
	 private User mapResultSetToUser(ResultSet rs) throws SQLException {
	        User user = new User();
	        user.setUser_id(rs.getInt("user_id"));
	        user.setFirst_name(rs.getString("first_name"));
	        user.setLast_name(rs.getString("last_name"));
	        user.setEmail(rs.getString("email"));
	        user.setPassword(rs.getString("password"));
	        user.setPhone_number(rs.getString("phone_number"));
	        user.setAddress(rs.getString("address"));
	        return user;
	    }
}
