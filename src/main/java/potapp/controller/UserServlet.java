package potapp.controller;

import potapp.dao.PoemDAO;
import potapp.model.Poem;
import potapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private PoemDAO poemDAO;

    @Override
    public void init() {
        poemDAO = new PoemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("poems".equalsIgnoreCase(action)) {
            List<Poem> userPoems = poemDAO.getPoemsByUserId(user.getId());
            request.setAttribute("poems", userPoems);
            request.getRequestDispatcher("dashboard/user/poems.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("dashboard/user/home.jsp").forward(request, response);
        }
    }
}
