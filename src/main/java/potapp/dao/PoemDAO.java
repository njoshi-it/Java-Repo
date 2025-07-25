package potapp.dao;

import potapp.model.Poem;
import potapp.model.User;
import potapp.util.DBUtil;

import java.sql.*;
import java.util.*;

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

                int userId = rs.getInt("user_id");
                User user = UserDAO.getUserById(userId);
                poem.setUser(user);

                poems.add(poem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return poems;
    }

    public List<Poem> getPoemsByUserId(int userId) {
        List<Poem> poems = new ArrayList<>();
        String sql = "SELECT p.*, COALESCE(AVG(r.rating), 0) AS avg_rating " +
                     "FROM poems p LEFT JOIN ratings r ON p.id = r.poem_id " +
                     "WHERE p.user_id = ? " +
                     "GROUP BY p.id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Poem poem = new Poem();
                poem.setId(rs.getInt("id"));
                poem.setUserId(rs.getInt("user_id"));
                poem.setTitle(rs.getString("title"));
                poem.setCategoryId(rs.getInt("category_id"));
                poem.setContent(rs.getString("content"));
                poem.setCreatedAt(rs.getTimestamp("created_at"));
                poem.setRating(rs.getDouble("avg_rating")); // store avg rating

                poems.add(poem);
            }
        } catch (SQLException e) {
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
            try (ResultSet rs = stmt.executeQuery()) {
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

                    int userId = rs.getInt("user_id");
                    User user = UserDAO.getUserById(userId);
                    poem.setUser(user);
                }
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

    public static String getUserNameById(int userId) {
        String name = "";

        String sql = "SELECT name FROM users WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("name");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return name;
    }

    public static String getCategoryNameById(int categoryId) {
        String name = "";

        String sql = "SELECT name FROM categories WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("name");
                }
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

                int userId = rs.getInt("user_id");
                User user = UserDAO.getUserById(userId);
                poem.setUser(user);

                int catId = poem.getCategoryId();
                categoryMap.computeIfAbsent(catId, k -> new ArrayList<>()).add(poem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categoryMap;
    }

    /**
     * Save a rating or update if it already exists for the user and poem.
     */
    public static void saveOrUpdateRating(int poemId, int userId, int rating) {
        String checkSql = "SELECT id FROM ratings WHERE poem_id = ? AND user_id = ?";
        String updateSql = "UPDATE ratings SET rating = ? WHERE id = ?";
        String insertSql = "INSERT INTO ratings (poem_id, user_id, rating) VALUES (?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setInt(1, poemId);
            checkStmt.setInt(2, userId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // Exists, update
                    int ratingId = rs.getInt("id");
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, rating);
                        updateStmt.setInt(2, ratingId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // Doesn't exist, insert
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, poemId);
                        insertStmt.setInt(2, userId);
                        insertStmt.setInt(3, rating);
                        insertStmt.executeUpdate();
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Get average rating for a poem; returns 0.0 if no ratings exist.
     */
    public static double getAverageRating(int poemId) {
        double avg = 0.0;
        String sql = "SELECT AVG(rating) AS avg_rating FROM ratings WHERE poem_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, poemId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    avg = rs.getDouble("avg_rating");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return avg;
    }

    /**
     * Get user's rating for a poem, returns 0 if none found.
     */
    public static int getUserRating(int poemId, int userId) {
        int rating = 0;
        String sql = "SELECT rating FROM ratings WHERE poem_id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, poemId);
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    rating = rs.getInt("rating");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rating;
    }
}
