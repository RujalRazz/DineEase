package com.rujal.dao;

import com.rujal.model.MenuItem;
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
 * MenuItemDao handles all database operations for MenuItem.
 */
public class MenuItemDao {
	private MenuItem mapResultSet(ResultSet rs) throws SQLException {
        MenuItem item = new MenuItem();
        item.setItemId(rs.getInt("item_id"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setPrice(rs.getDouble("price"));
        item.setCategory(rs.getString("category"));
        item.setImageUrl(rs.getString("image_url"));
        item.setAvailable(rs.getBoolean("is_available"));
        return item;
    }
	 /**
     * Fetches all available menu items ordered by category.
     */
	public Map<String, List<MenuItem>> getMenuGroupedByCategory() {
        Map<String, List<MenuItem>> menuMap = new LinkedHashMap<>();
        String sql = "SELECT * FROM menu_items WHERE is_available = true " +
                     "ORDER BY FIELD(category, 'Starters', 'Main Course', 'Desserts', 'Beverages')";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                MenuItem item = mapResultSet(rs);
                // Group items by category
                menuMap.computeIfAbsent(item.getCategory(), k -> new ArrayList<>()).add(item);
            }
        } catch (SQLException e) {
            System.err.println("[MenuItemDAO] getMenuGroupedByCategory failed: " + e.getMessage());
        }

        return menuMap;
    }
	 /**
     * Fetches all available menu items as a flat list.
     */
    public List<MenuItem> getAllMenuItems() {
        List<MenuItem> items = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE is_available = true";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                items.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("[MenuItemDAO] getAllMenuItems failed: " + e.getMessage());
        }

        return items;
    }
    /**
     * Inserts a new menu item into the database.
     */
    public boolean addMenuItem(MenuItem item) {
        String sql = "INSERT INTO menu_items " +
                     "(name, description, price, category, image_url, is_available) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setDouble(3, item.getPrice());
            ps.setString(4, item.getCategory());
            ps.setString(5, item.getImageUrl());
            ps.setBoolean(6, item.isAvailable());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MenuItemDAO] addMenuItem failed: " + e.getMessage());
            return false;
        }
    }
    /**
     * Updates an existing menu item.
     */
    public boolean updateMenuItem(MenuItem item) {
        String sql = "UPDATE menu_items SET " +
                     "name=?, description=?, price=?, category=?, " +
                     "image_url=?, is_available=? " +
                     "WHERE item_id=?";
        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setDouble(3, item.getPrice());
            ps.setString(4, item.getCategory());
            ps.setString(5, item.getImageUrl());
            ps.setBoolean(6, item.isAvailable());
            ps.setInt(7, item.getItemId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MenuItemDAO] updateMenuItem failed: " + e.getMessage());
            return false;
        }
    }
    /**
     * Deletes a menu item by ID.
     */
    public boolean deleteMenuItem(int itemId) {
        String sql = "DELETE FROM menu_items WHERE item_id = ?";
        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MenuItemDAO] deleteMenuItem failed: " + e.getMessage());
            return false;
        }
    }
}