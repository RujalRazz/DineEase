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
}