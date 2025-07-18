package potapp.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import potapp.dao.UserDAO;
import potapp.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/AdminUsersServlet")
public class AdminUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();

        request.setAttribute("users", users);

        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard/admin_users.jsp");
        dispatcher.forward(request, response);
    }
}
