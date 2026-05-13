package com.rujal.dao;

import com.rujal.model.Booking;
import com.rujal.config.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * BookingDao handles all database operations for Booking.
 */
public class BookingDao {
	/**
	 * Inserts a new booking record into the database.
	 */
	public int createBooking(Booking booking) {
		String sql = "INSERT INTO bookings " + "(user_id, restaurant_id, booking_date, booking_time, "
				+ "guest_count, special_request, status) " + "VALUES (?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, booking.getUserId());
			ps.setInt(2, booking.getRestaurantId());
			ps.setString(3, booking.getBookingDate());
			ps.setString(4, booking.getBookingTime());
			ps.setInt(5, booking.getGuestCount());
			ps.setString(6, booking.getSpecialRequest());
			ps.setString(7, "PENDING");

			int rows = ps.executeUpdate();
			if (rows > 0) {
				// Return generated booking ID
				ResultSet keys = ps.getGeneratedKeys();
				if (keys.next())
					return keys.getInt(1);
			}
		} catch (SQLException e) {
			System.err.println("[BookingDAO] createBooking failed: " + e.getMessage());
		}
		return -1;
	}

	/**
	 * Fetches all bookings for a specific user.
	 */
	public List<Booking> getBookingsByUser(int userId) {
		List<Booking> bookings = new ArrayList<>();
		String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_id DESC";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					bookings.add(mapResultSet(rs));
				}
			}
		} catch (SQLException e) {
			System.err.println("[BookingDAO] getBookingsByUser failed: " + e.getMessage());
		}
		return bookings;
	}

	/**
	 * Fetches all bookings that is used by admin dashboard.
	 */
	public List<Booking> getAllBookings() {
		List<Booking> bookings = new ArrayList<>();
		String sql = "SELECT * FROM bookings ORDER BY booking_id DESC";

		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				bookings.add(mapResultSet(rs));
			}
		} catch (SQLException e) {
			System.err.println("[BookingDAO] getAllBookings failed: " + e.getMessage());
		}
		return bookings;
	}

	private Booking mapResultSet(ResultSet rs) throws SQLException {
		Booking b = new Booking();
		b.setBookingId(rs.getInt("booking_id"));
		b.setUserId(rs.getInt("user_id"));
		b.setRestaurantId(rs.getInt("restaurant_id"));
		b.setBookingDate(rs.getString("booking_date"));
		b.setBookingTime(rs.getString("booking_time"));
		b.setGuestCount(rs.getInt("guest_count"));
		b.setSpecialRequest(rs.getString("special_request"));
		b.setStatus(rs.getString("status"));
		return b;
	}

	/**
	 * Updates the status of a booking.
	 */
	public boolean updateStatus(int bookingId, String status) {
		String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, bookingId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("[BookingDAO] updateStatus failed: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Deletes a booking by ID.
	 */
	public boolean deleteBooking(int bookingId) {
		String sql = "DELETE FROM bookings WHERE booking_id = ?";
		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, bookingId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("[BookingDAO] deleteBooking failed: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Fetches all bookings with user name and restaurant name via JOIN.
	 */
	public List<Object[]> getAllBookingsWithDetails() {
		List<Object[]> list = new ArrayList<>();
		String sql = "SELECT b.booking_id, " + "CONCAT(u.first_name, ' ', u.last_name) AS full_name, "
				+ "r.name AS restaurant_name, " + "b.booking_date, b.booking_time, b.guest_count, b.status "
				+ "FROM bookings b " + "JOIN users u ON b.user_id = u.user_id "
				+ "JOIN restaurants r ON b.restaurant_id = r.restaurant_id " + "ORDER BY b.booking_id DESC";

		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Object[] row = { rs.getInt("booking_id"), rs.getString("full_name"), rs.getString("restaurant_name"),
						rs.getString("booking_date"), rs.getString("booking_time"), rs.getInt("guest_count"),
						rs.getString("status") };
				list.add(row);
			}
		} catch (SQLException e) {
			System.err.println("[BookingDAO] getAllBookingsWithDetails failed: " + e.getMessage());
		}
		return list;
	}

	/**
	 * Counts total bookings in the database.
	 */
	public int countBookings() {
		String sql = "SELECT COUNT(*) FROM bookings";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[BookingDAO] countBookings failed: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Counts bookings created this week.
	 */
	public int countBookingsThisWeek() {
		String sql = "SELECT COUNT(*) FROM bookings " + "WHERE booking_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[BookingDAO] countBookingsThisWeek failed: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Returns total booking count for pagination.
	 */
	public int countAllBookings() {
		String sql = "SELECT COUNT(*) FROM bookings";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[BookingDAO] countAllBookings: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Fetches a paginated list of bookings with user and restaurant details via
	 * JOIN.
	 */
	public List<Object[]> getBookingsWithDetailsPaginated(int limit, int offset) {
		List<Object[]> list = new ArrayList<>();
		String sql = "SELECT b.booking_id, " + "CONCAT(u.first_name,' ',u.last_name) AS full_name, "
				+ "r.name AS restaurant_name, " + "b.booking_date, b.booking_time, " + "b.guest_count, b.status "
				+ "FROM bookings b " + "JOIN users u ON b.user_id = u.user_id "
				+ "JOIN restaurants r ON b.restaurant_id = r.restaurant_id " + "ORDER BY b.booking_id DESC "
				+ "LIMIT ? OFFSET ?";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);
			ps.setInt(2, offset);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(new Object[] { rs.getInt("booking_id"), rs.getString("full_name"),
							rs.getString("restaurant_name"), rs.getString("booking_date"), rs.getString("booking_time"),
							rs.getInt("guest_count"), rs.getString("status") });
				}
			}
		} catch (SQLException e) {
			System.err.println("[BookingDAO] getBookingsWithDetailsPaginated: " + e.getMessage());
		}
		return list;
	}
}
