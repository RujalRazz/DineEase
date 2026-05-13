package com.rujal.dao;

import com.rujal.model.Order;
import com.rujal.model.OrderItem;
import com.rujal.config.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * OrderDao handles all database operations for Order and OrderItem.
 */
public class OrderDao {

	/**
	 * Inserts a new order and its order items into the database.
	 */
	public int createOrder(Order order, List<OrderItem> items) {
		String orderSql = "INSERT INTO orders " + "(user_id, restaurant_id, total_amount, status) "
				+ "VALUES (?, ?, ?, ?)";

		String itemSql = "INSERT INTO order_items " + "(order_id, item_id, quantity, sub_total) "
				+ "VALUES (?, ?, ?, ?)";

		Connection conn = null;
		try {
			conn = DBconfig.getConnection();
			// Disable auto commit for transaction
			conn.setAutoCommit(false);

			// Insert order
			int orderId = -1;
			try (PreparedStatement ps = conn.prepareStatement(orderSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
				ps.setInt(1, order.getUserId());
				ps.setInt(2, order.getRestaurantId());
				ps.setDouble(3, order.getTotalAmount());
				ps.setString(4, "PENDING");
				ps.executeUpdate();

				ResultSet keys = ps.getGeneratedKeys();
				if (keys.next())
					orderId = keys.getInt(1);
			}

			if (orderId == -1) {
				conn.rollback();
				return -1;
			}

			// Insert each order item
			try (PreparedStatement ps = conn.prepareStatement(itemSql)) {
				for (OrderItem item : items) {
					ps.setInt(1, orderId);
					ps.setInt(2, item.getItemId());
					ps.setInt(3, item.getQuantity());
					ps.setDouble(4, item.getSubTotal());
					ps.addBatch();
				}
				ps.executeBatch();
			}

			// Commit transaction
			conn.commit();
			return orderId;

		} catch (SQLException e) {
			System.err.println("[OrderDAO] createOrder failed: " + e.getMessage());
			try {
				if (conn != null)
					conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			return -1;
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// Get orders by user
	public List<Order> getOrdersByUser(int userId) {
		List<Order> orders = new ArrayList<>();
		String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_id DESC";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next())
					orders.add(mapResultSet(rs));
			}
		} catch (SQLException e) {
			System.err.println("[OrderDAO] getOrdersByUser failed: " + e.getMessage());
		}
		return orders;
	}

	// Get all orders (admin)
	public List<Order> getAllOrders() {
		List<Order> orders = new ArrayList<>();
		String sql = "SELECT * FROM orders ORDER BY order_id DESC";

		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next())
				orders.add(mapResultSet(rs));
		} catch (SQLException e) {
			System.err.println("[OrderDAO] getAllOrders failed: " + e.getMessage());
		}
		return orders;
	}

	// Map ResultSet to Order
	private Order mapResultSet(ResultSet rs) throws SQLException {
		Order o = new Order();
		o.setOrderId(rs.getInt("order_id"));
		o.setUserId(rs.getInt("user_id"));
		o.setRestaurantId(rs.getInt("restaurant_id"));
		o.setOrderDate(rs.getString("order_date"));
		o.setTotalAmount(rs.getDouble("total_amount"));
		o.setStatus(rs.getString("status"));
		return o;
	}

	/**
	 * Updates the status of an order.
	 */
	public boolean updateStatus(int orderId, String status) {
		String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, orderId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("[OrderDAO] updateStatus failed: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Deletes an order and its order items by order ID.
	 */
	public boolean deleteOrder(int orderId) {
		Connection conn = null;
		try {
			conn = DBconfig.getConnection();
			conn.setAutoCommit(false);

			try (PreparedStatement ps = conn.prepareStatement("DELETE FROM order_items WHERE order_id = ?")) {
				ps.setInt(1, orderId);
				ps.executeUpdate();
			}

			try (PreparedStatement ps = conn.prepareStatement("DELETE FROM orders WHERE order_id = ?")) {
				ps.setInt(1, orderId);
				ps.executeUpdate();
			}

			conn.commit();
			return true;

		} catch (SQLException e) {
			System.err.println("[OrderDAO] deleteOrder failed: " + e.getMessage());
			try {
				if (conn != null)
					conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			return false;
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * Fetches all orders with user name and restaurant name via JOIN.
	 */
	public List<Object[]> getAllOrdersWithDetails() {
		List<Object[]> list = new ArrayList<>();
		String sql = "SELECT o.order_id, " + "CONCAT(u.first_name, ' ', u.last_name) AS full_name, "
				+ "r.name AS restaurant_name, " + "o.order_date, o.total_amount, o.status " + "FROM orders o "
				+ "JOIN users u ON o.user_id = u.user_id " + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
				+ "ORDER BY o.order_id DESC";

		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Object[] row = { rs.getInt("order_id"), rs.getString("full_name"), rs.getString("restaurant_name"),
						rs.getString("order_date"), rs.getDouble("total_amount"), rs.getString("status") };
				list.add(row);
			}
		} catch (SQLException e) {
			System.err.println("[OrderDAO] getAllOrdersWithDetails failed: " + e.getMessage());
		}
		return list;
	}

	/**
	 * Counts total orders in the database.
	 */
	public int countOrders() {
		String sql = "SELECT COUNT(*) FROM orders";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[OrderDAO] countOrders failed: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Counts orders placed today.
	 */
	public int countOrdersToday() {
		String sql = "SELECT COUNT(*) FROM orders " + "WHERE DATE(order_date) = CURDATE()";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[OrderDAO] countOrdersToday failed: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Returns total order count for pagination.
	 */
	public int countAllOrders() {
		String sql = "SELECT COUNT(*) FROM orders";
		try (Connection conn = DBconfig.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[OrderDAO] countAllOrders: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Fetches a paginated list of orders with user and restaurant details via JOIN.
	 */
	public List<Object[]> getOrdersWithDetailsPaginated(int limit, int offset) {
		List<Object[]> list = new ArrayList<>();
		String sql = "SELECT o.order_id, " + "CONCAT(u.first_name,' ',u.last_name) AS full_name, "
				+ "r.name AS restaurant_name, " + "o.order_date, o.total_amount, o.status " + "FROM orders o "
				+ "JOIN users u ON o.user_id = u.user_id " + "JOIN restaurants r ON o.restaurant_id = r.restaurant_id "
				+ "ORDER BY o.order_id DESC " + "LIMIT ? OFFSET ?";

		try (Connection conn = DBconfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);
			ps.setInt(2, offset);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(new Object[] { rs.getInt("order_id"), rs.getString("full_name"),
							rs.getString("restaurant_name"), rs.getString("order_date"), rs.getDouble("total_amount"),
							rs.getString("status") });
				}
			}
		} catch (SQLException e) {
			System.err.println("[OrderDAO] getOrdersWithDetailsPaginated: " + e.getMessage());
		}
		return list;
	}
}