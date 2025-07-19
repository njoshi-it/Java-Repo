package potapp.dao;

import potapp.model.Poem;
import potapp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class PoemDAO {

    public List<Poem> getAllPoems() {
        List<Poem> poems = new ArrayList<>();
        String sql = "SELECT * FROM poems";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Poem poem = new Poem(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getInt("category_id"),
                    rs.getFloat("rating"),
                    rs.getTimestamp("created_at")
                );
                poems.add(poem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return poems;
    }

    public List<Poem> getPoemsByUserId(int userId) {
        List<Poem> poems = new ArrayList<>();
        String sql = "SELECT * FROM poems WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Poem poem = new Poem(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getInt("category_id"),
                    rs.getFloat("rating"),
                    rs.getTimestamp("created_at")
                );
                poems.add(poem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return poems;
    }

    public static Poem getPoemById(int id) {
        Poem poem = null;
        String sql = "SELECT * FROM poems WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                poem = new Poem(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getInt("category_id"),
                    rs.getFloat("rating"),
                    rs.getTimestamp("created_at")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return poem;
    }

    public boolean updatePoem(Poem poem) {
        String sql = "UPDATE poems SET title = ?, content = ?, category_id = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, poem.getTitle());
            stmt.setString(2, poem.getContent());
            stmt.setInt(3, poem.getCategoryId());
            stmt.setInt(4, poem.getId());

            int updated = stmt.executeUpdate();
            return updated > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deletePoem(int id) {
        String sql = "DELETE FROM poems WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ New helper: Get user's name by user ID
    public static String getUserNameById(int userId) {
        String name = "";

        String sql = "SELECT name FROM users WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return name;
    }

    // ✅ New helper: Get category name by category ID
    public static String getCategoryNameById(int categoryId) {
        String name = "";

        String sql = "SELECT name FROM categories WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return name;
    }
    public static Map<Integer, List<Poem>> getPoemsGroupedByCategory() {
        Map<Integer, List<Poem>> categoryMap = new HashMap<>();

        String sql = "SELECT * FROM poems ORDER BY category_id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Poem poem = new Poem(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("user_id"),
                    rs.getInt("category_id"),
                    rs.getFloat("rating"),
                    rs.getTimestamp("created_at")
                );

                // ✅ Set User object with ID and Name
                potapp.model.User user = new potapp.model.User();
                int userId = rs.getInt("user_id");
                user.setId(userId);
                user.setName(getUserNameById(userId)); // use helper method
                poem.setUser(user);

                int catId = poem.getCategoryId();

                if (!categoryMap.containsKey(catId)) {
                    categoryMap.put(catId, new ArrayList<>());
                }
                categoryMap.get(catId).add(poem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categoryMap;
    }
}
