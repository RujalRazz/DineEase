package com.rujal.dao;

import com.rujal.model.Admin;
import com.rujal.config.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * AdminDao handles all database operations for the Admin model.
 * Admin has a separate login page and database table
 */

public class AdminDao {
	/**
     * Fetches admin by email, then verifies password
     * Returns Admin object if credentials match, null otherwise.
     */
	public Admin loginAdmin(String email, String password) {
        String sql = "SELECT * FROM admin WHERE email = ?";
        try (
                Connection conn = DBconfig.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
            ) {
        	ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Get the plain text password stored in the database
                    String storedPassword = rs.getString("password");

                    // Compare the user's input directly with the stored string
                    if (password.equals(storedPassword)) {
                        return mapResultSet(rs);
                    }
                }
            }
            
        } 
        catch (SQLException e) {
            System.err.println("[AdminDAO] loginAdmin failed: " + e.getMessage());
        }
        return null;
	}
	 private Admin mapResultSet(ResultSet rs) throws SQLException {
	        Admin admin = new Admin();
	        admin.setAdminId(rs.getInt("admin_id"));
	        admin.setUsername(rs.getString("username"));
	        admin.setEmail(rs.getString("email"));
	        admin.setPassword(rs.getString("password"));
	        return admin;
	    }
}