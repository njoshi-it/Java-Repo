package potapp.controller;

import potapp.dao.UserDAO;
import potapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // Handles GET request to show login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Handles POST request to process login
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
     // 🔍 Debug Log 1: Show raw input
        System.out.println("[DEBUG] Email entered: " + email);
        System.out.println("[DEBUG] Password entered: " + password);


        User user = userDAO.getUserByEmailAndPassword(email, password);

        if (user != null) {
        	
            System.out.println("[DEBUG] Login successful for user: " + user.getName() + ", Role: " + user.getRole());

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin/home.jsp");
            } else {
                response.sendRedirect("user/home.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
