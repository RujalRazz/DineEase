package com.rujal.dao;

import com.rujal.model.Restaurant;
import com.rujal.config.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * RestaurantDao handles all database operations for the Restaurant model.
 * Supports filtering by city and sorting by price range.
 */

public class RestaurantDao {
	/**
	 * Converts a database row into a Restaurant object. Only maps columns that
	 * belong to the restaurants table.
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
	 * Fetches only from the restaurants table means no JOIN needed cityId = 0 means
	 * all cities. priceSort = "asc" or "desc", null means no sort.
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
		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
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

	/**
	 * Counts the total number of restaurants in the database. Used by
	 * AdminDashboardController to display stats.
	 */
	public int countRestaurants() {
		String sql = "SELECT COUNT(*) FROM restaurants";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			System.err.println("[RestaurantDAO] countRestaurants failed: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Fetches the 5 most recently added restaurants. Used by
	 * AdminDashboardController for the dashboard table.
	 */
	public List<Restaurant> getRecentRestaurants() {
		List<Restaurant> list = new ArrayList<>();
		String sql = "SELECT * FROM restaurants ORDER BY restaurant_id DESC LIMIT 5";

		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(mapResultSet(rs));
			}
		} catch (SQLException e) {
			System.err.println("[RestaurantDAO] getRecentRestaurants failed: " + e.getMessage());
		}
		return list;
	}

	public List<Restaurant> getAllRestaurants() {
		return getRestaurants(0, null);
	}

	/**
	 * Inserts a new restaurant into the database. Returns true if insert was
	 * successful.
	 */
	public boolean addRestaurant(Restaurant r) {
		String sql = "INSERT INTO restaurants " + "(city_id, name, address, contact, description, "
				+ "image_url, rating, price_range, badge) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, r.getCityId());
			ps.setString(2, r.getName());
			ps.setString(3, r.getAddress());
			ps.setString(4, r.getContact());
			ps.setString(5, r.getDescription());
			ps.setString(6, r.getImageUrl());
			ps.setDouble(7, r.getRating());
			ps.setInt(8, r.getPriceRange());
			ps.setString(9, r.getBadge());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			System.err.println("[RestaurantDAO] addRestaurant failed: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Updates an existing restaurant in the database. Returns true if update was
	 * successful.
	 */
	public boolean updateRestaurant(Restaurant r) {
		String sql = "UPDATE restaurants SET " + "city_id=?, name=?, address=?, contact=?, description=?, "
				+ "image_url=?, rating=?, price_range=?, badge=? " + "WHERE restaurant_id=?";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, r.getCityId());
			ps.setString(2, r.getName());
			ps.setString(3, r.getAddress());
			ps.setString(4, r.getContact());
			ps.setString(5, r.getDescription());
			ps.setString(6, r.getImageUrl());
			ps.setDouble(7, r.getRating());
			ps.setInt(8, r.getPriceRange());
			ps.setString(9, r.getBadge());
			ps.setInt(10, r.getRestaurantId());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			System.err.println("[RestaurantDAO] updateRestaurant failed: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Deletes a restaurant from the database by ID. Returns true if delete was
	 * successful.
	 */
	public boolean deleteRestaurant(int restaurantId) {
		String sql = "DELETE FROM restaurants WHERE restaurant_id = ?";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, restaurantId);
			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			System.err.println("[RestaurantDAO] deleteRestaurant failed: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Fetches a single restaurant by its ID.
	 */
	public Restaurant getRestaurantById(int restaurantId) {
		String sql = "SELECT * FROM restaurants WHERE restaurant_id = ?";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, restaurantId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return mapResultSet(rs);
			}
		} catch (SQLException e) {
			System.err.println("[RestaurantDAO] getRestaurantById failed: " + e.getMessage());
		}
		return null;
	}
	
	/**
	 * Counts restaurants added this month using created_at column.
	 */
	public int countRestaurantsThisMonth() {
	    String sql = "SELECT COUNT(*) FROM restaurants " +
	                 "WHERE MONTH(created_at) = MONTH(CURDATE()) " +
	                 "AND YEAR(created_at) = YEAR(CURDATE())";
	    try (
	        Connection conn = DBconfig.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery()
	    ) {
	        if (rs.next()) return rs.getInt(1);
	    } catch (SQLException e) {
	        System.err.println("[RestaurantDAO] countRestaurantsThisMonth failed: " + e.getMessage());
	    }
	    return 0;
	}
	public Map<Integer, String> getDistinctCitiesFromRestaurants() {
	    Map<Integer, String> cityMap = new LinkedHashMap<>();
	    String sql =
	        "SELECT DISTINCT r.city_id, c.city_name " +
	        "FROM restaurants r " +
	        "JOIN cities c ON r.city_id = c.city_id " +
	        "ORDER BY c.city_name ASC";

	    try (
	        Connection conn = DBconfig.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery()
	    ) {
	        while (rs.next()) {
	            cityMap.put(rs.getInt("city_id"), rs.getString("city_name"));
	        }
	    } catch (SQLException e) {
	        System.err.println("[RestaurantDAO] getDistinctCities failed: " + e.getMessage());
	    }
	    return cityMap;
	}
}