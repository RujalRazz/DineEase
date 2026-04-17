package com.rujal.dao;
import com.rujal.model.Restaurant;
import com.rujal.config.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * RestaurantDao handles all database operations for the Restaurant model.
 * Supports filtering by city and sorting by price range.
*/

public class RestaurantDao {
	 /**
     * Converts a database row into a Restaurant object.
     * Only maps columns that belong to the restaurants table.
     */
	
	 private Restaurant mapResultSet(ResultSet rs) throws SQLException {
	        Restaurant r = new Restaurant();
	        r.setRestaurantId(rs.getInt("restaurant_id"));
	        r.setCityId(rs.getInt("city_id"));
	        r.setName(rs.getString("name"));
	        r.setAddress(rs.getString("address"));
	        r.setContact(rs.getString("contact"));
	        r.setDescription(rs.getString("description"));
	        r.setImageUrl(rs.getString("image_url"));
	        r.setRating(rs.getDouble("rating"));
	        r.setPriceRange(rs.getInt("price_range"));
	        r.setBadge(rs.getString("badge"));
	        return r;
	    }
	 /**
	     * Fetches only from the restaurants table means no JOIN needed
	     * cityId = 0 means all cities.
	     * priceSort = "asc" or "desc", null means no sort.
	     */
	 public List<Restaurant> getRestaurants(int cityId, String priceSort) {
		 List<Restaurant> list = new ArrayList<>();
		 
		 StringBuilder sql = new StringBuilder("SELECT * FROM restaurants ");
		 
		// Add city filter if a specific city is selected
		 if (cityId > 0) {
	            sql.append("WHERE city_id = ? ");
	        }
		 
		// Add price sort if direction provided
		 if (priceSort != null && !priceSort.isEmpty()) {
	            if (priceSort.equals("asc")) {
	                sql.append("ORDER BY price_range ASC");
	            } else if (priceSort.equals("desc")) {
	                sql.append("ORDER BY price_range DESC");
	            }
	        }
		 try (
		            Connection conn = DBconfig.getConnection();
		            PreparedStatement ps = conn.prepareStatement(sql.toString())
		        ) {
		            if (cityId > 0) {
		                ps.setInt(1, cityId);
		            }

		            try (ResultSet rs = ps.executeQuery()) {
		                while (rs.next()) {
		                    list.add(mapResultSet(rs));
		                }
		            }

		        } catch (SQLException e) {
		            System.err.println("[RestaurantDAO] getRestaurants failed: " + e.getMessage());
		        }
		 return list;
	 }
}