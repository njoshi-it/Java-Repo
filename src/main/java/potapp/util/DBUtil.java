package potapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.*;


public class DBUtil {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // ✅ Explicitly load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/poemportal?useSSL=false&serverTimezone=UTC";
            String username = "root";
            String password = "root"; // replace with your real password

            conn = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            System.out.println("[ERROR] JDBC Driver class not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("[ERROR] SQL Exception during DB connection.");
            e.printStackTrace();
        }
        return conn;
    }
    public static void close(Connection conn) {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void close(PreparedStatement stmt) {
        try {
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void close(ResultSet rs) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
