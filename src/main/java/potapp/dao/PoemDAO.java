package potapp.dao;

import potapp.model.Poem;
import potapp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoemDAO {

    // Retrieve all poems (for admin)
    public List<Poem> getAllPoems() {
        List<Poem> poems = new ArrayList<>();
        String sql = "SELECT * FROM poems";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Poem poem = new Poem();
                poem.setId(rs.getInt("id"));
                poem.setTitle(rs.getString("title"));
                poem.setContent(rs.getString("content"));
                poem.setCategory(rs.getString("category"));
                poem.setUserId(rs.getInt("user_id"));
                poem.setValue(rs.getDouble("value"));
                poems.add(poem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poems;
    }

    // Retrieve poems by specific user ID
    public List<Poem> getPoemsByUserId(int userId) {
        List<Poem> poems = new ArrayList<>();
        String sql = "SELECT * FROM poems WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Poem poem = new Poem();
                    poem.setId(rs.getInt("id"));
                    poem.setTitle(rs.getString("title"));
                    poem.setContent(rs.getString("content"));
                    poem.setCategory(rs.getString("category"));
                    poem.setUserId(rs.getInt("user_id"));
                    poem.setValue(rs.getDouble("value"));
                    poems.add(poem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poems;
    }

    // Add new poem
    public boolean addPoem(Poem poem) {
        String sql = "INSERT INTO poems (title, content, category, user_id, value) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, poem.getTitle());
            ps.setString(2, poem.getContent());
            ps.setString(3, poem.getCategory());
            ps.setInt(4, poem.getUserId());
            ps.setDouble(5, poem.getValue());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update existing poem
    public boolean updatePoem(Poem poem) {
        String sql = "UPDATE poems SET title = ?, content = ?, category = ?, value = ? WHERE id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, poem.getTitle());
            ps.setString(2, poem.getContent());
            ps.setString(3, poem.getCategory());
            ps.setDouble(4, poem.getValue());
            ps.setInt(5, poem.getId());
            ps.setInt(6, poem.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a poem
    public boolean deletePoem(int poemId, int userId) {
        String sql = "DELETE FROM poems WHERE id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, poemId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get single poem by ID
    public Poem getPoemById(int id) {
        String sql = "SELECT * FROM poems WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Poem poem = new Poem();
                poem.setId(rs.getInt("id"));
                poem.setTitle(rs.getString("title"));
                poem.setContent(rs.getString("content"));
                poem.setCategory(rs.getString("category"));
                poem.setUserId(rs.getInt("user_id"));
                poem.setValue(rs.getDouble("value"));
                rs.close();
                return poem;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
