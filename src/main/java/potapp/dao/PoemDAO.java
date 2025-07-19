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

                User user = UserDAO.getUserById(userId);
                poem.setUser(user);

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

                int userId = rs.getInt("user_id");
                User user = UserDAO.getUserById(userId);
                poem.setUser(user);
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
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
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

    public static void saveRating(int poemId, int userId, int rating) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            // Check if a rating already exists for this user and poem
            String checkSql = "SELECT id FROM ratings WHERE poem_id = ? AND user_id = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setInt(1, poemId);
            stmt.setInt(2, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Rating exists → update
                int ratingId = rs.getInt("id");
                DBUtil.close(rs);
                DBUtil.close(stmt);

                String updateSql = "UPDATE ratings SET rating = ? WHERE id = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setInt(1, rating);
                stmt.setInt(2, ratingId);
                stmt.executeUpdate();
            } else {
                // Rating doesn't exist → insert
                DBUtil.close(rs);
                DBUtil.close(stmt);

                String insertSql = "INSERT INTO ratings (poem_id, user_id, rating) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setInt(1, poemId);
                stmt.setInt(2, userId);
                stmt.setInt(3, rating);
                stmt.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(stmt);
            DBUtil.close(conn);
        }
    }


    public static double getAverageRating(int poemId) {
        double avg = 0.0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT AVG(rating) AS avg_rating FROM ratings WHERE poem_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, poemId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                avg = rs.getDouble("avg_rating");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(stmt);
            DBUtil.close(conn);
        }

        return avg;
    }
    public static int getUserRating(int poemId, int userId) {
        int rating = 0;
        String sql = "SELECT rating FROM ratings WHERE poem_id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, poemId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                rating = rs.getInt("rating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rating;
    }

}
