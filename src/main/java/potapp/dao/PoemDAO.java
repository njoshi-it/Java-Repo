package potapp.dao;

import potapp.model.Poem;
import potapp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    // ✅ NEW: Get single poem by ID
    public Poem getPoemById(int id) {
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

    // ✅ NEW: Update poem
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
}
