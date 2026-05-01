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
        String sql = "INSERT INTO bookings " +
                     "(user_id, restaurant_id, booking_date, booking_time, " +
                     "guest_count, special_request, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql,
                PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
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
                if (keys.next()) return keys.getInt(1);
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

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
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

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
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
}
