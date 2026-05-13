package com.rujal.dao;

import com.rujal.model.City;
import com.rujal.config.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

/**
 * CityDAO handles all database operations for the City model.
 */
public class CityDao {
	/**
	 * Fetches all cities from the cities table. Used by IndexController to populate
	 * the city grid on the home page.
	 */
	public List<City> getAllCities() {
		List<City> cities = new ArrayList<>();
		String sql = "SELECT c.city_id, c.city_name, c.city_value, c.image_url, \n"
				+ "       COUNT(r.restaurant_id) AS restaurant_count \n" + "FROM cities c \n"
				+ "LEFT JOIN restaurants r ON c.city_id = r.city_id \n"
				+ "GROUP BY c.city_id, c.city_name, c.city_value, c.image_url \n" + "ORDER BY c.city_id ASC";

		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
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

	/**
	 * Inserts a new city into the database. Enforces uniqueness on name and value.
	 */
	public void addCity(City city) throws Exception {
		String query = "INSERT INTO cities (city_name, city_value, image_url) VALUES (?, ?, ?)";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, city.getCityName());
			pstmt.setString(2, city.getCityValue());
			pstmt.setString(3, city.getImageUrl());
			pstmt.executeUpdate();

		} catch (SQLIntegrityConstraintViolationException e) {
			throw new Exception("A city with this Name or Value already exists!");
		} catch (SQLException e) {
			System.err.println("[CityDAO] addCity failed: " + e.getMessage());
			throw new Exception("Database error occurred while adding the city.");
		}
	}

	/**
	 * Updates an existing city.
	 */
	public void updateCity(City city) throws Exception {
		String query = "UPDATE cities SET city_name=?, city_value=?, image_url=? WHERE city_id=?";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, city.getCityName());
			pstmt.setString(2, city.getCityValue());
			pstmt.setString(3, city.getImageUrl());
			pstmt.setInt(4, city.getCityId());
			pstmt.executeUpdate();

		} catch (SQLIntegrityConstraintViolationException e) {
			throw new Exception("Update failed: Another city is already using this Name or Value.");
		} catch (SQLException e) {
			System.err.println("[CityDAO] updateCity failed: " + e.getMessage());
			throw new Exception("Database error occurred while updating the city.");
		}
	}

	/**
	 * Deletes a city. Blocks deletion if there are still restaurants linked to it.
	 */
	public void deleteCity(int cityId) throws Exception {
		// First, check if there are any linked restaurants
		String checkQuery = "SELECT COUNT(*) FROM restaurants WHERE city_id = ?";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

			checkStmt.setInt(1, cityId);
			ResultSet rs = checkStmt.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				throw new Exception("Cannot delete: Please remove or reassign all restaurants in this city first.");
			}
		}

		// If clear, proceed with deletion
		String deleteQuery = "DELETE FROM cities WHERE city_id = ?";
		try (Connection conn = DBconfig.getConnection(); PreparedStatement pstmt = conn.prepareStatement(deleteQuery)) {

			pstmt.setInt(1, cityId);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("[CityDAO] deleteCity failed: " + e.getMessage());
			throw new Exception("Database error occurred while deleting the city.");
		}
	}

	/**
	 * Returns total city count for pagination.
	 */
	public int countAllCities() {
		String sql = "SELECT COUNT(*) FROM cities";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[CityDAO] countAllCities: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Fetches a paginated list of cities.
	 */
	public List<City> getCitiesPaginated(int limit, int offset) {
		List<City> list = new ArrayList<>();
		String sql = "SELECT * FROM cities " + "ORDER BY city_id ASC " + "LIMIT ? OFFSET ?";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);
			ps.setInt(2, offset);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					City c = new City();
					c.setCityId(rs.getInt("city_id"));
					c.setCityName(rs.getString("city_name"));
					c.setRestaurantCount(rs.getString("restaurant_count"));
					c.setImageUrl(rs.getString("image_url"));
					c.setCityValue(rs.getString("city_value"));
					list.add(c);
				}
			}
		} catch (SQLException e) {
			System.err.println("[CityDAO] getCitiesPaginated: " + e.getMessage());
		}
		return list;
	}
}
