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
                poems.add(poem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poems;
    }

    // Retrieve poems by specific user ID (for user)
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
                    poems.add(poem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poems;
    }

    // You can add more methods: addPoem, updatePoem, deletePoem
}
