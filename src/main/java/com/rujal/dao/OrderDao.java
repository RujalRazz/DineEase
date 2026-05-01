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
        String orderSql = "INSERT INTO orders " +
                          "(user_id, restaurant_id, total_amount, status) " +
                          "VALUES (?, ?, ?, ?)";

        String itemSql  = "INSERT INTO order_items " +
                          "(order_id, item_id, quantity, sub_total) " +
                          "VALUES (?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBconfig.getConnection();
            // Disable auto commit for transaction
            conn.setAutoCommit(false);

            // Insert order
            int orderId = -1;
            try (PreparedStatement ps = conn.prepareStatement(orderSql,
                    PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getUserId());
                ps.setInt(2, order.getRestaurantId());
                ps.setDouble(3, order.getTotalAmount());
                ps.setString(4, "PENDING");
                ps.executeUpdate();

                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) orderId = keys.getInt(1);
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
            try { if (conn != null) conn.rollback(); }
            catch (SQLException ex) { ex.printStackTrace(); }
            return -1;
        } finally {
            try { if (conn != null) conn.close(); }
            catch (SQLException e) { e.printStackTrace(); }
        }
    }

    // Get orders by user
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_id DESC";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) orders.add(mapResultSet(rs));
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

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) orders.add(mapResultSet(rs));
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
}