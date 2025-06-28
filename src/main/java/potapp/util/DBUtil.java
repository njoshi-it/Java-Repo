package potapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

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
}
