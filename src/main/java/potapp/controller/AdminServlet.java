package potapp.controller;

import potapp.dao.UserDAO;
import potapp.dao.PoemDAO;
import potapp.model.User;
import potapp.model.Poem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO;
    private PoemDAO poemDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        poemDAO = new PoemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) action = "dashboard";

        switch (action) {
            case "users":
                List<User> users = userDAO.getAllUsers();
                request.setAttribute("users", users);
                request.getRequestDispatcher("dashboard/admin/users.jsp").forward(request, response);
                break;

            case "poems":
                List<Poem> poems = poemDAO.getAllPoems();
                request.setAttribute("poems", poems);
                request.getRequestDispatcher("dashboard/admin/poems.jsp").forward(request, response);
                break;

            case "dashboard":
            default:
                request.getRequestDispatcher("dashboard/admin/home.jsp").forward(request, response);
                break;
        }
    }
}
