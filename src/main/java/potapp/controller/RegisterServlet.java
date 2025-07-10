package potapp.controller;

import potapp.dao.UserDAO;
import potapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (name == null || email == null || password == null || role == null ||
            name.isEmpty() || email.isEmpty() || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (userDAO.userExists(email)) {
            request.setAttribute("error", "Email already registered.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed. Try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
