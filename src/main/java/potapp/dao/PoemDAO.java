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

    // You can add more methods later: addPoem, updatePoem, deletePoem
}
