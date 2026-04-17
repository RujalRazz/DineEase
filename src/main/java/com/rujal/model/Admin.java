package com.rujal.model;

/**
 * Admin model — maps to the admin table in the database.
 * Kept separate from User model intentionally —
 * admin is a different role with different access.
 */

public class Admin {
    private int adminId;
    private String username;
    private String email;
    private String password;
	public Admin(int adminId, String username, String email, String password) {
		super();
		this.adminId = adminId;
		this.username = username;
		this.email = email;
		this.password = password;
	}
    public Admin() {
    	
    }
	public int getAdminId() {
		return adminId;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
    
    
}