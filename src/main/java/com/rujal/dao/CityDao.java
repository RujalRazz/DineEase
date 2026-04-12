package com.rujal.dao;

import com.rujal.model.City;
import com.rujal.config.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * CityDAO handles all database operations for the City model.
 */
public class CityDao {
	 /**
     * Fetches all cities from the cities table.
     * Used by IndexController to populate the city grid on the home page.
     */
	 public List<City> getAllCities() {
	        List<City> cities = new ArrayList<>();
	        String sql = "SELECT * FROM cities";

	        try (
	            Connection conn = DBconfig.getConnection();
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery()
	        ) {
	            // Loop through each row and map to a City object
	            while (rs.next()) {
	                City city = new City();
	                city.setCityId(rs.getInt("city_id"));
	                city.setCityName(rs.getString("city_name"));
	                city.setRestaurantCount(rs.getString("restaurant_count"));
	                city.setImageUrl(rs.getString("image_url"));
	                city.setCityValue(rs.getString("city_value"));
	                cities.add(city);
	            }
	        } catch (SQLException e) {
	            System.err.println("[CityDAO] getAllCities failed: " + e.getMessage());
	        }

	        return cities;
	    }
	
	
}
